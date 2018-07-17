module multiply_constant_17_concatenation (
    input [7:0] a,
    output [15:0] mul
    );

    wire [8:0] sum_mid;
    
    assign sum_mid = {1'b0, a} + {5'b0_0000, a[7:4]};
    assign mul = {3'b000, sum_mid, a[3:0]};
    
endmodule
