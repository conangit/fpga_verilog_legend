`define HIGH_SPEED 150

module adder_4bits_generateifinif (
    input clk, rst,
    input [3:0] a, b,
    output [3:0] sum,
    output c
    );
    
    parameter [8:0] CLK_FRENQUENCY = 100;
    parameter [0:0] HIGH_CHIP = 0;
    localparam [0:0] HIGH_CLK = (CLK_FRENQUENCY > `HIGH_SPEED);
    
    generate
    begin
        case ({HIGH_CLK, HIGH_CHIP})
            2'b01:
            begin
                adder_4bits_combine C1(.a(a), .b(b), .clk(clk), .rst(rst), .sum(sum), .c(c));
            end
            
            default:
            begin
                adder_4bits_pipeline P1(.a(a), .b(b), .clk(clk), .rst(rst), .sum(sum), .c(c));
            end
        endcase
    end
    endgenerate