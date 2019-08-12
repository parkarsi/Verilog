/*Digital Clock*/
module digital_clock(clock,reset,sec,min,hr);
  input clock,reset;
  output reg [5:0] sec, min;
  output reg [4:0] hr;
  
  always@(posedge clock or posedge reset) begin
    if(reset) begin
      sec = 0;
      min = 0;
      hr  = 0;
    end else if(clock)
      begin
        sec = sec + 1;
        if(sec == 60) begin
          min = min + 1;
          sec = 0;
          if(min == 60) begin
            min = 0;
            hr = hr + 1;
            if (hr == 24) begin
              hr = 0;
              min = 0;
              sec = 0;
            end
          end
        end
      end
  end
endmodule

/*Testbench*/
module digital_clock_tb;
  
  reg clock,reset;
  wire [5:0] sec, min;
  wire [4:0] hr;
  
  digital_clock DC(clock,reset,sec,min,hr);
  
  initial $monitor($time," hr = %d min = %d sec =%d",hr,min,sec);
  initial clock = 1'b1;
  always #2 clock = ~clock;
  initial begin
    reset = 1'b1;
    #3 reset = 1'b0;
    #1000000 $finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
