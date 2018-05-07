// 累加器

module sum (
    inout CLK,
    inout RST_n,
    input [7:0] i_data,
    output reg [15:0] o_sum,
    output o_overflow_flag
    );
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            {o_overflow_flag, o_sum} <= 17'h0_0000;
        end
        else if (o_overflow_flag) begin
            {o_overflow_flag, o_sum} <= 17'h0_0000;
        end
        else begin
            {o_overflow_flag, o_sum} <= {o_overflow_flag, o_sum} + {9'h000, data};
        end
    end
    
    
endmodule
    
    

