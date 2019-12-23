//-------------------------------------------------------------------------
//    scope.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module keycode_reader(
	input logic [7:0] keycode,
	output logic w_on, a_on, s_on, d_on, e_on, f_on, t_on, g_on, y_on, h_on, u_on, j_on, k_on, c_on, l_on, 
	b_on, n_on, spacebar_on
);

// piano
assign a_on = (keycode == 8'h04);
assign w_on = (keycode == 8'h1A);
assign s_on = (keycode == 8'h16);
assign e_on = (keycode == 8'h08); 
assign d_on = (keycode == 8'h07);
assign f_on = (keycode == 8'h09);
assign t_on = (keycode == 8'h17);
assign g_on = (keycode == 8'h0A);
assign y_on = (keycode == 8'h1C);
assign h_on = (keycode == 8'h0B);
assign u_on = (keycode == 8'h18);
assign j_on = (keycode == 8'h0D);
assign k_on = (keycode == 8'h0E);
assign l_on = (keycode == 8'h0F);


// guitar
assign c_on = (keycode == 8'h06);


// drums 
assign b_on = (keycode == 8'h05); // snare
assign n_on = (keycode == 8'h11); // cymbal
assign spacebar_on = (keycode == 8'h2C); // bass

endmodule

