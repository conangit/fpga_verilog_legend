//复数乘法模块

//input statements
//输入数据选择单元
`define REAL_REAL   0
`define IMAGE_IMAGE 1
`define REAL_IMAGE  2
`define IMAGE_REAL  3

//output statements
//输出数据分配单元
`define REAL_1  2
`define REAL_2  3
`define IMAGE_1 4
`define IMAGE_2 5

module complex_mul (
    input CLK, RST_n,
    input signed[3:0] real_a,
    input signed[3:0] image_a,
    input signed[3:0] real_b,
    input signed[3:0] image_b,
    input data_strat,
    output reg signed[7:0] product_real,    //product_real  = real_a*real_b - image_a*image_b
    output reg signed[7:0] product_image,   //product_image = real_a*image_b + image_a*real_b
    );
    
    //当均为正数时 0111(7)  * 0111(7)  = 49(011_0001)  = 7bit
    //当均为负数时 1000(-8) * 1000(-8) = 64(0100_0000) = 8bit
    //此例限定取值范围为[-7,7]
    //7bit(product) + 7bit(product) <= 8bit(product_real/product_image)
    
    reg signed[6:0] real_1, real_2;
    reg signed[6:0] image_1, image_2;
    
    //复用的乘法计算单元
    reg signed[3:0] a, b;
    reg signed[6:0] product;
    
    //调度器--计数器
    reg [2:0] state_counter;
    
    //乘法计算单元
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            product <= 7'h00;
        end
        else begin
            product <= a * b;
        end
    end
    
    //调度器
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            state_counter <= 3'h7;
        end
        else if (data_strat) begin
            state_counter <= 3'h0;
        end
        else begin
            state_counter <= state_counter + 3'h1;
        end
    end
    
    //input part
    //数据输入分配
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            a <= 4'h0;
            b <= 4'h0;
        end
        else begin
            case (state_counter)
                `REAL_REAL:     //结果:实部  计算:实部*实部 状态0
                begin
                    a <= real_a;
                    b <= real_b;
                end
                `IMAGE_IMAGE:   //结果:实部  计算:虚部*虚部 状态1
                begin
                    a <= image_a;
                    b <= image_b;
                end
                `REAL_IMAGE:    //结果:虚部  计算:实部*虚部 状态2
                begin
                    a <= real_a;
                    b <= image_b;
                end
                `IMAGE_REAL:    //结果:虚部  计算:虚部*实部 状态3
                begin
                    a <= image_a;
                    b <= real_b;
                end
            endcase
        end
    end
    
    //output part
    //数据输入分配后端(计算单元前端) 存在一个D触发器 减少毛刺现场
    //故存在一个时钟周期时延 
    //本来"0输入数据 1输出计算结果" 将变为"0输入数据 1采样输入(保持输入) 2输出计算结果" 
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            real_1 <= 7'h00;
            real_2 <= 7'h00;
            image_1 <= 7'h00;
            image_2 <= 7'h00;
        end
        else begin
            case (state_counter)
                `REAL_1:    //状态2
                begin
                    real_1 <= product;
                end
                `REAL_2:    //状态3
                begin
                    real_2 <= product;
                end
                `IMAGE_1:   //状态4
                begin
                    image_1 <= product;
                end
                `IMAGE_2:   //状态5
                begin
                    image_2 <= product;
                end
            endcase
        end
    end

    
    //add part
    always @(posedge CLK or negedge RST_n) begin
        if (!RST_n) begin
            product_real <= 8'h00;
            product_image <= 8'00;
        end
        else begin
            product_real <= real_1 - real_2;
            product_image <= image_1 + image_2;
        end
    end
    
endmodule


