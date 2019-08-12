/*Simple ALU operation*/
/* 0 - add 
1 - subtract 
2 - bitwise and 
3 - bitwise nor
4 - bitwise or 
5 - bitwise nand 
6 - bitwose xor 
7 - bitwise not*/
module alu(a,b,opcode,out);
  input [7:0] a,b;
  input [2:0] opcode;
  output reg [7:0] out;
  
  parameter S0 =  3'b000, S1 =  3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;
  
  always@(a,b,opcode) begin
    case (opcode)
      S0: out = a+b;
      S1: out = a-b;
      S2: out = a&b;
      S3: out = ~(a|b);
      S4: out = a|b;
      S5: out = ~(a&b);
      S6: out = a^b;
      S7: out = ~a;
    endcase
  end
  
endmodule

/*Testbench*/
module alu_tb;
  reg [7:0] a,b;
  reg [2:0] opcode;
  wire [7:0] out;
  
  alu A(a,b,opcode,out);
  
  initial $monitor($time," a = %d, b = %d, opcode = %d, out = %d",a,b,opcode,out);
  
  initial begin
    a = 20; b = 10; opcode = 0;
    #5 opcode = 7;
    #5 opcode = 1;
    #5 opcode = 4;
    #5 opcode = 2;
    #5 opcode = 6;
    #5 opcode = 3;
    #5 opcode = 5;
    #5 $finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
