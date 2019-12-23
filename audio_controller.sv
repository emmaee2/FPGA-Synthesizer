

module audio_initializer(
	input logic Clk,
	input logic reset,
	//input logic data_over, //high when full signal is ready to be output, low when time to load
	input logic init_finish,
	
	output logic init
);

enum logic {INITIALIZE, READY} state, next_state;


always_ff @ (posedge Clk)
	begin 
		if(reset) begin
			state <= INITIALIZE;
		end
		else begin
			state <= next_state;
		end
	end

//state comb block
always_comb
begin
	//next_state = state;
	
	case(state)
		INITIALIZE : 
		begin	
			if(init_finish)
				next_state = READY;
			else
				next_state = INITIALIZE;
		end
			
		READY : 
		begin
			next_state = READY;
		end

	endcase
end

//signal comb block
always_comb
begin
	
	case(state)
		INITIALIZE :
		begin
			init = 1'b1;
		end
		
		READY :
		begin
			init = 1'b0;
		end
	endcase


end	

endmodule
