//16bit数据的可变移位操作 0~15位移位

module variable_shift_16bit (
    input clk, rst,
    input [15:0] a,
    input [3:0] width,
    output [15:0] b
    );
    
    //存储每步数据输入
    wire [15:0] a0;
    reg [15:0] a1, a2, a3, a4;
    
    //处理每步移位操作
    wire [3:0] width0;
    reg [2:0] width1;
    reg [1:0] width2;
    reg width3;
    
    assign a0 = a;
    assign b = a4;
    assign width0 = width;
    
    always @(posedge clk or negedge ret) begin
        if (!rst) begin
            width1 <= 3'b000;
            width2 <= 2'b00;
            width3 <= 1'b0;
        end
        else begin
            width1 <= width0[3:1];
            width2 <= width1[2:1];
            width3 <= width2[1];
        end
    end
    
    //第一步
    always @(posedge clk or negedge ret) begin
        if (!rst) begin
            a1 <= 16'h0000;
        end
        else if (width0[0]) begin
            a1 <= a0 << 1;
        end
        else begin
            a1 <= a0;
        end
    end
    
    //第二步
    always @(posedge clk or negedge ret) begin
        if (!rst) begin
            a2 <= 16'h0000;
        end
        else if (width1[0]) begin
            a2 <= a1 << 2;
        end
        else begin
            a2 <= a1;
        end
    end
    
    //第三步
    always @(posedge clk or negedge ret) begin
        if (!rst) begin
            a3 <= 16'h0000;
        end
        else if (width2[0]) begin
            a3 <= a2 << 4;
        end
        else begin
            a3 <= a2;
        end
    end
    
    //第四步
    always @(posedge clk or negedge ret) begin
        if (!rst) begin
            a4 <= 16'h0000;
        end
        else if (width2[0]) begin
            a4 <= a3 << 8;
        end
        else begin
            a4 <= a3;
        end
    end
    
endmodule

