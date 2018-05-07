//case分支语句

module coder_4_2_case (
    input [1:0] index,
    output [3:] result
    )
    
    always @(*)
    begin
        case (index)
        2'b00:
        begin
            result <= 4'b0000;
        end
        2'b01:
        begin
            result <= 4'b0010;
        end
        2'b10:
        begin
            result <= 4'b0100;
        end
        2'b11:
        begin
            result <= 4'b1000;
        end
        endcase
    end
endmodule