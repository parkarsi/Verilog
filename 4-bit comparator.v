/*4bit comparator*/
/* example focuses on unsigned comparison*/
module comparator(data1, data2, great, equal,less);
  input [3:0] data1, data2;
  output reg great,equal,less;
  
  //wire signed [3:0] data1,data2; /*for signed comparison*/
  always@(data1,data2)begin
    if(data1 > data2) begin
      great = 1'b1;
      equal = 1'b0;
      less  = 1'b0;
    end
    else if(data1 == data2)begin
      great = 1'b0;
      equal = 1'b1;
      less  = 1'b0;      
    end
    else if(data1 < data2) begin
      great = 1'b0;
      equal = 1'b0;
      less  = 1'b1;      
    end
  end
endmodule

/*Testbench */
module comparator_tb;
  reg [3:0] data1, data2;
  wire great,equal,less;
  
  comparator COMP(data1,data2,great,equal,less);
  
  initial $monitor($time," data1 = %d, data2 = %d, great = %b, equal = %b, less = %b", data1,data2,great,equal,less);
  
  initial begin
    data1 = 10; data2 = 12;
    #10 data1 = 15;
    #10 data2 = 15;

    #10 $finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
