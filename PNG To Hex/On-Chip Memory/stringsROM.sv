/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  stringsROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:3839]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/strings1.txt", mem);
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule
