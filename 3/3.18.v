module full_adder (
    input a0, a1,
    input c0,
    output s,
    output c1,
    )
    
    assign {c1, s} = a0 + a1 + c0;
    
endmodule
