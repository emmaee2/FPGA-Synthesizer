
module nios_system (
	clk_clk,
	keycode_export,
	onchip_memory2_0_reset1_reset,
	onchip_memory2_0_reset1_reset_req,
	onchip_memory2_0_s1_address,
	onchip_memory2_0_s1_debugaccess,
	onchip_memory2_0_s1_clken,
	onchip_memory2_0_s1_chipselect,
	onchip_memory2_0_s1_write,
	onchip_memory2_0_s1_readdata,
	onchip_memory2_0_s1_writedata,
	onchip_memory2_0_s1_byteenable,
	otg_hpi_address_export,
	otg_hpi_cs_export,
	otg_hpi_data_in_port,
	otg_hpi_data_out_port,
	otg_hpi_r_export,
	otg_hpi_reset_export,
	otg_hpi_w_export,
	reset_reset_n,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	onchip_memory_1_s1_address,
	onchip_memory_1_s1_debugaccess,
	onchip_memory_1_s1_clken,
	onchip_memory_1_s1_chipselect,
	onchip_memory_1_s1_write,
	onchip_memory_1_s1_readdata,
	onchip_memory_1_s1_writedata,
	onchip_memory_1_s1_byteenable,
	onchip_memory_1_reset1_reset,
	onchip_memory_1_reset1_reset_req,
	onchip_memory_0_reset1_reset,
	onchip_memory_0_reset1_reset_req,
	onchip_memory_0_s1_address,
	onchip_memory_0_s1_debugaccess,
	onchip_memory_0_s1_clken,
	onchip_memory_0_s1_chipselect,
	onchip_memory_0_s1_write,
	onchip_memory_0_s1_readdata,
	onchip_memory_0_s1_writedata,
	onchip_memory_0_s1_byteenable);	

	input		clk_clk;
	output	[7:0]	keycode_export;
	input		onchip_memory2_0_reset1_reset;
	input		onchip_memory2_0_reset1_reset_req;
	input	[12:0]	onchip_memory2_0_s1_address;
	input		onchip_memory2_0_s1_debugaccess;
	input		onchip_memory2_0_s1_clken;
	input		onchip_memory2_0_s1_chipselect;
	input		onchip_memory2_0_s1_write;
	output	[15:0]	onchip_memory2_0_s1_readdata;
	input	[15:0]	onchip_memory2_0_s1_writedata;
	input	[1:0]	onchip_memory2_0_s1_byteenable;
	output	[1:0]	otg_hpi_address_export;
	output		otg_hpi_cs_export;
	input	[15:0]	otg_hpi_data_in_port;
	output	[15:0]	otg_hpi_data_out_port;
	output		otg_hpi_r_export;
	output		otg_hpi_reset_export;
	output		otg_hpi_w_export;
	input		reset_reset_n;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input	[12:0]	onchip_memory_1_s1_address;
	input		onchip_memory_1_s1_debugaccess;
	input		onchip_memory_1_s1_clken;
	input		onchip_memory_1_s1_chipselect;
	input		onchip_memory_1_s1_write;
	output	[15:0]	onchip_memory_1_s1_readdata;
	input	[15:0]	onchip_memory_1_s1_writedata;
	input	[1:0]	onchip_memory_1_s1_byteenable;
	input		onchip_memory_1_reset1_reset;
	input		onchip_memory_1_reset1_reset_req;
	input		onchip_memory_0_reset1_reset;
	input		onchip_memory_0_reset1_reset_req;
	input	[15:0]	onchip_memory_0_s1_address;
	input		onchip_memory_0_s1_debugaccess;
	input		onchip_memory_0_s1_clken;
	input		onchip_memory_0_s1_chipselect;
	input		onchip_memory_0_s1_write;
	output	[15:0]	onchip_memory_0_s1_readdata;
	input	[15:0]	onchip_memory_0_s1_writedata;
	input	[1:0]	onchip_memory_0_s1_byteenable;
endmodule
