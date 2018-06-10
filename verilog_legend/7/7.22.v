module adder_line_generate
    #(parameter WIDTH = 8)
    (
        input [WIDTH - 1:0]a0, a1,
        output [WIDTH:0] sum
    );
    
    wire [WIDTH - 1:0] c;
    
    //other module
    half_adder H(.a0(a0[0]), .a1(a1[0]), .s(sum[0]), .c1(c[0]));
    
    /*
     * full_adder F1(.a0(a0[1]), .a1(a1[1]), .c0(c[0]), .s(sum[1]), .c1(c[1]));
     * full_adder F2(.a0(a0[2]), .a1(a1[2]), .c0(c[1]), .s(sum[2]), .c1(c[2]));
     * ...
     * full_adder F1(.a0(a0[WIDTH - 1]), .a1(a1[WIDTH - 1]), .c0(c[WIDTH - 2]), .s(sum[WIDTH - 1]), .c1(c[WIDTH - 1]));
     */
    
    generate
    begin
        genvar loop;
        begin 
            for (loop = 1; loop < WIDTH; loop = loop + 1)
            begin : FULL_ADDER
                full_adder F(.a0(a0[loop]), .a1(a1[loop]), .c0(c[loop-1]), .s(sum[loop]), .c1(c[loop]));
            end
        end
    end
    endgenerate
    
    assign sum[WIDTH] = c[WIDTH - 1];
    
endmodule

