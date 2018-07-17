//全加器模块
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

//半加器模块
module half_adder (
    input a0, a1,
    output s,
    output c1,
    );
    
full_adder F1 (
    .a0(a0),
    .a1(a1),
    .c0(1'b0),
    .s(s),
    .c1(c1),
    );
    
endmodule

//4bit加法器
module adder_4bit (
    input [3:0] a0, a1,
    output [3:0] sum,
    output c,
    );
    
    wire c0, c1, c2;
    
    half_adder H0(.a0(a0[0]), .a1(a1[0]), .s(sum[0]), .c1(c0),);
    //full_adder F1(.a0(a0[0]), .a1(a1[0]), .c0(1'b0), .s(sum(0), .c1(c0));
  
    full_adder F1(.a0(a0[1]), .a1(a1[1]), .c0(c0), .s(sum(1), .c1(c1));
    full_adder F2(.a0(a0[2]), .a1(a1[2]), .c0(c1), .s(sum(2), .c1(c2));
    full_adder F2(.a0(a0[3]), .a1(a1[3]), .c0(c2), .s(sum(3), .c1(c));
    
endmodule
