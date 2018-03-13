//四选一数据选择器

module selector_2bits (
    input [7:0] a0, a1, a2, a3,
    input [1:0] select,
    output [7:0] result
    );
    
    wire [7:0] mid_num_bit1;
    wire [7:0] mid_num_bit0;
    
    assign mid_num_bit1 = select[0] ? a3 : a2;
    assign mid_num_bit0 = select[0] ? a1 : a0;
    
    assign result = select[1] ? mid_num_bit1 : mid_num_bit0;
    
endmodule
