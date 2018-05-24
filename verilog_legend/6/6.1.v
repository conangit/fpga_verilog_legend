//主模块
module reset_recovery (
    input CLK,
    input PCB_RST,
    output reg reset
    );
    
    wire time_start;    //定时器启动
    wire time_on;       //20ms计时到达 输出0
    
    timer_20ms (.CLK(CLK), .start(time_start), .on(time_on));
    
    //当detected为1时，即检测到首次上升沿，则开始启动定时器 
    //短暂20ms内 time_on输出为1 则enable为0 暂时不再检测信号沿
    edge_detect E1(.CLK(CLK), .i_signal(PCB_RST), .enable(~time_on), .detected(time_start));

    always @(posedge CLK) begin
        reset <= ~time_on;
    end
endmodule

//定时器模块
module timer_20ms (
    input CLK,
    input start,
    output reg on
    );
    
    `define NUMBER_20MS 100_000
    
    reg [16:0] counter;
    
    always @(posedge CLK) begin
        on <= (counter != 0);
    end
    
    always @(posedge CLK) begin
        if (start) begin
            counter <= `NUMBER_20MS;
        end
        else if (counter != 0)
            counter <= counter -1;
        end
        else begin
        end
    end
endmodule

//边沿(上升沿)检测模块
module edge_detect (
    input CLK,
    input i_signal,
    input enable,
    output reg detected
    );
    
    reg i_delay;
    
    //delay 1 clock for input signal
    always @(posedge CLK) begin
        i_delay <= i_signal;
    end
    
    always @(posedge CLK) begin
        if (enable) begin
            detected <= (i_delay == 1'b1) && (i_signal == 1'b0);
        end
        else begin
            detected <= 1'b0;
        end
    end
endmodule


