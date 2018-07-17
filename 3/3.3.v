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
    
full_adder F1 (
    .a0(a0),
    .a1(a1),
    .c0(1'b0),
    .s(s),
    .c1(c1),
    );
    
endmodule