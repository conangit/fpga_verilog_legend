//可变位宽加法器

module add_flexible_biterwidth (
    clk,
    rst,
    a,
    b,
    result
    );
    
    parameter WIDTH_A = 8;
    parameter WIDTH_B = 8;
    
    localparam WIDTH_OUT = 1 + (((WIDTH_A) > (WIDTH_B)) ? (WIDTH_A) : (WIDTH_B));
    
    input clk, rst;
    input [WIDTH_A - 1:0] a;
    input [WIDTH_B - 1:0] b;
    output reg [WIDTH_OUT - 1:0] result;
    
    assign result = {{(WIDTH_OUT - WIDTH_A){1'b0}}, a} + {{(WIDTH_OUT - WIDTH_B){1'b0}}, b};
    
endmodule
