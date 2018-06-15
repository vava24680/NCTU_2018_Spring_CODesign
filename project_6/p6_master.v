
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
        input wire [C_M_AXI_DATA_WIDTH - 1 : 0] src_addr,
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
    integer innerLoopIndex;
    localparam integer GROUP_WIDTH = 1920;
    localparam integer GROUP_HEIGHT = 1080;
    localparam integer GROUP_BUFFER_WIDTH = 32;
    localparam integer GROUP_BUFFER_HEIGHT = 32;
    localparam integer NEW_ROWS_BUFFER_WIDTH = 32;
    localparam integer NEW_ROWS_BUFFER_HEIGHT = 16;
    localparam integer FACE_BUFFER_WIDTH = 32;
    localparam integer FACE_BUFFER_HEIGHT = 32;
    localparam integer PIXEL_WIDTH = 8;
    localparam integer TRANSFER_BUFFER_WIDTH = 32;
    localparam integer TRANSFER_BUFFER_HEIGHT = 16;
    localparam integer TRANSFER_BURST_LENGTH = 8;
    // C_TRANSACTIONS_NUM is the width of the index counter for
    // number of write or read transaction.
    localparam integer C_TRANSACTIONS_NUM = clogb2(TRANSFER_BURST_LENGTH-1);

    // Example State machine to initialize counter, initialize write transactions,
    // initialize read transactions and comparison of read data with the
    // written data words.
    parameter [1:0]
        IDLE = 2'b00, // This state initiates AXI4 transaction
                    // after the state machine changes state to INIT_READ
                    // when there is 0 to 1 transition on INIT_AXI_TXN
        INIT_READ  = 2'b01, // This state initializes read transaction
                            // once reads are done, the state machine
                            // changes state to INIT_WRITE
        RESET    = 2'b10,
        COMPLETE  = 2'b11; // This state issues the status of comparison
                            // of the written data with the read data

    // Global finite state machine states definitions
    localparam gINITIAL = 4'd0;
    localparam gREAD_UP_FACE = 4'd1;
    localparam gREAD_DOWN_FACE = 4'd2;
    localparam gREAD_UP_GROUP = 4'd3;
    localparam gREAD_DOWN_GROUP = 4'd4;
    localparam gCOMPUTE = 4'd5;

    // Computation finite state machine states definitions
    localparam cINITIAL = 4'd0;
    localparam cROUND0 = 4'd1;
    localparam cROUND1 = 4'd2;
    localparam CROUND2 = 4'd3;
    localparam CROUND3 = 4'd4;

    // New 16-rows transfer finite state machine states definitions
    localparam nrtIDLE = 2'd0;

    // Transfer finite state machine states definitions
    localparam tIDLE = 2'd0;
    localparam tINIT_READ = 2'd1;
    localparam tRESET = 2'd2;
    localparam tCOMPLETE = 2'd3;

    reg [4 - 1:0] gState;
    reg [4 - 1:0] cState;
    (* mark_debug = "true" *)reg [1:0] mst_exec_state;
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

    reg [PIXEL_WIDTH - 1 : 0] faceBuffer[0 : FACE_BUFFER_HEIGHT - 1][0 : FACE_BUFFER_WIDTH - 1];
    reg [PIXEL_WIDTH - 1 : 0] groupBuffer[0 : GROUP_BUFFER_HEIGHT - 1][0 : GROUP_BUFFER_WIDTH - 1];
    reg [PIXEL_WIDTH - 1 : 0] newRowsBuffer[0 : NEW_ROWS_BUFFER_HEIGHT - 1][0 : NEW_ROWS_BUFFER_WIDTH - 1];
    reg [PIXEL_WIDTH - 1 : 0] transferBuffer[0 : TRANSFER_BUFFER_HEIGHT - 1][0 : TRANSFER_BUFFER_WIDTH - 1];
    wire [PIXEL_WIDTH : 0] Difference[0 : FACE_BUFFER_HEIGHT - 1][0 : FACE_BUFFER_WIDTH - 1];
    reg [PIXEL_WIDTH - 1 : 0] absoluteDifference_0[0 : FACE_BUFFER_HEIGHT * FACE_BUFFER_WIDTH / 4 - 1];
    reg [PIXEL_WIDTH - 1 : 0] absoluteDifference_1[0 : FACE_BUFFER_HEIGHT * FACE_BUFFER_WIDTH / 4 - 1];
    reg [PIXEL_WIDTH - 1 : 0] absoluteDifference_2[0 : FACE_BUFFER_HEIGHT * FACE_BUFFER_WIDTH / 4 - 1];
    reg [PIXEL_WIDTH - 1 : 0] absoluteDifference_3[0 : FACE_BUFFER_HEIGHT * FACE_BUFFER_WIDTH / 4 - 1];
    reg [C_M_AXI_DATA_WIDTH - 1 : 0] adderResult_0[0 : 64 - 1];
    reg [C_M_AXI_DATA_WIDTH - 1 : 0] adderResult_1[0 : 16 - 1];
    reg [C_M_AXI_DATA_WIDTH - 1 : 0] adderResult_2[0 : 4 - 1];
    reg [C_M_AXI_DATA_WIDTH - 1 : 0] adderResult_3;
    reg [12 - 1 : 0] yIndexNow; //Range from 0 to 1079
    reg [12 - 1 : 0] xIndexNow; //Range from 0 to 1919
    reg [32 - 1 : 0] miniSAD;
    reg [8 - 1 : 0] i_index;
    reg [8 - 1 : 0] j_index;
    (* mark_debug = "true" *)reg [5 - 1 : 0] remainRows;
    reg cleanSignal;
    wire [32 - 1 : 0] faceShiftFlag;
    wire [32 - 1 : 0] groupShiftFlag;
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

    assign element1 = transferBuffer[0][15];
    assign element2 = transferBuffer[0][16];
    assign element3 = transferBuffer[0][17];
    assign element4 = transferBuffer[13][31];
    assign element5 = transferBuffer[14][31];
    assign element6 = transferBuffer[15][31];


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
            axi_araddr <= src_addr;
        else if (M_AXI_ARREADY && axi_arvalid)
            axi_araddr <= axi_araddr + 32;
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
            remainRows <= 5'd16;
        else if(mst_exec_state == INIT_READ)
            begin
                if(reads_done)
                    remainRows <= remainRows - 5'd1;
                else
                    remainRows <= remainRows;
            end
        else
            remainRows <= remainRows;
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
                hw_done <= 0;
            end
        else
            begin
            // state transition
            case (mst_exec_state)
                IDLE:
                    // Wait until the signal INIT_AXI_TXN becomes active.
                    if (init_txn_pulse == 1'b1)
                        begin
                            mst_exec_state  <= INIT_READ;
                            hw_done <= 0;
                        end
                    else
                        begin
                            mst_exec_state  <= IDLE;
                            hw_done <= 0;
                        end
                INIT_READ:
                    // This state is responsible to issue start_single_read pulse to
                    // initiate a read transaction. Read transactions will be
                    // issued until burst_read_active signal is asserted.
                    // read controller
                    if (reads_done)
                        begin
                            hw_done <= 1'b0;
                            mst_exec_state <= RESET;
                        end
                    else
                        begin
                            hw_done <= 1'b0;
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
                        if(remainRows == 5'd0)
                            begin
                                hw_done <= 1'b1;
                                mst_exec_state <= IDLE;
                            end
                        else
                            begin
                                hw_done <= 1'b0;
                                mst_exec_state <= INIT_READ;
                            end
                    end
                default :
                    begin
                        hw_done <= 1'b0;
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
                        if(reads_done)
                            gState <= gREAD_DOWN_FACE;
                        else
                            gState <= gREAD_UP_FACE;
                    end
                    gREAD_DOWN_FACE: begin
                        if(reads_done)
                            gState <= gREAD_UP_GROUP;
                        else
                            gState <= gREAD_DOWN_FACE;
                    end
                    gREAD_UP_GROUP: begin
                        if(reads_done)
                            gState <= gREAD_DOWN_GROUP;
                        else
                            gState <= gREAD_UP_GROUP;
                    end
                    gREAD_DOWN_GROUP: begin
                        if(reads_done)
                            gState <= gCOMPUTE;
                        else
                            gState <= gREAD_DOWN_GROUP;
                    end
                    gCOMPUTE: begin

                    end
                    default: ;
                endcase
            end
    end

    assign faceShiftFlag = gState * 2 + reads_done; //Safe

    always @ ( posedge M_AXI_ACLK ) begin
        case (faceShiftFlag)
            32'd5: begin
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
            32'd7: begin
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
                        faceBuffer[outerLoopIndex][10] <= transferBuffer[outerLoopIndex - TRANSFER_BUFFER_HEIGHT][10]
                        ;
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

    assign groupShiftFlag = gState * 2 + reads_done; //Safe

    always @ ( posedge M_AXI_ACLK ) begin
        case(groupShiftFlag)
            32'd9: begin
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
            32'd11: begin
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

    // Computation finite machine
    /*always @ (posedge M_AXI_ACLK) begin
        if(M_AXI_ARESETN)
            cState <= cINITIAL;
        else
            begin
                case(cState)
                    default: begin

                    end
                endcase
            end
    end*/

    generate
        for(genOuterIndex = 0; genOuterIndex < FACE_BUFFER_HEIGHT; genOuterIndex = genOuterIndex + 1)
            begin:diff
                assign Difference[genOuterIndex][0] = {1'b0, faceBuffer[genOuterIndex][0]} - {1'b0, groupBuffer[genOuterIndex][0]};
                assign Difference[genOuterIndex][1] = {1'b0, faceBuffer[genOuterIndex][1]} - {1'b0, groupBuffer[genOuterIndex][1]};
                assign Difference[genOuterIndex][2] = {1'b0, faceBuffer[genOuterIndex][2]} - {1'b0, groupBuffer[genOuterIndex][2]};
                assign Difference[genOuterIndex][3] = {1'b0, faceBuffer[genOuterIndex][3]} - {1'b0, groupBuffer[genOuterIndex][3]};
                assign Difference[genOuterIndex][4] = {1'b0, faceBuffer[genOuterIndex][4]} - {1'b0, groupBuffer[genOuterIndex][4]};
                assign Difference[genOuterIndex][5] = {1'b0, faceBuffer[genOuterIndex][5]} - {1'b0, groupBuffer[genOuterIndex][5]};
                assign Difference[genOuterIndex][6] = {1'b0, faceBuffer[genOuterIndex][6]} - {1'b0, groupBuffer[genOuterIndex][6]};
                assign Difference[genOuterIndex][7] = {1'b0, faceBuffer[genOuterIndex][7]} - {1'b0, groupBuffer[genOuterIndex][7]};
                assign Difference[genOuterIndex][8] = {1'b0, faceBuffer[genOuterIndex][8]} - {1'b0, groupBuffer[genOuterIndex][8]};
                assign Difference[genOuterIndex][9] = {1'b0, faceBuffer[genOuterIndex][9]} - {1'b0, groupBuffer[genOuterIndex][9]};
                assign Difference[genOuterIndex][10] = {1'b0, faceBuffer[genOuterIndex][10]} - {1'b0, groupBuffer[genOuterIndex][10]};
                assign Difference[genOuterIndex][11] = {1'b0, faceBuffer[genOuterIndex][11]} - {1'b0, groupBuffer[genOuterIndex][11]};
                assign Difference[genOuterIndex][12] = {1'b0, faceBuffer[genOuterIndex][12]} - {1'b0, groupBuffer[genOuterIndex][12]};
                assign Difference[genOuterIndex][13] = {1'b0, faceBuffer[genOuterIndex][13]} - {1'b0, groupBuffer[genOuterIndex][13]};
                assign Difference[genOuterIndex][14] = {1'b0, faceBuffer[genOuterIndex][14]} - {1'b0, groupBuffer[genOuterIndex][14]};
                assign Difference[genOuterIndex][15] = {1'b0, faceBuffer[genOuterIndex][15]} - {1'b0, groupBuffer[genOuterIndex][15]};
                assign Difference[genOuterIndex][16] = {1'b0, faceBuffer[genOuterIndex][16]} - {1'b0, groupBuffer[genOuterIndex][16]};
                assign Difference[genOuterIndex][17] = {1'b0, faceBuffer[genOuterIndex][17]} - {1'b0, groupBuffer[genOuterIndex][17]};
                assign Difference[genOuterIndex][18] = {1'b0, faceBuffer[genOuterIndex][18]} - {1'b0, groupBuffer[genOuterIndex][18]};
                assign Difference[genOuterIndex][19] = {1'b0, faceBuffer[genOuterIndex][19]} - {1'b0, groupBuffer[genOuterIndex][19]};
                assign Difference[genOuterIndex][20] = {1'b0, faceBuffer[genOuterIndex][20]} - {1'b0, groupBuffer[genOuterIndex][20]};
                assign Difference[genOuterIndex][21] = {1'b0, faceBuffer[genOuterIndex][21]} - {1'b0, groupBuffer[genOuterIndex][21]};
                assign Difference[genOuterIndex][22] = {1'b0, faceBuffer[genOuterIndex][22]} - {1'b0, groupBuffer[genOuterIndex][22]};
                assign Difference[genOuterIndex][23] = {1'b0, faceBuffer[genOuterIndex][23]} - {1'b0, groupBuffer[genOuterIndex][23]};
                assign Difference[genOuterIndex][24] = {1'b0, faceBuffer[genOuterIndex][24]} - {1'b0, groupBuffer[genOuterIndex][24]};
                assign Difference[genOuterIndex][25] = {1'b0, faceBuffer[genOuterIndex][25]} - {1'b0, groupBuffer[genOuterIndex][25]};
                assign Difference[genOuterIndex][26] = {1'b0, faceBuffer[genOuterIndex][26]} - {1'b0, groupBuffer[genOuterIndex][26]};
                assign Difference[genOuterIndex][27] = {1'b0, faceBuffer[genOuterIndex][27]} - {1'b0, groupBuffer[genOuterIndex][27]};
                assign Difference[genOuterIndex][28] = {1'b0, faceBuffer[genOuterIndex][28]} - {1'b0, groupBuffer[genOuterIndex][28]};
                assign Difference[genOuterIndex][29] = {1'b0, faceBuffer[genOuterIndex][29]} - {1'b0, groupBuffer[genOuterIndex][29]};
                assign Difference[genOuterIndex][30] = {1'b0, faceBuffer[genOuterIndex][30]} - {1'b0, groupBuffer[genOuterIndex][30]};
                assign Difference[genOuterIndex][31] = {1'b0, faceBuffer[genOuterIndex][31]} - {1'b0, groupBuffer[genOuterIndex][31]};
            end
    endgenerate

    always @ ( posedge M_AXI_ACLK ) begin
        for(outerLoopIndex = 0; outerLoopIndex < FACE_BUFFER_HEIGHT / 4; outerLoopIndex = outerLoopIndex + 1)
            begin
                for(innerLoopIndex = 0; innerLoopIndex < FACE_BUFFER_WIDTH; innerLoopIndex = innerLoopIndex  +1)
                    begin
                        absoluteDifference_0[outerLoopIndex * FACE_BUFFER_WIDTH + innerLoopIndex]
                        <= (Difference[outerLoopIndex][innerLoopIndex][8] == 1'b1)
                        ? 9'd0 - Difference[outerLoopIndex][innerLoopIndex]
                        : Difference[outerLoopIndex][innerLoopIndex];

                        absoluteDifference_1[outerLoopIndex * FACE_BUFFER_WIDTH + innerLoopIndex]
                        <= (Difference[outerLoopIndex + 8][innerLoopIndex][8] == 1'b1)
                        ? 9'd0 - Difference[outerLoopIndex + 8][innerLoopIndex]
                        : Difference[outerLoopIndex + 8][innerLoopIndex];

                        absoluteDifference_2[outerLoopIndex * FACE_BUFFER_WIDTH + innerLoopIndex]
                        <= (Difference[outerLoopIndex + 16][innerLoopIndex][8] == 1'b1)
                        ? 9'd0 - Difference[outerLoopIndex + 16][innerLoopIndex] :
                        Difference[outerLoopIndex + 16][innerLoopIndex];

                        absoluteDifference_3[outerLoopIndex * FACE_BUFFER_WIDTH + innerLoopIndex]
                        <= (Difference[outerLoopIndex + 24][innerLoopIndex][8] == 1'b1)
                        ? 9'd0 - Difference[outerLoopIndex + 24][innerLoopIndex]
                        : Difference[outerLoopIndex + 24][innerLoopIndex];
                    end
            end
    end

    always @ (posedge M_AXI_ACLK) begin
        for(outerLoopIndex = 0; outerLoopIndex < 16; outerLoopIndex = outerLoopIndex + 1)
            begin
                adderResult_1[outerLoopIndex] <= adderResult_0[outerLoopIndex * 4 + 0] + adderResult_0[outerLoopIndex * 4 + 1] + adderResult_0[outerLoopIndex * 4 + 2] + adderResult_0[outerLoopIndex * 4 + 3];
            end
    end

    always @ (posedge M_AXI_ACLK) begin
        for(outerLoopIndex = 0; outerLoopIndex < 4; outerLoopIndex = outerLoopIndex + 1)
            begin
                adderResult_2[outerLoopIndex] <= adderResult_1[outerLoopIndex * 4 + 0] + adderResult_1[outerLoopIndex * 4 + 1] + adderResult_1[outerLoopIndex * 4 + 2] + adderResult_1[outerLoopIndex * 4 + 3];
            end
    end

    always @ (posedge M_AXI_ACLK) begin
        adderResult_3 <= adderResult_2[0] + adderResult_2[1] + adderResult_2[2] + adderResult_3[3];
    end

    always @ (posedge M_AXI_ACLK) begin
        if(M_AXI_ARESETN == 1'b0)
            miniSAD <= 32'hFFFFFFFF;
        else //Need to be fixed
            miniSAD <= 32'd0;
    end

    // User logic ends

    endmodule
