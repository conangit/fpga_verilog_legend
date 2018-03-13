/*
 * wire assign 实现全加器
 * 
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
*/

module full_adder (
    input a0, a1,
    input c0,
    output reg s,
    output reg c1
    );
    
    wire t1, t2, t3;
    
    always@(*)
    begin
        s <= (a0 ^ a1) ^ c0;
    end
    
    assign t1 = a0 & c0;
    assign t2 = a1 & c0;
    assign t3 = a0 & a1;
    
    always@(*)
    begin
        c1 <= (t1 | t2) | t3;
    end
    
endmodule