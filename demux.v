/*1:4 demux*/
/* Behvaioral model */
module demux(in,sel,out1,out2,out3,out4);
  input in;
  input [1:0] sel;
  output reg out1,out2,out3,out4;
  parameter S1 = 2'b00, S2 = 2'b01, S3 = 2'b10, S4 = 2'b11;
  
  always@(in,sel)begin
    case(sel)
      S1: begin out1 = in;
      out2 = 1'b0;
      out3 = 1'b0;
        out4 = 1'b0; end
      S2: begin out1 = 1'b0;
      out2 = in;
      out3 = 1'b0;
        out4 = 1'b0;end
      S3: begin out1 = 1'b0;
      out2 = 1'b0;
      out3 = in;
        out4 = 1'b0;end
      S4: begin out1 = 1'b0;
      out2 = 1'b0;
      out3 = 1'b0;
        out4 = in; end
    endcase
  end
endmodule

/*Testbench*/
module demux_tb;
  reg in;
  reg [1:0] sel;
  wire out1,out2,out3,out4;
  
  demux DM(in,sel,out1,out2,out3,out4);
  
  initial $monitor($time," in = %b, sel =%b, out1=%b, out2=%b, out3=%b, out4=%b",in,sel,out1,out2,out3,out4);
  
  initial begin
    in = 1'b1; sel = 2'b00;
    #10 in = 1'b1; sel = 2'b10;
    #10 in = 1'b1; sel = 2'b01;
    #10 in = 1'b1; sel = 2'b11;
    #10 $finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
