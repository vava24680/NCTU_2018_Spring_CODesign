
`timescale 1 ns / 1 ps

    module compute_sad_ip_p3_v1_0_S00_AXI #
    (
        // Users to add parameters here

        // User parameters ends
        // Do not modify the parameters beyond this line

        // WIDTH of S_AXI data bus
        parameter integer C_S_AXI_DATA_WIDTH    = 32,
        // WIDTH of S_AXI address bus
        parameter integer C_S_AXI_ADDR_WIDTH    = 6
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
    reg [C_S_AXI_ADDR_WIDTH-1 : 0]     axi_awaddr;
    reg      axi_awready;
    reg      axi_wready;
    reg [1 : 0]     axi_bresp;
    reg      axi_bvalid;
    reg [C_S_AXI_ADDR_WIDTH-1 : 0]     axi_araddr;
    reg      axi_arready;
    reg [C_S_AXI_DATA_WIDTH-1 : 0]     axi_rdata;
    reg [1 : 0]     axi_rresp;
    reg      axi_rvalid;

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
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg0;
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg1;
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg2;
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg3;
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg4;
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg5;
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg6;
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg7;
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg8;    //regBank
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg9;    //hwActive
    reg [C_S_AXI_DATA_WIDTH-1:0]    slv_reg10;    //result
    wire     slv_reg_rden;
    wire     slv_reg_wren;
    reg [C_S_AXI_DATA_WIDTH-1:0]     reg_data_out;
    integer     byte_index;
    reg     aw_en;

    // I/O Connections assignments

    assign S_AXI_AWREADY    = axi_awready;
    assign S_AXI_WREADY    = axi_wready;
    assign S_AXI_BRESP    = axi_bresp;
    assign S_AXI_BVALID    = axi_bvalid;
    assign S_AXI_ARREADY    = axi_arready;
    assign S_AXI_RDATA    = axi_rdata;
    assign S_AXI_RRESP    = axi_rresp;
    assign S_AXI_RVALID    = axi_rvalid;
    // Implement axi_awready generation
    // axi_awready is asserted for one S_AXI_ACLK clock cycle when both
    // S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
    // de-asserted when reset is low.

    // Local parameters I need
    localparam HEIGHT = 32;
    localparam WIDTH = 32;
    localparam DATAWIDTH = 32;
    localparam PIXELWIDTH = 8;
    localparam totalElements = 1024;
    localparam totalAdderRounds = 16;
    localparam totalRounds = 1 + 1 + totalAdderRounds;
    integer outerLoopIndex;
    integer innerLoopIndex;
    integer i;

    // Registers buffer for face and group images
    reg signed [PIXELWIDTH :0] faceImg[WIDTH - 1:0][HEIGHT - 1:0];
    reg signed [PIXELWIDTH :0] groupImg[WIDTH - 1:0][HEIGHT - 1:0];

    // Register for FSM
    reg [5:0] counter;

    // Register for storing the difference
    reg signed [8:0] Difference[WIDTH - 1:0][HEIGHT - 1:0];

    // Register for storing the absolute difference
    reg [DATAWIDTH - 1:0] absoluteDifference[WIDTH - 1:0][HEIGHT - 1:0];

    // Register for 10-level adder tree
    /*reg [DATAWIDTH - 1:0] adder1_result[512:0];
    reg [DATAWIDTH - 1:0] adder2_result[256:0];
    reg [DATAWIDTH - 1:0] adder3_result[128:0];
    reg [DATAWIDTH - 1:0] adder4_result[64:0];
    reg [DATAWIDTH - 1:0] adder5_result[32:0];
    reg [DATAWIDTH - 1:0] adder6_result[16:0];
    reg [DATAWIDTH - 1:0] adder7_result[8:0];
    reg [DATAWIDTH - 1:0] adder8_result[4:0];
    reg [DATAWIDTH - 1:0] adder9_result[2:0];
    reg [DATAWIDTH - 1:0] adder10_result;*/
    reg [DATAWIDTH - 1:0] adder1_result[256:0];
    reg [DATAWIDTH - 1:0] adder2_result[128:0];
    reg [DATAWIDTH - 1:0] adder3_result[64:0];
    reg [DATAWIDTH - 1:0] adder4_result[32:0];
    reg [DATAWIDTH - 1:0] adder5_result[16:0];
    reg [DATAWIDTH - 1:0] adder6_result[8:0];
    reg [DATAWIDTH - 1:0] adder7_result[4:0];
    reg [DATAWIDTH - 1:0] adder8_result[2:0];

    reg [DATAWIDTH - 1:0] firstRoundAdderResult;
    reg [DATAWIDTH - 1:0] secondRoundAdderResult;

    // Wire for storing the signal from slv_reg8(regBank)
    wire [DATAWIDTH - 1:0] regBankPointer;

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
                                slv_reg10 <= 32'd0;
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
                counter <= 6'd0;
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
        if(regBankPointer < WIDTH)
            begin
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        if( regBankPointer == outerLoopIndex )
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < DATAWIDTH / PIXELWIDTH; innerLoopIndex = innerLoopIndex + 1)
                                    begin
                                        groupImg[outerLoopIndex][0 + innerLoopIndex] <= slv_reg0[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][4 + innerLoopIndex] <= slv_reg1[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][8 + innerLoopIndex] <= slv_reg2[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][12 + innerLoopIndex] <= slv_reg3[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][16 + innerLoopIndex] <= slv_reg4[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][20 + innerLoopIndex] <= slv_reg5[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][24 + innerLoopIndex] <= slv_reg6[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][28 + innerLoopIndex] <= slv_reg7[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                    end
                            end
                        else
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                                    begin
                                        groupImg[outerLoopIndex][innerLoopIndex] <= groupImg[outerLoopIndex][innerLoopIndex];
                                    end
                            end
                    end
                end
        else
            begin
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                groupImg[outerLoopIndex][innerLoopIndex] <= groupImg[outerLoopIndex][innerLoopIndex];
                            end
                    end
            end
    end*/
    always @ (posedge S_AXI_ACLK) begin
        if( S_AXI_ARESETN )
            begin
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex  = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                groupImg[outerLoopIndex][innerLoopIndex] <= 32'd0;
                            end
                    end
            end
        else
            begin
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        if( outerLoopIndex == regBankPointer )
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < DATAWIDTH / PIXELWIDTH; innerLoopIndex = innerLoopIndex + 1)
                                    begin
                                        groupImg[outerLoopIndex][0 + innerLoopIndex] <= slv_reg0[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][4 + innerLoopIndex] <= slv_reg1[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][8 + innerLoopIndex] <= slv_reg2[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][12 + innerLoopIndex] <= slv_reg3[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][16 + innerLoopIndex] <= slv_reg4[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][20 + innerLoopIndex] <= slv_reg5[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][24 + innerLoopIndex] <= slv_reg6[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        groupImg[outerLoopIndex][28 + innerLoopIndex] <= slv_reg7[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                    end
                            end
                        else
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                                    groupImg[outerLoopIndex][innerLoopIndex] <= groupImg[outerLoopIndex][innerLoopIndex];
                            end
                    end
            end
    end

    // Sequential circuit for moving data from interface registers to faceImg

    /*always @ ( posedge S_AXI_ACLK) begin
        if( regBankPointer < HEIGHT || regBankPointer > 2 * HEIGHT )
            begin
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                faceImg[outerLoopIndex][innerLoopIndex] <= faceImg[outerLoopIndex][innerLoopIndex];
                            end
                    end
            end
        else
            begin
                for(outerLoopIndex = HEIGHT; outerLoopIndex < 2 * HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        if( outerLoopIndex == regBankPointer )
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < DATAWIDTH / PIXELWIDTH; innerLoopIndex = innerLoopIndex + 1)
                                    begin
                                        faceImg[outerLoopIndex % HEIGHT][0 + innerLoopIndex] <= slv_reg0[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][4 + innerLoopIndex] <= slv_reg1[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][8 + innerLoopIndex] <= slv_reg2[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][12 + innerLoopIndex] <= slv_reg3[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][16 + innerLoopIndex] <= slv_reg4[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][20 + innerLoopIndex] <= slv_reg5[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][24 + innerLoopIndex] <= slv_reg6[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][28 + innerLoopIndex] <= slv_reg7[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                    end
                            end
                        else
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                                    begin
                                        faceImg[outerLoopIndex % HEIGHT][innerLoopIndex] <= faceImg[outerLoopIndex][innerLoopIndex];
                                    end
                            end
                    end
            end
    end*/

    always @ (posedge S_AXI_ACLK) begin
        if( S_AXI_ARESETN )
            begin
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            faceImg[outerLoopIndex][innerLoopIndex] <= faceImg[outerLoopIndex][innerLoopIndex];
                    end
            end
        else
            begin
                for(outerLoopIndex = HEIGHT; outerLoopIndex < 2 * HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        if( outerLoopIndex == regBankPointer )
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < DATAWIDTH / PIXELWIDTH; innerLoopIndex = innerLoopIndex + 1)
                                    begin
                                        faceImg[outerLoopIndex % HEIGHT][0 + innerLoopIndex] <= slv_reg0[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][4 + innerLoopIndex] <= slv_reg1[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][8 + innerLoopIndex] <= slv_reg2[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][12 + innerLoopIndex] <= slv_reg3[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][16 + innerLoopIndex] <= slv_reg4[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][20 + innerLoopIndex] <= slv_reg5[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][24 + innerLoopIndex] <= slv_reg6[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                        faceImg[outerLoopIndex % HEIGHT][28 + innerLoopIndex] <= slv_reg7[31 - innerLoopIndex * PIXELWIDTH -: PIXELWIDTH];
                                    end
                            end
                        else
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                                    faceImg[outerLoopIndex % HEIGHT][innerLoopIndex] <= faceImg[outerLoopIndex % HEIGHT][innerLoopIndex];
                            end
                    end
            end
    end

    // Combinational circuit for calculating difference

    genvar idx,jdx;

    always @ ( * ) begin
        case (regBankPointer)
            32'd0:    // First row to compute is at row 1
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 0) % 32 ][innerLoopIndex];
                            end
                    end
            32'd1:    // First row to compute is at row 2
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 1) % 32 ][innerLoopIndex];
                            end
                    end
            32'd2:    // First row to compute is at row 3
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 2) % 32 ][innerLoopIndex];
                            end
                    end
            32'd3:    // First row to compute is at row 4
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 3) % 32 ][innerLoopIndex];
                            end
                    end
            32'd4:    // First row to compute is at row 5
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 4) % 32 ][innerLoopIndex];
                            end
                    end
            32'd5:    // First row to compute is at row 6
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 5) % 32 ][innerLoopIndex];
                            end
                    end
            32'd6:    // First row to compute is at row 7
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 6 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd7:    // First row to compute is at row 8
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 7 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd8:    // First row to compute is at row 9
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 8 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd9:    // First row to compute is at row 10
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 9 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd10:    // First row to compute is at row 11
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 10 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd11:    // First row to compute is at row 12
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 11 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd12:    // First row to compute is at row 13
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 12 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd13:    // First row to compute is at row 14
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 13 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd14:    // First row to compute is at row 15
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 14 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd15:    // First row to compute is at row 16
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 15 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd16:    // First row to compute is at row 17
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 16 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd17:    // First row to compute is at row 18
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 17 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd18:    // First row to compute is at row 19
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 18 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd19:    // First row to compute is at row 20
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 19 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd20:    // First row to compute is at row 21
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 20 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd21: // First row to compute is at row 22
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 21 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd22:    // First row to compute is at row 23
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 22 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd23:    // First row to compute is at row 24
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 23 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd24:    // First row to compute is at row 25
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 24 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd25:    // First row to compute is at row 26
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 25 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd26:    // First row to compute is at row 27
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 26 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd27:    // First row to compute is at row 28
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 27 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd28:    // First row to compute is at row 29
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 28 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd29:    // First row to compute is at row 30
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 29 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd30:    // First row to compute is at row 31
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 30 ) % 32 ][innerLoopIndex];
                            end
                    end
            32'd31: // First row to compute is at row 0
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                Difference[outerLoopIndex][innerLoopIndex] = faceImg[outerLoopIndex][innerLoopIndex] - groupImg[ (outerLoopIndex + 1 + 31 ) % 32 ][innerLoopIndex];
                            end
                    end
            default: // Default situation
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 1)
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
                for(outerLoopIndex = 0; outerLoopIndex < WIDTH; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < HEIGHT; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                absoluteDifference[outerLoopIndex][innerLoopIndex] <= 32'd0;
                            end
                    end
            end
        else
            begin
                for(outerLoopIndex = 0; outerLoopIndex < WIDTH; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < HEIGHT; innerLoopIndex = innerLoopIndex + 1)
                            begin
                                absoluteDifference[outerLoopIndex][innerLoopIndex] <= Difference[outerLoopIndex][innerLoopIndex][8] == 1'b1 ? {15'b0, 9'b0 - Difference[outerLoopIndex][innerLoopIndex]} : {16'b0, Difference[outerLoopIndex][innerLoopIndex][7:0]};
                            end
                    end
            end
    end

    // 2nd-stage, 1st-level adder tree, 512
    always @ (posedge S_AXI_ACLK) begin
        if(counter < 6'd9)
            begin
                for(outerLoopIndex = 0; outerLoopIndex < HEIGHT / 2; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 2)
                            adder1_result[(outerLoopIndex * WIDTH + innerLoopIndex) / 2] <= absoluteDifference[outerLoopIndex][innerLoopIndex] + absoluteDifference[outerLoopIndex][innerLoopIndex + 1];
                    end
            end
        else
            begin
                for(outerLoopIndex = HEIGHT / 2; outerLoopIndex < HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < WIDTH; innerLoopIndex = innerLoopIndex + 2)
                            adder1_result[(outerLoopIndex * WIDTH + innerLoopIndex) / 2] <= absoluteDifference[outerLoopIndex][innerLoopIndex] + absoluteDifference[outerLoopIndex][innerLoopIndex + 1];
                    end
            end
    end
    // End of 1st-level adder tree

    // 3rd-stage, 2nd-level adder tree, 256
    always @ (posedge S_AXI_ACLK) begin
        for(outerLoopIndex = 0; outerLoopIndex < totalElements / 8; outerLoopIndex = outerLoopIndex + 1)
            begin
                adder2_result[outerLoopIndex] <= adder1_result[outerLoopIndex * 2] + adder1_result[outerLoopIndex * 2 + 1];
            end
    end
    // End of 2nd-level adder tree

    // 4th-stage, 3rd-level adder tree, 128
    always @ (posedge S_AXI_ACLK) begin
        for(outerLoopIndex = 0; outerLoopIndex < totalElements / 16; outerLoopIndex = outerLoopIndex + 1)
            adder3_result[outerLoopIndex] <= adder2_result[outerLoopIndex * 2] + adder2_result[outerLoopIndex * 2 + 1];
    end
    // End of 3rd-level adder tree

    //5th-stage, 4th-level adder tree, 64
    always @ (posedge S_AXI_ACLK) begin
        for(outerLoopIndex = 0; outerLoopIndex < totalElements / 32; outerLoopIndex = outerLoopIndex + 1)
            adder4_result[outerLoopIndex] <= adder3_result[outerLoopIndex * 2] + adder3_result[outerLoopIndex * 2 + 1];
    end
    // End of 4th-level adder tree

    // 6th-stage, 5th-level adder tree, 32
    always @ (posedge S_AXI_ACLK) begin
        for(outerLoopIndex = 0; outerLoopIndex < totalElements / 64; outerLoopIndex = outerLoopIndex + 1)
            adder5_result[outerLoopIndex] <= adder4_result[outerLoopIndex * 2] + adder4_result[outerLoopIndex * 2 + 1];
    end
    // End of 5th-level adder tree

    // 7th-stage, 6th-level adder tree, 16
    always @ (posedge S_AXI_ACLK) begin
        for(outerLoopIndex = 0; outerLoopIndex < totalElements / 128; outerLoopIndex = outerLoopIndex + 1)
            adder6_result[outerLoopIndex] <= adder5_result[outerLoopIndex * 2] + adder5_result[outerLoopIndex * 2 + 1];
    end
    // End of 6th-level adder tree

    // 8th-stage, 7th-level adder tree, 8
    always @ ( posedge S_AXI_ACLK ) begin
        for(outerLoopIndex = 0; outerLoopIndex < totalElements / 256; outerLoopIndex = outerLoopIndex + 1)
            adder7_result[outerLoopIndex] <= adder6_result[outerLoopIndex * 2] + adder6_result[outerLoopIndex * 2 + 1];
    end
    // End of 7th-level adder tree

    // 9th-stage, 8th-level adder tree, 4
    always @ (posedge S_AXI_ACLK) begin
        for(outerLoopIndex = 0; outerLoopIndex < totalElements / 512; outerLoopIndex = outerLoopIndex + 1)
            adder8_result[outerLoopIndex] <= adder7_result[outerLoopIndex * 2] + adder7_result[outerLoopIndex * 2 + 1];
    end

    // 10th-stage, 9th-level adder tree, 2
    always @ (posedge S_AXI_ACLK) begin
        if(counter > 6'd9)
            begin
                firstRoundAdderResult <= firstRoundAdderResult;
                secondRoundAdderResult <= adder8_result[0] + adder8_result[1];
            end
        else
            begin
                firstRoundAdderResult <= adder8_result[0] + adder8_result[1];
                secondRoundAdderResult <= secondRoundAdderResult;
            end
    end
    // User logic ends

    endmodule
