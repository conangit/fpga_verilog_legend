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
    // 假设每次输入数据均为max 7'b1111_1111, 则128各数据分发给4个源 故(2^8-1)(255) * 2^5(128/4) ≈ 2^13
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
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            data1 <= 8'h00;
            data2 <= 8'h00;
            data3 <= 8'h00;
            data4 <= 8'h00;
        end
        else if (count0 != 8'h00) begin
            case (count0[1:0])
                2'b11: data1<= input_data;  // 对128各输入数据进行分发
                2'b10: data2<= input_data;
                2'b01: data3<= input_data;
                2'b00: data4<= input_data;
            endcase
        end
        else begin
            data1 <= 8'h00;
            data2 <= 8'h00;
            data3 <= 8'h00;
            data4 <= 8'h00;
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            sum1 <= 15'h0000;
            sum2 <= 15'h0000;
            sum3 <= 15'h0000;
            sum4 <= 15'h0000;
        end
        else begin
            case (count0[1:0])
                2'b11: sum1<= sum1 + {7'h00, data1};  // 并行计算
                2'b10: sum2<= sum2 + {7'h00, data2};
                2'b01: sum3<= sum3 + {7'h00, data3};
                2'b00: sum4<= sum4 + {7'h00, data4};
            endcase
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            sum <= 17'h0_0000
        end
        else begin
            sum <= {2'b00, sum1} + {2'b00, sum2} + {2'b00, sum3} + {2'b00, sum4};
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            sum_enable <= 1'b0;
        end
        else if (count1 == 3'b001) begin
            sum_enable <= 1'b1;
        end
        else begin
            sum_enable <= 1'b0;
        end
    end
    
endmodule



