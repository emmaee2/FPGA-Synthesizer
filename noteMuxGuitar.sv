module note_mux_guitar (
		input Clk,
		input [7:0] note,
		output [6:0] pluck,
		output [4:0]pflag
);
							  
    
always_ff @ (posedge Clk) begin
	if (pluck[1])
		pflag = 5'd1;
	if (pluck[2])
		pflag = 5'd2;
	if (pluck[3])
		pflag = 5'd3;
	if (pluck[4])
		pflag = 5'd4;
	if (pluck[5])
		pflag = 5'd5;
	if (pluck[6])
		pflag = 5'd6;
	if (pluck == 7'b1111111)
		pflag = 5'd7;
	if (pluck == 7'b1111110)
		pflag = 5'd8;	
	if (pluck == 7'b1111100)
		pflag = 5'd9;	
	if (pluck == 7'b1111000)
		pflag = 5'd10;	
end


//keyboard
 always_comb
	begin
	  pluck = 7'b0;
		  
	  case(note)
			8'd9:			// 'F'
			begin
				pluck = 7'b0000010;
			end 
			
			8'd10:			// 'G'
			begin
				pluck  = 7'b0000100;
			end
				
			8'd11:			// 'H'  
			begin
				pluck = 7'b0001000;
			end
				
			8'd13:			// 'J' 
			begin
				pluck  = 7'b0010000;
			end
					
			8'd14:			// 'K'  
			begin
				pluck = 7'b0100000;
			end
				
			8'd15:			// 'L' 
			begin
				pluck = 7'b1000000;
			end
			
			8'd6:			// 'C' C CHORD
			begin
				pluck = 7'b1111111;
			end
			
			8'd8:			// 'E' E CHORD
			begin
				pluck = 7'b1111110;
			end
			
			8'd4:			// 'A' A CHORD
			begin
				pluck = 7'b1111100;
			end
			
			8'd7:			// 'space' D CHORD
			begin
				pluck = 7'b1111000;
			end
			
			default:
			begin
				pluck = 7'b0;
			end
		endcase
end
	
endmodule

