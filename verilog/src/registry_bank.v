module register_bank(
    input [7:0]     data_in,
    input [2:0]     reg_sel,  
    input           clk,
    input           en,
    output [7:0]    data_out
);
    reg [7:0] Q[7:0]; 

    always @(posedge clk) begin
        if (en)
            Q[reg_sel] <= data_in;
    end

    assign data_out = Q[reg_sel];

endmodule