`define WIDTH_1 8
`define WIDTH_2 4
`define WIDTH_3 3

`define MAX_1 200
`define MAX_2 13
`define MAX_3 5

module top_counter_parameter (
    input clk, rst,
    output [`WIDTH_1 - 1:0] counter1,
    output [`WIDTH_2 - 1:0] counter2,
    output [`WIDTH_3 - 1:0] counter3
    );
    
    counter_parameter C1(.clk(clk), .rst(rst), .counter(counter1));
    
    //模块参数传递形式一
    counter_parameter C2(.clk(clk), .rst(rst), .counter(counter2));
    defparam C2.WIDTH = `WIDTH_2, C2.MAX_VALUE = `MAX_2;
    
    //模块参数传递形式二
    counter_parameter #(.WIDTH(`WIDTH_3), .MAX_VALUE(`MAX_3)) C3(.clk(clk), .rst(rst), .counter(counter3));
    
    //模块参数传递形式三 -- 不建议
    //counter_parameter #(`WIDTH_3, `MAX_3) C3(.clk(clk), .rst(rst), .counter(counter3));
    
endmodule

module counter_parameter
    #(
        parameter WIDTH = 8, 
        parameter MAX_VALUE = 200
    )
    (
        input clk, rst,
        output reg[`WIDTH -1:0] counter
    );

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            counter <= 1'h0;
        end
        else if (counter < MAX_VALUE) begin
            counter <= counter + 1'h1;
        end
        else begin
            counter <= 1'h0;
        end
    end

endmodule

