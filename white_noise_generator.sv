//lfsr generates psuedo random numbers to simulate white nosie

module white_noise_generator (
	input   logic       clk,       // clock input
	input   logic       reset,      // reset input
	input   logic       enable,
	output  logic       lsb  
);

parameter LN =  8;
parameter [(LN - 1): 0] TAPS = 8'hb4;
parameter [(LN - 1): 0] INIT_FILL = { { (LN-1){1'b0}}, 1'b1 };

logic [(LN - 1): 0] sreg = INIT_FILL;


always_ff @(posedge clk)
if (reset) begin // active high reset
  sreg <= INIT_FILL ;
end else if (enable) begin
   if (lsb)
		sreg <= {1'b0, sreg[(LN-1):1]} ^ TAPS; //XOR if lsb is 1
	else
		sreg <= {1'b0, sreg[(LN-1):1]}; //otherwise shift
end 

assign	lsb = sreg[0];

endmodule // End Of Module counter

