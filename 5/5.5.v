//可编程定时器


module timer (
    input CLK,
    input RST_n,
    input [7:0] timer_circle,
    input start_flag,
    output reg o_time_over
    );
    
    reg [7:0] counter;
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            counter <= 8'h00;
        end
        else if ((start_flag == 1'b1) && (counter == 8'h00)) begin
            // load original value
            counter <= timer_circle;
        end
        else if (counter != 8'h00) begin
            counter <= counter - 8'h01;
        end
        else begin
        end
    end
    
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            o_time_over <= 1'b0;
        end
        else if (counter == 8'h01) begin
            o_time_over = 1'b1;
        end
        else
            o_time_over = 1'b0;
        end
    end
    
endmodule
    
    