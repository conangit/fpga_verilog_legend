module BUS_interface (
    inout [15:0] PCB_DATA_BUS,
    input WR_IN RD_IN,
    output DATA_ENABLE
    );
    
    wire [15:0] in_data;
    wire [15:0] out_data;
    
    assign in_data = PCB_DATA_BUS;
    assign PCB_DATA_BUS = (DATA_ENABLE) ? out_data : 16'hzzzz;
    
endmodule
