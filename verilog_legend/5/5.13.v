// 绝对值运算模块

module abs (
    input [7:0] signed_vale,
    output reg [6:0] result
    );

    always @(*) begin
        if (signed_value[7]) begin
            result <= (~signed_vale[6:0]) + 7'h01;
        end
        else begin
            result <= signed_vale[6:0];
        end
    end
    
endmodule

// 改进代码
module abs (
    input [7:0] signed_vale,
    output reg [6:0] result
    );

    always @(*) begin
        if (signed_value[7]) begin
            // -128
            if (signed_value[6:0] == 7'000_0000) begin
                result <= 7'h7f;
            end
            else begin
                result <= (~signed_vale[6:0]) + 7'h01;
            end
        end 
        else begin
            result <= signed_vale[6:0];
        end
    end
    
endmodule
