// 并行化累加器:定时器数值控制采样相位

module sum_parallel_timer (
    input [7:0] input_data,
    input data_start,
    input CLK, RST_n,
    output reg[16:0] sum,
    output reg sum_enable
    );
    
    reg [7:0] count0;
    reg [2:0] count1;
    
    reg [7:0] data1, data2, data3, data4;
    reg [14:0] sum1, sum2, sum3, sum4;
    
    // 8bits timer
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            count0 <= 8'h00;
        end
        else if (data_start) begin
            count0 <= 8'h7f + 8'h04;    // constant 4 is for 4 clock for last 4 data input
        end
        else if (count0 != 8'h00) begin
            count0 <= count0 - 8'h01;
        end
        else begin
            count0 <= 8'h00;
        end
    end
    
    // 3bits timer
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            count1 <= 3'b000;
        end
        else if (count0 == 8'h01) begin
            count1 <= 3'b111;
        end
        else if (count1 != 3'b000) begin
            count1 <= count1 - 3'b001;
        end
        else begin
            count1 <= 3'b0000;
        end
    end
    
    
    
    

