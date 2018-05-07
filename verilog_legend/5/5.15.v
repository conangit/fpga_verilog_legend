module adder_64bits_seperated_32bits (
    input [63:0] a, b,
    input CLK, input RST_n,
    output reg [63:0] sum,
    output c
    );
    
    reg [31:0] a0, b0;
    reg c0;
    
    reg [31:0] s0;
    wire [32:0] s1;
    
    assign s1 = {1'b0, a0} + {1'b0, b0} + {32'h0000_0000, c0};
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            a0 <= 32'h0000_0000;
            b0 <= 32'h0000_0000;
        end
        else begin
            a0 <= a[63:32];
            b0 <= b[63:32];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            c0 <= 1'b0;
            s0 <= 32'h0000_0000;
        end
        else begin
            {c0, s0} = a[31:0] + b[31:0];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            c <= 1'b0;
            sum <= 64'h0000_0000_0000_0000;
        end
        else begin
            c <= s1[32];
            sum <= {s1[31:0], s0};
        end
    end
    
endmodule

