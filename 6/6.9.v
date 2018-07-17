//比特序列检测单元--二段式有限状态机

//state defination
`define STATE_IDLE 0
`define STATE_BIT0 1
`define STATE_BIT1 2
`define STATE_BIT2 3
`define STATE_BIT3 4

//sequence to be detected
`define SYNC_CODE 4'b1001

module sequence_detect (
    input clk,
    input rst_n,
    input data,
    output reg detected
    );
    
    reg [3:0] state;
    wire [3:0] detecting_sequence;
    
    assign detecting_sequence = `SYNC_CODE;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= `STATE_IDLE;
        end
        else begin
            case (state)
                `STATE_IDLE :
                    begin
                        if (data == detecting_sequence[0]) begin
                            state <= `STATE_BIT0;
                        end
                        else begin
                        end
                    end
                 
                 `STATE_BIT0 :
                    begin
                        if (data == detecting_sequence[1]) begin
                            state <= `STATE_BIT1;
                        end
                        else begin
                            state <= `STATE_IDLE;
                        end
                    end
                    
                `STATE_BIT1 :
                    begin
                        if (data == detecting_sequence[2]) begin
                            state <= `STATE_BIT2;
                        end
                        else begin
                            state <= `STATE_IDLE;
                        end
                    end

                `STATE_BIT2 :
                    begin
                        if (data == detecting_sequence[3]) begin
                            state <= `STATE_BIT3;
                        end
                        else begin
                            state <= `STATE_IDLE;
                        end
                    end
                
                //小心
                `STATE_BIT3 :
                    begin
                        state <= `STATE_IDLE;
                    end
                    
                default :
                    begin
                        state <= `STATE_IDLE;
                    end
            endcase
        end
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            detected <= 1'b0;
        end
        else if (state == `STATE_BIT3) begin
            detected <= 1'b1;
        end
        else begin
            detected <= 1'b0;
        end
    end

endmodule

