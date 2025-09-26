`timescale 1ns / 1ps

module tb_alu;

    reg  [63:0] op1, op2;
    reg  [3:0]  alu_ctrl;
    wire [63:0] result;
    wire        zero;

    alu uut (
        .op1(op1),
        .op2(op2),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
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
        $display("Starting ALU testbench...");

        // ADD
        op1 = 64'd10; op2 = 64'd15; alu_ctrl = ALU_ADD;
        #10;
        $display("ADD: %d + %d = %d, zero=%b", op1, op2, result, zero);

        // SUB (not zero result)
        op1 = 64'd20; op2 = 64'd5; alu_ctrl = ALU_SUB;
        #10;
        $display("SUB: %d - %d = %d, zero=%b", op1, op2, result, zero);

        // SUB (zero result)
        op1 = 64'd5; op2 = 64'd5; alu_ctrl = ALU_SUB;
        #10;
        $display("SUB: %d - %d = %d, zero=%b", op1, op2, result, zero);

        // AND
        op1 = 64'hF0F0; op2 = 64'h0FF0; alu_ctrl = ALU_AND;
        #10;
        $display("AND: 0x%h & 0x%h = 0x%h, zero=%b", op1, op2, result, zero);

        // OR
        op1 = 64'hF0F0; op2 = 64'h0FF0; alu_ctrl = ALU_OR;
        #10;
        $display("OR: 0x%h | 0x%h = 0x%h, zero=%b", op1, op2, result, zero);

        // XOR
        op1 = 64'hFF00; op2 = 64'h0FF0; alu_ctrl = ALU_XOR;
        #10;
        $display("XOR: 0x%h ^ 0x%h = 0x%h, zero=%b", op1, op2, result, zero);

        // NOT
        op1 = 64'hFF00; alu_ctrl = ALU_NOT;
        #10;
        $display("NOT: ~0x%h = 0x%h, zero=%b", op1, result, zero);

        // SLT (signed)
        op1 = -64'd5; op2 = 64'd3; alu_ctrl = ALU_SLT;
        #10;
        $display("SLT: %d < %d = %d, zero=%b", op1, op2, result, zero);

        // SLTU (unsigned)
        op1 = 64'd5; op2 = 64'd3; alu_ctrl = ALU_SLTU;
        #10;
        $display("SLTU: %d < %d = %d, zero=%b", op1, op2, result, zero);

        // SLL
        op1 = 64'd1; op2 = 64'd4; alu_ctrl = ALU_SLL;
        #10;
        $display("SLL: %d << %d = %d, zero=%b", op1, op2, result, zero);

        // SRL
        op1 = 64'd16; op2 = 64'd2; alu_ctrl = ALU_SRL;
        #10;
        $display("SRL: %d >> %d = %d, zero=%b", op1, op2, result, zero);

        // SRA
        op1 = -64'd16; op2 = 64'd2; alu_ctrl = ALU_SRA;
        #10;
        $display("SRA: %d >>> %d = %d, zero=%b", op1, op2, result, zero);

        $display("Testbench finished.");
        $finish;
    end
endmodule