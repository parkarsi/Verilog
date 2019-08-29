/*------------CODE----------------------------------*/
module fifo_sync(clock,wen,ren,reset,data_in,data_out,full,empty);

    parameter DATA_WIDTH    = 8;
	parameter ADDRESS_WIDTH = 8;
	localparam DEPTH = 2**ADDRESS_WIDTH;
	
	input                  clock;
	input                  wen;
	input                  ren;
  input                  reset;
	input [DATA_WIDTH-1:0] data_in;
	output reg[DATA_WIDTH-1:0] data_out;
	output reg                full;
	output reg             empty;

	reg [ADDRESS_WIDTH:0] rd_pointer; 
	reg [ADDRESS_WIDTH:0] wr_pointer;
	reg [ADDRESS_WIDTH-1:0] rd_address;
	reg [ADDRESS_WIDTH-1:0] wr_address;
	reg [DATA_WIDTH-1:0] MEM [0:DEPTH-1];
	
	assign empty = (wr_pointer==rd_pointer?1'b1:1'b0);
	assign full  = ({!wr_pointer[ADDRESS_WIDTH],wr_pointer[ADDRESS_WIDTH-1:0]}==rd_pointer?1'b1:1'b0);
	
/*-------------CODE-------------------*/
	always@(posedge clock) begin
		if(reset) begin
			wr_pointer <= 0;
			rd_pointer <= 0;
			wr_address <= 0;
			rd_address <= 0;
			data_out   <= 0;
		end
		else begin
			if(wen && !full) begin
				MEM[wr_address] <= data_in;
				wr_pointer      <= wr_pointer + 1;
				wr_address      <= wr_address + 1;
			end
			else if(ren && !empty) begin
				data_out   <= MEM[rd_address];
				rd_pointer <= rd_pointer + 1;
				rd_address <= rd_address + 1;
			end
		end
	end
  
endmodule
/*------------TESTBENCH-----------------------------*/
module fifo_sync_test;

  parameter DATA_WIDTH = 8;

	reg                   clock;
	reg                   wen;
	reg                   ren;
  reg                   reset;
	reg  [DATA_WIDTH-1:0] data_in;
	wire [DATA_WIDTH-1:0] data_out;
	wire                  full;
	wire                  empty;

	
	fifo_sync FIFO(clock,wen,ren,reset,data_in,data_out,full,empty);
	
	initial clock = 1'b0;
	
	always #5 clock = ~clock;
	
	//initial $monitor($time,"");
	
	initial begin 
		reset = 1'b1;
		data_in = 'd18;
		#10 reset = 1'b0;
		wen = 1'b1;
		#100$ finish;
	
	end
 	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end
endmodule
