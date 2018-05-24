/*
a << shift_width[2:0] = a << (4shift_width[2]+2shift_width[1]+shift_width[0])

= ( (a<<shift_width[0]) << 2shift_width[1] ) << 4shift_width[2]

*/

module variable_shift_pipeline (
    input clk, rst,
    input [7:0] a,
    input [2:0] shift_width,
    output [7:0] b
    }
    
    wire [2:0] width_0;
    reg [1:0] width_1;
    reg width_2;
    
    wire [7:0] a0;
    reg [7:0] a1, a2, a3;
    
    assign a0 = a;
    assign b = a3;
    
    assign width_0 = shift_width;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            width_1 <= 2'b00;
            width_2 <= 1'b0;
        end
        else begin
            width_1 <= width_0[2:1];
            width_2 <= width_1[1];
        end
    end
    
    //第一步
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            a1 <= 8'h00;
        end
        else if (width_0[0]) begin
            a1 <= a0 << 1;
        end
        else begin
            a1 <= a0;
        end
    end
    
    //第二步
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            a2 <= 8'h00;
        end
        else if (width_1[0]) begin
            a2 <= a1 << 2;
        end
        else begin
            a2 <= a1;
        end;
    end
    
    //第三步
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            a3 <= 8'h00;
        end
        else if (width_2) begin
            a3 <= a2 << 4;
        end
        else begin
            a3 <= a2;
        end
    end
    
endmodule
    
    
 