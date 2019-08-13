/*binary to BCD*/
/* Double dabble algorithm or shift-and-add-3 algo */

module double_dabble(input_bin, output_bin);
  input [7:0] input_bin;
  output reg [11:0] output_bin;
  reg [3:0] i;
  always@(input_bin) begin
   output_bin = 0;
    for(i=0;i<8;i=i+1)begin
      output_bin = {output_bin[10:0],input_bin[7-i]};
      if(output_bin[3:0]>4 && i<7)
        output_bin[3:0] = output_bin[3:0]+3;
      if(output_bin[7:4]>4 && i<7)
        output_bin[7:4] = output_bin[7:4]+3;
      if(output_bin[11:8]>4 && i<7)
        output_bin[11:8] = output_bin[11:8]+3;
    end
  end
endmodule

/*Testbench*/
module double_dabble_tb;
  reg [7:0] input_bin;
  wire [11:0] output_bin;
  
  double_dabble DD(input_bin, output_bin);
  initial $monitor($time," output_bin = %b input_bin = %b",output_bin,input_bin);
  initial begin
    input_bin = 8'b11110011;
    #10; 
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
