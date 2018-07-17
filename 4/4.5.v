//与门

module and_gate_95 (
    input a, b,
    output reg result
    );
    
    always@(a or b)
    begin
        result <= a & b;
    end
endmodule

module and_gate_2001_comma (
    input a, b,
    output reg result
    );

    always@(a, b)
    begin
        result <= a & b;
    end
endmodule

module and_gate_2001_star (
    input a, b,
    output reg result
    );

    always@(*)
    begin
        result <= a & b;
    end
endmodule