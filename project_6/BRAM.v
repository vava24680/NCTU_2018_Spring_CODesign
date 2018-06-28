module YOUR_IP (
	input clk,
	input [31:0]data_in,
	output [31:0]data_out
	);

	wire we,en;
	wire [9:0]sram_addr;
	wire [9:0]addr;

	assign en = 1'b1;
	assign we = rnext;
	assign sram_addr = (rnext) ? read_index : addr;
	assign data_in = M_AXI_RDATA;

	bram b1(.clk(M_AXI_ACLK),.we(we), .en(en), .data_in(data_in), .data_out(data_out), .sram_addr(sram_addr));


endmodule



module bram
#(parameter DATA_WIDTH = 32, ADDR_WIDTH = 10, RAM_SIZE = 1024)
 (input clk, input we, input en,
  input  [ADDR_WIDTH-1 : 0] sram_addr,
  input  [DATA_WIDTH-1 : 0] data_in,
  output reg [DATA_WIDTH-1 : 0] data_out);

// Declareation of the memory cells
reg [DATA_WIDTH-1 : 0] RAM [RAM_SIZE - 1:0];

// ------------------------------------
// SRAM read operation
// ------------------------------------
always@(posedge clk)
begin
  if (en & we)
	data_out <= data_in;
  else
	data_out <= RAM[sram_addr];
end

// ------------------------------------
// SRAM write operation
// ------------------------------------
always@(posedge clk)
begin
  if (en & we)
	RAM[sram_addr] <= data_in;
end


endmodule