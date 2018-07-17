module case_no_full (
    input [7:0] number,
    input [1:0] select,
    input clk,
    input RST,
    output reg[7:0] result
    )

    always @(posedge clk or negedge RST)
    begin
        if (!RST)
        begin
            result <= 8'b0000_0000;
        end
        else
        begin
            case (select)
            2'b00:
            begin
                result <= number + 8'b0000_0001;
            end
            2'b01:
            begin
                result <= number;
            end
            2'b10:
            begin
                result <= number - 8'b0000_0001;
            end
            endcase
        end
    end
endmodule
