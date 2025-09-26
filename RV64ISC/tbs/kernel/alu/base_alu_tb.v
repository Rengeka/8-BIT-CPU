`timescale 1ns / 1ps

module tb_base_alu;

    reg  [63:0] op1, op2;
    reg  [3:0]  alu_ctrl;
    wire [63:0] result;

    base_alu uut (
        .op1(op1),
        .op2(op2),
        .alu_ctrl(alu_ctrl),
        .result(result)
    );

    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_NOT  = 4'b0101;
    localparam ALU_SLT  = 4'b0110;
    localparam ALU_SLTU = 4'b0111;
    localparam ALU_SLL  = 4'b1000;
    localparam ALU_SRL  = 4'b1001;
    localparam ALU_SRA  = 4'b1010;

    initial begin
        $display("Starting base_alu testbench...");

        // ADD
        op1 = 64'd10; op2 = 64'd15; alu_ctrl = ALU_ADD;
        #10;
        $display("ADD: %d + %d = %d", op1, op2, result);

        // SUB
        op1 = 64'd20; op2 = 64'd5; alu_ctrl = ALU_SUB;
        #10;
        $display("SUB: %d - %d = %d", op1, op2, result);

        // AND
        op1 = 64'hF0F0; op2 = 64'h0FF0; alu_ctrl = ALU_AND;
        #10;
        $display("AND: 0x%h & 0x%h = 0x%h", op1, op2, result);

        // OR
        op1 = 64'hF0F0; op2 = 64'h0FF0; alu_ctrl = ALU_OR;
        #10;
        $display("OR: 0x%h | 0x%h = 0x%h", op1, op2, result);

        // XOR
        op1 = 64'hFF00; op2 = 64'h0FF0; alu_ctrl = ALU_XOR;
        #10;
        $display("XOR: 0x%h ^ 0x%h = 0x%h", op1, op2, result);

        // NOT
        op1 = 64'hFF00; alu_ctrl = ALU_NOT;
        #10;
        $display("NOT: ~0x%h = 0x%h", op1, result);

        // SLT (signed)
        op1 = -64'd5; op2 = 64'd3; alu_ctrl = ALU_SLT;
        #10;
        $display("SLT: %d < %d = %d", op1, op2, result);

        // SLTU (unsigned)
        op1 = 64'd5; op2 = 64'd3; alu_ctrl = ALU_SLTU;
        #10;
        $display("SLTU: %d < %d = %d", op1, op2, result);

        // SLL (shift left logical)
        op1 = 64'd1; op2 = 64'd4; alu_ctrl = ALU_SLL;
        #10;
        $display("SLL: %d << %d = %d", op1, op2, result);

        // SRL (shift right logical)
        op1 = 64'd16; op2 = 64'd2; alu_ctrl = ALU_SRL;
        #10;
        $display("SRL: %d >> %d = %d", op1, op2, result);

        // SRA (shift right arithmetic)
        op1 = -64'd16; op2 = 64'd2; alu_ctrl = ALU_SRA;
        #10;
        $display("SRA: %d >>> %d = %d", op1, op2, result);

        $display("Testbench finished.");
        $finish;
    end

endmodule