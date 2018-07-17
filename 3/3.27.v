//4线-2线优先编码器

module decode_4_2 (
    input s1, s2, s3, s4,
    output [1:0] decode,
    output legal
    );
    
    wire [1:0] dec1, dec2, dec3;
    
    assign dec1 = 2'b00;
    assign dec2 = s2 ? 2'b01 : dec1;
    assign dec3 = s3 ? 2'b10 : dec2;
    assign decode = s4 ? 2'b11 : dec3;
    
    assign legal = |({s4, s3, s2, s1});     //利用缩减或 判断是否全为0

endmodule
