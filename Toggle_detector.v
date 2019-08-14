/*Toggle detector using FSM*/
/*S0 and S1 state*/
module detector(clock, reset,x,z);
  input clock,reset,x;
  output reg z;
  
  reg state, next_state;
  parameter S0=1'b0, S1=1'b1;
  
  always@(posedge clock) begin
    if(reset) begin
      state <= 'b0;
      next_state <= 'b0;
    end else state <= next_state;
  end
  
  always@(state,x) begin
    case(state)
      S0: if(x) next_state <= S1;
      else next_state <= S0;
      S1: if(x) next_state <= S1;
      else next_state <= S0;
      default: next_state <= S0;
    endcase
  end
  
  always@(x,state) begin
    case(state)
      S0: if(x) z=1;
      else z = 0;
      S1: if(x) z = 0;
        else z=1;
    endcase
  end
  
endmodule

/*Testbench*/
module detector_tb;
  reg clock, reset, x;
  wire z;
  
  detector D(clock,reset,x,z);
  
  initial clock = 1'b1;
  
  always #5 clock = ~clock;
  
  initial $monitor($time,"x=%b, state = %b, next_state=%b, z=%b",x,D.state,D.next_state,z);
  initial 
    begin
      reset = 1'b1;
      x = 1'b1;
      #10 reset = 'b0;
      x = 1'b1;
      #10 x = 'b0;
      #10 x = 'b0;
      #10 x = 'b1;
      #10 $finish;
    end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
