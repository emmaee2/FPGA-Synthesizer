//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( 
							  input        [9:0] DrawX, DrawY,      // Current pixel coordinates
							  input logic [1:0] InstrumentSel, // WHEN ADDING DRUMS, MAKE IT [1:0] 
							  input logic [7:0] keycode,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	

// ****************	
	 logic[3:0] back_Out;
	 logic[3:0] strings_Out;
	 logic[3:0] piano_Out;
	 logic[3:0] dot_Out;
	 
	 logic[3:0] drums_Out;
	 logic[3:0] boom_Out;
	 logic[3:0] crash_Out;
	 logic[3:0] crash_Out2;
	 
	 logic[3:0] A_Out; 
	 logic[3:0] W_Out; 
	 logic[3:0] S_Out;
	 logic[3:0] E_Out; 
	 logic[3:0] D_Out; 
	 logic[3:0] F_Out;
	 logic[3:0] T_Out; 
	 logic[3:0] G_Out; 
	 logic[3:0] Y_Out;
	 logic[3:0] H_Out;
	 logic[3:0] U_Out; 
	 logic[3:0] J_Out; 
	 logic[3:0] K_Out;
	 
	 
	 
// ****************
	
	  
	frameROM frame( // background
		.read_address(int'(DrawX/20) +  int'(DrawY/20)*32), // int'(x) --> casts x to type int
		.data_Out(back_Out)  
);


	stringsROM thestrings( // 40 x 64
		.read_address((int'((DrawX-176)/7))  + int'(DrawY/7)*40), 
		.data_Out(strings_Out)
);

	pianoROM thepiano( // 80 x 40
		.read_address(int'((DrawX-120)/5) + int'((DrawY-145)/7)*80), 
		.data_Out(piano_Out)
);


	drumsROM thedrums( // 80 x 40
		.read_address(int'((DrawX-78)/6) + int'((DrawY-190)/7)*80), // 480 x 280
		.data_Out(drums_Out)
);


	dotROM thedot( // 40 x 40
		.read_address(((DrawX-207)*3) + (DrawY-300)*48), 
		.data_Out(dot_Out)
);

// ************* KEYCODE ********************

logic a_On;

	keycode_reader kra(
		.keycode, 
		.a_on(a_On)
	);	
	
	
logic w_On;

	keycode_reader krw(
		.keycode, 
		.w_on(w_On)
	);	
	
logic s_On;

	keycode_reader krs(
		.keycode, 
		.s_on(s_On)
	);	
	
logic e_On;

	keycode_reader kre(
		.keycode, 
		.e_on(e_On)
	);	
	
logic d_On;

	keycode_reader krd(
		.keycode, 
		.d_on(d_On)
	);	
	
logic f_On;

	keycode_reader krf(
		.keycode, 
		.f_on(f_On)
	);	

logic t_On;

	keycode_reader krt(
		.keycode, 
		.t_on(t_On)
	);		

logic g_On;

	keycode_reader krg(
		.keycode, 
		.g_on(g_On)
	);	

logic y_On;

	keycode_reader kry(
		.keycode, 
		.y_on(y_On)
	);	
	
logic h_On;

	keycode_reader krh(
		.keycode, 
		.h_on(h_On)
	);	
	
logic u_On;

	keycode_reader kru(
		.keycode, 
		.u_on(u_On)
	);	
	
logic j_On;

	keycode_reader krj(
		.keycode, 
		.j_on(j_On)
	);	
	
logic k_On;

	keycode_reader krk(
		.keycode, 
		.k_on(k_On)
	);	

logic c_On;

	keycode_reader krc(
		.keycode, 
		.c_on(c_On)
	);	
	
logic l_On;

	keycode_reader krl(
		.keycode, 
		.l_on(l_On)
	);	
	

logic b_On;

	keycode_reader krb(
		.keycode, 
		.b_on(b_On)
	);	
	
logic n_On;

	keycode_reader krn(
		.keycode, 
		.n_on(n_On)
	);	
	
logic spb_On;

	keycode_reader krspc(
		.keycode, 
		.spacebar_on(spb_On)
	);	


// *************LETTERS**********************

	letterAROM letterA( // 33 x 33
		.read_address((DrawX-132) + (DrawY-330)*33), 
		.data_Out(A_Out)
);

	letterWROM letterW(   // 33 x 33
		.read_address((DrawX-156) + (DrawY-220)*33), 
		.data_Out(W_Out)
);

	letterSROM letterS(   // 33 x 33
		.read_address((DrawX-182) + (DrawY-330)*33), 
		.data_Out(S_Out)
);

	letterEROM letterE(   // 33 x 33
		.read_address((DrawX-206) + (DrawY-220)*33), 
		.data_Out(E_Out)
);

	letterDROM letterD(   // 33 x 33
		.read_address((DrawX-232) + (DrawY-330)*33), 
		.data_Out(D_Out)
);

	letterFROM letterF(   // 33 x 33
		.read_address((DrawX-282) + (DrawY-330)*33), 
		.data_Out(F_Out)
);

	letterTROM letterT(   // 33 x 33
		.read_address((DrawX-306) + (DrawY-220)*33), 
		.data_Out(T_Out)
);

	letterGROM letterG(   // 33 x 33
		.read_address((DrawX-332) + (DrawY-330)*33), 
		.data_Out(G_Out)
);

	letterYROM letterY(   // 33 x 33
		.read_address((DrawX-356) + (DrawY-220)*33), 
		.data_Out(Y_Out)
);

	letterHROM letterH(   // 33 x 33
		.read_address((DrawX-382) + (DrawY-330)*33), 
		.data_Out(H_Out)
);

	letterUROM letterU(   // 33 x 33
		.read_address((DrawX-406) + (DrawY-220)*33), 
		.data_Out(U_Out)
);

	letterJROM letterJ(   // 33 x 33
		.read_address((DrawX-432) + (DrawY-330)*33), 
		.data_Out(J_Out)
);

	letterKROM letterK(   // 33 x 33
		.read_address((DrawX-480) + (DrawY-330)*33), 
		.data_Out(K_Out)
);


// ****************************** END LETTERS **********************************************


// ****************************** START CRASHES **********************************************

	 crashROM crashy(   // 30 X 15
		.read_address(int'((DrawX-87)/4) + int'((DrawY-230)/3)*30),  // 120x75
		.data_Out(crash_Out)
);

	 crash2ROM crashy2(   // 30 X 15
		.read_address(int'((DrawX-420)/4) + int'((DrawY-230)/3)*30),  // 120x75
		.data_Out(crash_Out2)
);


	 boomROM boomy(   // 30 X 30
		.read_address(int'((DrawX-170)/9) + int'((DrawY-200)/9)*30),  // 270x270
		.data_Out(boom_Out)
);

// ***************************** END CRASHES **************************************************
  

  always_comb
    begin

// ******************************PIANO LETTERS********************************************

// LETTER A (C)

if(DrawX >= 132 && DrawX <= 162 && DrawY >= 330  && DrawY <= 360 && InstrumentSel == 2'b01)
		  begin
		  unique case(A_Out)
				
				4'd0: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd1: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end	


// LETTER W (C#)		  
else if(DrawX >= 156 && DrawX <= 186 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b01)
		  begin
		  unique case(W_Out)
				
				4'd1: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd0: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end	
		  
		  
// LETTER S (D)		  
else if(DrawX >= 182 && DrawX <= 212 && DrawY >= 330  && DrawY <= 360 && InstrumentSel == 2'b01)
		  begin
		  unique case(S_Out)
				
				4'd0: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd1: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end


// LETTER E (D#)		  
else if(DrawX >= 206 && DrawX <= 236 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b01)
		  begin
		  unique case(E_Out)
			
				4'd1: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd0: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end
			endcase
		  end	
	
// LETTER D (E)		  
else if(DrawX >= 232 && DrawX <= 262 && DrawY >= 330  && DrawY <= 360 && InstrumentSel == 2'b01)
		  begin
		  unique case(D_Out)
				
				4'd0: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd1: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end	
		 
// LETTER F (F)		  
else if(DrawX >= 282 && DrawX <= 312 && DrawY >= 330  && DrawY <= 360 && InstrumentSel == 2'b01)
		  begin
		  unique case(F_Out)
				
				4'd0: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd1: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end	 
		  
// LETTER T (F#)		  
else if(DrawX >= 306 && DrawX <= 336 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b01)
		  begin
		  unique case(T_Out)
				
				4'd1: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd0: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end
			endcase
		  end			  

// LETTER G (G)		  
else if(DrawX >= 332 && DrawX <= 362 && DrawY >= 330  && DrawY <= 360 && InstrumentSel == 2'b01)
		  begin
		  unique case(G_Out)
				
				4'd0: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd1: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end	
		  
// LETTER Y (G#)		  
else if(DrawX >= 356 && DrawX <= 386 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b01)
		  begin
		  unique case(Y_Out)
				
			4'd1: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd0: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end	
		  
// LETTER H (A)		  
else if(DrawX >= 382 && DrawX <= 412 && DrawY >= 330  && DrawY <= 360 && InstrumentSel == 2'b01)
		  begin
		  unique case(H_Out)
				
				4'd0: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd1: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end	
		  
// LETTER U (A#)		  
else if(DrawX >= 406 && DrawX <= 436 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b01)
		  begin
		  unique case(U_Out)
				
			4'd1: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd0: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end	

// LETTER J (B)		  
else if(DrawX >= 432 && DrawX <= 462 && DrawY >= 330  && DrawY <= 360 && InstrumentSel == 2'b01)
		  begin
		  unique case(J_Out)
				
				4'd0: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd1: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end	

// LETTER K (HIGH C)		  
else if(DrawX >= 480 && DrawX <= 510 && DrawY >= 330  && DrawY <= 360 && InstrumentSel == 2'b01)
		  begin
		  unique case(K_Out)
				
				4'd0: begin   // white
				  	Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;
				end

				
				4'd1: begin   // black
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end

			endcase
		  end			  
		  

// ******************************PIANO DOTS********************************************

// LOW C 
else if(DrawX >= 132 && DrawX <= 162 && DrawY >= 380  && DrawY <= 410 && InstrumentSel == 2'b01 && a_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end	
		 
// C SHARP 
 else if(DrawX >= 157 && DrawX <= 187 && DrawY >= 270  && DrawY <= 300 && InstrumentSel == 2'b01 && w_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // yellow
				  	Red = 8'hFE;
              Green = 8'hDE;
              Blue = 8'h7E;
				end

			endcase
		  end	 
// D 
 else if(DrawX >= 182 && DrawX <= 212 && DrawY >= 380  && DrawY <= 410 && InstrumentSel == 2'b01 && s_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		

	  
// D SHARP 
 else if(DrawX >= 207 && DrawX <= 237 && DrawY >= 270  && DrawY <= 300 && InstrumentSel == 2'b01 && e_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // yellow
					Red = 8'hFE;
              Green = 8'hDE;
              Blue = 8'h7E;
				end

			endcase
		  end
// E
 else if(DrawX >= 232 && DrawX <= 262 && DrawY >= 380  && DrawY <= 410 && InstrumentSel == 2'b01 && d_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end	
		  
// F 
 else if(DrawX >= 282 && DrawX <= 312 && DrawY >= 380  && DrawY <= 410 && InstrumentSel == 2'b01 && f_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end	
		 
// F SHARP 
 else if(DrawX >= 307 && DrawX <= 337 && DrawY >= 270  && DrawY <= 300 && InstrumentSel == 2'b01 && t_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // yellow
				  		  	Red = 8'hFE;
              Green = 8'hDE;
              Blue = 8'h7E;
				end

			endcase
		  end 
		  
// G
 else if(DrawX >= 332 && DrawX <= 362 && DrawY >= 380  && DrawY <= 410 && InstrumentSel == 2'b01 && g_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end	
// G SHARP 
 else if(DrawX >= 357 && DrawX <= 387 && DrawY >= 270  && DrawY <= 300 && InstrumentSel == 2'b01 && y_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // yellow
				  	  	Red = 8'hFE;
              Green = 8'hDE;
              Blue = 8'h7E;
				end

			endcase
		  end		  
		  
// A 
 else if(DrawX >= 382 && DrawX <= 412 && DrawY >= 380  && DrawY <= 410 && InstrumentSel == 2'b01 && h_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end	
		 
// A SHARP 
 else if(DrawX >= 407 && DrawX <= 437 && DrawY >= 270  && DrawY <= 300 && InstrumentSel == 2'b01 && u_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // yellow
				 	  	Red = 8'hFE;
              Green = 8'hDE;
              Blue = 8'h7E;
				end

			endcase
		  end
		 
// B
 else if(DrawX >= 432 && DrawX <= 462 && DrawY >= 380  && DrawY <= 410 && InstrumentSel == 2'b01 && j_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end	
		  
// HIGH C 
 else if(DrawX >= 480 && DrawX <= 510 && DrawY >= 380  && DrawY <= 410 && InstrumentSel == 2'b01 && k_On)
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
 
		
// ****************************** START PIANO *******************************************

else if(DrawX >= 120 && DrawX <= 520 && DrawY >= 145  && DrawY <= 420 && InstrumentSel == 2'b01) 
		  begin //
		  unique case(piano_Out)
				
				4'd1: begin   // black
				  	 Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end
				
				4'd2: begin // white
				  	 Red = 8'hFF;
              Green = 8'hFF;
              Blue = 8'hFF;

				end
	
			endcase

		  end		
		  
// **************************** END PIANO **************************************************



// ********************************GUITAR NOTES ******************************************	

	 

// Low E 
	else if(DrawX >= 217 && DrawX <= 247 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && f_On )  
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		

// A		  
	else if(DrawX >= 252 && DrawX <= 282 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && g_On) //  
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
// D		  
	else if(DrawX >= 287 && DrawX <= 317 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && h_On) // 
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
// G		  
	else if(DrawX >= 322 && DrawX <= 352 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && j_On)  // 
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end	
// B		  
	else if(DrawX >= 357 && DrawX <= 387 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && k_On) // 
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		 
		  
// HIGH E
	else if(DrawX >= 392 && DrawX <= 422 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && l_On) // 
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		


// -----------------------------------------------------------------------

// ********************************GUITAR CHORDS ******************************************

// ** if C CHORD  
	else if(DrawX >= 252 && DrawX <= 282 && DrawY >= 345  && DrawY <= 375 && InstrumentSel == 2'b10 && c_On) // bottom note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
	else if(DrawX >= 287 && DrawX <= 317 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && c_On) // middle note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
	else if(DrawX >= 357 && DrawX <= 387 && DrawY >= 75  && DrawY <= 105 && InstrumentSel == 2'b10 && c_On) // top note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
// ** END C CHORD


// ** if E CHORD  
	else if(DrawX >= 252 && DrawX <= 282 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && e_On) // bottom note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
	else if(DrawX >= 287 && DrawX <= 317 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && e_On) // middle note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
	else if(DrawX >= 322 && DrawX <= 352 && DrawY >= 95  && DrawY <= 125 && InstrumentSel == 2'b10 && e_On) // top note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
// ** END E CHORD



// ** if A CHORD  
	else if(DrawX >= 252 && DrawX <= 282 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && a_On) // bottom note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
	else if(DrawX >= 287 && DrawX <= 317 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && a_On) // middle note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
	else if(DrawX >= 322 && DrawX <= 352 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && a_On) // top note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
// ** END A CHORD


// ** if D CHORD  
	else if(DrawX >= 322 && DrawX <= 352 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && d_On) // lowest note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
	else if(DrawX >= 357 && DrawX <= 387 && DrawY >= 345  && DrawY <= 375 && InstrumentSel == 2'b10 && d_On) // middle note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
	else if(DrawX >= 392 && DrawX <= 422 && DrawY >= 220  && DrawY <= 250 && InstrumentSel == 2'b10 && d_On) // lowest note
		  begin
		  unique case(dot_Out)
				
				4'd1: begin   // blue
				  	Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h76;
				end

			endcase
		  end		
		  
// ** END D CHORD





// -----------------------------------------------------------------------


// ** START GUITAR 
		 
	else if(DrawX >= 176 && DrawX <= 470 && DrawY >= 0 && DrawY <= 480 && strings_Out != 0 && InstrumentSel == 2'b10)
		  begin
		 
		 unique case(strings_Out)		
				4'd1: begin  
				  Red = 8'h27;
              Green = 8'h19;
              Blue = 8'h06;
				end
				
				4'd2: begin
				  Red = 8'h61;
              Green = 8'h61;
              Blue = 8'h61;
				end
				
				4'd3: begin
				  Red = 8'hA9;
              Green = 8'h90;
              Blue = 8'h30;
				end
				
			endcase
		  end

// ****************************** END GUITAR ********************************************


// **************************** START DRUM CRASH *****************************************

// snare  
else if(DrawX >= 87 && DrawX <= 212 && DrawY >= 230 && DrawY <= 330 && crash_Out != 0 && InstrumentSel == 2'b11 && b_On) //  
		  begin
		 
		 unique case(crash_Out)		
				
				4'd1: begin
				  Red = 8'h88;
              Green = 8'h7C;
              Blue = 8'h11;
				end
				
				4'd2: begin
				  Red = 8'hE6;
              Green = 8'hD2;
              Blue = 8'h19;
				end
				
			endcase
		  end
		  
// cymbal
else if(DrawX >= 420 && DrawX <= 545 && DrawY >= 230 && DrawY <= 330 && crash_Out2 != 0 && InstrumentSel == 2'b11 && n_On) // 
		  begin
		 
		 unique case(crash_Out2)		
				
				4'd1: begin
				  Red = 8'h88;
              Green = 8'h7C;
              Blue = 8'h11;
				end
				
				4'd2: begin
				  Red = 8'hE6;
              Green = 8'hD2;
              Blue = 8'h19;
				end
				
			endcase
		  end		  

// bass 		  
else if(DrawX >= 170  && DrawX <= 420 && DrawY >= 200 && DrawY <= 465 && boom_Out != 0 && InstrumentSel == 2'b11  && spb_On) // 
		  begin
		 // used to be 200, 145, 165 
		 unique case(boom_Out)		
				
				4'd1: begin
				  Red = 8'h88;
              Green = 8'h7C;
              Blue = 8'h11;
				end
				
				4'd2: begin
				  Red = 8'hE6;
              Green = 8'hD2;
              Blue = 8'h19;
				end
				
			endcase
		  end


// ******************************* END DRUM CRASH *************************************************




// **************************** START DRUM IMAGE *****************************************
else if(DrawX >= 78 && DrawX <= 578 && DrawY >= 190 && DrawY <= 475 && drums_Out != 0 && InstrumentSel == 2'b11)
		 begin
		 
		 unique case(drums_Out)		
				4'd1: begin  
				  Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
				end
				
				4'd2: begin
				  Red = 8'h89;
              Green = 8'h7E;
              Blue = 8'h7E;
				end
				
				4'd3: begin
				  Red = 8'h52;
              Green = 8'h06;
              Blue = 8'h06;
				end
				
				4'd4: begin
				  Red = 8'h67;
              Green = 8'h5C;
              Blue = 8'h0B;
				end
				
				4'd5: begin
				  Red = 8'hE3;
              Green = 8'hDF;
              Blue = 8'hD4;
				end
				
				4'd6: begin
				  Red = 8'hA3;
              Green = 8'h92;
              Blue = 8'h10;
				end
				
			endcase
		  end
		  
// **************************** END DRUM IMAGE *****************************************


	 else
        begin  
			unique case(back_Out)
				4'd1: begin  
				  Red = 8'hF3;
              Green = 8'hF0;
              Blue = 8'hEC;
				end
				
				4'd2: begin
				  Red = 8'h4A;
              Green = 8'h30;
              Blue = 8'h0A;
				end
				
				4'd3: begin
				  Red = 8'h73;
              Green = 8'h47;
              Blue = 8'h10;
				end
				
				4'd4: begin
				  Red = 8'h73;
              Green = 8'h52;
              Blue = 8'h20;
				end
				
				4'd5: begin
				  Red = 8'h2E;
              Green = 8'h1E;
              Blue = 8'h06;
				end
				
				4'd6: begin
				  Red = 8'h37;
              Green = 8'h00;
              Blue = 8'h0F;
				end
			endcase	
	
		 end	  // for else   
    end // for always_comb
    
endmodule
