gv `define HIGH_SPEED 150

module adder_4bits_generateif 
    #(
        parameter CLK_FREQUENCY = 100
    )
    (
    inout [3:0] a, b,
    input clk, rst,
    output [3:0] sum,
    output c
    );
    
    generate
    begin
        if (CLK_FREQUENCY > `HIGH_SPEED) begin
            //other module
            adder_4bits_pipeline P1(.a(a), .b(b), .clk(clk), .rst(rst), .sum(sum), .c(c));
        end
        else begin
            //other module
            adder_4bits_combine C1(.a(a), .b(b), .clk(clk), .rst(rst), .sum(sum), .c(c));
        end
    end
    endgenerate
    
endmodule

