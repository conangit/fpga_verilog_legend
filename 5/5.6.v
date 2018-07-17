// 4级D触发器

module DFF_link_4 (
    input CLK,
    input RST_n,
    input i_data,
    output o_data
    );
    
    // 数组
    reg dff[3:0];
    
    assign o_data = dff[3];
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            dff[0] <= 1'b0;
        end
        else begin
           dff[0] <= i_data;
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            dff[1] <= 1'b0;
        end
        else begin
           dff[1] <= dff[0];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            dff[2] <= 1'b0;
        end
        else begin
           dff[2] <= dff[1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            dff[3] <= 1'b0;
        end
        else begin
           dff[3] <= dff[2];
        end
    end
    
endmodule

