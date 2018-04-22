
`timescale 1 ns / 1 ps

	module compute_sad_ip_p3_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 6
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave)
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 3;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 11
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;	//regBank
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;	//hwActive
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;	//result
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;
	reg	 aw_en;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	// Local parameters I need
	localparam Height = 32;
	localparam Width = 32;
	localparam DataWidth = 32;
	localparam pixelWidth = 8;
	localparam totalElements = 1024;
	localparam totalAdderRounds = 8;
	localparam totalRounds = 1 + totalAdderRounds + 1;
	integer outerLoopIndex;
	integer innerLoopIndex;
	integer i;

	// Registers for face and group images
	reg [pixelWidth : 0] faceImg_Row0[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row1[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row2[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row3[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row4[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row5[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row6[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row7[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row8[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row9[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row10[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row11[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row12[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row13[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row14[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row15[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row16[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row17[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row18[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row19[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row20[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row21[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row22[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row23[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row24[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row25[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row26[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row27[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row28[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row29[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row30[Width - 1 : 0];
	reg [pixelWidth : 0] faceImg_Row31[Width - 1 : 0];

	// Wire buffer for face and group images
	wire signed [pixelWidth :0] faceImg[Width - 1:0][Height - 1:0];
	wire signed [pixelWidth :0] groupImg[Width - 1:0][Height - 1:0];

	// Register for FSM
	reg [3:0] counter;

	// Register for storing the difference
	reg signed [8:0] Difference[Width - 1:0][Height - 1:0];

	// Register for storing the absolute difference
	reg [DataWidth - 1:0] absoluteDifference[Width - 1:0][Height - 1:0];

	// Register for 10-level adder tree
	//reg [DataWidth - 1:0] adder1_result[512:0];
	wire [DataWidth - 1:0] adder1_result[512:0];
	reg [DataWidth - 1:0] adder2_result[256:0];
	reg [DataWidth - 1:0] adder3_result[128:0];
	reg [DataWidth - 1:0] adder4_result[64:0];
	reg [DataWidth - 1:0] adder5_result[32:0];
	reg [DataWidth - 1:0] adder6_result[16:0];
	reg [DataWidth - 1:0] adder7_result[8:0];
	reg [DataWidth - 1:0] adder8_result[4:0];
	reg [DataWidth - 1:0] adder9_result[2:0];
	//reg [DataWidth - 1:0] adder10_result;

	// Wire for storing the signal from slv_reg8(regBank)
	wire [DataWidth - 1:0] regBankPointer;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	      aw_en <= 1'b1;
	    end
	  else
	    begin
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // slave is ready to accept write address when
	          // there is a valid write address and write data
	          // on the write address and data bus. This design
	          // expects no outstanding transactions.
	          axi_awready <= 1'b1;
	          aw_en <= 1'b0;
	        end
	        else if (S_AXI_BREADY && axi_bvalid)
	            begin
	              aw_en <= 1'b1;
	              axi_awready <= 1'b0;
	            end
	      else
	        begin
	          axi_awready <= 1'b0;
	        end
	    end
	end

	// Implement axi_awaddr latching
	// This process is used to latch the address when both
	// S_AXI_AWVALID and S_AXI_WVALID are valid.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end
	  else
	    begin
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // Write Address latching
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end
	end

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end
	  else
	    begin
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en )
	        begin
	          // slave is ready to accept write data when
	          // there is a valid write address and write data
	          // on the write address and data bus. This design
	          // expects no outstanding transactions.
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end
	end

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
		if ( S_AXI_ARESETN == 1'b0 )
			begin
				slv_reg0 <= 0;
				slv_reg1 <= 0;
				slv_reg2 <= 0;
				slv_reg3 <= 0;
				slv_reg4 <= 0;
				slv_reg5 <= 0;
				slv_reg6 <= 0;
				slv_reg7 <= 0;
				slv_reg8 <= 0;
				slv_reg9 <= 0;
				slv_reg10 <= 0;
			end
		else
			begin
				if (slv_reg_wren)
					begin
						case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
						  4'h0:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 0
						        slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'h1:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 1
						        slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'h2:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 2
						        slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'h3:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 3
						        slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'h4:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 4
						        slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'h5:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 5
						        slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'h6:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 6
						        slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'h7:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 7
						        slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'h8:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 8
						        slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'h9:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 9
						        slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  4'hA:
						    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
						        // Respective byte enables are asserted as per write strobes
						        // Slave register 10
						        slv_reg10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						      end
						  default : begin
						              slv_reg0 <= slv_reg0;
						              slv_reg1 <= slv_reg1;
						              slv_reg2 <= slv_reg2;
						              slv_reg3 <= slv_reg3;
						              slv_reg4 <= slv_reg4;
						              slv_reg5 <= slv_reg5;
						              slv_reg6 <= slv_reg6;
						              slv_reg7 <= slv_reg7;
						              slv_reg8 <= slv_reg8;
						              slv_reg9 <= slv_reg9;
						              slv_reg10 <= slv_reg10;
						            end
						endcase
					end
				else
					begin
						if( counter == totalRounds)
							begin
								slv_reg9 <= 32'd0;
								slv_reg10 <= adder9_result[0] + adder9_result[1];
							end
						else
							begin
								slv_reg9 <= slv_reg9;
								slv_reg10 <= slv_reg10;
							end
					end
			end
	end

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.
	// This marks the acceptance of address and indicates the status of
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end
	  else
	    begin
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid)
	            //check if bready is asserted while bvalid is high)
	            //(there is a possibility that bready is always asserted high)
	            begin
	              axi_bvalid <= 1'b0;
	            end
	        end
	    end
	end

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is
	// de-asserted when reset (active low) is asserted.
	// The read address is also latched when S_AXI_ARVALID is
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end
	  else
	    begin
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end
	end

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers
	// data are available on the axi_rdata bus at this instance. The
	// assertion of axi_rvalid marks the validity of read data on the
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid
	// is deasserted on reset (active low). axi_rresp and axi_rdata are
	// cleared to zero on reset (active low).
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end
	  else
	    begin
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end
	    end
	end

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        4'h0   : reg_data_out <= slv_reg0;
	        4'h1   : reg_data_out <= slv_reg1;
	        4'h2   : reg_data_out <= slv_reg2;
	        4'h3   : reg_data_out <= slv_reg3;
	        4'h4   : reg_data_out <= slv_reg4;
	        4'h5   : reg_data_out <= slv_reg5;
	        4'h6   : reg_data_out <= slv_reg6;
	        4'h7   : reg_data_out <= slv_reg7;
	        4'h8   : reg_data_out <= slv_reg8;
	        4'h9   : reg_data_out <= slv_reg9;
	        4'hA   : reg_data_out <= slv_reg10;
	        default : reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end
	  else
	    begin
	      // When there is a valid read address (S_AXI_ARVALID) with
	      // acceptance of read address by the slave (axi_arready),
	      // output the read dada
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end
	    end
	end

	// Add user logic here

	assign regBankPointer = slv_reg8;

	// Always block for FSM
	always @ ( posedge S_AXI_ACLK ) begin
		if( S_AXI_ARESETN == 1'b0 )
			begin
				counter <= 4'd0;
			end
		else if ( slv_reg9 == 32'd1 )
			begin
				counter <= counter + 1;
			end
		else
			begin
				counter <= counter;
			end
	end

	// Sequential circuit for moving data from interface registers to groupImg

	/*always @ ( posedge S_AXI_ACLK ) begin
		if(regBankPointer < Width)
			begin
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						if( regBankPointer == outerLoopIndex )
							begin
								for(innerLoopIndex = 0; innerLoopIndex < DataWidth / pixelWidth; innerLoopIndex = innerLoopIndex + 1)
									begin
										groupImg[outerLoopIndex][0 + innerLoopIndex] <= slv_reg0[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										groupImg[outerLoopIndex][4 + innerLoopIndex] <= slv_reg1[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										groupImg[outerLoopIndex][8 + innerLoopIndex] <= slv_reg2[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										groupImg[outerLoopIndex][12 + innerLoopIndex] <= slv_reg3[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										groupImg[outerLoopIndex][16 + innerLoopIndex] <= slv_reg4[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										groupImg[outerLoopIndex][20 + innerLoopIndex] <= slv_reg5[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										groupImg[outerLoopIndex][24 + innerLoopIndex] <= slv_reg6[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										groupImg[outerLoopIndex][28 + innerLoopIndex] <= slv_reg7[31 - innerLoopIndex * pixelWidth -: pixelWidth];
									end
							end
						else
							begin
								for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
									begin
										groupImg[outerLoopIndex][innerLoopIndex] <= groupImg[outerLoopIndex][innerLoopIndex];
									end
							end
					end
				end
		else
			begin
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								groupImg[outerLoopIndex][innerLoopIndex] <= groupImg[outerLoopIndex][innerLoopIndex];
							end
					end
			end
	end*/

	// Sequential circuit for moving data from interface registers to faceImg

	/*always @ ( posedge S_AXI_ACLK) begin
		if( regBankPointer < Height || regBankPointer > 2 * Height )
			begin
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								faceImg[outerLoopIndex][innerLoopIndex] <= faceImg[outerLoopIndex][innerLoopIndex];
							end
					end
			end
		else
			begin
				for(outerLoopIndex = Height; outerLoopIndex < 2 * Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						if( outerLoopIndex == regBankPointer )
							begin
								for(innerLoopIndex = 0; innerLoopIndex < DataWidth / pixelWidth; innerLoopIndex = innerLoopIndex + 1)
									begin
										faceImg[outerLoopIndex % Height][0 + innerLoopIndex] <= slv_reg0[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										faceImg[outerLoopIndex % Height][4 + innerLoopIndex] <= slv_reg1[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										faceImg[outerLoopIndex % Height][8 + innerLoopIndex] <= slv_reg2[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										faceImg[outerLoopIndex % Height][12 + innerLoopIndex] <= slv_reg3[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										faceImg[outerLoopIndex % Height][16 + innerLoopIndex] <= slv_reg4[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										faceImg[outerLoopIndex % Height][20 + innerLoopIndex] <= slv_reg5[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										faceImg[outerLoopIndex % Height][24 + innerLoopIndex] <= slv_reg6[31 - innerLoopIndex * pixelWidth -: pixelWidth];
										faceImg[outerLoopIndex % Height][28 + innerLoopIndex] <= slv_reg7[31 - innerLoopIndex * pixelWidth -: pixelWidth];
									end
							end
						else
							begin
								for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
									begin
										faceImg[outerLoopIndex % Height][innerLoopIndex] <= faceImg[outerLoopIndex][innerLoopIndex];
									end
							end
					end
			end
	end*/

	// Combinational circuit for calculating difference

	genvar idx,jdx;

	generate
		for(idx = 0; idx < Width; idx = idx + 1)
			begin
				assign faceImg[0][idx] = faceImg_Row0[idx];
				assign faceImg[1][idx] = faceImg_Row1[idx];
				assign faceImg[2][idx] = faceImg_Row2[idx];
				assign faceImg[3][idx] = faceImg_Row3[idx];
				assign faceImg[4][idx] = faceImg_Row4[idx];
				assign faceImg[5][idx] = faceImg_Row5[idx];
				assign faceImg[6][idx] = faceImg_Row6[idx];
				assign faceImg[7][idx] = faceImg_Row7[idx];
				assign faceImg[8][idx] = faceImg_Row8[idx];
				assign faceImg[9][idx] = faceImg_Row9[idx];
				assign faceImg[10][idx] = faceImg_Row10[idx];
				assign faceImg[11][idx] = faceImg_Row11[idx];
				assign faceImg[12][idx] = faceImg_Row12[idx];
				assign faceImg[13][idx] = faceImg_Row13[idx];
				assign faceImg[14][idx] = faceImg_Row14[idx];
				assign faceImg[15][idx] = faceImg_Row15[idx];
				assign faceImg[16][idx] = faceImg_Row16[idx];
				assign faceImg[17][idx] = faceImg_Row17[idx];
				assign faceImg[18][idx] = faceImg_Row18[idx];
				assign faceImg[19][idx] = faceImg_Row19[idx];
				assign faceImg[20][idx] = faceImg_Row20[idx];
				assign faceImg[21][idx] = faceImg_Row21[idx];
				assign faceImg[22][idx] = faceImg_Row22[idx];
				assign faceImg[23][idx] = faceImg_Row23[idx];
				assign faceImg[24][idx] = faceImg_Row24[idx];
				assign faceImg[25][idx] = faceImg_Row25[idx];
				assign faceImg[26][idx] = faceImg_Row26[idx];
				assign faceImg[27][idx] = faceImg_Row27[idx];
				assign faceImg[28][idx] = faceImg_Row28[idx];
				assign faceImg[29][idx] = faceImg_Row29[idx];
				assign faceImg[30][idx] = faceImg_Row30[idx];
				assign faceImg[31][idx] = faceImg_Row31[idx];
			end
	endgenerate


	always @ ( * ) begin
		case (regBankPointer)
			32'd0:	// First row to compute is at row 1
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 0) % 32 ][innerLoopIndex];
							end
					end
			32'd1:	// First row to compute is at row 2
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 1) % 32 ][innerLoopIndex];
							end
					end
			32'd2:	// First row to compute is at row 3
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 2) % 32 ][innerLoopIndex];
							end
					end
			32'd3:	// First row to compute is at row 4
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 3) % 32 ][innerLoopIndex];
							end
					end
			32'd4:	// First row to compute is at row 5
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 4) % 32 ][innerLoopIndex];
							end
					end
			32'd5:	// First row to compute is at row 6
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 5) % 32 ][innerLoopIndex];
							end
					end
			32'd6:	// First row to compute is at row 7
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 6 ) % 32 ][innerLoopIndex];
							end
					end
			32'd7:	// First row to compute is at row 8
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 7 ) % 32 ][innerLoopIndex];
							end
					end
			32'd8:	// First row to compute is at row 9
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 8 ) % 32 ][innerLoopIndex];
							end
					end
			32'd9:	// First row to compute is at row 10
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 9 ) % 32 ][innerLoopIndex];
							end
					end
			32'd10:	// First row to compute is at row 11
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 10 ) % 32 ][innerLoopIndex];
							end
					end
			32'd11:	// First row to compute is at row 12
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 11 ) % 32 ][innerLoopIndex];
							end
					end
			32'd12:	// First row to compute is at row 13
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 12 ) % 32 ][innerLoopIndex];
							end
					end
			32'd13:	// First row to compute is at row 14
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 13 ) % 32 ][innerLoopIndex];
							end
					end
			32'd14:	// First row to compute is at row 15
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 14 ) % 32 ][innerLoopIndex];
							end
					end
			32'd15:	// First row to compute is at row 16
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 15 ) % 32 ][innerLoopIndex];
							end
					end
			32'd16:	// First row to compute is at row 17
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 16 ) % 32 ][innerLoopIndex];
							end
					end
			32'd17:	// First row to compute is at row 18
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 17 ) % 32 ][innerLoopIndex];
							end
					end
			32'd18:	// First row to compute is at row 19
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 18 ) % 32 ][innerLoopIndex];
							end
					end
			32'd19:	// First row to compute is at row 20
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 19 ) % 32 ][innerLoopIndex];
							end
					end
			32'd20:	// First row to compute is at row 21
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 20 ) % 32 ][innerLoopIndex];
							end
					end
			32'd21: // First row to compute is at row 22
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 21 ) % 32 ][innerLoopIndex];
							end
					end
			32'd22:	// First row to compute is at row 23
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 22 ) % 32 ][innerLoopIndex];
							end
					end
			32'd23:	// First row to compute is at row 24
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 23 ) % 32 ][innerLoopIndex];
							end
					end
			32'd24:	// First row to compute is at row 25
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 24 ) % 32 ][innerLoopIndex];
							end
					end
			32'd25:	// First row to compute is at row 26
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 25 ) % 32 ][innerLoopIndex];
							end
					end
			32'd26:	// First row to compute is at row 27
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 26 ) % 32 ][innerLoopIndex];
							end
					end
			32'd27:	// First row to compute is at row 28
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 27 ) % 32 ][innerLoopIndex];
							end
					end
			32'd28:	// First row to compute is at row 29
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 28 ) % 32 ][innerLoopIndex];
							end
					end
			32'd29:	// First row to compute is at row 30
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 29 ) % 32 ][innerLoopIndex];
							end
					end
			32'd30:	// First row to compute is at row 31
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 30 ) % 32 ][innerLoopIndex];
							end
					end
			32'd31: // First row to compute is at row 0
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 31 ) % 32 ][innerLoopIndex];
							end
					end
			default: // Default situation
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 1)
							begin
								Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 31) % 32 ][innerLoopIndex];
							end
					end
		endcase
	end

	// 1st-stage, Calculating absolute difference
	always @ ( posedge S_AXI_ACLK ) begin
		if( S_AXI_ARESETN == 1'b0 )
			begin
				for(outerLoopIndex = 0; outerLoopIndex < Width; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Height; innerLoopIndex = innerLoopIndex + 1)
							begin
								absoluteDifference[outerLoopIndex][innerLoopIndex] <= 32'd0;
							end
					end
			end
		else
			begin
				for(outerLoopIndex = 0; outerLoopIndex < Width; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Height; innerLoopIndex = innerLoopIndex + 1)
							begin
								absoluteDifference[outerLoopIndex][innerLoopIndex] <= Difference[outerLoopIndex][innerLoopIndex][8] == 1'b1 ? {15'b0, 9'b0 - Difference[outerLoopIndex][innerLoopIndex]} : {16'b0, Difference[outerLoopIndex][innerLoopIndex][7:0]};
							end
					end
			end
	end



	// 1st-level Adder Tree
	generate
		for(idx = 0 ; idx < Height; idx = idx + 1)
			begin : level_1_outer
				for(jdx = 0; jdx < Width; jdx = jdx + 2)
					begin : level_1_inner
						assign adder1_result[(idx * Width + jdx) / 2] = absoluteDifference[idx][jdx] + absoluteDifference[idx][jdx + 1];
					end
			end
	endgenerate
	// End of 1st-level Adder Tree

	// 2nd-level Adder Tree
	always @ ( posedge S_AXI_ACLK ) begin
		for(outerLoopIndex = 0; outerLoopIndex < totalElements / 4; outerLoopIndex = outerLoopIndex + 1)
			begin
				adder2_result[outerLoopIndex] <= adder1_result[outerLoopIndex * 2] + adder1_result[outerLoopIndex * 2 + 1];
			end
	end
	// End of 2nd-level Adder Tree

	// 3rd-level Adder Tree
	always @ ( posedge S_AXI_ACLK ) begin
		for(outerLoopIndex = 0; outerLoopIndex < totalElements / 8; outerLoopIndex = outerLoopIndex + 1)
			begin
				adder3_result[outerLoopIndex] <= adder2_result[outerLoopIndex * 2] + adder2_result[outerLoopIndex * 2 + 1];
			end
	end
	// End of 3rd-level Adder Tree

	// 4th-level Adder Tree
	always @ ( posedge S_AXI_ACLK ) begin
		for(outerLoopIndex = 0; outerLoopIndex < totalElements / 16; outerLoopIndex = outerLoopIndex + 1)
			begin
				adder4_result[outerLoopIndex] <= adder3_result[outerLoopIndex * 2] + adder3_result[outerLoopIndex * 2 + 1];
			end
	end
	// End of 4th-level Adder Tree

	// 5-th level Adder Tree
	always @ ( posedge S_AXI_ACLK ) begin
		for(outerLoopIndex = 0; outerLoopIndex < totalElements / 32; outerLoopIndex = outerLoopIndex + 1)
			begin
				adder5_result[outerLoopIndex] <= adder4_result[outerLoopIndex * 2] + adder4_result[outerLoopIndex * 2 + 1];
			end
	end
	//End of 5-th level Adder Tree

	// 6-th level Adder Tree
	always @ ( posedge S_AXI_ACLK ) begin
		for(outerLoopIndex = 0; outerLoopIndex < totalElements / 64; outerLoopIndex = outerLoopIndex + 1)
			begin
				adder6_result[outerLoopIndex] <= adder5_result[outerLoopIndex * 2] + adder5_result[outerLoopIndex * 2 + 1];
			end
	end
	// End of 6th-level Adder Tree

	// 7-th level Adder Tree
	always @ ( posedge S_AXI_ACLK ) begin
		for(outerLoopIndex = 0; outerLoopIndex < totalElements / 128; outerLoopIndex = outerLoopIndex + 1)
			begin
				adder7_result[outerLoopIndex] <= adder6_result[outerLoopIndex * 2] + adder6_result[outerLoopIndex * 2 + 1];
			end
	end
	// End of 7th-level Adder Tree

	// 8-th level Adder Tree
	always @ ( posedge S_AXI_ACLK ) begin
		for(outerLoopIndex = 0; outerLoopIndex < totalElements / 256; outerLoopIndex = outerLoopIndex + 1)
			begin
				adder8_result[outerLoopIndex] <= adder7_result[outerLoopIndex * 2] + adder7_result[outerLoopIndex * 2 + 1];
			end
	end
	// End of 8th-level Adder Tree

	// 9-th level Adder Tree
	always @ ( posedge S_AXI_ACLK ) begin
		for(outerLoopIndex = 0; outerLoopIndex < totalElements / 512; outerLoopIndex = outerLoopIndex + 1)
			begin
				adder9_result[outerLoopIndex] <= adder8_result[outerLoopIndex * 2] + adder8_result[outerLoopIndex * 2 + 1];
			end
	end
	// End of 9th-level Adder Tree

	// 10-th level Adder Tree
	/*always @ ( posedge S_AXI_ACLK ) begin
		if( S_AXI_ARESETN == 1'b0 )
			begin
				adder10_result <= 32'd0;
			end
		else
			begin
				for(outerLoopIndex = 0; outerLoopIndex < totalElements / 1024; outerLoopIndex = outerLoopIndex + 1)
					begin
						adder10_result <= adder9_result[outerLoopIndex * 2] + adder9_result[outerLoopIndex * 2 + 1];
					end
			end
	end*/


	/*always @ ( posedge S_AXI_ACLK ) begin
		if ( S_AXI_ARESETN == 1'b0 )
			begin
				for(outerLoopIndex = 0; outerLoopIndex < totalElements / 2; outerLoopIndex = outerLoopIndex + 1)
					begin
						adder1_result[outerLoopIndex] <= 32'd0;
					end
			end
		else
			begin
				for(outerLoopIndex = 0; outerLoopIndex < Height; outerLoopIndex = outerLoopIndex + 1)
					begin
						for(innerLoopIndex = 0; innerLoopIndex < Width; innerLoopIndex = innerLoopIndex + 2)
							begin
								adder1_result[( outerLoopIndex * Width + innerLoopIndex ) / 2] <= absoluteDifference[outerLoopIndex][innerLoopIndex] + absoluteDifference[outerLoopIndex][innerLoopIndex + 1];
							end
					end
			end
	end*/
	// User logic ends

	endmodule
