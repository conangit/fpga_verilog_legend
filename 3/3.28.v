// 2bits 大于比较器
// (a > b) ? 1 : 0

module greater_2bits (
    input [1:0] a, b,
    output result
    );
    
    wire bit1;
    
    assign bit1 = (a[0] == 1 && b[0] == 0) ? 1'b1 : 1'b0;   //低位比较
    assign result = (a[1] == b[1]) ? bit1 : a[1];
    
endmodule

    