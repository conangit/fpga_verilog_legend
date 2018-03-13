module arithmetic (
    input [7:0] a0, a1,
    output [7:0] sum,
    output [7:0] min,
    output [7:0] mul,
    output [7:0] div,
    output [7:0] mod,
    output [7:0] pow,
    );
    
    assign sum = a0 + a1;
    assign min = a0 - a1;
    assign mul = a0 * a1;
    assign div = a0 / a1;
    assign mod = a0 % a1;
    assign pow = a0 ** a1;
    
endmodule
    