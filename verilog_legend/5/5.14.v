
/*******************************************/
// 基础模块 全加器/半加器
module full_adder (
    input a0, a1,
    input c0,
    output s,
    output c1,
    );
    
    wire t1, t2, t3;
    
    assign s = (a0 ^ a1) ^ c0;
    
    assign t1 = a0 & c0;
    assign t2 = a1 & c0;
    assign t3 = a0 & a1;
    assign c1 = (t1 | t2) | t3;
    
endmodule

module half_adder (
    input a0, a1,
    output s,
    output c1,
    );
    
full_adder F0 (
    .a0(a0),
    .a1(a1),
    .c0(1'b0),
    .s(s),
    .c1(c1),
    );
    
endmodule
/*******************************************/
//4bit位宽流水线加法器
module adder_4bits_pipeline (
    input [3:0] a,
    input [3:0] b,
    input CLK,
    input RST_n,
    output [3:0] sum,
    output c
    );
    
    reg [2:0] i_a1, i_b1;
    reg [1:0] i_a2, i_b2;
    reg i_a3, i_b3;
    
    reg D_c0, D_c1, D_c2;
    
    reg o_s0;
    reg [1:0] o_s1;
    reg [2:0] o_s2;
    
    wire s0, s1, s2, s3;
    wire c0, c1, c2, c3;
    
    half_adder H0(.a0(a[0], .a1(b[0]), .s(s0), .c1(c0));
    full_adder F1(.a0(i_a1[0]), .a1(i_b1[0]), .c0(D_c0), .s(s1), .c1(c1));
    full_adder F2(.a0(i_a2[0]), .a1(i_b2[0]), .c0(D_c1), .s(s2), .c1(c2));
    full_adder F3(.a0(i_a3), .a1(i_b3), .c0(D_c2), .s(s3), .c1(c3));
    
    assign sum = {s3,o_s2};
    assign c = c3;
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            i_a1 <= 3'b000;
            i_b1 <= 3'b000;
        end
        else begin
            i_a1 <= a[3:1];
            i_b1 <= b[3:1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            i_a2 <= 2'b00;
            i_b2 <= 2'b00;
        end
        else begin
            i_a2 <= i_a1[2:1];
            i_b2 <= i_a1[2:1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            i_a3 <= 1'b0;
            i_b3 <= 1'b0;
        end
        else begin
            i_a3 <= i_a1[1];
            i_bb <= i_a1[1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            {D_c0, D_c1, D_c2} = 3'b000;
        end
        else begin
            D_c0 <= c0;
            D_c1 <= c1;
            D_c2 <= c2;
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            o_s0 <= 1'b0;
            o_s1 <= 2'b00;
            o_s2 <= 3'b000;
        end
        else begin
            o_s0 <= s0;
            o_s1 <= {s1, o_s0};
            o_s2 <= {s2, o_s1};
        end
    end
    
endmodule

