//forvevr会永远占用仿真资源

`timescale 1ns/100ps

module clock_block_test;

    reg clk;
    reg clk_blocked;
    
    begin
        initial begin
            clk = 0;
            clk_blocked = 0;
            
            forever begin
                #10 clk = !clk;
            end
            
            #100 clk_blocked = !clk_blocked;
        end
    end
    
endmodule

/*
原本设想同时产生时钟 控制clk_blocked信号在100ns从0变为1
但块forever永远执行 占用全部仿真资源 导致clk_blocked永远为0
*/