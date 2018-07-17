//本地参数的比特序列检测单元--二段式
//参照例子6.9

`define SYNC_CODE 4'b1001

module sequence_detect (
    input clk, rst,
    input data,
    output reg detected
    );
    
    localparam STATE_IDLE = 0;
    localparam STATE_BIT0 = 1;
    localparam STATE_BIT1 = 2;
    localparam STATE_BIT2 = 3;
    localparam STATE_BIT3 = 4;
    
    reg [3:0] state;
    wire [3:0] detecting_sequence;
    
    assign detecting_sequence = `SYNC_CODE;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= STATE_IDLE;
        end
        else begin
            case (state)
                STATE_IDLE:
                begin
                    if (data == detecting_sequence[0]) begin
                        state <= STATE_BIT0;
                    end
                    else begin
                        state <= STATE_IDLE;
                    end
                end
                
                STATE_BIT0:
                begin
                    if (data == detecting_sequence[1]) begin
                        state <= STATE_BIT1;
                    end
                    else begin
                        state <= STATE_IDLE;
                    end
                end

                STATE_BIT1:
                begin
                    if (data == detecting_sequence[2]) begin
                        state <= STATE_BIT2;
                    end
                    else begin
                        state <= STATE_IDLE;
                    end
                end

                STATE_BIT2:
                begin
                    if (data == detecting_sequence[3]) begin
                        state <= STATE_BIT3;
                    end
                    else begin
                        state <= STATE_IDLE;
                    end
                end

                STATE_BIT3:
                begin
                    state <= STATE_IDLE;
                end
                
                default:
                begin
                    state <= STATE_IDLE;
                end
            endcase
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            detected <= 1'b0;
        end
        else if (state == STATE_BIT3) begin
            detected <= 1'b1;
        end
        else begin
            detected <= 1'b0;
        end
    end
    
endmodule


    
    