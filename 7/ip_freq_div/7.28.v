//分数分频代码

module frac_freqdiv 
    #(parameter DIV_IN = 3, DIV_OUT = 2)
    (
        input clk_in, rst,
        output clk_out
    );
    
    localparam N = DIV_IN / DIV_OUT;
    localparam DIV_X = DIV_IN - DIV_OUT * N;
    localparam DIY_Y = DIV_OUT;
    localparam M1 = DIY_Y - DIV_X;
    localparam M2 = DIV_X;
    
    localparam CLK_M1 = M1 * N;
    localparam CLK_M2 = M2 * (N+1);
    
    localparam CLK_NUMBER = CLK_M1 + CLK_M2;
    
    localparam WIDTH = int_log2(CLK_NUMBER);
    
    
    function integer int_log2(input integer num);
    begin
        int_log2 = 1;
        while ((2 ** int_log2) < num) begin
            int_log2 = int_log2 + 1;
        end
    end
    endfunction
    
    reg [WIDTH - 1:0] counter;
    wire c1, c2;
    wire sync1, sync2;
    reg clk_selection;
    
    int_freqdiv #(.DIV(N)) I1(.clk_in(clk_in), .rst(rst), .sync(sync1), .clk_out(c1));
    int_freqdiv #(.DIV(N+1)) I2(.clk_in(clk_in), .rst(rst), .sync(sync2), .clk_out(c2));
    
    assign clk_out = clk_selection ? c1 : c2;
    
    assign sync1 = (counter < CLK_M1);
    assign sync2 = ~sync1;  //在CLK_M1 ~ CLK_M2之间
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            counter <= 1'b0;
        end
        else if (counter == CLK_NUMBER - 1) begin
            counter <= 1'b0;
        end
        else begin
            counter <= counter + 1'h0;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            clk_selection <= 1'b0;
        end
        else begin
            clk_selection <= sync1;
        end
    end
    
    //或者
    /*
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            clk_selection <= 1'b0;
        end
        else if (counter < CLK_M1) begin
            clk_selection <= 1'b1;
        end
        else begin
            clk_selection <= 1'b0;
        end
    end
    */
    
endmodule
    
