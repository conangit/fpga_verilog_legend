`timescale 1ns/100ps

module repeat_normal;

    reg clk;
    
    begin
        initial begin
            clk = 0;
            
            repeat(10) begin
                #10 clk = !clk;
            end
        end
    end

endmodule