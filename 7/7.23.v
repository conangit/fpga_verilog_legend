module top_DFF_chain_generate (
    input in,
    input clk, rst,
    output delay1, delay2
    );
    
    localparam TAP1 = 5;
    localparam TAP2 = 7;
    
    //other module
    DFF_chain_generate #(.TAP(TAP1))  D1(.in(in), .clk(clk), .rst(rst), .delayed(delay1));
    DFF_chain_generate #(.TAP(TAP2))  D2(.in(in), .clk(clk), .rst(rst), .delayed(delay2));
    
endmodule


module DFF_chain_generate (
    input in,
    input clk, rst,
    output delayed
    );
    
    parameter TAP = 3;
    
    reg [TAP -1:0] D;
    
    assign delayed = D[TAP -1];
    
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            D[0] <= 1'b0;
        end
        else begin
            D[0] <= in;
        end
    end
    
    generate
    begin
        genvar loop;
        for (loop = 1; loop < TAP; loop = loop + 1)
        begin : delay
            always @(posedge clk or negedge rst) begin
                if (!rst) begin
                    D[loop] <= 1'b0;
                end
                else begin
                    D[loop] <= D[loop - 1];
                end
            end
        end
    end
    endgenerate
    
    