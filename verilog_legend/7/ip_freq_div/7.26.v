//整数分频模块

module int_freqdiv_G1
    #(parameter DIV = 2)
    (
        input clk_in, rst, sync,
        output clk_out
    );
    
    //根据分频系数 计算计算器内D触发器的位宽
    function integer int_log2(input integer num);
    begin
        int_log2 = 1;
        while ((2 ** int_log2) < num) begin
            int_log2 = int_log2 + 1;
        end
    end
    endfunction
    
    localparam REVERSE = (DIV - 2) / 2;
    localparam WIDTH = int_log2(DIV);
    
    reg [WIDTH - 1:0] counter;
    
    always @(posedge clk_in or negedge rst) begin
        if (!rst) begin
            counter <= DIV - 1;
        end
        else if (!SYNC) begin
            counter <= DIV - 1;
        end
        else if (counter == DIV - 1) begin
            counter <= 1'b0;
        end
        else begin
            counter <= counter + 1'b1;
        end
    end
    
    always @(posedge clk_in or negedge rst) begin
        if (!rst) begin
            clk_out <= 1'b0;
        end
        else if (!SYNC) begin
            clk_out <= 1'b0;
        end
        else if ((counter == DIV - 1) || (counter == REVERSE)) begin
            clk_out <= ~clk_in;
        end
    end 
    
endmodule

