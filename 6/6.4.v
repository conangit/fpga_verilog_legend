//异步复位同步释放
module sync_async_reset (
    input clk,
    input rst_n,
    input i_a,
    output o_a
    );
    
    reg buffer;
    
    reg reset1;
    reg reset2;
    
    assign o_a = buffer;
    assign rst_in = reset2;
    
    always @(posedge clk or negedge ret_n) begin
        if (!ret_n) begin
            reset1 <= 1'b0;
            reset2 <= 1'b0;
        end
        else begin
            reset1 <= 1'b1;
            reset2 <= reset1;
        end
    end
    
    always @(posedge clk or negedge ret_n) begin
        if (!rst_n) begin
            buffer <= 1'b0;
        end
        else begin
            buffer <= i_a;
        end
    end

endmodule
    