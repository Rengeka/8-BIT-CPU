`timescale 1ns/1ps

module cpu(
    input clk,
    input reset
);
    wire [15:0] pc;
    reg  [15:0] next_pc;

    program_counter pc_inst(
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    wire [7:0] instr_byte0, instr_byte1, instr_byte2, instr_byte3;

    ram_emu ram_inst(
        .clk(clk),
        .we(1'b0),          
        .addr(pc),
        .din(8'b0),
        .dout(instr_byte0)    
    );

    wire [7:0] instr_byte1_r = ram_inst.mem_array[pc+1];
    wire [7:0] instr_byte2_r = ram_inst.mem_array[pc+2];
    wire [7:0] instr_byte3_r = ram_inst.mem_array[pc+3];

    wire [6:0] opcode;
    wire is_ext;

    decoder decoder_inst(
        .instr_byte0(instr_byte0),
        .instr_byte1(instr_byte1_r),
        .instr_byte2(instr_byte2_r),
        .instr_byte3(instr_byte3_r)
    );

    assign is_ext = instr_byte0[7];
    assign opcode = instr_byte0[6:0];

    wire [2:0] reg1 = instr_byte1_r[7:5]; 
    wire [2:0] reg2 = instr_byte1_r[4:2];
    wire [2:0] reg_dest = instr_byte1_r[1:0];

    wire [7:0] reg_a, reg_b;
    wire [7:0] alu_result;

    registry_file regfile_inst(
        .read_reg1(reg1),
        .read_reg2(reg2),
        .read_data1(reg_a),
        .read_data2(reg_b),
        .write_reg(reg_dest),
        .write_data(alu_result),
        .write_en(1'b1),  
        .clk(clk)
    );

    wire zero, carry, overflow, negative;

    alu alu_inst(
        .a(reg_a),
        .b(reg_b),
        .opcode(opcode[3:0]),
        .cin(1'b0),
        .result(alu_result),
        .zero(zero),
        .carry(carry),
        .overflow(overflow),
        .negative(negative)
    );

    always @* begin
        next_pc = pc + 1;
    end

endmodule