/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  letterAROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterA.txt", mem); // PIANO C 
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule


// -------------------------------------------------------------


module  letterWROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterW.txt", mem); // PIANO C#
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterSROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterS.txt", mem); // PIANO D
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule



// -------------------------------------------------------------

module  letterEROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterE.txt", mem); // PIANO D#
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterDROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterD.txt", mem); // PIANO E
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterFROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterF.txt", mem); // PIANO F
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterTROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterT.txt", mem); // PIANO F#
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterGROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterG.txt", mem); // PIANO G
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterYROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterY.txt", mem); // PIANO G#
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterHROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterH.txt", mem); // PIANO A
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterUROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterU.txt", mem); // PIANO A#
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterJROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterJ.txt", mem); // PIANO B
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


module  letterKROM
(
		input logic [18:0] read_address,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:857]; // from [3:0] to [1:0]
 
initial
begin
	 $readmemh("sprite_bytes/LetterK.txt", mem); // PIANO HIGH C
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule

// -------------------------------------------------------------


