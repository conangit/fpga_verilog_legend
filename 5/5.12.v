module DFF_link_circle (
    input clk,
    input RST_n,
    input [7:0] i_data,
    input i_WR,
    output [7:0] o_data
    );
    
    reg [7:0] dff[3:0];
    integer loop;
    reg old_wr;
    
    // WR = 1, then output constant 0
    // old_wr = 1, WR = 0, hand-over between writing and reading
    assign o_data = (WR | old_wr) ? (8'h00) : (dff[3]);
    
    always @(posedge clk or negedge RST_n) begin
        if (!RST_n) begin
            for (loop = 0; loop <= 3; loop = loop + 1) begin
                dff[loop] <= 8'h00;
            end
        end
        else begin
            dff[0] <= (WR) ? (input) : (dff[3]);
            for (loop = 1; loop <= 3; loop = loop + 1) begin
                dff[loop] <= dff[loop -1];
            end
        end
    end
    
    always @(posedge clk or negedge RST_n) begin
        if (!RST_n) begin
            old_wr <= 1'b0;
        end
        else begin
            old_wr <= WR;
        end
    end
    
endmodule
    
    