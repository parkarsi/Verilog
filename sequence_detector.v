/*Pattern 10110*/

module seq_detector(x,reset,clock,z);
  input reset,clock,x;
  output reg z;
  
  
  parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
  reg [2:0] next_state,state;
  
  always@(posedge clock) begin
    if(reset) begin
      next_state <= S0;
      state <= S0;end
    else state<=next_state;
  end
    
  always@(x ,state) begin
      case(state)
        S0: begin if(x) next_state<=S1;
        else next_state<=S0; 
        end
        S1: begin if(x) next_state<=S1;
        else next_state<=S2; 
        end
        S2: begin if(x) next_state<=S3;
        else next_state<=S0; 
        end
        S3: begin if(x) next_state<=S4;
        else next_state<=S2; 
        end
        S4: begin if(x) next_state<=S1;
        else next_state<=S2; 
        end       
        default: next_state <= S0;
      endcase     
    end
    
    always@(x,state) begin
      case(state)
        S4: if(x) z = 0;
        else z = 1;
        S0,S1,S2,S3: z= 0;
        default: z=0;
      endcase
      
    end
  
endmodule

/*Testbench*/
module seq_detector_tb;
  reg x,reset,clock;
  wire z;
  
  seq_detector SD(x,reset,clock,z);
  
  initial $monitor($time, "x= %b, z = %b, state = %b, next_state = %b",x,z,SD.state,SD.next_state);
  
  initial clock = 1'b1;
  always #2 clock = ~clock;
  
  initial begin
   reset = 1'b1;
    #3 reset = 1'b0;
      x = 1;
    #8 x = 0;
    #4 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
