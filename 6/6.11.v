//时钟信号产生模块 50%占空比

`timescale 1ns/100ps

module clock_test;
    
    reg clk;
    
    begin
        initial begin
            clk = 0;
            
            forever begin
                #10 clk = !clk;
            end
        end
    end
    
endmodule
    