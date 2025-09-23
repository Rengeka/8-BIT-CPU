`timescale 1ns/1ps

module registry_file_tb;

    // Clock
    reg clk;

    // ALU signals
    wire [7:0] a, b;            // Inputs from registry file
    reg  [3:0] opcode;
    reg        cin;
    wire [7:0] alu_result;
    wire       zero, carry, overflow, negative;

    // Registry File signals
    reg  [2:0] read_reg1, read_reg2;
    reg  [2:0] write_reg;
    reg  [7:0] write_data;
    reg        write_en;

    // ALU instance
    alu alu (
        .a(a),
        .b(b),
        .opcode(opcode),
        .cin(cin),
        .result(alu_result),
        .zero(zero),
        .carry(carry),
        .overflow(overflow),
        .negative(negative)
    );

    // Registry File instance
    registry_file rf (
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .read_data1(a),
        .read_data2(b),
        .write_reg(write_reg),
        .write_data(write_data),
        .write_en(write_en),
        .clk(clk)
    );

    // Clock generator
    initial clk = 0;
    always #5 clk = ~clk;  // 10 ns period

    // Dump waveform
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, registry_file_tb);
    end

    // Monitor signals
    initial begin
        $monitor("t=%0dns | clk=%b | read_data1=%b read_data2=%b | a=%b b=%b cin=%b opcode=%b -> result=%b | Z=%b C=%b V=%b N=%b",
                 $time, clk, a, b, a, b, cin, opcode, alu_result, zero, carry, overflow, negative);
    end

    // Test sequence
    initial begin
        // Initialize
        write_en = 0;
        write_reg = 0;
        write_data = 0;
        read_reg1 = 0;
        read_reg2 = 1;
        opcode = 4'b0000;
        cin = 0;

        #10;

        // Write 0xAA to register 0
        write_en = 1;
        write_reg = 0;
        write_data = 8'hAA;
        #10;
        write_en = 0;

        // Read registers and perform ADD
        read_reg1 = 0;
        read_reg2 = 1;
        opcode = 4'b0000; // ADD
        #10;

        // Write 0x55 to register 1
        write_en = 1;
        write_reg = 1;
        write_data = 8'h55;
        #10;
        write_en = 0;

        // Read registers again and perform ADD
        read_reg1 = 0;
        read_reg2 = 1;
        opcode = 4'b0000; // ADD
        #10;

        $finish;
    end

endmodule