module multiplication_pipeline (
    inout [7:0] a,
    input [7:0] b,
    input CLK, RST_n,
    output [15:0] product
    );
    
    wire [7:0] a0, a1, a2, a3, a4, a5, a6, a7;
    wire [7:0] b0;
    wire [6:0] b1;
    wire [5:0] b2;
    wire [4:0] b3;
    wire [3:0] b4;
    wire [2:0] b5;
    wire [1:0] b6;
    wire b7;
    
    wire [7:0] result1;     // max = 1111_1111 * 1 = 8bit
    wire [9:0] result2;     // max = 1111_1111 * (1<<1) = 9bit + result1 <= 10bit
    wire [10:0] result3;    // max = 8bit * (1<<2) = 10bit + result1 <= 11bit
    wire [11:0] result4;
    wire [12:0] result5;
    wire [13:0] result6;
    wire [14:0] result7;
    wire [15:0] result8;    // max = 8bit * (1<<7) = 15bit + result7 <= 16bit
    
    // 每步逻辑计算的代码实现
    mul_pipe_step1 M1(.CLK(CLK), .RST_n(RST_n), .a_prev(a0), .b_prev(b0), .a_next(a1), .b_next(b1), .result_next(result1));
    mul_pipe_step2 M2(.CLK(CLK), .RST_n(RST_n), .a_prev(a1), .b_prev(b1), .result_prev(result1), .a_next(a2), .b_next(b2), .result_next(result2));
    mul_pipe_step3 M3(.CLK(CLK), .RST_n(RST_n), .a_prev(a2), .b_prev(b2), .result_prev(result2), .a_next(a3), .b_next(b3), .result_next(result3));
    mul_pipe_step4 M4(.CLK(CLK), .RST_n(RST_n), .a_prev(a3), .b_prev(b3), .result_prev(result3), .a_next(a4), .b_next(b4), .result_next(result4));
    mul_pipe_step5 M5(.CLK(CLK), .RST_n(RST_n), .a_prev(a4), .b_prev(b4), .result_prev(result4), .a_next(a5), .b_next(b5), .result_next(result5));
    mul_pipe_step6 M6(.CLK(CLK), .RST_n(RST_n), .a_prev(a5), .b_prev(b5), .result_prev(result5), .a_next(a6), .b_next(b6), .result_next(result6));
    mul_pipe_step7 M7(.CLK(CLK), .RST_n(RST_n), .a_prev(a6), .b_prev(b6), .result_prev(result6), .a_next(a7), .b_next(b7), .result_next(result7));
    mul_pipe_step8 M8(.CLK(CLK), .RST_n(RST_n), .a_prev(a7), .b_prev(b7), .result_prev(result7), .result_next(result8));

    assign a0 = a;
    assign b0 = b;
    assign product = result8;
    
endmodule

//step1
module mul_pipe_step1 (
    input CLK, RST_n,
    input [7:0] a_prev,
    input [7:0] b_prev,
    output reg[7:0] a_next,
    output reg[6:0] b_next,
    output reg[7:0] result_next,
    );
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            a_next <= 8'h00;
            b_next <= 7'h00;
        end
        else begin
            a_next <= a_prev;
            b_next <= b_prev[7:1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            result_next <= 8'h00;
        end
        else if (b_prev[0]) begin
            result_next <= a_prev;
        end
        else begin
            result_next <= 8'h00;
        end
    end
endmodule

//step2
module mul_pipe_step2 (
    input CLK, RST_n,
    input [7:0] a_prev,
    input [6:0] b_prev,
    input [7:0] result_prev,
    output [7:0] a_next,
    output [5:0] b_next,
    output [9:0] result_next,
    );
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            a_next <= 8'h00;
            b_next <= 6'h00;
        end
        else 
            a_next <= a_prev;
            b_next <= b_prev[6:1];
        end
    end

    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            result_next <= 10'h000;
        end
        else if (b_prev[0]) begin
            result_next <= {2'b00, result_prev} + {1'b0, a_prev, 1'b0}; // result = result + a << 1
        end
        else begin
            result_next <= {2'b00, result_prev}; // b_prev[0] = 0情况
        end
    end
endmodule

//step3
module mul_pipe_step3 (
    input CLK, RST_n,
    input [7:0] a_prev,
    input [5:0] b_prev,
    input [9:0] result_prev,
    output [7:0] a_next,
    output [4:0] b_next,
    output [10:0] result_next
    );
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            a_next <= 8'h00;
            b_next <= 5'h00;
        end
        else 
            a_next <= a_prev;
            b_next <= b_prev[5:1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            result_next <= 11'h000;
        end
        else if (b_prev[0]) begin
            result_next <= {1'b0, result_prev} + {1'b0, a_prev, 2'b00}; // result = result + a << 2
        end
        else begin
            result_next <= {1'b0, result_prev};
        end
    end
endmodule

//step4
module mul_pipe_step4 (
    input CLK, RST_n,
    input [7:0] a_prev,
    input [4:0] b_prev,
    input [10:0] result_prev,
    output [7:0] a_next,
    output [3:0] b_next,
    output [11:0] result_next
    );
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            a_next <= 8'h00;
            b_next <= 4'h0;
        end
        else 
            a_next <= a_prev;
            b_next <= b_prev[4:1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            result_next <= 12'h000;
        end
        else if (b_prev[0]) begin
            result_next <= {1'b0, result_prev} + {1'b0, a_prev, 3'b000}; // result = result + a << 3
        end
        else begin
            result_next <= {1'b0, result_prev};
        end
    end
endmodule

//step5
module mul_pipe_step5 (
    input CLK, RST_n,
    input [7:0] a_prev,
    input [3:0] b_prev,
    input [11:0] result_prev,
    output [7:0] a_next,
    output [2:0] b_next,
    output [12:0] result_next
    );
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            a_next <= 8'h00;
            b_next <= 3'h0;
        end
        else 
            a_next <= a_prev;
            b_next <= b_prev[3:1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            result_next <= 13'h0000;
        end
        else if (b_prev[0]) begin
            result_next <= {1'b0, result_prev} + {1'b0, a_prev, 4'b0000}; // result = result + a << 4
        end
        else begin
            result_next <= {1'b0, result_prev};
        end
    end
endmodule

//step6
module mul_pipe_step6 (
    input CLK, RST_n,
    input [7:0] a_prev,
    input [2:0] b_prev,
    input [12:0] result_prev,
    output [7:0] a_next,
    output [1:0] b_next,
    output [13:0] result_next
    );
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            a_next <= 8'h00;
            b_next <= 2'h0;
        end
        else 
            a_next <= a_prev;
            b_next <= b_prev[2:1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            result_next <= 14'h0000;
        end
        else if (b_prev[0]) begin
            result_next <= {1'b0, result_prev} + {1'b0, a_prev, 5'b0_0000}; // result = result + a << 5
        end
        else begin
            result_next <= {1'b0, result_prev};
        end
    end
endmodule

//step7
module mul_pipe_step7 (
    input CLK, RST_n,
    input [7:0] a_prev,
    input [1:0] b_prev,
    input [13:0] result_prev,
    output [7:0] a_next,
    output b_next,
    output [14:0] result_next
    );
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            a_next <= 8'h00;
            b_next <= 1'b0;
        end
        else 
            a_next <= a_prev;
            b_next <= b_prev[1];
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            result_next <= 15'h0000;
        end
        else if (b_prev[0]) begin
            result_next <= {1'b0, result_prev} + {1'b0, a_prev, 6'b00_0000}; // result = result + a << 6
        end
        else begin
            result_next <= {1'b0, result_prev};
        end
    end
endmodule

//step8
module mul_pipe_step8 (
    input CLK, RST_n,
    input [7:0] a_prev,
    input b_prev,
    input [14:0] result_prev,
    output [15:0] result_next
    );
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            result_next <= 16'h0000;
        end
        else if (b_prev) begin
            result_next <= {1'b0, result_prev} + {1'b0, a_prev, 7'b000_0000}; // result = result + a << 7
        end
        else begin
            result_next <= {1'b0, result_prev};
        end
    end
endmodule


