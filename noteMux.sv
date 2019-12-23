module note_mux (
		input [7:0] note,
		input octave,
		input hloctave,
		output [31:0]idxjmp	
);
////   A          220      = (48000)*19685267/(2^32)
////   A#         233.082  
////   B          246.942  
////   C          261.626
////   C#         277.183  = 277.183 * 1.0594631 (twelfth root of 2)
////   D          293.665
////   D#         311.127
////   E          329.628
////   F          349.228  * (2^32) / (48000)  = 31248430 (JUMPF)
////   F#         369.994
////   G          391.995
////   G#         415.305
////   A          440      => twice the frequency of A low

logic [31:0] jumpA = 32'd19685267;
logic [31:0] jumpAs = 32'd20855824;
logic [31:0] jumpB = 32'd22095976;
logic [31:0] jumpC = 32'd23409871;
logic [31:0] jumpCs = 32'd24801895;
logic [31:0] jumpD = 32'd26276692;
logic [31:0] jumpDs = 32'd27839186;
logic [31:0] jumpE = 32'd29494590;
logic [31:0] jumpF = 32'd31248430;
logic [31:0] jumpFs = 32'd33106558;
logic [31:0] jumpG = 32'd35075177;
logic [31:0] jumpGs = 32'd37160856;
logic [31:0] jumpAh = 32'd39370555;

	 
	 //keyboard
	 always_comb
		begin
		  idxjmp = 32'b0;
		  case(note)
				8'h4:			// 'A'
				begin
					idxjmp = jumpA;
				end 
				
				8'h1A:			// 'W' 
				begin
					idxjmp = jumpAs;
				end 
				
				8'h16:			// 'S'
				begin
					idxjmp = jumpB;
				end
				
				8'h8:			// 'E' 
				begin
					idxjmp = jumpC;
				end
				
				8'h7:			// 'D'  
				begin
					idxjmp = jumpCs;
				end
				
				8'h9:			// 'F' 
				begin
					idxjmp = jumpD;
				end
				
				8'h17:			// 'T' 
				begin
					idxjmp = jumpDs;
				end
				
				8'hA:			// 'G'  
				begin
					idxjmp = jumpE;
				end
				
				8'h1C:			// 'Y' 
				begin
					idxjmp = jumpF;
				end
				
				8'hB:			// 'H' 
				begin
					idxjmp = jumpFs;
				end
				
				8'h18:			// 'U'  
				begin
					idxjmp = jumpG;
				end
				
				8'hD:			// 'J' 
				begin
					idxjmp = jumpGs;
				end
				
				8'hE:			// 'K' 
				begin
					idxjmp = jumpAh;
				end
				
				default:
				begin
					idxjmp = 32'b0;
				end
			endcase
			if(octave)	begin
				if (hloctave)
					idxjmp = idxjmp << 1;
				else
					idxjmp = idxjmp >> 1;
			end
	end
endmodule

