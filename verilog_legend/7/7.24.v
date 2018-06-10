//位宽参数化的加法链--全加器/半加器合并

module adder_line_generate
    #(parameter WIDTH = 8)
    (
        input [WIDTH - 1:0]a0, a1,
        output [WIDTH:0] sum
    );
    
    generate
    begin
        genvar loop;
        for (loop = 0; loop < WIDTH; loop = loop + 1);
        begin : ADDER
            wire c;     //本质上为ADDER[loop].c
            if (loop == 0) begin
                half_addrer h(.a0(a0[loop]), .a1(a1[loop]), .s(sum[loop]), .c1(c));
            end
            else begin
                full_adder f(.a0(a0[loop]), .a1(a1[loop]), .c0(ADDER[loop-1].c), .s(sum[loop]), .c1(c));
            end
        end
    end
    endgenerate
    
    assign sum[WIDTH] = ADDER[WIDTH - 1].c;

endmodule

