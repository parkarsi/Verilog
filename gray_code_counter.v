/* 4-bit gray-code counter*/
module gray_code_counter(clock,reset,out);
  input  clock,reset;
  output reg [3:0] out;
  
  reg [4:0] i;
  reg q0,q1,q2;
  reg [3:0] count;

  always@(posedge clock) begin
    if(reset) begin
      out = 0;
      count = 0;
    end else begin
     // for (i = 0;i<16;i=i+1)begin
      
      count = count +1;
      q0 = count[0]^count[1];
      q1 = count[1]^count[2];
      q2 = count[2]^count[3];
      out = {count[3],q2,q1,q0};
    //  end
    end
  end
endmodule

/*Testbench*/
module gray_code_counter_tb;
  reg  clock,reset;
  wire [3:0] out;
  
  gray_code_counter GC(clock,reset,out);
  
  initial $monitor($time," out = %b", out);
  
  initial clock = 1'b1;
  always #5 clock = ~clock;
  
  initial begin
    reset = 1'b1;
    #5 reset = 1'b0;
    #500 $finish;
  end
endmodule
