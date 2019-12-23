	component nios_system is
		port (
			clk_clk                           : in    std_logic                     := 'X';             -- clk
			keycode_export                    : out   std_logic_vector(7 downto 0);                     -- export
			onchip_memory2_0_reset1_reset     : in    std_logic                     := 'X';             -- reset
			onchip_memory2_0_reset1_reset_req : in    std_logic                     := 'X';             -- reset_req
			onchip_memory2_0_s1_address       : in    std_logic_vector(12 downto 0) := (others => 'X'); -- address
			onchip_memory2_0_s1_debugaccess   : in    std_logic                     := 'X';             -- debugaccess
			onchip_memory2_0_s1_clken         : in    std_logic                     := 'X';             -- clken
			onchip_memory2_0_s1_chipselect    : in    std_logic                     := 'X';             -- chipselect
			onchip_memory2_0_s1_write         : in    std_logic                     := 'X';             -- write
			onchip_memory2_0_s1_readdata      : out   std_logic_vector(15 downto 0);                    -- readdata
			onchip_memory2_0_s1_writedata     : in    std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			onchip_memory2_0_s1_byteenable    : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			otg_hpi_address_export            : out   std_logic_vector(1 downto 0);                     -- export
			otg_hpi_cs_export                 : out   std_logic;                                        -- export
			otg_hpi_data_in_port              : in    std_logic_vector(15 downto 0) := (others => 'X'); -- in_port
			otg_hpi_data_out_port             : out   std_logic_vector(15 downto 0);                    -- out_port
			otg_hpi_r_export                  : out   std_logic;                                        -- export
			otg_hpi_reset_export              : out   std_logic;                                        -- export
			otg_hpi_w_export                  : out   std_logic;                                        -- export
			reset_reset_n                     : in    std_logic                     := 'X';             -- reset_n
			sdram_clk_clk                     : out   std_logic;                                        -- clk
			sdram_wire_addr                   : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba                     : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n                  : out   std_logic;                                        -- cas_n
			sdram_wire_cke                    : out   std_logic;                                        -- cke
			sdram_wire_cs_n                   : out   std_logic;                                        -- cs_n
			sdram_wire_dq                     : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                    : out   std_logic_vector(3 downto 0);                     -- dqm
			sdram_wire_ras_n                  : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                   : out   std_logic;                                        -- we_n
			onchip_memory_1_s1_address        : in    std_logic_vector(12 downto 0) := (others => 'X'); -- address
			onchip_memory_1_s1_debugaccess    : in    std_logic                     := 'X';             -- debugaccess
			onchip_memory_1_s1_clken          : in    std_logic                     := 'X';             -- clken
			onchip_memory_1_s1_chipselect     : in    std_logic                     := 'X';             -- chipselect
			onchip_memory_1_s1_write          : in    std_logic                     := 'X';             -- write
			onchip_memory_1_s1_readdata       : out   std_logic_vector(15 downto 0);                    -- readdata
			onchip_memory_1_s1_writedata      : in    std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			onchip_memory_1_s1_byteenable     : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			onchip_memory_1_reset1_reset      : in    std_logic                     := 'X';             -- reset
			onchip_memory_1_reset1_reset_req  : in    std_logic                     := 'X';             -- reset_req
			onchip_memory_0_reset1_reset      : in    std_logic                     := 'X';             -- reset
			onchip_memory_0_reset1_reset_req  : in    std_logic                     := 'X';             -- reset_req
			onchip_memory_0_s1_address        : in    std_logic_vector(15 downto 0) := (others => 'X'); -- address
			onchip_memory_0_s1_debugaccess    : in    std_logic                     := 'X';             -- debugaccess
			onchip_memory_0_s1_clken          : in    std_logic                     := 'X';             -- clken
			onchip_memory_0_s1_chipselect     : in    std_logic                     := 'X';             -- chipselect
			onchip_memory_0_s1_write          : in    std_logic                     := 'X';             -- write
			onchip_memory_0_s1_readdata       : out   std_logic_vector(15 downto 0);                    -- readdata
			onchip_memory_0_s1_writedata      : in    std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			onchip_memory_0_s1_byteenable     : in    std_logic_vector(1 downto 0)  := (others => 'X')  -- byteenable
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk                           => CONNECTED_TO_clk_clk,                           --                     clk.clk
			keycode_export                    => CONNECTED_TO_keycode_export,                    --                 keycode.export
			onchip_memory2_0_reset1_reset     => CONNECTED_TO_onchip_memory2_0_reset1_reset,     -- onchip_memory2_0_reset1.reset
			onchip_memory2_0_reset1_reset_req => CONNECTED_TO_onchip_memory2_0_reset1_reset_req, --                        .reset_req
			onchip_memory2_0_s1_address       => CONNECTED_TO_onchip_memory2_0_s1_address,       --     onchip_memory2_0_s1.address
			onchip_memory2_0_s1_debugaccess   => CONNECTED_TO_onchip_memory2_0_s1_debugaccess,   --                        .debugaccess
			onchip_memory2_0_s1_clken         => CONNECTED_TO_onchip_memory2_0_s1_clken,         --                        .clken
			onchip_memory2_0_s1_chipselect    => CONNECTED_TO_onchip_memory2_0_s1_chipselect,    --                        .chipselect
			onchip_memory2_0_s1_write         => CONNECTED_TO_onchip_memory2_0_s1_write,         --                        .write
			onchip_memory2_0_s1_readdata      => CONNECTED_TO_onchip_memory2_0_s1_readdata,      --                        .readdata
			onchip_memory2_0_s1_writedata     => CONNECTED_TO_onchip_memory2_0_s1_writedata,     --                        .writedata
			onchip_memory2_0_s1_byteenable    => CONNECTED_TO_onchip_memory2_0_s1_byteenable,    --                        .byteenable
			otg_hpi_address_export            => CONNECTED_TO_otg_hpi_address_export,            --         otg_hpi_address.export
			otg_hpi_cs_export                 => CONNECTED_TO_otg_hpi_cs_export,                 --              otg_hpi_cs.export
			otg_hpi_data_in_port              => CONNECTED_TO_otg_hpi_data_in_port,              --            otg_hpi_data.in_port
			otg_hpi_data_out_port             => CONNECTED_TO_otg_hpi_data_out_port,             --                        .out_port
			otg_hpi_r_export                  => CONNECTED_TO_otg_hpi_r_export,                  --               otg_hpi_r.export
			otg_hpi_reset_export              => CONNECTED_TO_otg_hpi_reset_export,              --           otg_hpi_reset.export
			otg_hpi_w_export                  => CONNECTED_TO_otg_hpi_w_export,                  --               otg_hpi_w.export
			reset_reset_n                     => CONNECTED_TO_reset_reset_n,                     --                   reset.reset_n
			sdram_clk_clk                     => CONNECTED_TO_sdram_clk_clk,                     --               sdram_clk.clk
			sdram_wire_addr                   => CONNECTED_TO_sdram_wire_addr,                   --              sdram_wire.addr
			sdram_wire_ba                     => CONNECTED_TO_sdram_wire_ba,                     --                        .ba
			sdram_wire_cas_n                  => CONNECTED_TO_sdram_wire_cas_n,                  --                        .cas_n
			sdram_wire_cke                    => CONNECTED_TO_sdram_wire_cke,                    --                        .cke
			sdram_wire_cs_n                   => CONNECTED_TO_sdram_wire_cs_n,                   --                        .cs_n
			sdram_wire_dq                     => CONNECTED_TO_sdram_wire_dq,                     --                        .dq
			sdram_wire_dqm                    => CONNECTED_TO_sdram_wire_dqm,                    --                        .dqm
			sdram_wire_ras_n                  => CONNECTED_TO_sdram_wire_ras_n,                  --                        .ras_n
			sdram_wire_we_n                   => CONNECTED_TO_sdram_wire_we_n,                   --                        .we_n
			onchip_memory_1_s1_address        => CONNECTED_TO_onchip_memory_1_s1_address,        --      onchip_memory_1_s1.address
			onchip_memory_1_s1_debugaccess    => CONNECTED_TO_onchip_memory_1_s1_debugaccess,    --                        .debugaccess
			onchip_memory_1_s1_clken          => CONNECTED_TO_onchip_memory_1_s1_clken,          --                        .clken
			onchip_memory_1_s1_chipselect     => CONNECTED_TO_onchip_memory_1_s1_chipselect,     --                        .chipselect
			onchip_memory_1_s1_write          => CONNECTED_TO_onchip_memory_1_s1_write,          --                        .write
			onchip_memory_1_s1_readdata       => CONNECTED_TO_onchip_memory_1_s1_readdata,       --                        .readdata
			onchip_memory_1_s1_writedata      => CONNECTED_TO_onchip_memory_1_s1_writedata,      --                        .writedata
			onchip_memory_1_s1_byteenable     => CONNECTED_TO_onchip_memory_1_s1_byteenable,     --                        .byteenable
			onchip_memory_1_reset1_reset      => CONNECTED_TO_onchip_memory_1_reset1_reset,      --  onchip_memory_1_reset1.reset
			onchip_memory_1_reset1_reset_req  => CONNECTED_TO_onchip_memory_1_reset1_reset_req,  --                        .reset_req
			onchip_memory_0_reset1_reset      => CONNECTED_TO_onchip_memory_0_reset1_reset,      --  onchip_memory_0_reset1.reset
			onchip_memory_0_reset1_reset_req  => CONNECTED_TO_onchip_memory_0_reset1_reset_req,  --                        .reset_req
			onchip_memory_0_s1_address        => CONNECTED_TO_onchip_memory_0_s1_address,        --      onchip_memory_0_s1.address
			onchip_memory_0_s1_debugaccess    => CONNECTED_TO_onchip_memory_0_s1_debugaccess,    --                        .debugaccess
			onchip_memory_0_s1_clken          => CONNECTED_TO_onchip_memory_0_s1_clken,          --                        .clken
			onchip_memory_0_s1_chipselect     => CONNECTED_TO_onchip_memory_0_s1_chipselect,     --                        .chipselect
			onchip_memory_0_s1_write          => CONNECTED_TO_onchip_memory_0_s1_write,          --                        .write
			onchip_memory_0_s1_readdata       => CONNECTED_TO_onchip_memory_0_s1_readdata,       --                        .readdata
			onchip_memory_0_s1_writedata      => CONNECTED_TO_onchip_memory_0_s1_writedata,      --                        .writedata
			onchip_memory_0_s1_byteenable     => CONNECTED_TO_onchip_memory_0_s1_byteenable      --                        .byteenable
		);

