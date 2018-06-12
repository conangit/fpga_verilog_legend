//任意分频系数的整数分频模块

module int_freqdiv
    #(parameter DIV = 2)
    (
        input clk_in, rst, sync,
        output clk_out
    );
    
    generate 
    begin
        if (DIV <= 1) begin
            assign clk_out = clk_in && rst;     //原始时钟直连 不需要同步sync信号参与
        end
        else begin
            int_freqdiv_G1 #(.DIV(DIV)) g(.clk_in(clk_in), .rst(rst), .sync(sync), .clk_out(clk_out));
        end
    end
    endgenerate
    
endmodule

