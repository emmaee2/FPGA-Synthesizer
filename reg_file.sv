//delay line register file
module ks_regfile(
  input clk,
  input reset,
  input write, //0read, 1write
  input [7:0]r2address,
  input [15:0]sampleIn,
  
  output [15:0] sampleOut1,
  output [15:0] sampleOut2
);
parameter LEN = 218; // length of table

logic [15:0] delayLine[(LEN-1):0]; //Len # of samples each 16 bits

always_ff @(posedge clk) begin
	//reset
	if (reset) begin
		for(int i = 0; i < LEN; i++) begin
			delayLine[i] <= 16'b0;
		end
	end
	else if (write) begin
		delayLine[r2address] <= sampleIn;
	end
end

always_comb begin	
	//outputs
	sampleOut2 = delayLine[r2address];
	
	if (r2address == 8'b0)
		sampleOut1 = delayLine[(LEN - 1)];
	else
		sampleOut1 = delayLine[(r2address - 1)];
end
	
			
endmodule



module avg_register(
	input clk,
	input write, //0read, 1write
	input [15:0] in,
  
	output [15:0] out
);
logic [15:0] next;


always_ff @(posedge clk) begin
	out <= next;
end

always_comb begin
	next = out;
	if(write)
		next = in;
	else
		next = out;
end


endmodule
