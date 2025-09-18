`timescale 1ns/1ps


module and_gate_tb;
    reg a, b;
    wire y;

    and_gate uut (.a(a), .b(b), .y(y));

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, and_gate_tb);
    end

    initial begin
        $monitor("t=%0dns a=%b b=%b y=%b", $time, a, b, y);
    end

    initial begin
        a = 0; b = 0;
        #10 a = 1;
        #10 b = 1;
        #10 a = 0;
        #10 $finish;
    end
endmodule