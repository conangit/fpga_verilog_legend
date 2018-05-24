//主模块
module reset_recovery (
    input CLK,
    input PCB_RST,
    output reg reset    //输入到芯片RST的复位信号
    );
    
    wire time_start;    //定时器启动
    wire time_on;       //20ms计时到达 输出1
    
    timer_20ms (.CLK(CLK), .start(time_start), .on(time_on));
    
    //一旦检测到电平变化 即当detected为1时，即检测到首次上升沿，则(触发定时器动作)开始启动定时器 
    //短暂20ms内 time_on输出为0 则enable为0 暂时不再检测信号沿
    //若20ms后 detected再次为1 说明按键释放还未稳定 则将再次启动定时器 如此循环下去 知道复位信号有效
    edge_detect E1(.CLK(CLK), .i_signal(PCB_RST), .enable(time_on), .detected(time_start));

    //检测到按键松开(首次出现上升沿) 到20ms内 reset = 0
    //20ms后按键释放 reset = 1
    always @(posedge CLK) begin
        reset <= time_on;
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
        on <= (counter == 0);       //计时到达 输出为1
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


