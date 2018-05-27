//占空比为10%的时钟信号产生模块

`timesacle 1ns/100ps

module clock_test;

    reg clk;
    
    begin
        initial begin
            clk = 0;
            
            forever begin
                #18 clk = !clk;
                #2  clk = !clk;
            end
        end
    end

endmodule