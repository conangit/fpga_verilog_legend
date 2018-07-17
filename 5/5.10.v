// 8bit位宽度输入 4阶D触发器

module DFF_link_4_8bits (
    input CLK,
    input RST_n;
    input [7:0] i_data,
    output [7:0] o_data
    )
    
    reg [7:0] dff [3:0];
    integer loop;
    
    assign o_data = dff[3];
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            for (loop = 0; loop < 4; loop = loop + 1) begin
                dff[loop] <= 8'h00;
            end
        end
        else begin
            dff[0] <= i_data;
            for (loop = 1; loop < 4; loop = loop + 1) begin
                dff[loop] <= dff[loop - 1];
            end
        end
    end
    
endmodule


    