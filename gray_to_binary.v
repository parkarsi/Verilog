/*4-bit gray-to-binary converter*/
module gray_to_bin#(parameter SIZE = 4)(gray,bin);
  input [SIZE-1:0] gray;
  output reg [SIZE-1:0] bin;
  reg [SIZE:0] i;
  always@(*)begin
    for (int i=0;i<SIZE;i=i+1) begin
      //bin[i] = ^(gray[SIZE-1:i]);
      bin[i] = ^(gray>>i);
    end
    
  end
endmodule

/*Testbench*/
module gray_to_bin_tb#(parameter SIZE = 4);
  reg  [SIZE-1:0] gray;
  wire [SIZE-1:0] bin;
  
  gray_to_bin GB(gray,bin);
  
  initial $monitor($time," gray %b bin %b",gray,bin);
  initial begin
   gray = 4'b0011;
  end
endmodule

