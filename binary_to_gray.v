/*4-bit binary to gray converter*/
module bin_to_gray#(parameter SIZE = 4)(bin,gray);
  input [SIZE-1:0] bin;
  output reg [SIZE-1:0] gray;
  reg [SIZE:0] i;
  always@(*)begin
    for (int i=0;i<SIZE-1;i=i+1) begin
      //bin[i] = ^(gray[SIZE-1:i]);
      gray[i] = bin[i]^bin[i+1];
    end
    gray[SIZE-1] = bin[SIZE-1];
    
  end
endmodule

/*other method and simple*/
module bin_to_gray#(parameter SIZE = 4)(bin,gray);
  input [SIZE-1:0] bin;
  output reg [SIZE-1:0] gray;

  assign gray = (bin>>1)^bin;

endmodule

/*Testbench*/
module bin_to_gray_tb#(parameter SIZE = 4);
  reg  [SIZE-1:0] bin;
  wire [SIZE-1:0] gray;
  
  bin_to_gray BG(bin,gray);
  
  initial $monitor($time," bin %b gray %b",bin,gray);
  

  
  initial begin
   bin = 4'b1000;
  end
endmodule
