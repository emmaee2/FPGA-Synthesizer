module drumkit (
		input [7:0] note,
		output snare,
		output bass,
		output cymbal
);

	 
	 //keyboard
always_comb
	begin
	  snare = 1'b0;
	  bass = 1'b0;
	  cymbal = 1'b0;
				
	  case(note)
			8'd5:			// 'B'
			begin
				snare = 1'b1;
			end 
			
			8'd17:			// 'N' 
			begin
				cymbal = 1'b1;
			end 
			
			8'd44:			// 'Space'
			begin
				bass = 1'b1;
			end
			
			default:
			begin
				snare = 1'b0;
				bass = 1'b0;
				cymbal = 1'b0;
			end
		endcase
end
endmodule

