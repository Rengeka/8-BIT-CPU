module base_alu(
    input  wire [63:0] op1, op2,
    input  wire [3:0]  alu_ctrl,

    output wire [63:0] result
);
    reg [63:0] base_result;

    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;

    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_NOT  = 4'b0101;

    localparam ALU_SLT  = 4'b0110;  // set less than (signed)
    localparam ALU_SLTU = 4'b0111;  // set less than (unsigned)

    localparam ALU_SLL  = 4'b1000;  // shift left logical
    localparam ALU_SRL  = 4'b1001;  // shift right logical
    localparam ALU_SRA  = 4'b1010;  // shift right arithmetic

    always @* begin
        case (alu_ctrl)
            ALU_ADD: base_result = op1 + op2;
            ALU_SUB: base_result = op1 - op2;
            ALU_AND: base_result = op1 & op2;
            ALU_OR:  base_result = op1 | op2;
            ALU_XOR: base_result = op1 ^ op2;
            ALU_NOT: base_result = ~op1;
            ALU_SLT: base_result = ($signed(op1) < $signed(op2)) ? 64'd1 : 64'd0;
            ALU_SLTU: base_result = (op1 < op2) ? 64'd1 : 64'd0;
            ALU_SLL: base_result = op1 << op2[5:0]; 
            ALU_SRL: base_result = op1 >> op2[5:0];
            ALU_SRA: base_result = $signed(op1) >>> op2[5:0];
            default: base_result = 64'b0;
        endcase
    end

    assign result = base_result;

endmodule