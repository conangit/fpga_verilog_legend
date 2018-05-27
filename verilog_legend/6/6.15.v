`timescale 1ns/100ps

module while_normal;

    reg clk;
    reg [3:0] loop_number = 0;
    
    begin
        initial begin
            clk = 0;
            
            while (loop_number < 10) begin
                #10 clk = !clk;
                loop_number = loop_number + 1;
            end
        end
    end
    
endmodule