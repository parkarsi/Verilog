/*Fibonnachi series*/
module fib(clock,reset,user_input,fib_output);
  input clock,reset;
  input [7:0] user_input;
  output reg [19:0] fib_output;
  reg [7:0] counter;
  reg ready;
  reg [19:0] prev_state, next_state;
  always@(reset) begin
        prev_state <= 'd0;
        next_state <= 'd1;
        counter <= 'd1;
        //ready <= 0;
      end
  always@(posedge clock)
   begin
      
          next_state <= next_state + prev_state;
          prev_state <= next_state;
          counter <= counter + 'd1;
      // $display("%d",next_state);
     if(counter == (user_input-1)) begin 
          ready <= 1;
        end
        else ready<=0;
      
    end
  
  assign fib_output = next_state;
  always@(ready) begin
    if(ready) $display("%d %d",user_input,fib_output);
  end
endmodule

/*Testbench*/
module fib_tb;
    reg clock,reset;
  reg [7:0] user_input;
  wire [19:0] fib_output;
  
  fib F(clock,reset,user_input,fib_output);
  initial clock = 1'b1;
  always #2 clock = ~clock;
  
  initial begin
    reset = 1'b1;
    user_input = 'd5;
    #3 reset = 1'b0;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
