//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module top_level( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX4, HEX5, HEX6, HEX7,
				 input        [17:0] SW,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,     //SDRAM Clock
				//audio stuff						
				output logic AUD_XCK, 
				input logic AUD_BCLK, 
				input logic AUD_ADCDAT, 
				output logic AUD_DACDAT, 
				input logic AUD_DACLRCK, AUD_ADCLRCK, 
				output logic I2C_SDAT, 
				output logic I2C_SCLK
                    );
    
    logic Reset_h, Clk;
    logic [7:0] keycode;
	 logic [9:0] DrawX, DrawY;
	 logic [1:0] Instrument;
	 
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
			Reset_h <= ~(KEY[0]); 	  // The push buttons are active low
	 end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
	 logic is_ball, w_on, a_on, s_on, d_on, e_on, f_on, t_on, g_on, y_on, h_on, u_on, j_on, 
			 k_on, c_on, l_on, b_on, n_on, spacebar_on;
    
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );
     
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     nios_system nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset),
									  
									  //snare
								     .onchip_memory2_0_reset1_reset(1'b1), 
									  //.onchip_memory2_0_reset1_reset_req(), //                        .reset_req
									  .onchip_memory2_0_s1_address(ROM_ADDR_SNARE),       //     onchip_memory2_0_s1.address
									  .onchip_memory2_0_s1_debugaccess(1'b0),  
									  .onchip_memory2_0_s1_clken(1'b1),     
									  .onchip_memory2_0_s1_chipselect(1'b1),  
									  .onchip_memory2_0_s1_write(1'b0),  
									  .onchip_memory2_0_s1_readdata(ROM_DATA_SNARE),  
								     .onchip_memory2_0_s1_writedata(16'b0),  
									  .onchip_memory2_0_s1_byteenable(2'b11),  
    
										//cymbal
								     .onchip_memory_0_reset1_reset(1'b1),   
									  //.onchip_memory_0_reset1_reset_req(), //                        .reset_req
									  .onchip_memory_0_s1_address(ROM_ADDR_CYMBAL),       //     onchip_memory2_0_s1.address
									  .onchip_memory_0_s1_debugaccess(1'b0),   
									  .onchip_memory_0_s1_clken(1'b1),      
									  .onchip_memory_0_s1_chipselect(1'b1),   
									  .onchip_memory_0_s1_write(1'b0),        
									  .onchip_memory_0_s1_readdata(ROM_DATA_CYMBAL),   
								     .onchip_memory_0_s1_writedata(16'b0), 
									  .onchip_memory_0_s1_byteenable(2'b11),
									 
										//bass
								     .onchip_memory_1_reset1_reset(1'b1),     // onchip_memory2_0_reset1.reset
									  //.onchip_memory_1_reset1_reset_req(), //                        .reset_req
									  .onchip_memory_1_s1_address(ROM_ADDR_BASS),  
									  .onchip_memory_1_s1_debugaccess(1'b0),  
									  .onchip_memory_1_s1_clken(1'b1),        
									  .onchip_memory_1_s1_chipselect(1'b1),    
									  .onchip_memory_1_s1_write(1'b0),       
									  .onchip_memory_1_s1_readdata(ROM_DATA_BASS),    
								     .onchip_memory_1_s1_writedata(16'b0),   
									  .onchip_memory_1_s1_byteenable(2'b11)  
	 );
	 
	 
    
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
// TODO: Fill in the connections for the rest of the modules  
    VGA_controller vga_controller_instance
	 (
		.Clk, .Reset(Reset_h), 
		.VGA_HS, .VGA_VS, .VGA_CLK, .VGA_BLANK_N, .VGA_SYNC_N, 
		.DrawX, .DrawY
	 );
	
	 
	 keycode_reader reader0(.*);
    
    color_mapper color_instance(.InstrumentSel(Instrument),.*);
	 
    // Display keycode on hex display
//	 logic [3:0] hex3tester;
//	 logic [3:0] hex2tester = 4'b0;
//	 assign hex3tester = pflag;
	 
    HexDriver hex_inst_0 (keycode[3:0], HEX0);
    HexDriver hex_inst_1 (keycode[7:4], HEX1);
//    HexDriver hex_inst_2 (hex2tester, HEX2);
//    HexDriver hex_inst_3 (hex3tester, HEX3);
	 
	 HexDriver hex_inst_4 (lOut[3:0], HEX4);
    HexDriver hex_inst_5 (lOut[7:4], HEX5);
	 HexDriver hex_inst_6 (lOut[11:8], HEX6);
    HexDriver hex_inst_7 (lOut[15:12], HEX7);
	 
	 //audio interface
	 //useful signals for outputting sound
	 logic [15:0] lOut, rOut;
	 logic init, init_finish, data_over;
	 //for adc (not relevant)
	 logic adc_full;
	 logic [31:0] ADCDATA;
	 //declaring the rest
	 audio_interface audioDriver
	 (	
		.LDATA(lOut), .RDATA(rOut),
		.clk(Clk), .Reset(Reset_h), .INIT(init),
		.INIT_FINISH(init_finish),
		.adc_full(adc_full),
		.data_over(data_over),
		.AUD_MCLK(AUD_XCK), .AUD_BCLK(AUD_BCLK), .AUD_ADCDAT(AUD_ADCDAT), .AUD_DACDAT(AUD_DACDAT),
		.AUD_DACLRCK(AUD_DACLRCK), .AUD_ADCLRCK(AUD_ADCLRCK), .I2C_SDAT(I2C_SDAT),
		.I2C_SCLK(I2C_SCLK), .ADCDATA(ADCDATA)
	 );
	 
	
	 audio_initializer initializer(.Clk(Clk), .reset(Reset_h),	.init_finish(init_finish), .init(init));
	 
	///link to select///
	always_comb begin
		if(Instrument == 2'b01) begin
			rOut = lOutPiano;
			lOut = lOutPiano;
		end else if(Instrument == 2'b10) begin
			rOut = rOutGuitar;
			lOut = lOutGuitar;
		end else if(Instrument == 2'b11) begin
			rOut = lOutDrum;
			lOut = lOutDrum;
		end else begin
			rOut =  lOutPiano;
			lOut =  lOutPiano;
		end
	end
//	 
///////////////////////////pian0////////////////
//  A          220        
//  A#         233.082
//  B          246.942
//  C          261.626
//  C#         277.183
//  D          293.665
//  D#         311.127
//  E          329.628
//  F          349.228
//  F#         369.994
//  G          391.995
//  G#         415.305
////////////////////////////////////////////////

	 logic [31:0] phase;
	 logic [31:0] jump = 32'b0;
	 
	 always @(negedge data_over or posedge Reset_h) begin
		if (Reset_h)
			phase <= 32'b0;
		else
			phase <= phase + jump;
	 end
	 
	 logic [15:0] lOutPiano;
	 logic [7:0] idx;
	 assign idx = phase[31:24];
	 sine_table sinelu(.index(idx), .signal(lOutPiano)); //lOut is the appropriate sine
	 
	 note_mux note_select(.note(keycode[7:0]), .octave(SW[17]), .hloctave(SW[16]), .idxjmp(jump));
	 assign rOutPiano = lOutPiano;
	 
////////////////strings//////////////////////////////////////////////////////////
logic [15:0] lOutGuitar, rOutGuitar;
logic [15:0] stringE, stringB, stringG, stringD, stringA, stringEl;
logic [6:0] pluck;
logic [4:0] pflag;	

logic [15:0] CChordA, CChordD, CChordG, CChordB; 				
logic [15:0] EChordEl, EChordA, EChordD, EChordG;
logic [15:0] AChordA, AChordD, AChordG, AChordB;
logic [15:0] DChordD, DChordG, DChordB, DChordE;

//C CHORD
ks_string_controller guitar_CchordA(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111111), 
											  .data_over(data_over), .stringlen(10'd370),
											  .sample_out(CChordA));
ks_string_controller guitar_CchordD(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111111), 
											  .data_over(data_over), .stringlen(10'd294),
											  .sample_out(CChordD));						  
ks_string_controller guitar_CchordG(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111111), 
											  .data_over(data_over), .stringlen(10'd247),
											  .sample_out(CChordG));
ks_string_controller guitar_CchordB(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111111), 
											  .data_over(data_over), .stringlen(10'd185),
											  .sample_out(CChordB));

///E CHORD 
ks_string_controller guitar_EchordG(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111110), 
											  .data_over(data_over), .stringlen(10'd233),
											  .sample_out(EChordG));
ks_string_controller guitar_EchordD(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111110), 
											  .data_over(data_over), .stringlen(10'd294),
											  .sample_out(EChordD));
ks_string_controller guitar_EchordA(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111110), 
											  .data_over(data_over), .stringlen(10'd392),
											  .sample_out(EChordA));
ks_string_controller guitar_EchordEl(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111110), 
											  .data_over(data_over), .stringlen(10'd587),
											  .sample_out(EChordEl));				  

//A CHORD
ks_string_controller guitar_AchordA(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111111), 
											  .data_over(data_over), .stringlen(10'd440),
											  .sample_out(AChordA));
ks_string_controller guitar_AchordD(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111100), 
											  .data_over(data_over), .stringlen(10'd294),
											  .sample_out(AChordD));						  
ks_string_controller guitar_AchordG(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111100), 
											  .data_over(data_over), .stringlen(10'd220),
											  .sample_out(AChordG));
ks_string_controller guitar_AchordB(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111100), 
											  .data_over(data_over), .stringlen(10'd175),
											  .sample_out(AChordB));

//D CHORD
ks_string_controller guitar_DchordD(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111000), 
											  .data_over(data_over), .stringlen(10'd330),
											  .sample_out(DChordD));
ks_string_controller guitar_DchordG(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111000), 
											  .data_over(data_over), .stringlen(10'd220),
											  .sample_out(DChordG));						  
ks_string_controller guitar_DchordB(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111000), 
											  .data_over(data_over), .stringlen(10'd165),
											  .sample_out(DChordB));
ks_string_controller guitar_DchordE(.Clk(Clk), .Reset(Reset_h), .pluck(pluck == 7'b1111000), 
											  .data_over(data_over), .stringlen(10'd131),
											  .sample_out(DChordE));							
							
///STANDARD TUNING				
ks_string_controller guitar_stringEl(.Clk(Clk), .Reset(Reset_h), .pluck(pluck[1]), 
											  .data_over(data_over), .stringlen(10'd587),
											  .sample_out(stringEl));
											  
ks_string_controller guitar_stringA(.Clk(Clk), .Reset(Reset_h), .pluck(pluck[2]), 
											  .data_over(data_over), .stringlen(10'd440),
											  .sample_out(stringA));
											  
ks_string_controller guitar_stringD(.Clk(Clk), .Reset(Reset_h), .pluck(pluck[3]), 
											  .data_over(data_over), .stringlen(10'd330),
											  .sample_out(stringD));										  
											  
ks_string_controller guitar_stringG(.Clk(Clk), .Reset(Reset_h), .pluck(pluck[4]), 
											  .data_over(data_over), .stringlen(10'd247),
											  .sample_out(stringG));											  
											  
ks_string_controller guitar_stringB(.Clk(Clk), .Reset(Reset_h), .pluck(pluck[5]), 
											  .data_over(data_over), .stringlen(10'd196),
											  .sample_out(stringB));
											  
ks_string_controller guitar_stringE(.Clk(Clk), .Reset(Reset_h), .pluck(pluck[6]), 
											  .data_over(data_over), .stringlen(10'd147),
											  .sample_out(stringE)); 

note_mux_guitar string_select(.Clk(Clk), .note(keycode), .pluck(pluck), .pflag(pflag));

always_comb begin
	lOutGuitar = 16'b0;
	rOutGuitar = 16'b0;
	case(pflag)
		5'd7 : begin
			lOutGuitar = (CChordA >>> 1) + (CChordD >>> 1);
			rOutGuitar = (CChordG >>> 1) + (CChordB >>> 1);
		end	
		5'd8 : begin
			lOutGuitar = (EChordEl >>> 1) + (EChordA >>> 1); 
			rOutGuitar = (EChordG >>> 1) + (EChordD >>> 1);
		end	
		5'd9 : begin
			lOutGuitar = (AChordA >>> 1) + (AChordD >>> 1);
			rOutGuitar = (AChordG >>> 1) + (AChordB >>> 1);
		end	
		5'd10 : begin
			lOutGuitar = (DChordD >>> 1) + (DChordG >>> 1);
			rOutGuitar = (DChordB >>> 1) + (DChordE >>> 1);
		end	
		
		5'd6 : begin
			lOutGuitar = stringE;
			rOutGuitar = stringE;
		end
		5'd5 : begin
			lOutGuitar = stringB;
			rOutGuitar = stringB;
		end
		5'd4 : begin
			lOutGuitar = stringG;
			rOutGuitar = stringG;
		end
		5'd3 : begin
			lOutGuitar = stringD;
			rOutGuitar = stringD;
		end
		5'd2 : begin
			lOutGuitar = stringA;
			rOutGuitar = stringA;
		end
		5'd1 : begin
			lOutGuitar = stringEl;
			rOutGuitar = stringEl;
		end
		default : begin
			lOutGuitar = 16'b0;
			rOutGuitar = 16'b0;
			end
	endcase
end


///////////////drum////////////////////////////////
////uses on chip memory
logic [15:0]lOutDrum, rOutDrum;
logic [12:0] ROM_ADDR_SNARE;
logic [15:0] ROM_DATA_SNARE;
logic [12:0] ROM_ADDR_BASS;
logic [15:0] ROM_DATA_BASS;
logic [15:0] ROM_ADDR_CYMBAL;
logic [15:0] ROM_DATA_CYMBAL;
logic cymbal_hit;
logic snare_hit;
logic bass_hit;
assign rOutDrum = lOutDrum;

always @(negedge data_over or posedge Reset_h) begin
		if (Reset_h)
			ROM_ADDR_SNARE <= 13'b0;
		else if (snare_hit) begin
			if((ROM_ADDR_SNARE != 13'h1A79))
				ROM_ADDR_SNARE <= ROM_ADDR_SNARE + 1'b1;
		end
		else if(~snare_hit)
			ROM_ADDR_SNARE <= 13'b0;

end

always @(negedge data_over or posedge Reset_h) begin
		if (Reset_h)
			ROM_ADDR_BASS <= 13'b0;
		else if (bass_hit) begin
			if((ROM_ADDR_BASS != 13'h1F9D))
				ROM_ADDR_BASS <= ROM_ADDR_BASS + 1'b1;
		end
		else if(~bass_hit)
			ROM_ADDR_BASS <= 13'b0;
end

always @(negedge data_over or posedge Reset_h) begin
		if (Reset_h)
			ROM_ADDR_CYMBAL <= 16'b0;
		else if (cymbal_hit) begin
			if((ROM_ADDR_CYMBAL != 16'hBCFF))
				ROM_ADDR_CYMBAL <= ROM_ADDR_CYMBAL + 1'b1;
		end
//		else if((ROM_ADDR_CYMBAL != 16'hBCFF))
//			ROM_ADDR_CYMBAL <= ROM_ADDR_CYMBAL + 1'b1;
		else	
			ROM_ADDR_CYMBAL <= 16'b0;
end

drumkit hit_it( .note(keycode), .snare(snare_hit), .bass(bass_hit), .cymbal(cymbal_hit));

always_ff @(posedge Clk) begin
	if(snare_hit)
		lOutDrum = ROM_DATA_SNARE;
	else if(bass_hit)
		lOutDrum = ROM_DATA_BASS;
	else if(cymbal_hit)
		lOutDrum = ROM_DATA_CYMBAL;
end

//////////////////////////////////////////////
//this block is for a looped sample
//always @(negedge data_over or posedge Reset_h) begin
//		if (Reset_h)
//			ROM_ADDR <= 13'b0;
//		else if ((ROM_ADDR == 13'h1A79)) begin
//			ROM_ADDR <= 13'b0;
//		end else begin
//			ROM_ADDR <= ROM_ADDR + 1'b1;
//		end
//	 end

///////////////VGA DISPLAY STATE MACHINE/////////////////////
logic [1:0] in = 2'b00;
logic clear = 1'b0;


enum logic [3:0] {WAIT1, WAIT2, WAIT3, RESET, piano, guitar, drums, DoNothing} curr_state, nextstate; 


always_ff
begin
	in <= 2'b00;
	clear <= 1'b0;
	case (curr_state)
		RESET:
				clear <= 1'b1;
		piano:
				in <= 2'b01;
		guitar: 
				in <= 2'b10;
	   drums:
				in <= 2'b11;
		
		default:
		begin
				in <= 2'b00;
				clear <= 1'b0;
		end
	endcase
end

// 1'd1 = piano
// 1'd2 = guitar
// 1'd3 = drums

always_ff @ (posedge Clk)
begin
	
	Instrument = Instrument;

            curr_state <= nextstate;
				
				if(clear) // same as piano (default) -- also RESET
					begin
						Instrument <= 2'b01; 
					end
					
				else if(in == 2'b01) // piano
					begin
						Instrument <= 2'b01; 
					end
					
				else if(in == 2'b10) // guitar
					begin
						Instrument <= 2'b10;
					end
	
				else if(in == 2'b11) // drums
					begin
						Instrument <= 2'b11;
					end
	
				else
					begin
						Instrument <= Instrument;
					end
end

always_comb

	begin
	nextstate = curr_state;

	unique case (curr_state)
		RESET:
			if(KEY[0]) // KEY 0 LET GO/NOT PRESSED
				nextstate = DoNothing;
			else
				nextstate = RESET;
		DoNothing:
			if(~(KEY[0])) // KEY 0 PRESSED -- RESET to default (piano)
				nextstate = RESET;
				
			else if(~(KEY[1])) // KEY 1 PRESSED -- piano 
				nextstate = WAIT1;
				
			else if(~(KEY[2])) // KEY 2 PRESSED -- guitar 
				nextstate = WAIT2;
				
			else if(~(KEY[3])) // KEY 3 PRESSED -- drums 
				nextstate = WAIT3;	
		WAIT1:
			if(KEY[1]) // KEY 1 LET GO / not pressed 
				nextstate = piano;
			else 
				nextstate = WAIT1;
		WAIT2:
			if(KEY[2]) // KEY 2 LET GO / not pressed 
				nextstate = guitar;
			else 
				nextstate = WAIT2;
		WAIT3:
			if(KEY[3]) // KEY 3 LET GO / not pressed 
				nextstate = drums;
			else 
				nextstate = WAIT3;

		piano:
			nextstate = DoNothing;
			
		guitar:
			nextstate = DoNothing;
				
		drums:
			nextstate = DoNothing;
	
	
endcase
end

endmodule
