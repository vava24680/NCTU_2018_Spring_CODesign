
`timescale 1 ns / 1 ps

    module transfer_v1_0_M00_AXI #
    (
        // Users to add parameters here

        // User parameters ends
        // Do not modify the parameters beyond this line

        // Base address of targeted slave
        parameter  C_M_TARGET_SLAVE_BASE_ADDR    = 32'h40000000,
        // Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
        parameter integer C_M_AXI_BURST_LEN    = 16,
        // Thread ID Width
        parameter integer C_M_AXI_ID_WIDTH    = 1,
        // Width of Address Bus
        parameter integer C_M_AXI_ADDR_WIDTH    = 32,
        // Width of Data Bus
        parameter integer C_M_AXI_DATA_WIDTH    = 32,
        // Width of User Write Address Bus
        parameter integer C_M_AXI_AWUSER_WIDTH    = 0,
        // Width of User Read Address Bus
        parameter integer C_M_AXI_ARUSER_WIDTH    = 0,
        // Width of User Write Data Bus
        parameter integer C_M_AXI_WUSER_WIDTH    = 0,
        // Width of User Read Data Bus
        parameter integer C_M_AXI_RUSER_WIDTH    = 0,
        // Width of User Response Bus
        parameter integer C_M_AXI_BUSER_WIDTH    = 0
    )
    (
        // Users to add ports here
        (* mark_debug = "true" *)input wire hw_active,
        input wire [C_M_AXI_DATA_WIDTH - 1 : 0] face_src_addr,
        input wire [C_M_AXI_DATA_WIDTH - 1 : 0] group_src_addr,
        output reg hw_done,
        output wire [C_M_AXI_DATA_WIDTH - 1 : 0] element1,
        output wire [C_M_AXI_DATA_WIDTH - 1 : 0] element2,
        output wire [C_M_AXI_DATA_WIDTH - 1 : 0] element3,
        output wire [C_M_AXI_DATA_WIDTH - 1 : 0] element4,
        output wire [C_M_AXI_DATA_WIDTH - 1 : 0] element5,
        output wire [C_M_AXI_DATA_WIDTH - 1 : 0] element6,
        // User ports ends
        // Do not modify the ports beyond this line
        // Global Clock Signal.
        input wire  M_AXI_ACLK,
        // Global Reset Singal. This Signal is Active Low
        input wire  M_AXI_ARESETN,
        // Master Interface Write Address ID
        output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID,
        // Master Interface Write Address
        output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
        // Burst length. The burst length gives the exact number of transfers in a burst
        output wire [7 : 0] M_AXI_AWLEN,
        // Burst size. This signal indicates the size of each transfer in the burst
        output wire [2 : 0] M_AXI_AWSIZE,
        // Burst type. The burst type and the size information,
    // determine how the address for each transfer within the burst is calculated.
        output wire [1 : 0] M_AXI_AWBURST,
        // Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
        output wire  M_AXI_AWLOCK,
        // Memory type. This signal indicates how transactions
    // are required to progress through a system.
        output wire [3 : 0] M_AXI_AWCACHE,
        // Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
        output wire [2 : 0] M_AXI_AWPROT,
        // Quality of Service, QoS identifier sent for each write transaction.
        output wire [3 : 0] M_AXI_AWQOS,
        // Optional User-defined signal in the write address channel.
        output wire [C_M_AXI_AWUSER_WIDTH-1 : 0] M_AXI_AWUSER,
        // Write address valid. This signal indicates that
    // the channel is signaling valid write address and control information.
        output wire  M_AXI_AWVALID,
        // Write address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
        input wire  M_AXI_AWREADY,
        // Master Interface Write Data.
        output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
        // Write strobes. This signal indicates which byte
    // lanes hold valid data. There is one write strobe
    // bit for each eight bits of the write data bus.
        output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
        // Write last. This signal indicates the last transfer in a write burst.
        output wire  M_AXI_WLAST,
        // Optional User-defined signal in the write data channel.
        output wire [C_M_AXI_WUSER_WIDTH-1 : 0] M_AXI_WUSER,
        // Write valid. This signal indicates that valid write
    // data and strobes are available
        output wire  M_AXI_WVALID,
        // Write ready. This signal indicates that the slave
    // can accept the write data.
        input wire  M_AXI_WREADY,
        // Master Interface Write Response.
        input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
        // Write response. This signal indicates the status of the write transaction.
        input wire [1 : 0] M_AXI_BRESP,
        // Optional User-defined signal in the write response channel
        input wire [C_M_AXI_BUSER_WIDTH-1 : 0] M_AXI_BUSER,
        // Write response valid. This signal indicates that the
    // channel is signaling a valid write response.
        input wire  M_AXI_BVALID,
        // Response ready. This signal indicates that the master
    // can accept a write response.
        output wire  M_AXI_BREADY,
        // Master Interface Read Address.
        output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
        // Read address. This signal indicates the initial
    // address of a read burst transaction.
        output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
        // Burst length. The burst length gives the exact number of transfers in a burst
        output wire [7 : 0] M_AXI_ARLEN,
        // Burst size. This signal indicates the size of each transfer in the burst
        output wire [2 : 0] M_AXI_ARSIZE,
        // Burst type. The burst type and the size information,
    // determine how the address for each transfer within the burst is calculated.
        output wire [1 : 0] M_AXI_ARBURST,
        // Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
        output wire  M_AXI_ARLOCK,
        // Memory type. This signal indicates how transactions
    // are required to progress through a system.
        output wire [3 : 0] M_AXI_ARCACHE,
        // Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
        output wire [2 : 0] M_AXI_ARPROT,
        // Quality of Service, QoS identifier sent for each read transaction
        output wire [3 : 0] M_AXI_ARQOS,
        // Optional User-defined signal in the read address channel.
        output wire [C_M_AXI_ARUSER_WIDTH-1 : 0] M_AXI_ARUSER,
        // Write address valid. This signal indicates that
    // the channel is signaling valid read address and control information
        output wire  M_AXI_ARVALID,
        // Read address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
        input wire  M_AXI_ARREADY,
        // Read ID tag. This signal is the identification tag
    // for the read data group of signals generated by the slave.
        input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
        // Master Read Data
        (* mark_debug = "true" *)input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
        // Read response. This signal indicates the status of the read transfer
        input wire [1 : 0] M_AXI_RRESP,
        // Read last. This signal indicates the last transfer in a read burst
        input wire  M_AXI_RLAST,
        // Optional User-defined signal in the read address channel.
        input wire [C_M_AXI_RUSER_WIDTH-1 : 0] M_AXI_RUSER,
        // Read valid. This signal indicates that the channel
    // is signaling the required read data.
        input wire  M_AXI_RVALID,
        // Read ready. This signal indicates that the master can
    // accept the read data and response information.
        output wire  M_AXI_RREADY
    );

    //(* mark_debug = "true" *)

    // function called clogb2 that returns an integer which has the
    //value of the ceiling of the log base 2

    // function called clogb2 that returns an integer which has the
    // value of the ceiling of the log base 2.
    function integer clogb2 (input integer bit_depth);
        begin
            for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
                bit_depth = bit_depth >> 1;
        end
    endfunction

    integer outerLoopIndex;
    integer outerLoopIndex_2;
    integer outerLoopIndex_3;
    integer innerLoopIndex;
    integer innerLoopIndex_2;
    integer innerLoopIndex_3;
    localparam integer GROUP_WIDTH = 1920;
    localparam integer GROUP_HEIGHT = 1080;
    localparam integer FACE_WIDTH = 32;
    localparam integer FACE_HEIGHT = 32;
    localparam integer GROUP_BUFFER_WIDTH = 32;
    localparam integer GROUP_BUFFER_HEIGHT = 32;
    localparam integer NEW_ROWS_BUFFER_WIDTH = 32;
    localparam integer NEW_ROWS_BUFFER_HEIGHT = 16;
    localparam integer FACE_BUFFER_WIDTH = FACE_WIDTH;
    localparam integer FACE_BUFFER_HEIGHT = FACE_HEIGHT;
    localparam integer PIXEL_WIDTH = 8;
    localparam integer TRANSFER_BUFFER_WIDTH = 32;
    localparam integer TRANSFER_BUFFER_HEIGHT = 16;
    localparam integer TRANSFER_BURST_LENGTH = 8;
    localparam integer MAX_X_POS = GROUP_WIDTH - FACE_BUFFER_WIDTH + 1;
    localparam integer MAX_Y_POS = GROUP_HEIGHT - FACE_BUFFER_HEIGHT + 1;
    // C_TRANSACTIONS_NUM is the width of the index counter for
    // number of write or read transaction.
    localparam integer C_TRANSACTIONS_NUM = clogb2(TRANSFER_BURST_LENGTH-1);

    // Example State machine to initialize counter, initialize write transactions,
    // initialize read transactions and comparison of read data with the
    // written data words.
    localparam IDLE = 2'b00; // This state initiates AXI4 transaction
                    // after the state machine changes state to INIT_READ
                    // when there is 0 to 1 transition on INIT_AXI_TXN
    localparam INIT_READ  = 2'b01; // This state initializes read transaction
                            // once reads are done, the state machine
                            // changes state to INIT_WRITE
    localparam RESET    = 2'b10;
    localparam COMPLETE  = 2'b11; // This state issues the status of comparison
                            // of the written data with the read data

    // Global finite state machine states definitions
    localparam gINITIAL = 4'd0;
    localparam gREAD_UP_FACE = 4'd1;
    localparam gREAD_DOWN_FACE = 4'd2;
    localparam gREAD_UP_GROUP = 4'd3;
    localparam gREAD_DOWN_GROUP = 4'd4;
    localparam gREAD_EXTRA_SIXTEEN_ROWS = 4'd5;
    localparam gCOMPUTE = 4'd6;
    localparam gCOMPLETE = 4'd7;

    // Computation finite state machine states definitions
    localparam cINITIAL = 4'd0;
    localparam cFIRST_ROUND_COMPUTATION = 4'd1;
    localparam cCOMPARE_SAD = 4'd2;
    localparam cSIXTEEN_ROWS_DONE = 4'd3;

    // Transfer finite state machine states definitions
    localparam tIDLE = 2'd0;
    localparam tINIT_READ = 2'd1;
    localparam tRESET = 2'd2;
    localparam tCOMPLETE = 2'd3;

    // AXI4LITE signals
    //AXI4 internal temp signals
    reg [C_M_AXI_ADDR_WIDTH-1 : 0]     axi_awaddr;
    reg      axi_awvalid;
    reg [C_M_AXI_DATA_WIDTH-1 : 0]     axi_wdata;
    reg      axi_wlast;
    reg      axi_wvalid;
    reg      axi_bready;
    reg [C_M_AXI_ADDR_WIDTH-1 : 0]     axi_araddr;
    reg      axi_arvalid;
    reg      axi_rready;
    //write beat count in a burst
    reg [C_TRANSACTIONS_NUM : 0]     write_index;
    //read beat count in a burst
    reg [C_TRANSACTIONS_NUM : 0]     read_index;
    //size of C_M_AXI_BURST_LEN length burst in bytes
    wire [C_TRANSACTIONS_NUM+2 : 0]     burst_size_bytes;
    reg      start_single_burst_write;
    reg      start_single_burst_read;
    reg      writes_done;
    (* mark_debug = "true" *)reg      reads_done;
    reg      burst_write_active;
    reg      burst_read_active;
    //Interface response error flags
    wire      write_resp_error;
    wire      read_resp_error;
    wire      wnext;
    wire      rnext;
    reg      init_txn_ff;
    reg      init_txn_ff2;
    reg      init_txn_edge;
    wire      init_txn_pulse;

    (* mark_debug = "true" *)reg [4 - 1:0] gState;
    (* mark_debug = "true" *)reg [4 - 1:0] cState;
    (* mark_debug = "true" *)reg fetchSixteenRowsFlag;
    (* mark_debug = "true" *)reg [1:0] mst_exec_state;
    reg [PIXEL_WIDTH - 1 : 0] faceBuffer[0 : FACE_BUFFER_HEIGHT - 1][0 : FACE_BUFFER_WIDTH - 1];
    reg [PIXEL_WIDTH - 1 : 0] groupBuffer[0 : GROUP_BUFFER_HEIGHT - 1][0 : GROUP_BUFFER_WIDTH - 1];
    reg [PIXEL_WIDTH - 1 : 0] newRowsBuffer[0 : NEW_ROWS_BUFFER_HEIGHT - 1][0 : NEW_ROWS_BUFFER_WIDTH - 1];
    reg [PIXEL_WIDTH - 1 : 0] transferBuffer[0 : TRANSFER_BUFFER_HEIGHT - 1][0 : TRANSFER_BUFFER_WIDTH - 1];
    wire [PIXEL_WIDTH - 1: 0] absoluteDifference[0 : FACE_BUFFER_HEIGHT - 1][0 : FACE_BUFFER_WIDTH - 1];
    reg [C_M_AXI_DATA_WIDTH - 1 : 0] adderResult_0[0 : 256 - 1];
    reg [C_M_AXI_DATA_WIDTH - 1 : 0] adderResult_1[0 : 64 - 1];
    reg [C_M_AXI_DATA_WIDTH - 1 : 0] adderResult_2[0 : 16 - 1];
    reg [C_M_AXI_DATA_WIDTH - 1 : 0] adderResult_3[0 : 4 - 1];
    reg [C_M_AXI_DATA_WIDTH - 1 : 0] adderResult_4;
    (* mark_debug = "true" *)reg [12 - 1 : 0] yIndexNow; //Range from 0 to 1047, represent the the upper left y-coordinate of the rectangle computating.
    (* mark_debug = "true" *)reg [12 - 1 : 0] xIndexNow; //Range from 0 to 1887, represent the the upper left x-coordinate of the rectanble computating.
    (* mark_debug = "true" *)reg [12 - 1 : 0] yIndexAns;
    (* mark_debug = "true" *)reg [12 - 1 : 0] xIndexAns;
    (* mark_debug = "true" *)reg [32 - 1 : 0] miniSAD;
    reg [8 - 1 : 0] i_index;
    reg [8 - 1 : 0] j_index;
    (* mark_debug = "true" *)reg [5 - 1 : 0] remainRowsSubsOne;
    reg cleanSignal;
    reg shiftDatatSignal;
    (* mark_debug = "true" *)reg startAdderSignal;
    (* mark_debug = "true" *)reg startPipelineTransferSignal;
    (* mark_debug = "true" *)reg pipelineTransferDoneSignal;
    (* mark_debug = "true" *)reg reachBottomSignal;
    (* mark_debug = "true" *)reg [5 - 1 : 0] cCounter;
    (* mark_debug = "true" *)reg [12 - 1 : 0] numberOfRowsNotTransfered;
    (* mark_debug = "true" *)wire [16 - 1 : 0] sum;
    // I/O Connections assignments

    //I/O Connections. Write Address (AW)
    assign M_AXI_AWID    = 'b0;
    //The AXI address is a concatenation of the target base address + active offset range
    assign M_AXI_AWADDR    = /* C_M_TARGET_SLAVE_BASE_ADDR + */ axi_awaddr;
    //Burst LENgth is number of transaction beats, minus 1
    assign M_AXI_AWLEN    = TRANSFER_BURST_LENGTH - 1;
    //Size should be C_M_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
    assign M_AXI_AWSIZE    = clogb2((C_M_AXI_DATA_WIDTH/8)-1);
    //INCR burst type is usually used, except for keyhole bursts
    assign M_AXI_AWBURST    = 2'b01;
    assign M_AXI_AWLOCK    = 1'b0;
    //Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port.
    // Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example
    // is meant to test memory, not intermediate cache.
    assign M_AXI_AWCACHE    = 4'b0010;
    assign M_AXI_AWPROT    = 3'h0;
    assign M_AXI_AWQOS    = 4'h0;
    assign M_AXI_AWUSER    = 'b1;
    assign M_AXI_AWVALID    = axi_awvalid;
    //Write Data(W)
    assign M_AXI_WDATA    = axi_wdata;
    //All bursts are complete and aligned in this example
    assign M_AXI_WSTRB    = {(C_M_AXI_DATA_WIDTH/8){1'b1}};
    assign M_AXI_WLAST    = axi_wlast;
    assign M_AXI_WUSER    = 'b0;
    assign M_AXI_WVALID    = axi_wvalid;
    //Write Response (B)
    assign M_AXI_BREADY    = axi_bready;
    //Read Address (AR)
    assign M_AXI_ARID    = 'b0;
    assign M_AXI_ARADDR    = /* C_M_TARGET_SLAVE_BASE_ADDR + */ axi_araddr;
    //Burst LENgth is number of transaction beats, minus 1
    assign M_AXI_ARLEN    = TRANSFER_BURST_LENGTH - 1;
    //Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
    assign M_AXI_ARSIZE    = clogb2((C_M_AXI_DATA_WIDTH/8)-1);
    //INCR burst type is usually used, except for keyhole bursts
    assign M_AXI_ARBURST    = 2'b01;
    assign M_AXI_ARLOCK    = 1'b0;
    //Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port.
    // Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example
    // is meant to test memory, not intermediate cache.
    assign M_AXI_ARCACHE    = 4'b0010;
    assign M_AXI_ARPROT    = 3'h0;
    assign M_AXI_ARQOS    = 4'h0;
    assign M_AXI_ARUSER    = 'b1;
    assign M_AXI_ARVALID    = axi_arvalid;
    //Read and Read Response (R)
    assign M_AXI_RREADY    = axi_rready;
    //Example design I/O
    //Burst size in bytes
    assign burst_size_bytes    = TRANSFER_BURST_LENGTH * C_M_AXI_DATA_WIDTH/8;
    assign init_txn_pulse    = (!init_txn_ff2) && init_txn_ff;

    assign element1 = faceBuffer[0][0];
    assign element2 = faceBuffer[15][31];
    assign element3 = faceBuffer[16][31];
    assign element4 = faceBuffer[31][31];
    assign element5 = xIndexAns;
    assign element6 = yIndexAns;


    //Generate a one-clock pulse to initiate the AXI4 copy transaction.
    always @(posedge M_AXI_ACLK)
    begin
        // Initiates AXI transaction delay
        if (M_AXI_ARESETN == 0 )
            begin
                init_txn_ff <= 1'b0;
                init_txn_ff2 <= 1'b0;
            end
        else
            begin
                init_txn_ff <= hw_active;
                init_txn_ff2 <= init_txn_ff;
            end
    end
//--------------------
//Write Address Channel
//--------------------

// The purpose of the write address channel is to request the address and
// command information for the entire transaction.  It is a single beat
// of information.

// The AXI4 Write address channel in this example will continue to initiate
// write commands as fast as it is allowed by the slave/interconnect.
// The address will be incremented on each accepted address transaction,
// by burst_size_byte to point to the next address.

    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )
            begin
                axi_awvalid <= 1'b0;
            end
        // If previously not valid , start next transaction
        else if (~axi_awvalid && start_single_burst_write)
            begin
                axi_awvalid <= 1'b1;
            end
        /* Once asserted, VALIDs cannot be deasserted, so axi_awvalid
        must wait until transaction is accepted */
        else if (M_AXI_AWREADY && axi_awvalid)
            begin
                axi_awvalid <= 1'b0;
            end
        else
            axi_awvalid <= axi_awvalid;
    end

    // Next address after AWREADY indicates previous address acceptance
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)
            begin
                axi_awaddr <= 0;
            end
        else if (M_AXI_AWREADY && axi_awvalid)
            begin
                axi_awaddr <= axi_awaddr + burst_size_bytes;
            end
        else
            axi_awaddr <= axi_awaddr;
    end

//--------------------
//Write Data Channel
//--------------------

//The write data will continually try to push write data across the interface.

//The amount of data accepted will depend on the AXI slave and the AXI
//Interconnect settings, such as if there are FIFOs enabled in interconnect.

//Note that there is no explicit timing relationship to the write address channel.
//The write channel has its own throttling flag, separate from the AW channel.

//Synchronization between the channels must be determined by the user.

//The simpliest but lowest performance would be to only issue one address write
//and write data burst at a time.

//In this example they are kept in sync by using the same address increment
//and burst sizes. Then the AW and W channels have their transactions measured
//with threshold counters as part of the user logic, to make sure neither
//channel gets too far ahead of each other.

//Forward movement occurs when the write channel is valid and ready

    assign wnext = M_AXI_WREADY & axi_wvalid;

    // WVALID logic, similar to the axi_awvalid always block above
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )
            begin
                axi_wvalid <= 1'b0;
            end
        // If previously not valid, start next transaction
        else if (~axi_wvalid && start_single_burst_write)
            begin
                axi_wvalid <= 1'b1;
            end
        /* If WREADY and too many writes, throttle WVALID
        Once asserted, VALIDs cannot be deasserted, so WVALID
        must wait until burst is complete with WLAST */
        else if (wnext && axi_wlast)
            axi_wvalid <= 1'b0;
        else
            axi_wvalid <= axi_wvalid;
    end


    //WLAST generation on the MSB of a counter underflow
    // WVALID logic, similar to the axi_awvalid always block above
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )
            begin
                axi_wlast <= 1'b0;
            end
            // axi_wlast is asserted when the write index
            // count reaches the penultimate count to synchronize
            // with the last write data when write_index is b1111
            // else if (&(write_index[C_TRANSACTIONS_NUM-1:1])&& ~write_index[0] && wnext)
        else if (((write_index == TRANSFER_BURST_LENGTH-2 && TRANSFER_BURST_LENGTH >= 2) && wnext) || (TRANSFER_BURST_LENGTH == 1 ))
            begin
                axi_wlast <= 1'b1;
            end
        // Deassrt axi_wlast when the last write data has been
        // accepted by the slave with a valid response
        else if (wnext)
            axi_wlast <= 1'b0;
        else if (axi_wlast && TRANSFER_BURST_LENGTH == 1)
            axi_wlast <= 1'b0;
        else
            axi_wlast <= axi_wlast;
    end


    /* Burst length counter. Uses extra counter register bit to indicate terminal
    count to reduce decode logic */
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 || start_single_burst_write == 1'b1)
        begin
        write_index <= 0;
        end
        else if (wnext && (write_index != TRANSFER_BURST_LENGTH-1))
        begin
        write_index <= write_index + 1;
        end
        else
        write_index <= write_index;
    end


    /* Write Data Generator */
    always @(*)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1)
            axi_wdata = 0;
        else if (mst_exec_state == IDLE)
            axi_wdata = 0;
        else
            axi_wdata = axi_wdata;
    end


    //----------------------------
    //Write Response (B) Channel
    //----------------------------

    //The write response channel provides feedback that the write has committed
    //to memory. BREADY will occur when all of the data and the write address
    //has arrived and been accepted by the slave.

    //The write issuance (number of outstanding write addresses) is started by
    //the Address Write transfer, and is completed by a BREADY/BRESP.

    //While negating BREADY will eventually throttle the AWREADY signal,
    //it is best not to throttle the whole data channel this way.

    //The BRESP bit [1] is used indicate any errors from the interconnect or
    //slave for the entire write burst. This example will capture the error
    //into the ERROR output.

    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )
            begin
                axi_bready <= 1'b0;
            end
        // accept/acknowledge bresp with axi_bready by the master
        // when M_AXI_BVALID is asserted by slave
        else if (M_AXI_BVALID && ~axi_bready)
            begin
                axi_bready <= 1'b1;
            end
        // deassert after one clock cycle
        else if (axi_bready)
            begin
                axi_bready <= 1'b0;
            end
        // retain the previous value
        else
            axi_bready <= axi_bready;
    end


    //Flag any write response errors
    assign write_resp_error = axi_bready & M_AXI_BVALID & M_AXI_BRESP[1];

    //----------------------------
    //Read Address Channel
    //----------------------------

    //The Read Address Channel (AW) provides a similar function to the
    //Write Address channel- to provide the tranfer qualifiers for the burst.

    //In this example, the read address increments in the same
    //manner as the write address channel.

    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )
            begin
                axi_arvalid <= 1'b0;
            end
            // If previously not valid , start next transaction
        else if (~axi_arvalid && start_single_burst_read)
            begin
                axi_arvalid <= 1'b1;
            end
        else if (M_AXI_ARREADY && axi_arvalid)
            begin
                axi_arvalid <= 1'b0;
            end
        else
            axi_arvalid <= axi_arvalid;
    end


    // Next address after ARREADY indicates previous address acceptance
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)
            axi_araddr <= face_src_addr;
        else if (M_AXI_ARREADY && axi_arvalid)
            //axi_araddr <= axi_araddr + 32;
            case (gState)
                gREAD_UP_FACE: begin
                    axi_araddr <= axi_araddr + 32;
                end
                gREAD_DOWN_FACE: begin
                    axi_araddr <= (remainRowsSubsOne == 5'd0) ? group_src_addr : axi_araddr + 32;
                end
                gREAD_UP_GROUP, gREAD_DOWN_GROUP, gREAD_EXTRA_SIXTEEN_ROWS: begin
                    axi_araddr <= axi_araddr + GROUP_WIDTH;
                end
                gCOMPUTE: begin
                    axi_araddr <= (reachBottomSignal) ? axi_araddr - GROUP_WIDTH * GROUP_HEIGHT + 1 : axi_araddr + 32'd1920;
                    //M_AXI_ARREADY, axi_arvalid and reachBottomSignal won't happen to be 1 at the same clock cycle
                    axi_araddr <= ( (axi_araddr - group_src_addr) == (GROUP_HEIGHT - 1) * GROUP_WIDTH )
                    ? axi_araddr - GROUP_WIDTH * (GROUP_HEIGHT - 1) + 1
                    : axi_araddr + 32'd1920;
                end
                default: begin
                    axi_araddr <= axi_araddr;
                end
            endcase
        else
            axi_araddr <= axi_araddr;
    end


    //--------------------------------
    //Read Data (and Response) Channel
    //--------------------------------

    // Forward movement occurs when the channel is valid and ready
    assign rnext = M_AXI_RVALID && axi_rready;


    // Burst length counter. Uses extra counter register bit to indicate
    // terminal count to reduce decode logic
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 || start_single_burst_read)
            begin
                read_index <= 0;
            end
        else if (rnext && (read_index != TRANSFER_BURST_LENGTH-1))
            begin
                read_index <= read_index + 1;
            end
        else
            read_index <= read_index;
    end


    /*
    The Read Data channel returns the results of the read request

    In this example the data checker is always able to accept
    more data, so no need to throttle the RREADY signal
    */
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )
            begin
                axi_rready <= 1'b0;
            end
        // accept/acknowledge rdata/rresp with axi_rready by the master
        // when M_AXI_RVALID is asserted by slave
        else if (M_AXI_RVALID)
            begin
                if (M_AXI_RLAST && axi_rready)
                    begin
                        axi_rready <= 1'b0;
                    end
                else
                    begin
                        axi_rready <= 1'b1;
                    end
            end
        // retain the previous value
    end

    // Read a data burst into the transferBuffer
    always @(posedge M_AXI_ACLK)
    begin
        //Read data when RVALID is active
        if (rnext)
            begin
                for(outerLoopIndex = 0; outerLoopIndex < TRANSFER_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        transferBuffer[outerLoopIndex][0] <= (outerLoopIndex == i_index && j_index == 0) ? M_AXI_RDATA[31:24] : transferBuffer[outerLoopIndex][0];
                        transferBuffer[outerLoopIndex][1] <= (outerLoopIndex == i_index && j_index == 0) ? M_AXI_RDATA[23:16] : transferBuffer[outerLoopIndex][1];
                        transferBuffer[outerLoopIndex][2] <= (outerLoopIndex == i_index && j_index == 0) ? M_AXI_RDATA[15:8] : transferBuffer[outerLoopIndex][2];
                        transferBuffer[outerLoopIndex][3] <= (outerLoopIndex == i_index && j_index == 0) ? M_AXI_RDATA[7:0] : transferBuffer[outerLoopIndex][3];
                        transferBuffer[outerLoopIndex][4] <= (outerLoopIndex == i_index && j_index == 1) ? M_AXI_RDATA[31:24] : transferBuffer[outerLoopIndex][4];
                        transferBuffer[outerLoopIndex][5] <= (outerLoopIndex == i_index && j_index == 1) ? M_AXI_RDATA[23:16] : transferBuffer[outerLoopIndex][5];
                        transferBuffer[outerLoopIndex][6] <= (outerLoopIndex == i_index && j_index == 1) ? M_AXI_RDATA[15:8] : transferBuffer[outerLoopIndex][6];
                        transferBuffer[outerLoopIndex][7] <= (outerLoopIndex == i_index && j_index == 1) ? M_AXI_RDATA[7:0] : transferBuffer[outerLoopIndex][7];
                        transferBuffer[outerLoopIndex][8] <= (outerLoopIndex == i_index && j_index == 2) ? M_AXI_RDATA[31:24] : transferBuffer[outerLoopIndex][8];
                        transferBuffer[outerLoopIndex][9] <= (outerLoopIndex == i_index && j_index == 2) ? M_AXI_RDATA[23:16] : transferBuffer[outerLoopIndex][9];
                        transferBuffer[outerLoopIndex][10] <= (outerLoopIndex == i_index && j_index == 2) ? M_AXI_RDATA[15:8] : transferBuffer[outerLoopIndex][10];
                        transferBuffer[outerLoopIndex][11] <= (outerLoopIndex == i_index && j_index == 2) ? M_AXI_RDATA[7:0] : transferBuffer[outerLoopIndex][11];
                        transferBuffer[outerLoopIndex][12] <= (outerLoopIndex == i_index && j_index == 3) ? M_AXI_RDATA[31:24] : transferBuffer[outerLoopIndex][12];
                        transferBuffer[outerLoopIndex][13] <= (outerLoopIndex == i_index && j_index == 3) ? M_AXI_RDATA[23:16] : transferBuffer[outerLoopIndex][13];
                        transferBuffer[outerLoopIndex][14] <= (outerLoopIndex == i_index && j_index == 3) ? M_AXI_RDATA[15:8] : transferBuffer[outerLoopIndex][14];
                        transferBuffer[outerLoopIndex][15] <= (outerLoopIndex == i_index && j_index == 3) ? M_AXI_RDATA[7:0] : transferBuffer[outerLoopIndex][15];
                        transferBuffer[outerLoopIndex][16] <= (outerLoopIndex == i_index && j_index == 4) ? M_AXI_RDATA[31:24] : transferBuffer[outerLoopIndex][16];
                        transferBuffer[outerLoopIndex][17] <= (outerLoopIndex == i_index && j_index == 4) ? M_AXI_RDATA[23:16] : transferBuffer[outerLoopIndex][17];
                        transferBuffer[outerLoopIndex][18] <= (outerLoopIndex == i_index && j_index == 4) ? M_AXI_RDATA[15:8] : transferBuffer[outerLoopIndex][18];
                        transferBuffer[outerLoopIndex][19] <= (outerLoopIndex == i_index && j_index == 4) ? M_AXI_RDATA[7:0] : transferBuffer[outerLoopIndex][19];
                        transferBuffer[outerLoopIndex][20] <= (outerLoopIndex == i_index && j_index == 5) ? M_AXI_RDATA[31:24] : transferBuffer[outerLoopIndex][20];
                        transferBuffer[outerLoopIndex][21] <= (outerLoopIndex == i_index && j_index == 5) ? M_AXI_RDATA[23:16] : transferBuffer[outerLoopIndex][21];
                        transferBuffer[outerLoopIndex][22] <= (outerLoopIndex == i_index && j_index == 5) ? M_AXI_RDATA[15:8] : transferBuffer[outerLoopIndex][22];
                        transferBuffer[outerLoopIndex][23] <= (outerLoopIndex == i_index && j_index == 5) ? M_AXI_RDATA[7:0] : transferBuffer[outerLoopIndex][23];
                        transferBuffer[outerLoopIndex][24] <= (outerLoopIndex == i_index && j_index == 6) ? M_AXI_RDATA[31:24] : transferBuffer[outerLoopIndex][24];
                        transferBuffer[outerLoopIndex][25] <= (outerLoopIndex == i_index && j_index == 6) ? M_AXI_RDATA[23:16] : transferBuffer[outerLoopIndex][25];
                        transferBuffer[outerLoopIndex][26] <= (outerLoopIndex == i_index && j_index == 6) ? M_AXI_RDATA[15:8] : transferBuffer[outerLoopIndex][26];
                        transferBuffer[outerLoopIndex][27] <= (outerLoopIndex == i_index && j_index == 6) ? M_AXI_RDATA[7:0] : transferBuffer[outerLoopIndex][27];
                        transferBuffer[outerLoopIndex][28] <= (outerLoopIndex == i_index && j_index == 7) ? M_AXI_RDATA[31:24] : transferBuffer[outerLoopIndex][28];
                        transferBuffer[outerLoopIndex][29] <= (outerLoopIndex == i_index && j_index == 7) ? M_AXI_RDATA[23:16] : transferBuffer[outerLoopIndex][29];
                        transferBuffer[outerLoopIndex][30] <= (outerLoopIndex == i_index && j_index == 7) ? M_AXI_RDATA[15:8] : transferBuffer[outerLoopIndex][30];
                        transferBuffer[outerLoopIndex][31] <= (outerLoopIndex == i_index && j_index == 7) ? M_AXI_RDATA[7:0] : transferBuffer[outerLoopIndex][31];
                    end
            end
        else
            begin
                for(outerLoopIndex = 0; outerLoopIndex < TRANSFER_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < TRANSFER_BUFFER_WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            transferBuffer[outerLoopIndex][innerLoopIndex] <= transferBuffer[outerLoopIndex][innerLoopIndex];
                    end
            end
    end

    always @ ( posedge M_AXI_ACLK ) begin
        if(mst_exec_state == IDLE)
            i_index <= 8'd0;
        else if(mst_exec_state == COMPLETE)
            i_index <= i_index + 8'd1;
        else
            i_index <= i_index;
    end

    always @ ( posedge M_AXI_ACLK ) begin
        if(mst_exec_state == IDLE || mst_exec_state == COMPLETE)
            j_index <= 8'd0;
        else if(rnext)
            j_index <= j_index + 8'd1;
        else
            j_index <= j_index;
    end

    //Flag any read response errors
    assign read_resp_error = axi_rready & M_AXI_RVALID & M_AXI_RRESP[1];

    //implement master command interface state machine
    always @ ( posedge M_AXI_ACLK ) begin
        if(mst_exec_state == IDLE)
            remainRowsSubsOne <= (numberOfRowsNotTransfered < 12'd16) ? numberOfRowsNotTransfered - 1 : TRANSFER_BUFFER_HEIGHT - 1;
        else if(mst_exec_state == COMPLETE)
            begin
                if(reads_done)
                    remainRowsSubsOne <= (remainRowsSubsOne > 5'd0) ? remainRowsSubsOne - 5'd1 : 5'd0;
                else
                    remainRowsSubsOne <= remainRowsSubsOne;
            end
        else
            remainRowsSubsOne <= remainRowsSubsOne;
    end

    always @ ( posedge M_AXI_ACLK ) begin
        if (M_AXI_ARESETN == 1'b0)
            fetchSixteenRowsFlag <= 1'b0;
        else if(fetchSixteenRowsFlag == 1'b0)
            if( (gState >= gREAD_DOWN_FACE && gState <= gREAD_EXTRA_SIXTEEN_ROWS && mst_exec_state == IDLE)
                ||
                reachBottomSignal
                ||
                startPipelineTransferSignal
                )
                fetchSixteenRowsFlag <= 1'b1;
            else
                fetchSixteenRowsFlag <= 1'b0;
        else
            fetchSixteenRowsFlag <= 1'b0;
    end

    always @ ( posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0 )
            begin
                // reset condition
                // All the signals are assigned default values under reset condition
                mst_exec_state <= IDLE;
                start_single_burst_write <= 1'b0;
                start_single_burst_read  <= 1'b0;
            end
        else
            begin
            // state transition
            case (mst_exec_state)
                IDLE:
                    // Wait until the signal INIT_AXI_TXN becomes active.
                    if (init_txn_pulse == 1'b1 || fetchSixteenRowsFlag == 1'b1)
                        begin
                            mst_exec_state  <= INIT_READ;
                        end
                    else
                        begin
                            mst_exec_state  <= IDLE;
                        end
                INIT_READ:
                    // This state is responsible to issue start_single_read pulse to
                    // initiate a read transaction. Read transactions will be
                    // issued until burst_read_active signal is asserted.
                    // read controller
                    if (reads_done)
                        begin
                            mst_exec_state <= RESET;
                        end
                    else
                        begin
                            mst_exec_state  <= INIT_READ;
                            if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read)
                                start_single_burst_read <= 1'b1;
                            else
                                start_single_burst_read <= 1'b0; //Negate to generate a pulse
                        end
                RESET:
                    mst_exec_state <= COMPLETE;
                COMPLETE:
                    // This state is responsible to issue the state of comparison
                    // of written data with the read data. If no error flags are set,
                    // compare_done signal will be asseted to indicate success.
                    //if (~error_reg)
                    begin
                        if(remainRowsSubsOne == 5'd0)
                            begin
                                mst_exec_state <= IDLE;
                            end
                        else
                            begin
                                mst_exec_state <= INIT_READ;
                            end
                    end
                default :
                    begin
                        mst_exec_state  <= IDLE;
                    end
            endcase
        end
    end //MASTER_EXECUTION_PROC

    always @ (posedge M_AXI_ACLK) begin
        if(M_AXI_ARESETN == 1'b0 || init_txn_pulse == 1'b1)
            cleanSignal <= 1'b0;
        else if(mst_exec_state == RESET)
            cleanSignal <= 1'b1;
        else if(cleanSignal == 1'b1)
            cleanSignal <= 1'b0;
        else
            cleanSignal <= cleanSignal;
    end

    // burst_read_active signal is asserted when there is a burst write transaction
    // is initiated by the assertion of start_single_burst_write. start_single_burst_read
    // signal remains asserted until the burst read is accepted by the master
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)
            burst_read_active <= 1'b0;
            //The burst_write_active is asserted when a write burst transaction is initiated
        else if (start_single_burst_read)
            burst_read_active <= 1'b1;
        else if (M_AXI_RVALID && axi_rready && M_AXI_RLAST)
            burst_read_active <= 0;
    end


    // Check for last read completion.

    // This logic is to qualify the last read count with the final read
    // response. This demonstrates how to confirm that a read has been
    // committed.
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 || cleanSignal == 1'b1)
            reads_done <= 1'b0;
        //The reads_done should be associated with a rready response
        //else if (M_AXI_BVALID && axi_bready && (write_burst_counter == {(C_NO_BURSTS_REQ-1){1}}) && axi_wlast)
        else if (M_AXI_RVALID && axi_rready && (read_index == TRANSFER_BURST_LENGTH-1))
            reads_done <= 1'b1;
        else
            reads_done <= reads_done;
    end

    // Add user logic here

    genvar genOuterIndex;

    always @ ( posedge M_AXI_ACLK ) begin
        if(M_AXI_ARESETN == 1'b0 || gState == gINITIAL || reachBottomSignal)
            numberOfRowsNotTransfered <= 12'd1080;
        else if(sum >= 3)
            numberOfRowsNotTransfered <= (numberOfRowsNotTransfered >= 12'd16) ? numberOfRowsNotTransfered - 12'd16 : 12'd0;
        else
            numberOfRowsNotTransfered <= numberOfRowsNotTransfered;
    end

    always @ ( posedge M_AXI_ACLK ) begin
        if(M_AXI_ARESETN == 1'b0)
            gState <= gINITIAL;
        else
            begin
                case (gState)
                    gINITIAL: begin
                        if(init_txn_pulse == 1'b1)
                            gState <= gREAD_UP_FACE;
                        else
                            gState <= gINITIAL;
                    end
                    gREAD_UP_FACE: begin //gREAD_UP_FACE
                        if(remainRowsSubsOne == 5'b0 && mst_exec_state == COMPLETE)
                            gState <= gREAD_DOWN_FACE;
                        else
                            gState <= gREAD_UP_FACE;
                    end
                    gREAD_DOWN_FACE: begin
                        if(remainRowsSubsOne == 5'b0 && mst_exec_state == COMPLETE)
                            gState <= gREAD_UP_GROUP;
                        else
                            gState <= gREAD_DOWN_FACE;
                    end
                    gREAD_UP_GROUP: begin
                        if(remainRowsSubsOne == 5'b0 && mst_exec_state == COMPLETE)
                            gState <= gREAD_DOWN_GROUP;
                        else
                            gState <= gREAD_UP_GROUP;
                    end
                    gREAD_DOWN_GROUP: begin
                        if(remainRowsSubsOne == 5'b0 && mst_exec_state == COMPLETE)
                            gState <= gREAD_EXTRA_SIXTEEN_ROWS;
                        else
                            gState <= gREAD_DOWN_GROUP;
                    end
                    gREAD_EXTRA_SIXTEEN_ROWS: begin
                        if(remainRowsSubsOne == 5'b0 && mst_exec_state == COMPLETE)
                            gState <= gCOMPUTE;
                        else
                            gState <= gREAD_EXTRA_SIXTEEN_ROWS;
                    end
                    gCOMPUTE: begin
                        if(reachBottomSignal)
                            gState <= ( xIndexNow == MAX_X_POS ) ? gCOMPLETE : gREAD_UP_GROUP;
                        else
                            gState <= gCOMPUTE;
                    end
                    gCOMPLETE: begin
                        gState <= gINITIAL;
                    end
                    default: begin
                        gState <= gINITIAL;
                    end
                endcase
            end
    end

    always @ (posedge M_AXI_ACLK) begin
        if(M_AXI_ARESETN == 1'b0)
            hw_done <= 1'b0;
        else
            hw_done <= (gState == gCOMPLETE) ? 1'b1 : 1'b0;
    end

    assign sum = gState * (mst_exec_state == 5'd3 && remainRowsSubsOne == 5'd0);

    // always block for shiftDatatSignal signal
    always @ (posedge M_AXI_ACLK) begin
        if(sum == 16'd5 || pipelineTransferDoneSignal == 1'b1)
            shiftDatatSignal <= 1'b1;
        else if(cCounter == 5'd15)
            shiftDatatSignal <= 1'b0;
        else
            shiftDatatSignal <= shiftDatatSignal;
    end

    // always block for moving data from transferBuffer to faceBuffer
    always @ ( posedge M_AXI_ACLK ) begin
        case (sum)
            16'd1: begin
                for(outerLoopIndex = 0; outerLoopIndex < TRANSFER_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        faceBuffer[outerLoopIndex][0] <= transferBuffer[outerLoopIndex][0];
                        faceBuffer[outerLoopIndex][1] <= transferBuffer[outerLoopIndex][1];
                        faceBuffer[outerLoopIndex][2] <= transferBuffer[outerLoopIndex][2];
                        faceBuffer[outerLoopIndex][3] <= transferBuffer[outerLoopIndex][3];
                        faceBuffer[outerLoopIndex][4] <= transferBuffer[outerLoopIndex][4];
                        faceBuffer[outerLoopIndex][5] <= transferBuffer[outerLoopIndex][5];
                        faceBuffer[outerLoopIndex][6] <= transferBuffer[outerLoopIndex][6];
                        faceBuffer[outerLoopIndex][7] <= transferBuffer[outerLoopIndex][7];
                        faceBuffer[outerLoopIndex][8] <= transferBuffer[outerLoopIndex][8];
                        faceBuffer[outerLoopIndex][9] <= transferBuffer[outerLoopIndex][9];
                        faceBuffer[outerLoopIndex][10] <= transferBuffer[outerLoopIndex][10];
                        faceBuffer[outerLoopIndex][11] <= transferBuffer[outerLoopIndex][11];
                        faceBuffer[outerLoopIndex][12] <= transferBuffer[outerLoopIndex][12];
                        faceBuffer[outerLoopIndex][13] <= transferBuffer[outerLoopIndex][13];
                        faceBuffer[outerLoopIndex][14] <= transferBuffer[outerLoopIndex][14];
                        faceBuffer[outerLoopIndex][15] <= transferBuffer[outerLoopIndex][15];
                        faceBuffer[outerLoopIndex][16] <= transferBuffer[outerLoopIndex][16];
                        faceBuffer[outerLoopIndex][17] <= transferBuffer[outerLoopIndex][17];
                        faceBuffer[outerLoopIndex][18] <= transferBuffer[outerLoopIndex][18];
                        faceBuffer[outerLoopIndex][19] <= transferBuffer[outerLoopIndex][19];
                        faceBuffer[outerLoopIndex][20] <= transferBuffer[outerLoopIndex][20];
                        faceBuffer[outerLoopIndex][21] <= transferBuffer[outerLoopIndex][21];
                        faceBuffer[outerLoopIndex][22] <= transferBuffer[outerLoopIndex][22];
                        faceBuffer[outerLoopIndex][23] <= transferBuffer[outerLoopIndex][23];
                        faceBuffer[outerLoopIndex][24] <= transferBuffer[outerLoopIndex][24];
                        faceBuffer[outerLoopIndex][25] <= transferBuffer[outerLoopIndex][25];
                        faceBuffer[outerLoopIndex][26] <= transferBuffer[outerLoopIndex][26];
                        faceBuffer[outerLoopIndex][27] <= transferBuffer[outerLoopIndex][27];
                        faceBuffer[outerLoopIndex][28] <= transferBuffer[outerLoopIndex][28];
                        faceBuffer[outerLoopIndex][29] <= transferBuffer[outerLoopIndex][29];
                        faceBuffer[outerLoopIndex][30] <= transferBuffer[outerLoopIndex][30];
                        faceBuffer[outerLoopIndex][31] <= transferBuffer[outerLoopIndex][31];
                    end
                for(outerLoopIndex = TRANSFER_BUFFER_HEIGHT; outerLoopIndex < FACE_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        faceBuffer[outerLoopIndex][0] <= faceBuffer[outerLoopIndex][0];
                        faceBuffer[outerLoopIndex][1] <= faceBuffer[outerLoopIndex][1];
                        faceBuffer[outerLoopIndex][2] <= faceBuffer[outerLoopIndex][2];
                        faceBuffer[outerLoopIndex][3] <= faceBuffer[outerLoopIndex][3];
                        faceBuffer[outerLoopIndex][4] <= faceBuffer[outerLoopIndex][4];
                        faceBuffer[outerLoopIndex][5] <= faceBuffer[outerLoopIndex][5];
                        faceBuffer[outerLoopIndex][6] <= faceBuffer[outerLoopIndex][6];
                        faceBuffer[outerLoopIndex][7] <= faceBuffer[outerLoopIndex][7];
                        faceBuffer[outerLoopIndex][8] <= faceBuffer[outerLoopIndex][8];
                        faceBuffer[outerLoopIndex][9] <= faceBuffer[outerLoopIndex][9];
                        faceBuffer[outerLoopIndex][10] <= faceBuffer[outerLoopIndex][10];
                        faceBuffer[outerLoopIndex][11] <= faceBuffer[outerLoopIndex][11];
                        faceBuffer[outerLoopIndex][12] <= faceBuffer[outerLoopIndex][12];
                        faceBuffer[outerLoopIndex][13] <= faceBuffer[outerLoopIndex][13];
                        faceBuffer[outerLoopIndex][14] <= faceBuffer[outerLoopIndex][14];
                        faceBuffer[outerLoopIndex][15] <= faceBuffer[outerLoopIndex][15];
                        faceBuffer[outerLoopIndex][16] <= faceBuffer[outerLoopIndex][16];
                        faceBuffer[outerLoopIndex][17] <= faceBuffer[outerLoopIndex][17];
                        faceBuffer[outerLoopIndex][18] <= faceBuffer[outerLoopIndex][18];
                        faceBuffer[outerLoopIndex][19] <= faceBuffer[outerLoopIndex][19];
                        faceBuffer[outerLoopIndex][20] <= faceBuffer[outerLoopIndex][20];
                        faceBuffer[outerLoopIndex][21] <= faceBuffer[outerLoopIndex][21];
                        faceBuffer[outerLoopIndex][22] <= faceBuffer[outerLoopIndex][22];
                        faceBuffer[outerLoopIndex][23] <= faceBuffer[outerLoopIndex][23];
                        faceBuffer[outerLoopIndex][24] <= faceBuffer[outerLoopIndex][24];
                        faceBuffer[outerLoopIndex][25] <= faceBuffer[outerLoopIndex][25];
                        faceBuffer[outerLoopIndex][26] <= faceBuffer[outerLoopIndex][26];
                        faceBuffer[outerLoopIndex][27] <= faceBuffer[outerLoopIndex][27];
                        faceBuffer[outerLoopIndex][28] <= faceBuffer[outerLoopIndex][28];
                        faceBuffer[outerLoopIndex][29] <= faceBuffer[outerLoopIndex][29];
                        faceBuffer[outerLoopIndex][30] <= faceBuffer[outerLoopIndex][30];
                        faceBuffer[outerLoopIndex][31] <= faceBuffer[outerLoopIndex][31];
                    end
            end
            16'd2: begin
                for(outerLoopIndex = 0; outerLoopIndex < TRANSFER_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        faceBuffer[outerLoopIndex][0] <= faceBuffer[outerLoopIndex][0];
                        faceBuffer[outerLoopIndex][1] <= faceBuffer[outerLoopIndex][1];
                        faceBuffer[outerLoopIndex][2] <= faceBuffer[outerLoopIndex][2];
                        faceBuffer[outerLoopIndex][3] <= faceBuffer[outerLoopIndex][3];
                        faceBuffer[outerLoopIndex][4] <= faceBuffer[outerLoopIndex][4];
                        faceBuffer[outerLoopIndex][5] <= faceBuffer[outerLoopIndex][5];
                        faceBuffer[outerLoopIndex][6] <= faceBuffer[outerLoopIndex][6];
                        faceBuffer[outerLoopIndex][7] <= faceBuffer[outerLoopIndex][7];
                        faceBuffer[outerLoopIndex][8] <= faceBuffer[outerLoopIndex][8];
                        faceBuffer[outerLoopIndex][9] <= faceBuffer[outerLoopIndex][9];
                        faceBuffer[outerLoopIndex][10] <= faceBuffer[outerLoopIndex][10];
                        faceBuffer[outerLoopIndex][11] <= faceBuffer[outerLoopIndex][11];
                        faceBuffer[outerLoopIndex][12] <= faceBuffer[outerLoopIndex][12];
                        faceBuffer[outerLoopIndex][13] <= faceBuffer[outerLoopIndex][13];
                        faceBuffer[outerLoopIndex][14] <= faceBuffer[outerLoopIndex][14];
                        faceBuffer[outerLoopIndex][15] <= faceBuffer[outerLoopIndex][15];
                        faceBuffer[outerLoopIndex][16] <= faceBuffer[outerLoopIndex][16];
                        faceBuffer[outerLoopIndex][17] <= faceBuffer[outerLoopIndex][17];
                        faceBuffer[outerLoopIndex][18] <= faceBuffer[outerLoopIndex][18];
                        faceBuffer[outerLoopIndex][19] <= faceBuffer[outerLoopIndex][19];
                        faceBuffer[outerLoopIndex][20] <= faceBuffer[outerLoopIndex][20];
                        faceBuffer[outerLoopIndex][21] <= faceBuffer[outerLoopIndex][21];
                        faceBuffer[outerLoopIndex][22] <= faceBuffer[outerLoopIndex][22];
                        faceBuffer[outerLoopIndex][23] <= faceBuffer[outerLoopIndex][23];
                        faceBuffer[outerLoopIndex][24] <= faceBuffer[outerLoopIndex][24];
                        faceBuffer[outerLoopIndex][25] <= faceBuffer[outerLoopIndex][25];
                        faceBuffer[outerLoopIndex][26] <= faceBuffer[outerLoopIndex][26];
                        faceBuffer[outerLoopIndex][27] <= faceBuffer[outerLoopIndex][27];
                        faceBuffer[outerLoopIndex][28] <= faceBuffer[outerLoopIndex][28];
                        faceBuffer[outerLoopIndex][29] <= faceBuffer[outerLoopIndex][29];
                        faceBuffer[outerLoopIndex][30] <= faceBuffer[outerLoopIndex][30];
                        faceBuffer[outerLoopIndex][31] <= faceBuffer[outerLoopIndex][31];
                    end
                for(outerLoopIndex = TRANSFER_BUFFER_HEIGHT; outerLoopIndex < FACE_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        faceBuffer[outerLoopIndex][0] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][0];
                        faceBuffer[outerLoopIndex][1] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][1];
                        faceBuffer[outerLoopIndex][2] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][2];
                        faceBuffer[outerLoopIndex][3] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][3];
                        faceBuffer[outerLoopIndex][4] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][4];
                        faceBuffer[outerLoopIndex][5] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][5];
                        faceBuffer[outerLoopIndex][6] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][6];
                        faceBuffer[outerLoopIndex][7] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][7];
                        faceBuffer[outerLoopIndex][8] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][8];
                        faceBuffer[outerLoopIndex][9] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][9];
                        faceBuffer[outerLoopIndex][10] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][10];
                        faceBuffer[outerLoopIndex][11] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][11];
                        faceBuffer[outerLoopIndex][12] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][12];
                        faceBuffer[outerLoopIndex][13] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][13];
                        faceBuffer[outerLoopIndex][14] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][14];
                        faceBuffer[outerLoopIndex][15] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][15];
                        faceBuffer[outerLoopIndex][16] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][16];
                        faceBuffer[outerLoopIndex][17] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][17];
                        faceBuffer[outerLoopIndex][18] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][18];
                        faceBuffer[outerLoopIndex][19] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][19];
                        faceBuffer[outerLoopIndex][20] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][20];
                        faceBuffer[outerLoopIndex][21] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][21];
                        faceBuffer[outerLoopIndex][22] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][22];
                        faceBuffer[outerLoopIndex][23] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][23];
                        faceBuffer[outerLoopIndex][24] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][24];
                        faceBuffer[outerLoopIndex][25] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][25];
                        faceBuffer[outerLoopIndex][26] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][26];
                        faceBuffer[outerLoopIndex][27] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][27];
                        faceBuffer[outerLoopIndex][28] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][28];
                        faceBuffer[outerLoopIndex][29] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][29];
                        faceBuffer[outerLoopIndex][30] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][30];
                        faceBuffer[outerLoopIndex][31] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][31];
                    end
            end
            default: begin
                for(outerLoopIndex = 0; outerLoopIndex < FACE_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        faceBuffer[outerLoopIndex][0] <= faceBuffer[outerLoopIndex][0];
                        faceBuffer[outerLoopIndex][1] <= faceBuffer[outerLoopIndex][1];
                        faceBuffer[outerLoopIndex][2] <= faceBuffer[outerLoopIndex][2];
                        faceBuffer[outerLoopIndex][3] <= faceBuffer[outerLoopIndex][3];
                        faceBuffer[outerLoopIndex][4] <= faceBuffer[outerLoopIndex][4];
                        faceBuffer[outerLoopIndex][5] <= faceBuffer[outerLoopIndex][5];
                        faceBuffer[outerLoopIndex][6] <= faceBuffer[outerLoopIndex][6];
                        faceBuffer[outerLoopIndex][7] <= faceBuffer[outerLoopIndex][7];
                        faceBuffer[outerLoopIndex][8] <= faceBuffer[outerLoopIndex][8];
                        faceBuffer[outerLoopIndex][9] <= faceBuffer[outerLoopIndex][9];
                        faceBuffer[outerLoopIndex][10] <= faceBuffer[outerLoopIndex][10];
                        faceBuffer[outerLoopIndex][11] <= faceBuffer[outerLoopIndex][11];
                        faceBuffer[outerLoopIndex][12] <= faceBuffer[outerLoopIndex][12];
                        faceBuffer[outerLoopIndex][13] <= faceBuffer[outerLoopIndex][13];
                        faceBuffer[outerLoopIndex][14] <= faceBuffer[outerLoopIndex][14];
                        faceBuffer[outerLoopIndex][15] <= faceBuffer[outerLoopIndex][15];
                        faceBuffer[outerLoopIndex][16] <= faceBuffer[outerLoopIndex][16];
                        faceBuffer[outerLoopIndex][17] <= faceBuffer[outerLoopIndex][17];
                        faceBuffer[outerLoopIndex][18] <= faceBuffer[outerLoopIndex][18];
                        faceBuffer[outerLoopIndex][19] <= faceBuffer[outerLoopIndex][19];
                        faceBuffer[outerLoopIndex][20] <= faceBuffer[outerLoopIndex][20];
                        faceBuffer[outerLoopIndex][21] <= faceBuffer[outerLoopIndex][21];
                        faceBuffer[outerLoopIndex][22] <= faceBuffer[outerLoopIndex][22];
                        faceBuffer[outerLoopIndex][23] <= faceBuffer[outerLoopIndex][23];
                        faceBuffer[outerLoopIndex][24] <= faceBuffer[outerLoopIndex][24];
                        faceBuffer[outerLoopIndex][25] <= faceBuffer[outerLoopIndex][25];
                        faceBuffer[outerLoopIndex][26] <= faceBuffer[outerLoopIndex][26];
                        faceBuffer[outerLoopIndex][27] <= faceBuffer[outerLoopIndex][27];
                        faceBuffer[outerLoopIndex][28] <= faceBuffer[outerLoopIndex][28];
                        faceBuffer[outerLoopIndex][29] <= faceBuffer[outerLoopIndex][29];
                        faceBuffer[outerLoopIndex][30] <= faceBuffer[outerLoopIndex][30];
                        faceBuffer[outerLoopIndex][31] <= faceBuffer[outerLoopIndex][31];
                    end
            end
        endcase
    end

    // always block for moving data from transferBuffer to groupBuffer
    always @ ( posedge M_AXI_ACLK ) begin
        case(sum)
            16'd0: begin
                if(cState == cFIRST_ROUND_COMPUTATION || cState == cCOMPARE_SAD)
                    begin
                        for(outerLoopIndex = 0; outerLoopIndex < GROUP_BUFFER_HEIGHT - 1; outerLoopIndex = outerLoopIndex + 1)
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < GROUP_BUFFER_HEIGHT; innerLoopIndex = innerLoopIndex + 1)
                                    groupBuffer[outerLoopIndex][innerLoopIndex] <= groupBuffer[outerLoopIndex + 1][innerLoopIndex];
                            end
                        for(innerLoopIndex = 0; innerLoopIndex < GROUP_BUFFER_WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            groupBuffer[31][innerLoopIndex] <= newRowsBuffer[0][innerLoopIndex];
                    end
                else
                    begin
                        for(outerLoopIndex = 0; outerLoopIndex < GROUP_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                            begin
                                for(innerLoopIndex = 0; innerLoopIndex < GROUP_BUFFER_WIDTH; innerLoopIndex = innerLoopIndex + 1)
                                    groupBuffer[outerLoopIndex][innerLoopIndex] <= groupBuffer[outerLoopIndex][innerLoopIndex];
                            end
                    end
            end
            16'd3: begin
                for(outerLoopIndex = 0; outerLoopIndex < TRANSFER_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        groupBuffer[outerLoopIndex][0] <= transferBuffer[outerLoopIndex][0];
                        groupBuffer[outerLoopIndex][1] <= transferBuffer[outerLoopIndex][1];
                        groupBuffer[outerLoopIndex][2] <= transferBuffer[outerLoopIndex][2];
                        groupBuffer[outerLoopIndex][3] <= transferBuffer[outerLoopIndex][3];
                        groupBuffer[outerLoopIndex][4] <= transferBuffer[outerLoopIndex][4];
                        groupBuffer[outerLoopIndex][5] <= transferBuffer[outerLoopIndex][5];
                        groupBuffer[outerLoopIndex][6] <= transferBuffer[outerLoopIndex][6];
                        groupBuffer[outerLoopIndex][7] <= transferBuffer[outerLoopIndex][7];
                        groupBuffer[outerLoopIndex][8] <= transferBuffer[outerLoopIndex][8];
                        groupBuffer[outerLoopIndex][9] <= transferBuffer[outerLoopIndex][9];
                        groupBuffer[outerLoopIndex][10] <= transferBuffer[outerLoopIndex][10];
                        groupBuffer[outerLoopIndex][11] <= transferBuffer[outerLoopIndex][11];
                        groupBuffer[outerLoopIndex][12] <= transferBuffer[outerLoopIndex][12];
                        groupBuffer[outerLoopIndex][13] <= transferBuffer[outerLoopIndex][13];
                        groupBuffer[outerLoopIndex][14] <= transferBuffer[outerLoopIndex][14];
                        groupBuffer[outerLoopIndex][15] <= transferBuffer[outerLoopIndex][15];
                        groupBuffer[outerLoopIndex][16] <= transferBuffer[outerLoopIndex][16];
                        groupBuffer[outerLoopIndex][17] <= transferBuffer[outerLoopIndex][17];
                        groupBuffer[outerLoopIndex][18] <= transferBuffer[outerLoopIndex][18];
                        groupBuffer[outerLoopIndex][19] <= transferBuffer[outerLoopIndex][19];
                        groupBuffer[outerLoopIndex][20] <= transferBuffer[outerLoopIndex][20];
                        groupBuffer[outerLoopIndex][21] <= transferBuffer[outerLoopIndex][21];
                        groupBuffer[outerLoopIndex][22] <= transferBuffer[outerLoopIndex][22];
                        groupBuffer[outerLoopIndex][23] <= transferBuffer[outerLoopIndex][23];
                        groupBuffer[outerLoopIndex][24] <= transferBuffer[outerLoopIndex][24];
                        groupBuffer[outerLoopIndex][25] <= transferBuffer[outerLoopIndex][25];
                        groupBuffer[outerLoopIndex][26] <= transferBuffer[outerLoopIndex][26];
                        groupBuffer[outerLoopIndex][27] <= transferBuffer[outerLoopIndex][27];
                        groupBuffer[outerLoopIndex][28] <= transferBuffer[outerLoopIndex][28];
                        groupBuffer[outerLoopIndex][29] <= transferBuffer[outerLoopIndex][29];
                        groupBuffer[outerLoopIndex][30] <= transferBuffer[outerLoopIndex][30];
                        groupBuffer[outerLoopIndex][31] <= transferBuffer[outerLoopIndex][31];
                    end
                for(outerLoopIndex = TRANSFER_BUFFER_HEIGHT; outerLoopIndex < GROUP_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        groupBuffer[outerLoopIndex][0] <= groupBuffer[outerLoopIndex][0];
                        groupBuffer[outerLoopIndex][1] <= groupBuffer[outerLoopIndex][1];
                        groupBuffer[outerLoopIndex][2] <= groupBuffer[outerLoopIndex][2];
                        groupBuffer[outerLoopIndex][3] <= groupBuffer[outerLoopIndex][3];
                        groupBuffer[outerLoopIndex][4] <= groupBuffer[outerLoopIndex][4];
                        groupBuffer[outerLoopIndex][5] <= groupBuffer[outerLoopIndex][5];
                        groupBuffer[outerLoopIndex][6] <= groupBuffer[outerLoopIndex][6];
                        groupBuffer[outerLoopIndex][7] <= groupBuffer[outerLoopIndex][7];
                        groupBuffer[outerLoopIndex][8] <= groupBuffer[outerLoopIndex][8];
                        groupBuffer[outerLoopIndex][9] <= groupBuffer[outerLoopIndex][9];
                        groupBuffer[outerLoopIndex][10] <= groupBuffer[outerLoopIndex][10];
                        groupBuffer[outerLoopIndex][11] <= groupBuffer[outerLoopIndex][11];
                        groupBuffer[outerLoopIndex][12] <= groupBuffer[outerLoopIndex][12];
                        groupBuffer[outerLoopIndex][13] <= groupBuffer[outerLoopIndex][13];
                        groupBuffer[outerLoopIndex][14] <= groupBuffer[outerLoopIndex][14];
                        groupBuffer[outerLoopIndex][15] <= groupBuffer[outerLoopIndex][15];
                        groupBuffer[outerLoopIndex][16] <= groupBuffer[outerLoopIndex][16];
                        groupBuffer[outerLoopIndex][17] <= groupBuffer[outerLoopIndex][17];
                        groupBuffer[outerLoopIndex][18] <= groupBuffer[outerLoopIndex][18];
                        groupBuffer[outerLoopIndex][19] <= groupBuffer[outerLoopIndex][19];
                        groupBuffer[outerLoopIndex][20] <= groupBuffer[outerLoopIndex][20];
                        groupBuffer[outerLoopIndex][21] <= groupBuffer[outerLoopIndex][21];
                        groupBuffer[outerLoopIndex][22] <= groupBuffer[outerLoopIndex][22];
                        groupBuffer[outerLoopIndex][23] <= groupBuffer[outerLoopIndex][23];
                        groupBuffer[outerLoopIndex][24] <= groupBuffer[outerLoopIndex][24];
                        groupBuffer[outerLoopIndex][25] <= groupBuffer[outerLoopIndex][25];
                        groupBuffer[outerLoopIndex][26] <= groupBuffer[outerLoopIndex][26];
                        groupBuffer[outerLoopIndex][27] <= groupBuffer[outerLoopIndex][27];
                        groupBuffer[outerLoopIndex][28] <= groupBuffer[outerLoopIndex][28];
                        groupBuffer[outerLoopIndex][29] <= groupBuffer[outerLoopIndex][29];
                        groupBuffer[outerLoopIndex][30] <= groupBuffer[outerLoopIndex][30];
                        groupBuffer[outerLoopIndex][31] <= groupBuffer[outerLoopIndex][31];
                    end
            end
            16'd4: begin
                for(outerLoopIndex = 0; outerLoopIndex < TRANSFER_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        groupBuffer[outerLoopIndex][0] <= groupBuffer[outerLoopIndex][0];
                        groupBuffer[outerLoopIndex][1] <= groupBuffer[outerLoopIndex][1];
                        groupBuffer[outerLoopIndex][2] <= groupBuffer[outerLoopIndex][2];
                        groupBuffer[outerLoopIndex][3] <= groupBuffer[outerLoopIndex][3];
                        groupBuffer[outerLoopIndex][4] <= groupBuffer[outerLoopIndex][4];
                        groupBuffer[outerLoopIndex][5] <= groupBuffer[outerLoopIndex][5];
                        groupBuffer[outerLoopIndex][6] <= groupBuffer[outerLoopIndex][6];
                        groupBuffer[outerLoopIndex][7] <= groupBuffer[outerLoopIndex][7];
                        groupBuffer[outerLoopIndex][8] <= groupBuffer[outerLoopIndex][8];
                        groupBuffer[outerLoopIndex][9] <= groupBuffer[outerLoopIndex][9];
                        groupBuffer[outerLoopIndex][10] <= groupBuffer[outerLoopIndex][10];
                        groupBuffer[outerLoopIndex][11] <= groupBuffer[outerLoopIndex][11];
                        groupBuffer[outerLoopIndex][12] <= groupBuffer[outerLoopIndex][12];
                        groupBuffer[outerLoopIndex][13] <= groupBuffer[outerLoopIndex][13];
                        groupBuffer[outerLoopIndex][14] <= groupBuffer[outerLoopIndex][14];
                        groupBuffer[outerLoopIndex][15] <= groupBuffer[outerLoopIndex][15];
                        groupBuffer[outerLoopIndex][16] <= groupBuffer[outerLoopIndex][16];
                        groupBuffer[outerLoopIndex][17] <= groupBuffer[outerLoopIndex][17];
                        groupBuffer[outerLoopIndex][18] <= groupBuffer[outerLoopIndex][18];
                        groupBuffer[outerLoopIndex][19] <= groupBuffer[outerLoopIndex][19];
                        groupBuffer[outerLoopIndex][20] <= groupBuffer[outerLoopIndex][20];
                        groupBuffer[outerLoopIndex][21] <= groupBuffer[outerLoopIndex][21];
                        groupBuffer[outerLoopIndex][22] <= groupBuffer[outerLoopIndex][22];
                        groupBuffer[outerLoopIndex][23] <= groupBuffer[outerLoopIndex][23];
                        groupBuffer[outerLoopIndex][24] <= groupBuffer[outerLoopIndex][24];
                        groupBuffer[outerLoopIndex][25] <= groupBuffer[outerLoopIndex][25];
                        groupBuffer[outerLoopIndex][26] <= groupBuffer[outerLoopIndex][26];
                        groupBuffer[outerLoopIndex][27] <= groupBuffer[outerLoopIndex][27];
                        groupBuffer[outerLoopIndex][28] <= groupBuffer[outerLoopIndex][28];
                        groupBuffer[outerLoopIndex][29] <= groupBuffer[outerLoopIndex][29];
                        groupBuffer[outerLoopIndex][30] <= groupBuffer[outerLoopIndex][30];
                        groupBuffer[outerLoopIndex][31] <= groupBuffer[outerLoopIndex][31];
                    end
                for(outerLoopIndex = TRANSFER_BUFFER_HEIGHT; outerLoopIndex < GROUP_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        groupBuffer[outerLoopIndex][0] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][0];
                        groupBuffer[outerLoopIndex][1] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][1];
                        groupBuffer[outerLoopIndex][2] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][2];
                        groupBuffer[outerLoopIndex][3] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][3];
                        groupBuffer[outerLoopIndex][4] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][4];
                        groupBuffer[outerLoopIndex][5] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][5];
                        groupBuffer[outerLoopIndex][6] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][6];
                        groupBuffer[outerLoopIndex][7] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][7];
                        groupBuffer[outerLoopIndex][8] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][8];
                        groupBuffer[outerLoopIndex][9] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][9];
                        groupBuffer[outerLoopIndex][10] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][10];
                        groupBuffer[outerLoopIndex][11] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][11];
                        groupBuffer[outerLoopIndex][12] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][12];
                        groupBuffer[outerLoopIndex][13] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][13];
                        groupBuffer[outerLoopIndex][14] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][14];
                        groupBuffer[outerLoopIndex][15] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][15];
                        groupBuffer[outerLoopIndex][16] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][16];
                        groupBuffer[outerLoopIndex][17] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][17];
                        groupBuffer[outerLoopIndex][18] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][18];
                        groupBuffer[outerLoopIndex][19] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][19];
                        groupBuffer[outerLoopIndex][20] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][20];
                        groupBuffer[outerLoopIndex][21] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][21];
                        groupBuffer[outerLoopIndex][22] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][22];
                        groupBuffer[outerLoopIndex][23] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][23];
                        groupBuffer[outerLoopIndex][24] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][24];
                        groupBuffer[outerLoopIndex][25] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][25];
                        groupBuffer[outerLoopIndex][26] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][26];
                        groupBuffer[outerLoopIndex][27] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][27];
                        groupBuffer[outerLoopIndex][28] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][28];
                        groupBuffer[outerLoopIndex][29] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][29];
                        groupBuffer[outerLoopIndex][30] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][30];
                        groupBuffer[outerLoopIndex][31] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][31];
                    end
            end
            default: begin
                for(outerLoopIndex = 0; outerLoopIndex < GROUP_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        groupBuffer[outerLoopIndex][0] <= groupBuffer[outerLoopIndex][0];
                        groupBuffer[outerLoopIndex][1] <= groupBuffer[outerLoopIndex][1];
                        groupBuffer[outerLoopIndex][2] <= groupBuffer[outerLoopIndex][2];
                        groupBuffer[outerLoopIndex][3] <= groupBuffer[outerLoopIndex][3];
                        groupBuffer[outerLoopIndex][4] <= groupBuffer[outerLoopIndex][4];
                        groupBuffer[outerLoopIndex][5] <= groupBuffer[outerLoopIndex][5];
                        groupBuffer[outerLoopIndex][6] <= groupBuffer[outerLoopIndex][6];
                        groupBuffer[outerLoopIndex][7] <= groupBuffer[outerLoopIndex][7];
                        groupBuffer[outerLoopIndex][8] <= groupBuffer[outerLoopIndex][8];
                        groupBuffer[outerLoopIndex][9] <= groupBuffer[outerLoopIndex][9];
                        groupBuffer[outerLoopIndex][10] <= groupBuffer[outerLoopIndex][10];
                        groupBuffer[outerLoopIndex][11] <= groupBuffer[outerLoopIndex][11];
                        groupBuffer[outerLoopIndex][12] <= groupBuffer[outerLoopIndex][12];
                        groupBuffer[outerLoopIndex][13] <= groupBuffer[outerLoopIndex][13];
                        groupBuffer[outerLoopIndex][14] <= groupBuffer[outerLoopIndex][14];
                        groupBuffer[outerLoopIndex][15] <= groupBuffer[outerLoopIndex][15];
                        groupBuffer[outerLoopIndex][16] <= groupBuffer[outerLoopIndex][16];
                        groupBuffer[outerLoopIndex][17] <= groupBuffer[outerLoopIndex][17];
                        groupBuffer[outerLoopIndex][18] <= groupBuffer[outerLoopIndex][18];
                        groupBuffer[outerLoopIndex][19] <= groupBuffer[outerLoopIndex][19];
                        groupBuffer[outerLoopIndex][20] <= groupBuffer[outerLoopIndex][20];
                        groupBuffer[outerLoopIndex][21] <= groupBuffer[outerLoopIndex][21];
                        groupBuffer[outerLoopIndex][22] <= groupBuffer[outerLoopIndex][22];
                        groupBuffer[outerLoopIndex][23] <= groupBuffer[outerLoopIndex][23];
                        groupBuffer[outerLoopIndex][24] <= groupBuffer[outerLoopIndex][24];
                        groupBuffer[outerLoopIndex][25] <= groupBuffer[outerLoopIndex][25];
                        groupBuffer[outerLoopIndex][26] <= groupBuffer[outerLoopIndex][26];
                        groupBuffer[outerLoopIndex][27] <= groupBuffer[outerLoopIndex][27];
                        groupBuffer[outerLoopIndex][28] <= groupBuffer[outerLoopIndex][28];
                        groupBuffer[outerLoopIndex][29] <= groupBuffer[outerLoopIndex][29];
                        groupBuffer[outerLoopIndex][30] <= groupBuffer[outerLoopIndex][30];
                        groupBuffer[outerLoopIndex][31] <= groupBuffer[outerLoopIndex][31];
                    end
            end
        endcase
    end

    // always block for moving data from transferBuffer to newRowsBuffer
    always @ (posedge M_AXI_ACLK) begin
        if(cState == cINITIAL && startAdderSignal)
            begin
                for(outerLoopIndex = 0; outerLoopIndex < TRANSFER_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        newRowsBuffer[outerLoopIndex][0] <= transferBuffer[outerLoopIndex][0];
                        newRowsBuffer[outerLoopIndex][1] <= transferBuffer[outerLoopIndex][1];
                        newRowsBuffer[outerLoopIndex][2] <= transferBuffer[outerLoopIndex][2];
                        newRowsBuffer[outerLoopIndex][3] <= transferBuffer[outerLoopIndex][3];
                        newRowsBuffer[outerLoopIndex][4] <= transferBuffer[outerLoopIndex][4];
                        newRowsBuffer[outerLoopIndex][5] <= transferBuffer[outerLoopIndex][5];
                        newRowsBuffer[outerLoopIndex][6] <= transferBuffer[outerLoopIndex][6];
                        newRowsBuffer[outerLoopIndex][7] <= transferBuffer[outerLoopIndex][7];
                        newRowsBuffer[outerLoopIndex][8] <= transferBuffer[outerLoopIndex][8];
                        newRowsBuffer[outerLoopIndex][9] <= transferBuffer[outerLoopIndex][9];
                        newRowsBuffer[outerLoopIndex][10] <= transferBuffer[outerLoopIndex][10];
                        newRowsBuffer[outerLoopIndex][11] <= transferBuffer[outerLoopIndex][11];
                        newRowsBuffer[outerLoopIndex][12] <= transferBuffer[outerLoopIndex][12];
                        newRowsBuffer[outerLoopIndex][13] <= transferBuffer[outerLoopIndex][13];
                        newRowsBuffer[outerLoopIndex][14] <= transferBuffer[outerLoopIndex][14];
                        newRowsBuffer[outerLoopIndex][15] <= transferBuffer[outerLoopIndex][15];
                        newRowsBuffer[outerLoopIndex][16] <= transferBuffer[outerLoopIndex][16];
                        newRowsBuffer[outerLoopIndex][17] <= transferBuffer[outerLoopIndex][17];
                        newRowsBuffer[outerLoopIndex][18] <= transferBuffer[outerLoopIndex][18];
                        newRowsBuffer[outerLoopIndex][19] <= transferBuffer[outerLoopIndex][19];
                        newRowsBuffer[outerLoopIndex][20] <= transferBuffer[outerLoopIndex][20];
                        newRowsBuffer[outerLoopIndex][21] <= transferBuffer[outerLoopIndex][21];
                        newRowsBuffer[outerLoopIndex][22] <= transferBuffer[outerLoopIndex][22];
                        newRowsBuffer[outerLoopIndex][23] <= transferBuffer[outerLoopIndex][23];
                        newRowsBuffer[outerLoopIndex][24] <= transferBuffer[outerLoopIndex][24];
                        newRowsBuffer[outerLoopIndex][25] <= transferBuffer[outerLoopIndex][25];
                        newRowsBuffer[outerLoopIndex][26] <= transferBuffer[outerLoopIndex][26];
                        newRowsBuffer[outerLoopIndex][27] <= transferBuffer[outerLoopIndex][27];
                        newRowsBuffer[outerLoopIndex][28] <= transferBuffer[outerLoopIndex][28];
                        newRowsBuffer[outerLoopIndex][29] <= transferBuffer[outerLoopIndex][29];
                        newRowsBuffer[outerLoopIndex][30] <= transferBuffer[outerLoopIndex][30];
                        newRowsBuffer[outerLoopIndex][31] <= transferBuffer[outerLoopIndex][31];
                    end
            end
        else if(cState == cFIRST_ROUND_COMPUTATION || cState == cCOMPARE_SAD)
            begin
                for(outerLoopIndex = 0; outerLoopIndex < NEW_ROWS_BUFFER_HEIGHT - 1; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        for(innerLoopIndex = 0; innerLoopIndex < NEW_ROWS_BUFFER_WIDTH; innerLoopIndex = innerLoopIndex + 1)
                            newRowsBuffer[outerLoopIndex][innerLoopIndex] <= newRowsBuffer[outerLoopIndex + 1][innerLoopIndex];
                    end
                for(innerLoopIndex_2 = 0; innerLoopIndex_2 < NEW_ROWS_BUFFER_WIDTH; innerLoopIndex_2 = innerLoopIndex_2 + 1)
                    begin
                        newRowsBuffer[15][innerLoopIndex_2] <= groupBuffer[0][innerLoopIndex_2];
                    end
            end
        else
            begin
                for(outerLoopIndex = 0; outerLoopIndex < NEW_ROWS_BUFFER_HEIGHT; outerLoopIndex = outerLoopIndex + 1)
                    begin
                        newRowsBuffer[outerLoopIndex][0] <= newRowsBuffer[outerLoopIndex][0];
                        newRowsBuffer[outerLoopIndex][1] <= newRowsBuffer[outerLoopIndex][1];
                        newRowsBuffer[outerLoopIndex][2] <= newRowsBuffer[outerLoopIndex][2];
                        newRowsBuffer[outerLoopIndex][3] <= newRowsBuffer[outerLoopIndex][3];
                        newRowsBuffer[outerLoopIndex][4] <= newRowsBuffer[outerLoopIndex][4];
                        newRowsBuffer[outerLoopIndex][5] <= newRowsBuffer[outerLoopIndex][5];
                        newRowsBuffer[outerLoopIndex][6] <= newRowsBuffer[outerLoopIndex][6];
                        newRowsBuffer[outerLoopIndex][7] <= newRowsBuffer[outerLoopIndex][7];
                        newRowsBuffer[outerLoopIndex][8] <= newRowsBuffer[outerLoopIndex][8];
                        newRowsBuffer[outerLoopIndex][9] <= newRowsBuffer[outerLoopIndex][9];
                        newRowsBuffer[outerLoopIndex][10] <= newRowsBuffer[outerLoopIndex][10];
                        newRowsBuffer[outerLoopIndex][11] <= newRowsBuffer[outerLoopIndex][11];
                        newRowsBuffer[outerLoopIndex][12] <= newRowsBuffer[outerLoopIndex][12];
                        newRowsBuffer[outerLoopIndex][13] <= newRowsBuffer[outerLoopIndex][13];
                        newRowsBuffer[outerLoopIndex][14] <= newRowsBuffer[outerLoopIndex][14];
                        newRowsBuffer[outerLoopIndex][15] <= newRowsBuffer[outerLoopIndex][15];
                        newRowsBuffer[outerLoopIndex][16] <= newRowsBuffer[outerLoopIndex][16];
                        newRowsBuffer[outerLoopIndex][17] <= newRowsBuffer[outerLoopIndex][17];
                        newRowsBuffer[outerLoopIndex][18] <= newRowsBuffer[outerLoopIndex][18];
                        newRowsBuffer[outerLoopIndex][19] <= newRowsBuffer[outerLoopIndex][19];
                        newRowsBuffer[outerLoopIndex][20] <= newRowsBuffer[outerLoopIndex][20];
                        newRowsBuffer[outerLoopIndex][21] <= newRowsBuffer[outerLoopIndex][21];
                        newRowsBuffer[outerLoopIndex][22] <= newRowsBuffer[outerLoopIndex][22];
                        newRowsBuffer[outerLoopIndex][23] <= newRowsBuffer[outerLoopIndex][23];
                        newRowsBuffer[outerLoopIndex][24] <= newRowsBuffer[outerLoopIndex][24];
                        newRowsBuffer[outerLoopIndex][25] <= newRowsBuffer[outerLoopIndex][25];
                        newRowsBuffer[outerLoopIndex][26] <= newRowsBuffer[outerLoopIndex][26];
                        newRowsBuffer[outerLoopIndex][27] <= newRowsBuffer[outerLoopIndex][27];
                        newRowsBuffer[outerLoopIndex][28] <= newRowsBuffer[outerLoopIndex][28];
                        newRowsBuffer[outerLoopIndex][29] <= newRowsBuffer[outerLoopIndex][29];
                        newRowsBuffer[outerLoopIndex][30] <= newRowsBuffer[outerLoopIndex][30];
                        newRowsBuffer[outerLoopIndex][31] <= newRowsBuffer[outerLoopIndex][31];
                    end
            end
    end

    // always block for startPipelineTransferSignal signal
    always @ (posedge M_AXI_ACLK) begin
        if(M_AXI_ACLK == 1'b0)
            startPipelineTransferSignal <= 1'b0;
        else if(startPipelineTransferSignal == 1'b1)
            startPipelineTransferSignal <= 1'b0;
        else if(startAdderSignal && numberOfRowsNotTransfered > 12'd0)
            startPipelineTransferSignal <= 1'b1;
        else
            startPipelineTransferSignal <= 1'b0;
    end

    // always block for pipelineTransferDoneSignal signal
    always @ (posedge M_AXI_ACLK) begin
        if(pipelineTransferDoneSignal == 1'b1)
            pipelineTransferDoneSignal <= 1'b0;
        //else if(startAdderSignal == 1'b1) // This logic needs to be fixed
        else if(sum == 16'd6)
            pipelineTransferDoneSignal <= 1'b1;
        else
            pipelineTransferDoneSignal <= 1'b0;
    end

    // always block for startAdderSignal signal
    always @ (posedge M_AXI_ACLK) begin
        if(startAdderSignal == 1'b1)
            startAdderSignal <= 1'b0;
        else if(sum == 16'd5 || pipelineTransferDoneSignal == 1'b1)
            startAdderSignal <= 1'b1;
        else
            startAdderSignal <= 1'b0;
    end

    // always block for reachBottomSignal signal
    always @ (posedge M_AXI_ACLK) begin
        if(gState == gINITIAL || reachBottomSignal)
            reachBottomSignal <= 1'b0;
        else if(yIndexNow == MAX_Y_POS && xIndexNow != MAX_X_POS)
            reachBottomSignal <= 1'b1;
        else
            reachBottomSignal <= 1'b0;
    end

    // Computation finite state machine
    always @ (posedge M_AXI_ACLK) begin
        if(gState == gREAD_EXTRA_SIXTEEN_ROWS)
            cState <= cINITIAL;
        else
            case(cState)
                cINITIAL: begin
                    cState <= (startAdderSignal) ? cFIRST_ROUND_COMPUTATION : cINITIAL;
                end
                cFIRST_ROUND_COMPUTATION: begin
                    cState <= (reachBottomSignal) ? cINITIAL : ( (cCounter == 5'd4) ? cCOMPARE_SAD : cFIRST_ROUND_COMPUTATION );
                end
                cCOMPARE_SAD: begin
                    cState <= (reachBottomSignal) ? cINITIAL : ( (cCounter == 5'd20) ? cSIXTEEN_ROWS_DONE : cCOMPARE_SAD );
                end
                cSIXTEEN_ROWS_DONE: begin
                    cState <= (reachBottomSignal) ? cINITIAL : ( (pipelineTransferDoneSignal) ? cINITIAL : cSIXTEEN_ROWS_DONE );
                end
                default: begin
                    cState <= cINITIAL;
                end
            endcase
    end

    // always block for cCounter
    always @ (posedge M_AXI_ACLK) begin
        case (cState)
            cINITIAL: begin
                cCounter <= 5'd0;
            end
            cSIXTEEN_ROWS_DONE: begin
                cCounter <= cCounter;
            end
            default: begin
                cCounter <= (reachBottomSignal) ? 5'd0 : cCounter + 5'd1;
            end
        endcase
    end

    // Combinational circuit for computing absolute difference
    generate
        for(genOuterIndex = 0; genOuterIndex < FACE_BUFFER_HEIGHT; genOuterIndex = genOuterIndex + 1)
            begin:diff
                assign absoluteDifference[genOuterIndex][0] = (faceBuffer[genOuterIndex][0] > groupBuffer[genOuterIndex][0])
                ? faceBuffer[genOuterIndex][0] - groupBuffer[genOuterIndex][0]
                : groupBuffer[genOuterIndex][0] - faceBuffer[genOuterIndex][0];
                assign absoluteDifference[genOuterIndex][1] = (faceBuffer[genOuterIndex][1] > groupBuffer[genOuterIndex][1])
                ? faceBuffer[genOuterIndex][1] - groupBuffer[genOuterIndex][1]
                : groupBuffer[genOuterIndex][1] - faceBuffer[genOuterIndex][1];
                assign absoluteDifference[genOuterIndex][2] = (faceBuffer[genOuterIndex][2] > groupBuffer[genOuterIndex][2])
                ? faceBuffer[genOuterIndex][2] - groupBuffer[genOuterIndex][2]
                : groupBuffer[genOuterIndex][2] - faceBuffer[genOuterIndex][2];
                assign absoluteDifference[genOuterIndex][3] = (faceBuffer[genOuterIndex][3] > groupBuffer[genOuterIndex][3])
                ? faceBuffer[genOuterIndex][3] - groupBuffer[genOuterIndex][3]
                : groupBuffer[genOuterIndex][3] - faceBuffer[genOuterIndex][3];
                assign absoluteDifference[genOuterIndex][4] = (faceBuffer[genOuterIndex][4] > groupBuffer[genOuterIndex][4])
                ? faceBuffer[genOuterIndex][4] - groupBuffer[genOuterIndex][4]
                : groupBuffer[genOuterIndex][4] - faceBuffer[genOuterIndex][4];
                assign absoluteDifference[genOuterIndex][5] = (faceBuffer[genOuterIndex][5] > groupBuffer[genOuterIndex][5])
                ? faceBuffer[genOuterIndex][5] - groupBuffer[genOuterIndex][5]
                : groupBuffer[genOuterIndex][5] - faceBuffer[genOuterIndex][5];
                assign absoluteDifference[genOuterIndex][6] = (faceBuffer[genOuterIndex][6] > groupBuffer[genOuterIndex][6])
                ? faceBuffer[genOuterIndex][6] - groupBuffer[genOuterIndex][6]
                : groupBuffer[genOuterIndex][6] - faceBuffer[genOuterIndex][6];
                assign absoluteDifference[genOuterIndex][7] = (faceBuffer[genOuterIndex][7] > groupBuffer[genOuterIndex][7])
                ? faceBuffer[genOuterIndex][7] - groupBuffer[genOuterIndex][7]
                : groupBuffer[genOuterIndex][7] - faceBuffer[genOuterIndex][7];
                assign absoluteDifference[genOuterIndex][8] = (faceBuffer[genOuterIndex][8] > groupBuffer[genOuterIndex][8])
                ? faceBuffer[genOuterIndex][8] - groupBuffer[genOuterIndex][8]
                : groupBuffer[genOuterIndex][8] - faceBuffer[genOuterIndex][8];
                assign absoluteDifference[genOuterIndex][9] = (faceBuffer[genOuterIndex][9] > groupBuffer[genOuterIndex][9])
                ? faceBuffer[genOuterIndex][9] - groupBuffer[genOuterIndex][9]
                : groupBuffer[genOuterIndex][9] - faceBuffer[genOuterIndex][9];
                assign absoluteDifference[genOuterIndex][10] = (faceBuffer[genOuterIndex][10] > groupBuffer[genOuterIndex][10])
                ? faceBuffer[genOuterIndex][10] - groupBuffer[genOuterIndex][10]
                : groupBuffer[genOuterIndex][10] - faceBuffer[genOuterIndex][10];
                assign absoluteDifference[genOuterIndex][11] = (faceBuffer[genOuterIndex][11] > groupBuffer[genOuterIndex][11])
                ? faceBuffer[genOuterIndex][11] - groupBuffer[genOuterIndex][11]
                : groupBuffer[genOuterIndex][11] - faceBuffer[genOuterIndex][11];
                assign absoluteDifference[genOuterIndex][12] = (faceBuffer[genOuterIndex][12] > groupBuffer[genOuterIndex][12])
                ? faceBuffer[genOuterIndex][12] - groupBuffer[genOuterIndex][12]
                : groupBuffer[genOuterIndex][12] - faceBuffer[genOuterIndex][12];
                assign absoluteDifference[genOuterIndex][13] = (faceBuffer[genOuterIndex][13] > groupBuffer[genOuterIndex][13])
                ? faceBuffer[genOuterIndex][13] - groupBuffer[genOuterIndex][13]
                : groupBuffer[genOuterIndex][13] - faceBuffer[genOuterIndex][13];
                assign absoluteDifference[genOuterIndex][14] = (faceBuffer[genOuterIndex][14] > groupBuffer[genOuterIndex][14])
                ? faceBuffer[genOuterIndex][14] - groupBuffer[genOuterIndex][14]
                : groupBuffer[genOuterIndex][14] - faceBuffer[genOuterIndex][14];
                assign absoluteDifference[genOuterIndex][15] = (faceBuffer[genOuterIndex][15] > groupBuffer[genOuterIndex][15])
                ? faceBuffer[genOuterIndex][15] - groupBuffer[genOuterIndex][15]
                : groupBuffer[genOuterIndex][15] - faceBuffer[genOuterIndex][15];
                assign absoluteDifference[genOuterIndex][16] = (faceBuffer[genOuterIndex][16] > groupBuffer[genOuterIndex][16])
                ? faceBuffer[genOuterIndex][16] - groupBuffer[genOuterIndex][16]
                : groupBuffer[genOuterIndex][16] - faceBuffer[genOuterIndex][16];
                assign absoluteDifference[genOuterIndex][17] = (faceBuffer[genOuterIndex][17] > groupBuffer[genOuterIndex][17])
                ? faceBuffer[genOuterIndex][17] - groupBuffer[genOuterIndex][17]
                : groupBuffer[genOuterIndex][17] - faceBuffer[genOuterIndex][17];
                assign absoluteDifference[genOuterIndex][18] = (faceBuffer[genOuterIndex][18] > groupBuffer[genOuterIndex][18])
                ? faceBuffer[genOuterIndex][18] - groupBuffer[genOuterIndex][18]
                : groupBuffer[genOuterIndex][18] - faceBuffer[genOuterIndex][18];
                assign absoluteDifference[genOuterIndex][19] = (faceBuffer[genOuterIndex][19] > groupBuffer[genOuterIndex][19])
                ? faceBuffer[genOuterIndex][19] - groupBuffer[genOuterIndex][19]
                : groupBuffer[genOuterIndex][19] - faceBuffer[genOuterIndex][19];
                assign absoluteDifference[genOuterIndex][20] = (faceBuffer[genOuterIndex][20] > groupBuffer[genOuterIndex][20])
                ? faceBuffer[genOuterIndex][20] - groupBuffer[genOuterIndex][20]
                : groupBuffer[genOuterIndex][20] - faceBuffer[genOuterIndex][20];
                assign absoluteDifference[genOuterIndex][21] = (faceBuffer[genOuterIndex][21] > groupBuffer[genOuterIndex][21])
                ? faceBuffer[genOuterIndex][21] - groupBuffer[genOuterIndex][21]
                : groupBuffer[genOuterIndex][21] - faceBuffer[genOuterIndex][21];
                assign absoluteDifference[genOuterIndex][22] = (faceBuffer[genOuterIndex][22] > groupBuffer[genOuterIndex][22])
                ? faceBuffer[genOuterIndex][22] - groupBuffer[genOuterIndex][22]
                : groupBuffer[genOuterIndex][22] - faceBuffer[genOuterIndex][22];
                assign absoluteDifference[genOuterIndex][23] = (faceBuffer[genOuterIndex][23] > groupBuffer[genOuterIndex][23])
                ? faceBuffer[genOuterIndex][23] - groupBuffer[genOuterIndex][23]
                : groupBuffer[genOuterIndex][23] - faceBuffer[genOuterIndex][23];
                assign absoluteDifference[genOuterIndex][24] = (faceBuffer[genOuterIndex][24] > groupBuffer[genOuterIndex][24])
                ? faceBuffer[genOuterIndex][24] - groupBuffer[genOuterIndex][24]
                : groupBuffer[genOuterIndex][24] - faceBuffer[genOuterIndex][24];
                assign absoluteDifference[genOuterIndex][25] = (faceBuffer[genOuterIndex][25] > groupBuffer[genOuterIndex][25])
                ? faceBuffer[genOuterIndex][25] - groupBuffer[genOuterIndex][25]
                : groupBuffer[genOuterIndex][25] - faceBuffer[genOuterIndex][25];
                assign absoluteDifference[genOuterIndex][26] = (faceBuffer[genOuterIndex][26] > groupBuffer[genOuterIndex][26])
                ? faceBuffer[genOuterIndex][26] - groupBuffer[genOuterIndex][26]
                : groupBuffer[genOuterIndex][26] - faceBuffer[genOuterIndex][26];
                assign absoluteDifference[genOuterIndex][27] = (faceBuffer[genOuterIndex][27] > groupBuffer[genOuterIndex][27])
                ? faceBuffer[genOuterIndex][27] - groupBuffer[genOuterIndex][27]
                : groupBuffer[genOuterIndex][27] - faceBuffer[genOuterIndex][27];
                assign absoluteDifference[genOuterIndex][28] = (faceBuffer[genOuterIndex][28] > groupBuffer[genOuterIndex][28])
                ? faceBuffer[genOuterIndex][28] - groupBuffer[genOuterIndex][28]
                : groupBuffer[genOuterIndex][28] - faceBuffer[genOuterIndex][28];
                assign absoluteDifference[genOuterIndex][29] = (faceBuffer[genOuterIndex][29] > groupBuffer[genOuterIndex][29])
                ? faceBuffer[genOuterIndex][29] - groupBuffer[genOuterIndex][29]
                : groupBuffer[genOuterIndex][29] - faceBuffer[genOuterIndex][29];
                assign absoluteDifference[genOuterIndex][30] = (faceBuffer[genOuterIndex][30] > groupBuffer[genOuterIndex][30])
                ? faceBuffer[genOuterIndex][30] - groupBuffer[genOuterIndex][30]
                : groupBuffer[genOuterIndex][30] - faceBuffer[genOuterIndex][30];
                assign absoluteDifference[genOuterIndex][31] = (faceBuffer[genOuterIndex][31] > groupBuffer[genOuterIndex][31])
                ? faceBuffer[genOuterIndex][31] - groupBuffer[genOuterIndex][31]
                : groupBuffer[genOuterIndex][31] - faceBuffer[genOuterIndex][31];
            end
    endgenerate

    // always block for 1st-stage adder tree
    always @ (posedge M_AXI_ACLK) begin
        adderResult_0[0] <= absoluteDifference[0][0] + absoluteDifference[0][1] + absoluteDifference[0][2] + absoluteDifference[0][3];
        adderResult_0[1] <= absoluteDifference[0][4] + absoluteDifference[0][5] + absoluteDifference[0][6] + absoluteDifference[0][7];
        adderResult_0[2] <= absoluteDifference[0][8] + absoluteDifference[0][9] + absoluteDifference[0][10] + absoluteDifference[0][11];
        adderResult_0[3] <= absoluteDifference[0][12] + absoluteDifference[0][13] + absoluteDifference[0][14] + absoluteDifference[0][15];
        adderResult_0[4] <= absoluteDifference[0][16] + absoluteDifference[0][17] + absoluteDifference[0][18] + absoluteDifference[0][19];
        adderResult_0[5] <= absoluteDifference[0][20] + absoluteDifference[0][21] + absoluteDifference[0][22] + absoluteDifference[0][23];
        adderResult_0[6] <= absoluteDifference[0][24] + absoluteDifference[0][25] + absoluteDifference[0][26] + absoluteDifference[0][27];
        adderResult_0[7] <= absoluteDifference[0][28] + absoluteDifference[0][29] + absoluteDifference[0][30] + absoluteDifference[0][31];
        adderResult_0[8] <= absoluteDifference[1][0] + absoluteDifference[1][1] + absoluteDifference[1][2] + absoluteDifference[1][3];
        adderResult_0[9] <= absoluteDifference[1][4] + absoluteDifference[1][5] + absoluteDifference[1][6] + absoluteDifference[1][7];
        adderResult_0[10] <= absoluteDifference[1][8] + absoluteDifference[1][9] + absoluteDifference[1][10] + absoluteDifference[1][11];
        adderResult_0[11] <= absoluteDifference[1][12] + absoluteDifference[1][13] + absoluteDifference[1][14] + absoluteDifference[1][15];
        adderResult_0[12] <= absoluteDifference[1][16] + absoluteDifference[1][17] + absoluteDifference[1][18] + absoluteDifference[1][19];
        adderResult_0[13] <= absoluteDifference[1][20] + absoluteDifference[1][21] + absoluteDifference[1][22] + absoluteDifference[1][23];
        adderResult_0[14] <= absoluteDifference[1][24] + absoluteDifference[1][25] + absoluteDifference[1][26] + absoluteDifference[1][27];
        adderResult_0[15] <= absoluteDifference[1][28] + absoluteDifference[1][29] + absoluteDifference[1][30] + absoluteDifference[1][31];
        adderResult_0[16] <= absoluteDifference[2][0] + absoluteDifference[2][1] + absoluteDifference[2][2] + absoluteDifference[2][3];
        adderResult_0[17] <= absoluteDifference[2][4] + absoluteDifference[2][5] + absoluteDifference[2][6] + absoluteDifference[2][7];
        adderResult_0[18] <= absoluteDifference[2][8] + absoluteDifference[2][9] + absoluteDifference[2][10] + absoluteDifference[2][11];
        adderResult_0[19] <= absoluteDifference[2][12] + absoluteDifference[2][13] + absoluteDifference[2][14] + absoluteDifference[2][15];
        adderResult_0[20] <= absoluteDifference[2][16] + absoluteDifference[2][17] + absoluteDifference[2][18] + absoluteDifference[2][19];
        adderResult_0[21] <= absoluteDifference[2][20] + absoluteDifference[2][21] + absoluteDifference[2][22] + absoluteDifference[2][23];
        adderResult_0[22] <= absoluteDifference[2][24] + absoluteDifference[2][25] + absoluteDifference[2][26] + absoluteDifference[2][27];
        adderResult_0[23] <= absoluteDifference[2][28] + absoluteDifference[2][29] + absoluteDifference[2][30] + absoluteDifference[2][31];
        adderResult_0[24] <= absoluteDifference[3][0] + absoluteDifference[3][1] + absoluteDifference[3][2] + absoluteDifference[3][3];
        adderResult_0[25] <= absoluteDifference[3][4] + absoluteDifference[3][5] + absoluteDifference[3][6] + absoluteDifference[3][7];
        adderResult_0[26] <= absoluteDifference[3][8] + absoluteDifference[3][9] + absoluteDifference[3][10] + absoluteDifference[3][11];
        adderResult_0[27] <= absoluteDifference[3][12] + absoluteDifference[3][13] + absoluteDifference[3][14] + absoluteDifference[3][15];
        adderResult_0[28] <= absoluteDifference[3][16] + absoluteDifference[3][17] + absoluteDifference[3][18] + absoluteDifference[3][19];
        adderResult_0[29] <= absoluteDifference[3][20] + absoluteDifference[3][21] + absoluteDifference[3][22] + absoluteDifference[3][23];
        adderResult_0[30] <= absoluteDifference[3][24] + absoluteDifference[3][25] + absoluteDifference[3][26] + absoluteDifference[3][27];
        adderResult_0[31] <= absoluteDifference[3][28] + absoluteDifference[3][29] + absoluteDifference[3][30] + absoluteDifference[3][31];
        adderResult_0[32] <= absoluteDifference[4][0] + absoluteDifference[4][1] + absoluteDifference[4][2] + absoluteDifference[4][3];
        adderResult_0[33] <= absoluteDifference[4][4] + absoluteDifference[4][5] + absoluteDifference[4][6] + absoluteDifference[4][7];
        adderResult_0[34] <= absoluteDifference[4][8] + absoluteDifference[4][9] + absoluteDifference[4][10] + absoluteDifference[4][11];
        adderResult_0[35] <= absoluteDifference[4][12] + absoluteDifference[4][13] + absoluteDifference[4][14] + absoluteDifference[4][15];
        adderResult_0[36] <= absoluteDifference[4][16] + absoluteDifference[4][17] + absoluteDifference[4][18] + absoluteDifference[4][19];
        adderResult_0[37] <= absoluteDifference[4][20] + absoluteDifference[4][21] + absoluteDifference[4][22] + absoluteDifference[4][23];
        adderResult_0[38] <= absoluteDifference[4][24] + absoluteDifference[4][25] + absoluteDifference[4][26] + absoluteDifference[4][27];
        adderResult_0[39] <= absoluteDifference[4][28] + absoluteDifference[4][29] + absoluteDifference[4][30] + absoluteDifference[4][31];
        adderResult_0[40] <= absoluteDifference[5][0] + absoluteDifference[5][1] + absoluteDifference[5][2] + absoluteDifference[5][3];
        adderResult_0[41] <= absoluteDifference[5][4] + absoluteDifference[5][5] + absoluteDifference[5][6] + absoluteDifference[5][7];
        adderResult_0[42] <= absoluteDifference[5][8] + absoluteDifference[5][9] + absoluteDifference[5][10] + absoluteDifference[5][11];
        adderResult_0[43] <= absoluteDifference[5][12] + absoluteDifference[5][13] + absoluteDifference[5][14] + absoluteDifference[5][15];
        adderResult_0[44] <= absoluteDifference[5][16] + absoluteDifference[5][17] + absoluteDifference[5][18] + absoluteDifference[5][19];
        adderResult_0[45] <= absoluteDifference[5][20] + absoluteDifference[5][21] + absoluteDifference[5][22] + absoluteDifference[5][23];
        adderResult_0[46] <= absoluteDifference[5][24] + absoluteDifference[5][25] + absoluteDifference[5][26] + absoluteDifference[5][27];
        adderResult_0[47] <= absoluteDifference[5][28] + absoluteDifference[5][29] + absoluteDifference[5][30] + absoluteDifference[5][31];
        adderResult_0[48] <= absoluteDifference[6][0] + absoluteDifference[6][1] + absoluteDifference[6][2] + absoluteDifference[6][3];
        adderResult_0[49] <= absoluteDifference[6][4] + absoluteDifference[6][5] + absoluteDifference[6][6] + absoluteDifference[6][7];
        adderResult_0[50] <= absoluteDifference[6][8] + absoluteDifference[6][9] + absoluteDifference[6][10] + absoluteDifference[6][11];
        adderResult_0[51] <= absoluteDifference[6][12] + absoluteDifference[6][13] + absoluteDifference[6][14] + absoluteDifference[6][15];
        adderResult_0[52] <= absoluteDifference[6][16] + absoluteDifference[6][17] + absoluteDifference[6][18] + absoluteDifference[6][19];
        adderResult_0[53] <= absoluteDifference[6][20] + absoluteDifference[6][21] + absoluteDifference[6][22] + absoluteDifference[6][23];
        adderResult_0[54] <= absoluteDifference[6][24] + absoluteDifference[6][25] + absoluteDifference[6][26] + absoluteDifference[6][27];
        adderResult_0[55] <= absoluteDifference[6][28] + absoluteDifference[6][29] + absoluteDifference[6][30] + absoluteDifference[6][31];
        adderResult_0[56] <= absoluteDifference[7][0] + absoluteDifference[7][1] + absoluteDifference[7][2] + absoluteDifference[7][3];
        adderResult_0[57] <= absoluteDifference[7][4] + absoluteDifference[7][5] + absoluteDifference[7][6] + absoluteDifference[7][7];
        adderResult_0[58] <= absoluteDifference[7][8] + absoluteDifference[7][9] + absoluteDifference[7][10] + absoluteDifference[7][11];
        adderResult_0[59] <= absoluteDifference[7][12] + absoluteDifference[7][13] + absoluteDifference[7][14] + absoluteDifference[7][15];
        adderResult_0[60] <= absoluteDifference[7][16] + absoluteDifference[7][17] + absoluteDifference[7][18] + absoluteDifference[7][19];
        adderResult_0[61] <= absoluteDifference[7][20] + absoluteDifference[7][21] + absoluteDifference[7][22] + absoluteDifference[7][23];
        adderResult_0[62] <= absoluteDifference[7][24] + absoluteDifference[7][25] + absoluteDifference[7][26] + absoluteDifference[7][27];
        adderResult_0[63] <= absoluteDifference[7][28] + absoluteDifference[7][29] + absoluteDifference[7][30] + absoluteDifference[7][31];
        adderResult_0[64] <= absoluteDifference[8][0] + absoluteDifference[8][1] + absoluteDifference[8][2] + absoluteDifference[8][3];
        adderResult_0[65] <= absoluteDifference[8][4] + absoluteDifference[8][5] + absoluteDifference[8][6] + absoluteDifference[8][7];
        adderResult_0[66] <= absoluteDifference[8][8] + absoluteDifference[8][9] + absoluteDifference[8][10] + absoluteDifference[8][11];
        adderResult_0[67] <= absoluteDifference[8][12] + absoluteDifference[8][13] + absoluteDifference[8][14] + absoluteDifference[8][15];
        adderResult_0[68] <= absoluteDifference[8][16] + absoluteDifference[8][17] + absoluteDifference[8][18] + absoluteDifference[8][19];
        adderResult_0[69] <= absoluteDifference[8][20] + absoluteDifference[8][21] + absoluteDifference[8][22] + absoluteDifference[8][23];
        adderResult_0[70] <= absoluteDifference[8][24] + absoluteDifference[8][25] + absoluteDifference[8][26] + absoluteDifference[8][27];
        adderResult_0[71] <= absoluteDifference[8][28] + absoluteDifference[8][29] + absoluteDifference[8][30] + absoluteDifference[8][31];
        adderResult_0[72] <= absoluteDifference[9][0] + absoluteDifference[9][1] + absoluteDifference[9][2] + absoluteDifference[9][3];
        adderResult_0[73] <= absoluteDifference[9][4] + absoluteDifference[9][5] + absoluteDifference[9][6] + absoluteDifference[9][7];
        adderResult_0[74] <= absoluteDifference[9][8] + absoluteDifference[9][9] + absoluteDifference[9][10] + absoluteDifference[9][11];
        adderResult_0[75] <= absoluteDifference[9][12] + absoluteDifference[9][13] + absoluteDifference[9][14] + absoluteDifference[9][15];
        adderResult_0[76] <= absoluteDifference[9][16] + absoluteDifference[9][17] + absoluteDifference[9][18] + absoluteDifference[9][19];
        adderResult_0[77] <= absoluteDifference[9][20] + absoluteDifference[9][21] + absoluteDifference[9][22] + absoluteDifference[9][23];
        adderResult_0[78] <= absoluteDifference[9][24] + absoluteDifference[9][25] + absoluteDifference[9][26] + absoluteDifference[9][27];
        adderResult_0[79] <= absoluteDifference[9][28] + absoluteDifference[9][29] + absoluteDifference[9][30] + absoluteDifference[9][31];
        adderResult_0[80] <= absoluteDifference[10][0] + absoluteDifference[10][1] + absoluteDifference[10][2] + absoluteDifference[10][3];
        adderResult_0[81] <= absoluteDifference[10][4] + absoluteDifference[10][5] + absoluteDifference[10][6] + absoluteDifference[10][7];
        adderResult_0[82] <= absoluteDifference[10][8] + absoluteDifference[10][9] + absoluteDifference[10][10] + absoluteDifference[10][11];
        adderResult_0[83] <= absoluteDifference[10][12] + absoluteDifference[10][13] + absoluteDifference[10][14] + absoluteDifference[10][15];
        adderResult_0[84] <= absoluteDifference[10][16] + absoluteDifference[10][17] + absoluteDifference[10][18] + absoluteDifference[10][19];
        adderResult_0[85] <= absoluteDifference[10][20] + absoluteDifference[10][21] + absoluteDifference[10][22] + absoluteDifference[10][23];
        adderResult_0[86] <= absoluteDifference[10][24] + absoluteDifference[10][25] + absoluteDifference[10][26] + absoluteDifference[10][27];
        adderResult_0[87] <= absoluteDifference[10][28] + absoluteDifference[10][29] + absoluteDifference[10][30] + absoluteDifference[10][31];
        adderResult_0[88] <= absoluteDifference[11][0] + absoluteDifference[11][1] + absoluteDifference[11][2] + absoluteDifference[11][3];
        adderResult_0[89] <= absoluteDifference[11][4] + absoluteDifference[11][5] + absoluteDifference[11][6] + absoluteDifference[11][7];
        adderResult_0[90] <= absoluteDifference[11][8] + absoluteDifference[11][9] + absoluteDifference[11][10] + absoluteDifference[11][11];
        adderResult_0[91] <= absoluteDifference[11][12] + absoluteDifference[11][13] + absoluteDifference[11][14] + absoluteDifference[11][15];
        adderResult_0[92] <= absoluteDifference[11][16] + absoluteDifference[11][17] + absoluteDifference[11][18] + absoluteDifference[11][19];
        adderResult_0[93] <= absoluteDifference[11][20] + absoluteDifference[11][21] + absoluteDifference[11][22] + absoluteDifference[11][23];
        adderResult_0[94] <= absoluteDifference[11][24] + absoluteDifference[11][25] + absoluteDifference[11][26] + absoluteDifference[11][27];
        adderResult_0[95] <= absoluteDifference[11][28] + absoluteDifference[11][29] + absoluteDifference[11][30] + absoluteDifference[11][31];
        adderResult_0[96] <= absoluteDifference[12][0] + absoluteDifference[12][1] + absoluteDifference[12][2] + absoluteDifference[12][3];
        adderResult_0[97] <= absoluteDifference[12][4] + absoluteDifference[12][5] + absoluteDifference[12][6] + absoluteDifference[12][7];
        adderResult_0[98] <= absoluteDifference[12][8] + absoluteDifference[12][9] + absoluteDifference[12][10] + absoluteDifference[12][11];
        adderResult_0[99] <= absoluteDifference[12][12] + absoluteDifference[12][13] + absoluteDifference[12][14] + absoluteDifference[12][15];
        adderResult_0[100] <= absoluteDifference[12][16] + absoluteDifference[12][17] + absoluteDifference[12][18] + absoluteDifference[12][19];
        adderResult_0[101] <= absoluteDifference[12][20] + absoluteDifference[12][21] + absoluteDifference[12][22] + absoluteDifference[12][23];
        adderResult_0[102] <= absoluteDifference[12][24] + absoluteDifference[12][25] + absoluteDifference[12][26] + absoluteDifference[12][27];
        adderResult_0[103] <= absoluteDifference[12][28] + absoluteDifference[12][29] + absoluteDifference[12][30] + absoluteDifference[12][31];
        adderResult_0[104] <= absoluteDifference[13][0] + absoluteDifference[13][1] + absoluteDifference[13][2] + absoluteDifference[13][3];
        adderResult_0[105] <= absoluteDifference[13][4] + absoluteDifference[13][5] + absoluteDifference[13][6] + absoluteDifference[13][7];
        adderResult_0[106] <= absoluteDifference[13][8] + absoluteDifference[13][9] + absoluteDifference[13][10] + absoluteDifference[13][11];
        adderResult_0[107] <= absoluteDifference[13][12] + absoluteDifference[13][13] + absoluteDifference[13][14] + absoluteDifference[13][15];
        adderResult_0[108] <= absoluteDifference[13][16] + absoluteDifference[13][17] + absoluteDifference[13][18] + absoluteDifference[13][19];
        adderResult_0[109] <= absoluteDifference[13][20] + absoluteDifference[13][21] + absoluteDifference[13][22] + absoluteDifference[13][23];
        adderResult_0[110] <= absoluteDifference[13][24] + absoluteDifference[13][25] + absoluteDifference[13][26] + absoluteDifference[13][27];
        adderResult_0[111] <= absoluteDifference[13][28] + absoluteDifference[13][29] + absoluteDifference[13][30] + absoluteDifference[13][31];
        adderResult_0[112] <= absoluteDifference[14][0] + absoluteDifference[14][1] + absoluteDifference[14][2] + absoluteDifference[14][3];
        adderResult_0[113] <= absoluteDifference[14][4] + absoluteDifference[14][5] + absoluteDifference[14][6] + absoluteDifference[14][7];
        adderResult_0[114] <= absoluteDifference[14][8] + absoluteDifference[14][9] + absoluteDifference[14][10] + absoluteDifference[14][11];
        adderResult_0[115] <= absoluteDifference[14][12] + absoluteDifference[14][13] + absoluteDifference[14][14] + absoluteDifference[14][15];
        adderResult_0[116] <= absoluteDifference[14][16] + absoluteDifference[14][17] + absoluteDifference[14][18] + absoluteDifference[14][19];
        adderResult_0[117] <= absoluteDifference[14][20] + absoluteDifference[14][21] + absoluteDifference[14][22] + absoluteDifference[14][23];
        adderResult_0[118] <= absoluteDifference[14][24] + absoluteDifference[14][25] + absoluteDifference[14][26] + absoluteDifference[14][27];
        adderResult_0[119] <= absoluteDifference[14][28] + absoluteDifference[14][29] + absoluteDifference[14][30] + absoluteDifference[14][31];
        adderResult_0[120] <= absoluteDifference[15][0] + absoluteDifference[15][1] + absoluteDifference[15][2] + absoluteDifference[15][3];
        adderResult_0[121] <= absoluteDifference[15][4] + absoluteDifference[15][5] + absoluteDifference[15][6] + absoluteDifference[15][7];
        adderResult_0[122] <= absoluteDifference[15][8] + absoluteDifference[15][9] + absoluteDifference[15][10] + absoluteDifference[15][11];
        adderResult_0[123] <= absoluteDifference[15][12] + absoluteDifference[15][13] + absoluteDifference[15][14] + absoluteDifference[15][15];
        adderResult_0[124] <= absoluteDifference[15][16] + absoluteDifference[15][17] + absoluteDifference[15][18] + absoluteDifference[15][19];
        adderResult_0[125] <= absoluteDifference[15][20] + absoluteDifference[15][21] + absoluteDifference[15][22] + absoluteDifference[15][23];
        adderResult_0[126] <= absoluteDifference[15][24] + absoluteDifference[15][25] + absoluteDifference[15][26] + absoluteDifference[15][27];
        adderResult_0[127] <= absoluteDifference[15][28] + absoluteDifference[15][29] + absoluteDifference[15][30] + absoluteDifference[15][31];
        adderResult_0[128] <= absoluteDifference[16][0] + absoluteDifference[16][1] + absoluteDifference[16][2] + absoluteDifference[16][3];
        adderResult_0[129] <= absoluteDifference[16][4] + absoluteDifference[16][5] + absoluteDifference[16][6] + absoluteDifference[16][7];
        adderResult_0[130] <= absoluteDifference[16][8] + absoluteDifference[16][9] + absoluteDifference[16][10] + absoluteDifference[16][11];
        adderResult_0[131] <= absoluteDifference[16][12] + absoluteDifference[16][13] + absoluteDifference[16][14] + absoluteDifference[16][15];
        adderResult_0[132] <= absoluteDifference[16][16] + absoluteDifference[16][17] + absoluteDifference[16][18] + absoluteDifference[16][19];
        adderResult_0[133] <= absoluteDifference[16][20] + absoluteDifference[16][21] + absoluteDifference[16][22] + absoluteDifference[16][23];
        adderResult_0[134] <= absoluteDifference[16][24] + absoluteDifference[16][25] + absoluteDifference[16][26] + absoluteDifference[16][27];
        adderResult_0[135] <= absoluteDifference[16][28] + absoluteDifference[16][29] + absoluteDifference[16][30] + absoluteDifference[16][31];
        adderResult_0[136] <= absoluteDifference[17][0] + absoluteDifference[17][1] + absoluteDifference[17][2] + absoluteDifference[17][3];
        adderResult_0[137] <= absoluteDifference[17][4] + absoluteDifference[17][5] + absoluteDifference[17][6] + absoluteDifference[17][7];
        adderResult_0[138] <= absoluteDifference[17][8] + absoluteDifference[17][9] + absoluteDifference[17][10] + absoluteDifference[17][11];
        adderResult_0[139] <= absoluteDifference[17][12] + absoluteDifference[17][13] + absoluteDifference[17][14] + absoluteDifference[17][15];
        adderResult_0[140] <= absoluteDifference[17][16] + absoluteDifference[17][17] + absoluteDifference[17][18] + absoluteDifference[17][19];
        adderResult_0[141] <= absoluteDifference[17][20] + absoluteDifference[17][21] + absoluteDifference[17][22] + absoluteDifference[17][23];
        adderResult_0[142] <= absoluteDifference[17][24] + absoluteDifference[17][25] + absoluteDifference[17][26] + absoluteDifference[17][27];
        adderResult_0[143] <= absoluteDifference[17][28] + absoluteDifference[17][29] + absoluteDifference[17][30] + absoluteDifference[17][31];
        adderResult_0[144] <= absoluteDifference[18][0] + absoluteDifference[18][1] + absoluteDifference[18][2] + absoluteDifference[18][3];
        adderResult_0[145] <= absoluteDifference[18][4] + absoluteDifference[18][5] + absoluteDifference[18][6] + absoluteDifference[18][7];
        adderResult_0[146] <= absoluteDifference[18][8] + absoluteDifference[18][9] + absoluteDifference[18][10] + absoluteDifference[18][11];
        adderResult_0[147] <= absoluteDifference[18][12] + absoluteDifference[18][13] + absoluteDifference[18][14] + absoluteDifference[18][15];
        adderResult_0[148] <= absoluteDifference[18][16] + absoluteDifference[18][17] + absoluteDifference[18][18] + absoluteDifference[18][19];
        adderResult_0[149] <= absoluteDifference[18][20] + absoluteDifference[18][21] + absoluteDifference[18][22] + absoluteDifference[18][23];
        adderResult_0[150] <= absoluteDifference[18][24] + absoluteDifference[18][25] + absoluteDifference[18][26] + absoluteDifference[18][27];
        adderResult_0[151] <= absoluteDifference[18][28] + absoluteDifference[18][29] + absoluteDifference[18][30] + absoluteDifference[18][31];
        adderResult_0[152] <= absoluteDifference[19][0] + absoluteDifference[19][1] + absoluteDifference[19][2] + absoluteDifference[19][3];
        adderResult_0[153] <= absoluteDifference[19][4] + absoluteDifference[19][5] + absoluteDifference[19][6] + absoluteDifference[19][7];
        adderResult_0[154] <= absoluteDifference[19][8] + absoluteDifference[19][9] + absoluteDifference[19][10] + absoluteDifference[19][11];
        adderResult_0[155] <= absoluteDifference[19][12] + absoluteDifference[19][13] + absoluteDifference[19][14] + absoluteDifference[19][15];
        adderResult_0[156] <= absoluteDifference[19][16] + absoluteDifference[19][17] + absoluteDifference[19][18] + absoluteDifference[19][19];
        adderResult_0[157] <= absoluteDifference[19][20] + absoluteDifference[19][21] + absoluteDifference[19][22] + absoluteDifference[19][23];
        adderResult_0[158] <= absoluteDifference[19][24] + absoluteDifference[19][25] + absoluteDifference[19][26] + absoluteDifference[19][27];
        adderResult_0[159] <= absoluteDifference[19][28] + absoluteDifference[19][29] + absoluteDifference[19][30] + absoluteDifference[19][31];
        adderResult_0[160] <= absoluteDifference[20][0] + absoluteDifference[20][1] + absoluteDifference[20][2] + absoluteDifference[20][3];
        adderResult_0[161] <= absoluteDifference[20][4] + absoluteDifference[20][5] + absoluteDifference[20][6] + absoluteDifference[20][7];
        adderResult_0[162] <= absoluteDifference[20][8] + absoluteDifference[20][9] + absoluteDifference[20][10] + absoluteDifference[20][11];
        adderResult_0[163] <= absoluteDifference[20][12] + absoluteDifference[20][13] + absoluteDifference[20][14] + absoluteDifference[20][15];
        adderResult_0[164] <= absoluteDifference[20][16] + absoluteDifference[20][17] + absoluteDifference[20][18] + absoluteDifference[20][19];
        adderResult_0[165] <= absoluteDifference[20][20] + absoluteDifference[20][21] + absoluteDifference[20][22] + absoluteDifference[20][23];
        adderResult_0[166] <= absoluteDifference[20][24] + absoluteDifference[20][25] + absoluteDifference[20][26] + absoluteDifference[20][27];
        adderResult_0[167] <= absoluteDifference[20][28] + absoluteDifference[20][29] + absoluteDifference[20][30] + absoluteDifference[20][31];
        adderResult_0[168] <= absoluteDifference[21][0] + absoluteDifference[21][1] + absoluteDifference[21][2] + absoluteDifference[21][3];
        adderResult_0[169] <= absoluteDifference[21][4] + absoluteDifference[21][5] + absoluteDifference[21][6] + absoluteDifference[21][7];
        adderResult_0[170] <= absoluteDifference[21][8] + absoluteDifference[21][9] + absoluteDifference[21][10] + absoluteDifference[21][11];
        adderResult_0[171] <= absoluteDifference[21][12] + absoluteDifference[21][13] + absoluteDifference[21][14] + absoluteDifference[21][15];
        adderResult_0[172] <= absoluteDifference[21][16] + absoluteDifference[21][17] + absoluteDifference[21][18] + absoluteDifference[21][19];
        adderResult_0[173] <= absoluteDifference[21][20] + absoluteDifference[21][21] + absoluteDifference[21][22] + absoluteDifference[21][23];
        adderResult_0[174] <= absoluteDifference[21][24] + absoluteDifference[21][25] + absoluteDifference[21][26] + absoluteDifference[21][27];
        adderResult_0[175] <= absoluteDifference[21][28] + absoluteDifference[21][29] + absoluteDifference[21][30] + absoluteDifference[21][31];
        adderResult_0[176] <= absoluteDifference[22][0] + absoluteDifference[22][1] + absoluteDifference[22][2] + absoluteDifference[22][3];
        adderResult_0[177] <= absoluteDifference[22][4] + absoluteDifference[22][5] + absoluteDifference[22][6] + absoluteDifference[22][7];
        adderResult_0[178] <= absoluteDifference[22][8] + absoluteDifference[22][9] + absoluteDifference[22][10] + absoluteDifference[22][11];
        adderResult_0[179] <= absoluteDifference[22][12] + absoluteDifference[22][13] + absoluteDifference[22][14] + absoluteDifference[22][15];
        adderResult_0[180] <= absoluteDifference[22][16] + absoluteDifference[22][17] + absoluteDifference[22][18] + absoluteDifference[22][19];
        adderResult_0[181] <= absoluteDifference[22][20] + absoluteDifference[22][21] + absoluteDifference[22][22] + absoluteDifference[22][23];
        adderResult_0[182] <= absoluteDifference[22][24] + absoluteDifference[22][25] + absoluteDifference[22][26] + absoluteDifference[22][27];
        adderResult_0[183] <= absoluteDifference[22][28] + absoluteDifference[22][29] + absoluteDifference[22][30] + absoluteDifference[22][31];
        adderResult_0[184] <= absoluteDifference[23][0] + absoluteDifference[23][1] + absoluteDifference[23][2] + absoluteDifference[23][3];
        adderResult_0[185] <= absoluteDifference[23][4] + absoluteDifference[23][5] + absoluteDifference[23][6] + absoluteDifference[23][7];
        adderResult_0[186] <= absoluteDifference[23][8] + absoluteDifference[23][9] + absoluteDifference[23][10] + absoluteDifference[23][11];
        adderResult_0[187] <= absoluteDifference[23][12] + absoluteDifference[23][13] + absoluteDifference[23][14] + absoluteDifference[23][15];
        adderResult_0[188] <= absoluteDifference[23][16] + absoluteDifference[23][17] + absoluteDifference[23][18] + absoluteDifference[23][19];
        adderResult_0[189] <= absoluteDifference[23][20] + absoluteDifference[23][21] + absoluteDifference[23][22] + absoluteDifference[23][23];
        adderResult_0[190] <= absoluteDifference[23][24] + absoluteDifference[23][25] + absoluteDifference[23][26] + absoluteDifference[23][27];
        adderResult_0[191] <= absoluteDifference[23][28] + absoluteDifference[23][29] + absoluteDifference[23][30] + absoluteDifference[23][31];
        adderResult_0[192] <= absoluteDifference[24][0] + absoluteDifference[24][1] + absoluteDifference[24][2] + absoluteDifference[24][3];
        adderResult_0[193] <= absoluteDifference[24][4] + absoluteDifference[24][5] + absoluteDifference[24][6] + absoluteDifference[24][7];
        adderResult_0[194] <= absoluteDifference[24][8] + absoluteDifference[24][9] + absoluteDifference[24][10] + absoluteDifference[24][11];
        adderResult_0[195] <= absoluteDifference[24][12] + absoluteDifference[24][13] + absoluteDifference[24][14] + absoluteDifference[24][15];
        adderResult_0[196] <= absoluteDifference[24][16] + absoluteDifference[24][17] + absoluteDifference[24][18] + absoluteDifference[24][19];
        adderResult_0[197] <= absoluteDifference[24][20] + absoluteDifference[24][21] + absoluteDifference[24][22] + absoluteDifference[24][23];
        adderResult_0[198] <= absoluteDifference[24][24] + absoluteDifference[24][25] + absoluteDifference[24][26] + absoluteDifference[24][27];
        adderResult_0[199] <= absoluteDifference[24][28] + absoluteDifference[24][29] + absoluteDifference[24][30] + absoluteDifference[24][31];
        adderResult_0[200] <= absoluteDifference[25][0] + absoluteDifference[25][1] + absoluteDifference[25][2] + absoluteDifference[25][3];
        adderResult_0[201] <= absoluteDifference[25][4] + absoluteDifference[25][5] + absoluteDifference[25][6] + absoluteDifference[25][7];
        adderResult_0[202] <= absoluteDifference[25][8] + absoluteDifference[25][9] + absoluteDifference[25][10] + absoluteDifference[25][11];
        adderResult_0[203] <= absoluteDifference[25][12] + absoluteDifference[25][13] + absoluteDifference[25][14] + absoluteDifference[25][15];
        adderResult_0[204] <= absoluteDifference[25][16] + absoluteDifference[25][17] + absoluteDifference[25][18] + absoluteDifference[25][19];
        adderResult_0[205] <= absoluteDifference[25][20] + absoluteDifference[25][21] + absoluteDifference[25][22] + absoluteDifference[25][23];
        adderResult_0[206] <= absoluteDifference[25][24] + absoluteDifference[25][25] + absoluteDifference[25][26] + absoluteDifference[25][27];
        adderResult_0[207] <= absoluteDifference[25][28] + absoluteDifference[25][29] + absoluteDifference[25][30] + absoluteDifference[25][31];
        adderResult_0[208] <= absoluteDifference[26][0] + absoluteDifference[26][1] + absoluteDifference[26][2] + absoluteDifference[26][3];
        adderResult_0[209] <= absoluteDifference[26][4] + absoluteDifference[26][5] + absoluteDifference[26][6] + absoluteDifference[26][7];
        adderResult_0[210] <= absoluteDifference[26][8] + absoluteDifference[26][9] + absoluteDifference[26][10] + absoluteDifference[26][11];
        adderResult_0[211] <= absoluteDifference[26][12] + absoluteDifference[26][13] + absoluteDifference[26][14] + absoluteDifference[26][15];
        adderResult_0[212] <= absoluteDifference[26][16] + absoluteDifference[26][17] + absoluteDifference[26][18] + absoluteDifference[26][19];
        adderResult_0[213] <= absoluteDifference[26][20] + absoluteDifference[26][21] + absoluteDifference[26][22] + absoluteDifference[26][23];
        adderResult_0[214] <= absoluteDifference[26][24] + absoluteDifference[26][25] + absoluteDifference[26][26] + absoluteDifference[26][27];
        adderResult_0[215] <= absoluteDifference[26][28] + absoluteDifference[26][29] + absoluteDifference[26][30] + absoluteDifference[26][31];
        adderResult_0[216] <= absoluteDifference[27][0] + absoluteDifference[27][1] + absoluteDifference[27][2] + absoluteDifference[27][3];
        adderResult_0[217] <= absoluteDifference[27][4] + absoluteDifference[27][5] + absoluteDifference[27][6] + absoluteDifference[27][7];
        adderResult_0[218] <= absoluteDifference[27][8] + absoluteDifference[27][9] + absoluteDifference[27][10] + absoluteDifference[27][11];
        adderResult_0[219] <= absoluteDifference[27][12] + absoluteDifference[27][13] + absoluteDifference[27][14] + absoluteDifference[27][15];
        adderResult_0[220] <= absoluteDifference[27][16] + absoluteDifference[27][17] + absoluteDifference[27][18] + absoluteDifference[27][19];
        adderResult_0[221] <= absoluteDifference[27][20] + absoluteDifference[27][21] + absoluteDifference[27][22] + absoluteDifference[27][23];
        adderResult_0[222] <= absoluteDifference[27][24] + absoluteDifference[27][25] + absoluteDifference[27][26] + absoluteDifference[27][27];
        adderResult_0[223] <= absoluteDifference[27][28] + absoluteDifference[27][29] + absoluteDifference[27][30] + absoluteDifference[27][31];
        adderResult_0[224] <= absoluteDifference[28][0] + absoluteDifference[28][1] + absoluteDifference[28][2] + absoluteDifference[28][3];
        adderResult_0[225] <= absoluteDifference[28][4] + absoluteDifference[28][5] + absoluteDifference[28][6] + absoluteDifference[28][7];
        adderResult_0[226] <= absoluteDifference[28][8] + absoluteDifference[28][9] + absoluteDifference[28][10] + absoluteDifference[28][11];
        adderResult_0[227] <= absoluteDifference[28][12] + absoluteDifference[28][13] + absoluteDifference[28][14] + absoluteDifference[28][15];
        adderResult_0[228] <= absoluteDifference[28][16] + absoluteDifference[28][17] + absoluteDifference[28][18] + absoluteDifference[28][19];
        adderResult_0[229] <= absoluteDifference[28][20] + absoluteDifference[28][21] + absoluteDifference[28][22] + absoluteDifference[28][23];
        adderResult_0[230] <= absoluteDifference[28][24] + absoluteDifference[28][25] + absoluteDifference[28][26] + absoluteDifference[28][27];
        adderResult_0[231] <= absoluteDifference[28][28] + absoluteDifference[28][29] + absoluteDifference[28][30] + absoluteDifference[28][31];
        adderResult_0[232] <= absoluteDifference[29][0] + absoluteDifference[29][1] + absoluteDifference[29][2] + absoluteDifference[29][3];
        adderResult_0[233] <= absoluteDifference[29][4] + absoluteDifference[29][5] + absoluteDifference[29][6] + absoluteDifference[29][7];
        adderResult_0[234] <= absoluteDifference[29][8] + absoluteDifference[29][9] + absoluteDifference[29][10] + absoluteDifference[29][11];
        adderResult_0[235] <= absoluteDifference[29][12] + absoluteDifference[29][13] + absoluteDifference[29][14] + absoluteDifference[29][15];
        adderResult_0[236] <= absoluteDifference[29][16] + absoluteDifference[29][17] + absoluteDifference[29][18] + absoluteDifference[29][19];
        adderResult_0[237] <= absoluteDifference[29][20] + absoluteDifference[29][21] + absoluteDifference[29][22] + absoluteDifference[29][23];
        adderResult_0[238] <= absoluteDifference[29][24] + absoluteDifference[29][25] + absoluteDifference[29][26] + absoluteDifference[29][27];
        adderResult_0[239] <= absoluteDifference[29][28] + absoluteDifference[29][29] + absoluteDifference[29][30] + absoluteDifference[29][31];
        adderResult_0[240] <= absoluteDifference[30][0] + absoluteDifference[30][1] + absoluteDifference[30][2] + absoluteDifference[30][3];
        adderResult_0[241] <= absoluteDifference[30][4] + absoluteDifference[30][5] + absoluteDifference[30][6] + absoluteDifference[30][7];
        adderResult_0[242] <= absoluteDifference[30][8] + absoluteDifference[30][9] + absoluteDifference[30][10] + absoluteDifference[30][11];
        adderResult_0[243] <= absoluteDifference[30][12] + absoluteDifference[30][13] + absoluteDifference[30][14] + absoluteDifference[30][15];
        adderResult_0[244] <= absoluteDifference[30][16] + absoluteDifference[30][17] + absoluteDifference[30][18] + absoluteDifference[30][19];
        adderResult_0[245] <= absoluteDifference[30][20] + absoluteDifference[30][21] + absoluteDifference[30][22] + absoluteDifference[30][23];
        adderResult_0[246] <= absoluteDifference[30][24] + absoluteDifference[30][25] + absoluteDifference[30][26] + absoluteDifference[30][27];
        adderResult_0[247] <= absoluteDifference[30][28] + absoluteDifference[30][29] + absoluteDifference[30][30] + absoluteDifference[30][31];
        adderResult_0[248] <= absoluteDifference[31][0] + absoluteDifference[31][1] + absoluteDifference[31][2] + absoluteDifference[31][3];
        adderResult_0[249] <= absoluteDifference[31][4] + absoluteDifference[31][5] + absoluteDifference[31][6] + absoluteDifference[31][7];
        adderResult_0[250] <= absoluteDifference[31][8] + absoluteDifference[31][9] + absoluteDifference[31][10] + absoluteDifference[31][11];
        adderResult_0[251] <= absoluteDifference[31][12] + absoluteDifference[31][13] + absoluteDifference[31][14] + absoluteDifference[31][15];
        adderResult_0[252] <= absoluteDifference[31][16] + absoluteDifference[31][17] + absoluteDifference[31][18] + absoluteDifference[31][19];
        adderResult_0[253] <= absoluteDifference[31][20] + absoluteDifference[31][21] + absoluteDifference[31][22] + absoluteDifference[31][23];
        adderResult_0[254] <= absoluteDifference[31][24] + absoluteDifference[31][25] + absoluteDifference[31][26] + absoluteDifference[31][27];
        adderResult_0[255] <= absoluteDifference[31][28] + absoluteDifference[31][29] + absoluteDifference[31][30] + absoluteDifference[31][31];
    end

    // always block for 2nd-stage adder tree
    always @ (posedge M_AXI_ACLK) begin
        adderResult_1[0] <= adderResult_0[0] + adderResult_0[1] + adderResult_0[2] + adderResult_0[3];
        adderResult_1[1] <= adderResult_0[4] + adderResult_0[5] + adderResult_0[6] + adderResult_0[7];
        adderResult_1[2] <= adderResult_0[8] + adderResult_0[9] + adderResult_0[10] + adderResult_0[11];
        adderResult_1[3] <= adderResult_0[12] + adderResult_0[13] + adderResult_0[14] + adderResult_0[15];
        adderResult_1[4] <= adderResult_0[16] + adderResult_0[17] + adderResult_0[18] + adderResult_0[19];
        adderResult_1[5] <= adderResult_0[20] + adderResult_0[21] + adderResult_0[22] + adderResult_0[23];
        adderResult_1[6] <= adderResult_0[24] + adderResult_0[25] + adderResult_0[26] + adderResult_0[27];
        adderResult_1[7] <= adderResult_0[28] + adderResult_0[29] + adderResult_0[30] + adderResult_0[31];
        adderResult_1[8] <= adderResult_0[32] + adderResult_0[33] + adderResult_0[34] + adderResult_0[35];
        adderResult_1[9] <= adderResult_0[36] + adderResult_0[37] + adderResult_0[38] + adderResult_0[39];
        adderResult_1[10] <= adderResult_0[40] + adderResult_0[41] + adderResult_0[42] + adderResult_0[43];
        adderResult_1[11] <= adderResult_0[44] + adderResult_0[45] + adderResult_0[46] + adderResult_0[47];
        adderResult_1[12] <= adderResult_0[48] + adderResult_0[49] + adderResult_0[50] + adderResult_0[51];
        adderResult_1[13] <= adderResult_0[52] + adderResult_0[53] + adderResult_0[54] + adderResult_0[55];
        adderResult_1[14] <= adderResult_0[56] + adderResult_0[57] + adderResult_0[58] + adderResult_0[59];
        adderResult_1[15] <= adderResult_0[60] + adderResult_0[61] + adderResult_0[62] + adderResult_0[63];
        adderResult_1[16] <= adderResult_0[64] + adderResult_0[65] + adderResult_0[66] + adderResult_0[67];
        adderResult_1[17] <= adderResult_0[68] + adderResult_0[69] + adderResult_0[70] + adderResult_0[71];
        adderResult_1[18] <= adderResult_0[72] + adderResult_0[73] + adderResult_0[74] + adderResult_0[75];
        adderResult_1[19] <= adderResult_0[76] + adderResult_0[77] + adderResult_0[78] + adderResult_0[79];
        adderResult_1[20] <= adderResult_0[80] + adderResult_0[81] + adderResult_0[82] + adderResult_0[83];
        adderResult_1[21] <= adderResult_0[84] + adderResult_0[85] + adderResult_0[86] + adderResult_0[87];
        adderResult_1[22] <= adderResult_0[88] + adderResult_0[89] + adderResult_0[90] + adderResult_0[91];
        adderResult_1[23] <= adderResult_0[92] + adderResult_0[93] + adderResult_0[94] + adderResult_0[95];
        adderResult_1[24] <= adderResult_0[96] + adderResult_0[97] + adderResult_0[98] + adderResult_0[99];
        adderResult_1[25] <= adderResult_0[100] + adderResult_0[101] + adderResult_0[102] + adderResult_0[103];
        adderResult_1[26] <= adderResult_0[104] + adderResult_0[105] + adderResult_0[106] + adderResult_0[107];
        adderResult_1[27] <= adderResult_0[108] + adderResult_0[109] + adderResult_0[110] + adderResult_0[111];
        adderResult_1[28] <= adderResult_0[112] + adderResult_0[113] + adderResult_0[114] + adderResult_0[115];
        adderResult_1[29] <= adderResult_0[116] + adderResult_0[117] + adderResult_0[118] + adderResult_0[119];
        adderResult_1[30] <= adderResult_0[120] + adderResult_0[121] + adderResult_0[122] + adderResult_0[123];
        adderResult_1[31] <= adderResult_0[124] + adderResult_0[125] + adderResult_0[126] + adderResult_0[127];
        adderResult_1[32] <= adderResult_0[128] + adderResult_0[129] + adderResult_0[130] + adderResult_0[131];
        adderResult_1[33] <= adderResult_0[132] + adderResult_0[133] + adderResult_0[134] + adderResult_0[135];
        adderResult_1[34] <= adderResult_0[136] + adderResult_0[137] + adderResult_0[138] + adderResult_0[139];
        adderResult_1[35] <= adderResult_0[140] + adderResult_0[141] + adderResult_0[142] + adderResult_0[143];
        adderResult_1[36] <= adderResult_0[144] + adderResult_0[145] + adderResult_0[146] + adderResult_0[147];
        adderResult_1[37] <= adderResult_0[148] + adderResult_0[149] + adderResult_0[150] + adderResult_0[151];
        adderResult_1[38] <= adderResult_0[152] + adderResult_0[153] + adderResult_0[154] + adderResult_0[155];
        adderResult_1[39] <= adderResult_0[156] + adderResult_0[157] + adderResult_0[158] + adderResult_0[159];
        adderResult_1[40] <= adderResult_0[160] + adderResult_0[161] + adderResult_0[162] + adderResult_0[163];
        adderResult_1[41] <= adderResult_0[164] + adderResult_0[165] + adderResult_0[166] + adderResult_0[167];
        adderResult_1[42] <= adderResult_0[168] + adderResult_0[169] + adderResult_0[170] + adderResult_0[171];
        adderResult_1[43] <= adderResult_0[172] + adderResult_0[173] + adderResult_0[174] + adderResult_0[175];
        adderResult_1[44] <= adderResult_0[176] + adderResult_0[177] + adderResult_0[178] + adderResult_0[179];
        adderResult_1[45] <= adderResult_0[180] + adderResult_0[181] + adderResult_0[182] + adderResult_0[183];
        adderResult_1[46] <= adderResult_0[184] + adderResult_0[185] + adderResult_0[186] + adderResult_0[187];
        adderResult_1[47] <= adderResult_0[188] + adderResult_0[189] + adderResult_0[190] + adderResult_0[191];
        adderResult_1[48] <= adderResult_0[192] + adderResult_0[193] + adderResult_0[194] + adderResult_0[195];
        adderResult_1[49] <= adderResult_0[196] + adderResult_0[197] + adderResult_0[198] + adderResult_0[199];
        adderResult_1[50] <= adderResult_0[200] + adderResult_0[201] + adderResult_0[202] + adderResult_0[203];
        adderResult_1[51] <= adderResult_0[204] + adderResult_0[205] + adderResult_0[206] + adderResult_0[207];
        adderResult_1[52] <= adderResult_0[208] + adderResult_0[209] + adderResult_0[210] + adderResult_0[211];
        adderResult_1[53] <= adderResult_0[212] + adderResult_0[213] + adderResult_0[214] + adderResult_0[215];
        adderResult_1[54] <= adderResult_0[216] + adderResult_0[217] + adderResult_0[218] + adderResult_0[219];
        adderResult_1[55] <= adderResult_0[220] + adderResult_0[221] + adderResult_0[222] + adderResult_0[223];
        adderResult_1[56] <= adderResult_0[224] + adderResult_0[225] + adderResult_0[226] + adderResult_0[227];
        adderResult_1[57] <= adderResult_0[228] + adderResult_0[229] + adderResult_0[230] + adderResult_0[231];
        adderResult_1[58] <= adderResult_0[232] + adderResult_0[233] + adderResult_0[234] + adderResult_0[235];
        adderResult_1[59] <= adderResult_0[236] + adderResult_0[237] + adderResult_0[238] + adderResult_0[239];
        adderResult_1[60] <= adderResult_0[240] + adderResult_0[241] + adderResult_0[242] + adderResult_0[243];
        adderResult_1[61] <= adderResult_0[244] + adderResult_0[245] + adderResult_0[246] + adderResult_0[247];
        adderResult_1[62] <= adderResult_0[248] + adderResult_0[249] + adderResult_0[250] + adderResult_0[251];
        adderResult_1[63] <= adderResult_0[252] + adderResult_0[253] + adderResult_0[254] + adderResult_0[255];
    end

    // always block for 3rd-stage adder tree
    always @ (posedge M_AXI_ACLK) begin
        adderResult_2[0] <= adderResult_1[0] + adderResult_1[1] + adderResult_1[2] + adderResult_1[3];
        adderResult_2[1] <= adderResult_1[4] + adderResult_1[5] + adderResult_1[6] + adderResult_1[7];
        adderResult_2[2] <= adderResult_1[8] + adderResult_1[9] + adderResult_1[10] + adderResult_1[11];
        adderResult_2[3] <= adderResult_1[12] + adderResult_1[13] + adderResult_1[14] + adderResult_1[15];
        adderResult_2[4] <= adderResult_1[16] + adderResult_1[17] + adderResult_1[18] + adderResult_1[19];
        adderResult_2[5] <= adderResult_1[20] + adderResult_1[21] + adderResult_1[22] + adderResult_1[23];
        adderResult_2[6] <= adderResult_1[24] + adderResult_1[25] + adderResult_1[26] + adderResult_1[27];
        adderResult_2[7] <= adderResult_1[28] + adderResult_1[29] + adderResult_1[30] + adderResult_1[31];
        adderResult_2[8] <= adderResult_1[32] + adderResult_1[33] + adderResult_1[34] + adderResult_1[35];
        adderResult_2[9] <= adderResult_1[36] + adderResult_1[37] + adderResult_1[38] + adderResult_1[39];
        adderResult_2[10] <= adderResult_1[40] + adderResult_1[41] + adderResult_1[42] + adderResult_1[43];
        adderResult_2[11] <= adderResult_1[44] + adderResult_1[45] + adderResult_1[46] + adderResult_1[47];
        adderResult_2[12] <= adderResult_1[48] + adderResult_1[49] + adderResult_1[50] + adderResult_1[51];
        adderResult_2[13] <= adderResult_1[52] + adderResult_1[53] + adderResult_1[54] + adderResult_1[55];
        adderResult_2[14] <= adderResult_1[56] + adderResult_1[57] + adderResult_1[58] + adderResult_1[59];
        adderResult_2[15] <= adderResult_1[60] + adderResult_1[61] + adderResult_1[62] + adderResult_1[63];
    end

    // always block for 4th-stage adder tree
    always @ (posedge M_AXI_ACLK) begin
        adderResult_3[0] <= adderResult_2[0] + adderResult_2[1] + adderResult_2[2] + adderResult_2[3];
        adderResult_3[1] <= adderResult_2[4] + adderResult_2[5] + adderResult_2[6] + adderResult_2[7];
        adderResult_3[2] <= adderResult_2[8] + adderResult_2[9] + adderResult_2[10] + adderResult_2[11];
        adderResult_3[3] <= adderResult_2[12] + adderResult_2[13] + adderResult_2[14] + adderResult_2[15];
    end

    // always block for 5th-stage adder tree
    always @ (posedge M_AXI_ACLK) begin
        adderResult_4 <= adderResult_3[0] + adderResult_3[1] + adderResult_3[2] + adderResult_3[3];
    end

    // always block for xIndexNow
    always @ ( posedge M_AXI_ACLK ) begin
        if(gState == gINITIAL || xIndexNow == MAX_X_POS && reachBottomSignal != 1'b1)
            xIndexNow <= 12'd0;
        //else if(yIndexNow == MAX_Y_POS)
        else if(reachBottomSignal)
            xIndexNow <= xIndexNow + 32'd1;
        else
            xIndexNow <= xIndexNow;
    end

    // always block for yIndexNow
    always @ ( posedge M_AXI_ACLK ) begin
        if(gState == gINITIAL || yIndexNow == MAX_Y_POS)
            yIndexNow <= 12'd0;
        else if(cCounter >= 5'd5 && cCounter <= 5'd20 && reachBottomSignal != 1'b1)
            yIndexNow <= yIndexNow + 32'd1;
        else
            yIndexNow <= yIndexNow;
    end

    // always block for yIndexAns
    always @ (posedge M_AXI_ACLK) begin
        if(gState == gINITIAL)
            yIndexAns <= 32'd0;
        else if(cCounter >= 5'd5 && cCounter <= 5'd20 && reachBottomSignal != 1'b1)
            yIndexAns <= (miniSAD > adderResult_4) ? yIndexNow : yIndexAns;
        else
            yIndexAns <= yIndexAns;
    end

    // always block for xIndexAns
    always @ (posedge M_AXI_ACLK) begin
        if(gState == gINITIAL)
            xIndexAns <= 32'd0;
        else if(cCounter >= 5'd5 && cCounter <= 5'd20 && reachBottomSignal != 1'b1)
            xIndexAns <= (miniSAD > adderResult_4) ? xIndexNow : xIndexAns;
        else
            xIndexAns <= xIndexAns;
    end

    // always block for miniSAD
    always @ (posedge M_AXI_ACLK) begin
        if(gState == gINITIAL)
            miniSAD <= 32'hffffffff;
        else if(cCounter >= 5'd5 && cCounter <= 5'd20 && reachBottomSignal != 1'b1)
            miniSAD <= (miniSAD > adderResult_4) ? adderResult_4 : miniSAD;
        else
            miniSAD <= miniSAD;
    end

    // User logic ends

    endmodule
