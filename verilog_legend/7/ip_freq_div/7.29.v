/*
 * 考虑各种输入情况
 * 不合理 输出原始时钟
 *      DIV_IN < DIV_OUT 倍频
 *      DIV_OUT <= 0
 * 合理 整数分频
 *      DIV_OUT = 1 且 DIV_IN > 0
 * 合理 分数分频
 *      DIV_OUT > 1 且 DIV_IN >= DIV_OUT
 * 
 * 
 */
 
module freqdiv 
    #(parameter DIV_IN = 3, DIV_OUT = 2)
    (
        input clk_in,
        input rst,
        output clk_out
    );
    
    localparam IILEGAL = ((DIV_IN < DIN_OUT) || (DIN_OUT <= 0));
    localparam INT_FREQDIV = ((DIV_OUT == 1) && (DIV_IN > 0));
    
    generate 
    begin
        case ({IILEGAL, INT_FREQDIV})
            2'b00 :
            begin
                frac_freqdiv #(.DIV_IN(DIV_IN), .DIV_OUT(DIV_OUT)) F(.clk_in(clk_in), .rst(rst), .clk_out(clk_out));
            end
            
            2'b01 :
            begin
                int_freqdiv #(.DIV(DIV_IN)) I(.clk_in(clk_in), .rst(rst), .clk_out(clk_out));
            end
            
            default :
            begin
                assign clk_out = clk_in && rst;
            end
        endcase
    end
    endgenerate
    
endmodule

