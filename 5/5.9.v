// for循环实现4阶D触发器

module DFF_link_for (
    input CLK,
    input RST_n,
    input i_data,
    input o_data
    );
    
    reg dff[3:0];
    integer loop;
    
    assign o_data  = dff[3];
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            for (loop  = 0; loop < 4; loop = loop + 1) begin
                dff[loop] <= 1'b0;
            end
        end
        else begin
            dff[0] <= i_data;
            for (loop = 1; loop < 4; loop = loop +1) begin
                dff[loop] = dff[loop - 1];
            end
        end
    end
    
endmodule

