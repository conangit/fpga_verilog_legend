module event_not_in_logic_1 (
    input clear, none_business,
    output reg result
    );
    
    always @(clear, none_business)
    begin
        result <= clear;
    end
    
endmodule


module event_not_in_logic_2 (
    input clear, none_business,
    output reg result
    );
    
    always @(none_business)
    begin
        result <= clear;
    end
    
endmodule