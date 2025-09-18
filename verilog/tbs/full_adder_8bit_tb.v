`timescale 1ns/1ps

module full_adder_tb;
    reg  [7:0] a, b;
    reg  [3:0] opcode;
    reg        cin;
    wire [7:0] result;
    wire       zero, carry, overflow, negative;

    full_adder uut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .cin(cin),
        .result(result),
        .zero(zero),
        .carry(carry),
        .overflow(overflow),
        .negative(negative)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, full_adder_tb);
    end

    initial begin
        $monitor("t=%0dns | a=%b b=%b cin=%b opcode=%b -> result=%b | Z=%b C=%b V=%b N=%b",
                  $time, a, b, cin, opcode, result, zero, carry, overflow, negative);
    end

    initial begin
        // ADD
        a = 8'd10; b = 8'd20; cin = 0; opcode = 4'b0000; #10;
        a = 8'd127; b = 8'd1;  cin = 0; opcode = 4'b0000; #10;  // overflow
        a = 8'd200; b = 8'd100; cin = 0; opcode = 4'b0000; #10; // carry

        // SUB 
        a = 8'd50; b = 8'd20; opcode = 4'b0001; #10;
        a = 8'd20; b = 8'd50; opcode = 4'b0001; #10; // borrow -> carry

        // Bitwise 
        a = 8'b10101010; b = 8'b11001100; opcode = 4'b0010; #10; // AND
        opcode = 4'b0011; #10; // OR
        opcode = 4'b0100; #10; // XOR
        opcode = 4'b0101; #10; // NOT

        // Logical 
        a = 8'd0; b = 8'd5; opcode = 4'b0110; #10; // logical AND
        opcode = 4'b0111; #10; // logical OR
        opcode = 4'b1000; #10; // logical XOR
        opcode = 4'b1001; #10; // logical NOT

        #10 $finish;
    end
endmodule