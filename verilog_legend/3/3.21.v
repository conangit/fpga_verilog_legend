module multiply_constant_17_concatenation (
    input [7:0] a,
    output [15:0] mul
    );

    assign mul = {4'b0000, a, 4'b0000} + {8'h00, a};        // mul = a * 17
    
endmodule
