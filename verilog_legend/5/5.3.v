//计数器

//不带溢出保护功能
module counter (
    input CLK,
    input RST,
    input enable,
    output reg[7:0] counter
    );
    
    always @(*)
    begin
        if (!RST) begin
            counter <= 8'h00;
        end
        else if (enable) begin
            counter <= counter + 8'h001;
            else begin
            end
        end
    end
endmodule

//带溢出保护功能
module counter (
    input CLK,
    input RST,
    input enable,
    output reg [7:0] counter,
    output reg overflow_flag
    );
    
    always @(*) begin
        if (!RST) begin
            {overflow_flag, counter} <= 9'h000;
        end
        else if (overflow_flag) begin
            {overflow_flag, counter} <= 9'h000;
        end
        else if (enable) begin
            {overflow_flag, counter} <= {overflow_flag, counter} + 9'h001; 
        end
        else begin
        end
    end
endmodule

