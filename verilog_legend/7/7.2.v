//任务与函数结合 计算边长为width的泳池面积

module function_total (
    input clk, rst,
    input [7:0] width,
    output reg[16:0] area
    );
    
    function automatic [15:0] square(input [7:0] width);
    begin
        square = {8'h00, width} * {8'h00, width};
    end
    endfunction
    
    function automatic [15:0] circle(input [7:0] diameter);
    begin
        circle = (24d'201 * {16'h0000, diameter} * {16'h0000, diameter}) / 256;
    end
    endfunction
    
    task automatic total(input [7:0] width, output [16:0] area);
    begin
        area = {1'b0, square(width)} + {1'b0, circle(width)}
    end
    endtask

    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            area <= 17'h0_0000;
        end
        else begin
            total(width, area);
        end
    end

endmodule
