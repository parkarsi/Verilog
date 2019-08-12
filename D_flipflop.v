/* D-flipflop with synchronous and asynchronous set,reset,enable*/
/* Behavioral model */

/*Synchrounous*/
module dff(clock,reset,set,enable,d,q,qbar);
  input clock,reset,set,enable,d;
  output reg q,qbar;
  
  always@(posedge clock)begin
    if(reset) begin
      q <= 1'b0;
      qbar <= 1'b0;
    end
    else if(set) begin
      q <= 1'b1;
      qbar <= 1'b1;      
    end
    else if(enable) begin
      q <= d;
      qbar <= ~d;      
    end
  end
    
endmodule

/*Testbench*/
module dff_tb;
  reg clock,reset,set,enable,d;
  wire q,qbar;
  
  dff D(clock,reset,set,enable,d,q,qbar);
  
  initial $monitor($time," reset=%b, set=%b, enable=%b, q=%b, qbar=%b",reset,set,enable,q,qbar);
  
  initial clock = 1'b1;
  always #5 clock = ~clock;
  
  initial begin
    d = 1'b1;
    reset = 1'b1;
    #7 reset = 1'b0;
    enable = 1'b1;
    #10 enable = 1'b0;
    set = 1'b1;
    #10 set = 1'b0;
    #10 enable = 1'b1;
    #10 d = 1'b0;
    #10 $finish;  
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
