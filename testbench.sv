module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
//logic reset;
//logic clk;
//logic enable;
//logic lsb;
//
//// Instantiating the DUT
//white_noise_generator lfsr_mod(.*);

//////////////////ks test//
logic Clk;
logic [9:0] ClkCount;
logic data_over; 
logic reset;
logic pluck;
logic [15:0] stringE;
				
				
KS_algorithm guitar_stringE(.Clk(Clk), .Reset(reset), .pluck(pluck), 
											  .data_over(data_over), .stringlen(10'd147),
											  .sample_out(stringE));



//logic [127:0]  Cipherkey;
//assign rndkey1 = AES.AES.KEY_SCHEDULE[127:0];
////assign rndkey11 = AES.AES.KEY_SCHEDULE[1407:1280];
////assign rndkey10 = AES.AES.KEY_SCHEDULE[1279:1152];
//assign roundNum = AES.AES.roundNum;
//assign count = AES.AES.state_controller.count;
//assign KEY_SCHEDULE = AES.AES.KEY_SCHEDULE;
//
//assign addroundkey_op = AES.AES.addroundkey_op;
//assign invsubbytes_op = AES.AES.invsubbytes_op;
//assign shiftrow_op = AES.AES.shiftrow_op;
//assign mixcol_op = AES.AES.mixcol_op;
//
//assign output_state_code = AES.AES.output_state_code;
//assign AES_STATE = AES.AES.AES_STATE;
//assign next_key = AES.AES.next_key;



always begin: CLOCK_GENERATION
	#1 Clk <= ~Clk;
	if (ClkCount == 10'd1000)	begin
		data_over <= ~data_over;
		ClkCount <= 10'b0;
	end
	ClkCount <= ClkCount + 1'b1;
end

initial begin: CLOCK_INITALIZATION
	Clk <= 0;
	data_over <= 0;
	ClkCount <= 0; 
end

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
	reset = 0;
	pluck = 0;
	
	#2 reset = 1;
	#2 reset = 0;
	
	#20000 pluck = 1;
	#20000 pluck = 0;
  
	



end
endmodule
