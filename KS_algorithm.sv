module KS_algorithm ( //_string_controller(
	input Clk,
	input Reset,
	input pluck,
	input data_over,
	input [9:0]stringlen,
	output [15:0] sample_out
);

enum logic [3:0] {HOLD, INITIALIZE, LOADA, LOADA2, LOADB, LOADB2, CALCULATE, UPDATEPTR1, 
						UPDATEPTR2, WAIT1, WAIT2} state, next_state;

logic loadA, loadB, loadSample;
logic [15:0] A_in, B_in, dl_in, sample_in;
logic [15:0] A_out, B_out, dl_out;
logic [9:0] dl_w_addr, dl_r_addr;
logic [9:0] ptrA_in, ptrB_in, ptrA_out, ptrB_out;
logic wren, rden, randen;
logic randbit;
logic [9:0] count;
logic [9:0] next_count;
logic [15:0] loadptrA, loadptrB;

memBlock delayLine(.clk(Clk), .q(dl_out), .data(dl_in), .wraddress(dl_w_addr), 
						 .rdaddress(dl_r_addr), .wren(wren), .rden(rden));
						 
Dreg Areg(.Clk(Clk), .Load(loadA), .Reset(Reset), .D(A_in), .Q(A_out));
Dreg Breg(.Clk(Clk), .Load(loadB), .Reset(Reset), .D(B_in), .Q(B_out));

Dreg PTRAreg(.Clk(Clk), .Load(loadptrA), .Reset(Reset), .D(ptrA_in), .Q(ptrA_out));
Dreg PTRBreg(.Clk(Clk), .Load(loadptrB), .Reset(Reset), .D(ptrB_in), .Q(ptrB_out));

Dreg sample(.Clk(Clk), .Load(loadSample), .Reset(Reset), .D(sample_in), .Q(sample_out));

white_noise_generator randomNum(.clk(Clk), .reset(Reset), .enable(1'b1), .lsb(randbit));

///////////progress to the next state
always_ff @ (posedge Clk)
begin 
	if(Reset) begin
		state <= HOLD;
	end
	else begin
		state <= next_state;
	end
	count <= next_count;
end

/////////////always comb states
always_comb begin
	next_state = state;
	
	case(state)
		HOLD : 
		begin	
			if(pluck)
				next_state = INITIALIZE;
			else
				next_state = HOLD;
			end
		
		INITIALIZE : 
		begin	
			if (~pluck) begin
				if(next_count < stringlen)
					next_state = INITIALIZE;
				else
					next_state = LOADA;
			end
		end
		
		LOADA : 
		begin	
			next_state = LOADA2;
		end
		
		LOADA2 : 
		begin	
			next_state = LOADB;
		end
		
		LOADB :
		begin
			next_state = LOADB2;
		end
		
		LOADB2 :
		begin
			next_state = CALCULATE;
		end
		
		CALCULATE : 
		begin
			next_state = UPDATEPTR2;
		end
		
		UPDATEPTR2 : 
		begin
			next_state = UPDATEPTR1; //step B up to A and fill in sample
		end
		
		UPDATEPTR1 : 
		begin
			next_state = WAIT1; //step A up one, ready to go again
		end
		
		WAIT1 :
		begin
			if(data_over)
				next_state = WAIT2;
			else
				next_state = WAIT1;
		end
		
		WAIT2 :
		begin
			if(~data_over)
				next_state = LOADA;
			else if (pluck)
				next_state = HOLD;
			else
				next_state = WAIT2;
		end
		
	endcase
end

//////////////always comb signals
always_comb begin
	next_count = count;
	rden = 1'b0;
	wren = 1'b0;
	loadA = 1'b0;
	loadB = 1'b0;
	loadSample = 1'b0;
	A_in = 16'b0;
	B_in = 16'b0;
	dl_in = 16'b0;
	sample_in = 16'b0;
	dl_w_addr = 9'b0;
	dl_r_addr = 9'b0;
	ptrA_in = 9'b0;
	ptrB_in = 9'b1;
	loadptrA = 1'b0;
	loadptrB = 1'b0;
	
	case(state)
		HOLD : 
		begin	
			next_count = 9'b0;
			ptrA_in = 9'b0;
			ptrB_in = 9'b1;
			loadptrA = 1'b1;
			loadptrB = 1'b1;
		end
		
		INITIALIZE : 
		begin	
			//write random bits to delay line for full line length
			next_count = count + 1'b1;
			wren = 1'b1;
			dl_w_addr = count;
			if(randbit)
				dl_in = 16'hEFFF;
			else
				dl_in = 16'h8000;
		end
		
		LOADA : 
		begin	
			//get delay line value at A
			loadA = 1'b1;
			rden = 1'b1;
			dl_r_addr = ptrA_out;
			A_in = dl_out;
		end
		
		LOADA2 : 
		begin	
			//get delay line value at A
			loadA = 1'b1;
			rden = 1'b1;
			dl_r_addr = ptrA_out;
			A_in = dl_out;
		end
		
		LOADB :
		begin
			//get delay line value at A
			loadB = 1'b1;
			rden = 1'b1;
			dl_r_addr = ptrB_out;
			B_in = dl_out;
		end
		
		LOADB2 :
		begin
			//get delay line value at A
			loadB = 1'b1;
			rden = 1'b1;
			dl_r_addr = ptrB_out;
			B_in = dl_out;
		end
		
		CALCULATE : 
		begin
			loadSample = 1'b1;
			sample_in = (B_out / 2) + (A_out / 2); //>>>
		end
		
		UPDATEPTR2 : 
		begin
			//new B input
			loadptrB = 1'b1; 
			ptrB_in = ptrA_out; //set B to A
			
			//update delay line, put filtered sample in A
			wren = 1'b1;
			dl_w_addr = ptrA_out;
			dl_in = sample_out;
		end
		
		UPDATEPTR1 : 
		begin
			//update delay line, increment A
			loadptrA = 1'b1;
			if(ptrA_out == stringlen)
				ptrA_in = 9'b0;
			else
				ptrA_in = ptrA_out + 1'b1;
		end
		
		WAIT1 :
		begin
			//waits here for signal to be done playing
		end
		
		WAIT2 :
		begin
			//wait2 is entered when ready for new signal -> next state is loadA
		end
		
		default:
		begin
			next_count = count;
			wren = 1'b1;
			loadA = 1'b0;
			loadB = 1'b0;
			loadSample = 1'b0;
			A_in = 16'b0;
			B_in = 16'b0;
			dl_in = 16'b0;
			sample_in = 16'b0;
			dl_w_addr = 9'b0;
			ptrA_in = 9'b0;
			ptrB_in = 9'b1;
			loadptrA = 1'b0;
			loadptrB = 1'b0;
		end
		
	endcase
end

endmodule

////////////////////////registers///////////////////////
///flip flop
module Dreg 
(
	input Clk, Load, Reset, 
	input [15:0] D,
	output logic [15:0] Q
);

always_ff @ (posedge Clk) 
begin
	if (Reset)
		Q <= 1'b0; 
	else 
		if (Load)
			Q <= D;
		else 
			Q <= Q;
end
endmodule 

///delay line shift register
module memBlock( 
	input clk,
	output logic [15:0] q,
	input  [15:0] data,
	input [9:0] wraddress, rdaddress,
	input wren, rden
);

	logic [9:0] read_address_reg;
	logic [15:0] mem [1023:0];
	reg rden_reg;
	
	always @ (posedge clk)
	begin
		if (wren) 
			mem[wraddress] <= data;
	end
	always @ (posedge clk) begin
		if (rden_reg)
			q <= mem[read_address_reg];
		read_address_reg <= rdaddress;
		rden_reg <= rden;
	end
	
endmodule 
