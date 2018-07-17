//具有时序的任务

`timescale 10ns/100ps

`define REPARE_TIME 3
`define INIT_TIMER 100
`define OFFSET 1

module ROM_task (
    input CLK, RD,
    input [7:0] addr,
    output reg[7:0] data
    );
    
    task automatic init(output reg[7:0] data);
    begin
        data = 8'hff;
        #(`INIT_TIMER) data = 8'hzz;
    end
    endtask
    
    task automatic read(input [7:0] addr, output reg[7:0] data);
    begin
        repeat(`REPARE_TIME) @(posedge CLK);
        data = addr + `OFFSET;
    end
    endtask
    
    initial begin
        init(data);
    end
    
    always @(posedge CLK) begin
        if (RD) begin
            read(addr, data);
        end
    end
    
endmodule

