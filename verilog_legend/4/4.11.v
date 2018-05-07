//多路选择转换为编码器 

//串行结构
module coder_4_2_serial (
    input [1:0] index,
    output reg[3:0] result
    )
    
    always @(*)
    begin
        if (index == 2'b00)
        begin
            result <= 4b'0001;
        end
        else if (index == 2'b01)
        begin
            result <= 4'b0010;
        end
        else if (index == 2'b10)
        begin
            result <= 4'b0100;
        end
        else
        begin 
            result <= 4'b1000;
        end
    end
endmodule


//并行结构
module coder_4_2_parallel (
    input [1:0] index,
    output reg[3:0] result
    )

    always @(*)
    begin
        if (index[1])
        begin
            if (index[0])
            begin
                result <= 4'b1000;
            end
            else
            begin
                result <= 4'b0100;
            end
        end
        else
        begin
            if (index[0])
            begin
                result <= 4'b0010;
            end
            else
            begin
                result <= 4'b0000;
            end
        end
    end
endmodule


