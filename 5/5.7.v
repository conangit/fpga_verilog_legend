// 4阶触发器的合并写法

//简单合并
module DFF_link_4 (
    input CLK,
    input RST_n,
    input i_data,
    output o_data
    );
    
    reg dff[3:0];
    
    assign o_data = dff[3];
    
    always @(posedge CLK or negedge RST_n) begin
        if (RST_n == 1'b0) begin
            dff[0] <= 1'b0;
            dff[1] <= 1'b0;
            dff[2] <= 1'b0;
            dff[3] <= 1'b0;
        end
        else begin
            dff[0] <= i_data;
            dff[1] <= dff[0];
            dff[2] <= dff[1];
            dff[3] <= dff[2];
        end
    end
    
endmodule


// {}拼接操作合并
module DFF_link_4 (
    input CLK,
    input RST_n,
    input i_data,
    output o_data
    );
    
    reg dff[3:0];
    
    assign o_data = dff[3];
    
    always @(posedge CLK or negedge RST_n) begin
        if (RST_n == 1'b0) begin
            {dff[0],dff[1],dff[2],dff[3]} <= 4'b0000;
        end
        else begin
            {dff[0],dff[1],dff[2],dff[3]} <= {i_data,dff[0],dff[1],dff[2]};
        end
    end
    
endmodule

