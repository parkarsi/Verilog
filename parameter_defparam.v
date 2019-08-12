/*Parameter and defparam*/
module arith(
    A,
    B,
    C,
    D,
    Sum,
    Product
    );

    parameter size_adder = 4;
    parameter size_mult = 4;
    
    input [size_adder-1 : 0] A,B;
     input [size_mult-1 : 0] C,D;
    output [size_adder : 0] Sum;
    output [size_mult*2-1 : 0] Product;
    wire [size_adder : 0] Sum;
    wire [size_mult*2-1 : 0] Product;  
    assign Sum = A+B;
    assign Product = C*D;
    
endmodule

//Instantiation method 1: module instance parameter value assignment
//In this method the parameter value is changed using a '#' operator at the time of instantiation. 

module tb_arith;
    reg [7:0] A,B;
    reg [5:0] C,D;
    wire [8:0] Sum;
    wire [11:0] Product;

    //Value '8' will be passed to the first parameter defined which is size_adder.
    //Value '6' will be passed to the second parameter defined which is size_mult.
    arith #(8,6) uut1 (
        .A(A), 
        .B(B), 
        .C(C),
        .D(D),
        .Sum(Sum),
        .Product(Product)
    );

    initial begin
        A = 34;     B = 45;     C = 10;     D = 50;     #100;
        A = 255;        B = 255;        C = 20;     D = 60;     #100;
        A = 121;        B = 13;     C = 30;     D = 10;     #100;
        A = 200;        B = 200;        C = 40;     D = 20;     #100;
    end
      
endmodule

//Instantiation method 2: Using defparam keyword

module tb_arith;

    reg [7:0] A,B;
    reg [5:0] C,D;
    wire [8:0] Sum;
    wire [11:0] Product;


    arith uut1 (
        .A(A), 
        .B(B), 
        .C(C),
        .D(D),
        .Sum(Sum),
        .Product(Product)
    );
    
    //pass new values to the parameter here. 
    defparam uut1.size_adder = 8;
    defparam uut1.size_mult = 6;

    initial begin
        
        A = 34;     B = 45;     C = 10;     D = 50;     #100;
        A = 255;        B = 255;        C = 20;     D = 60;     #100;
        A = 121;        B = 13;     C = 30;     D = 10;     #100;
        A = 200;        B = 200;        C = 40;     D = 20;     #100;
    end
      
endmodule
