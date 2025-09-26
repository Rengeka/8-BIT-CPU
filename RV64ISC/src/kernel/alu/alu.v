module alu(
    input  wire [63:0] op1, op2,
    input  wire [3:0]  alu_ctrl,

    output wire [63:0] result,
    output wire        zero                
);
    wire [63:0] base_result;

    base_alu base_alu_inst (
        .op1(op1),
        .op2(op2),
        .alu_ctrl(alu_ctrl),
        .result(base_result)
    );

    assign result = base_result;

    assign zero = (base_result == 64'b0);

endmodule