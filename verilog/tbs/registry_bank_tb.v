`timescale 1ns / 1ps

module register_bank_tb;

    reg [7:0] data_in;
    reg [2:0] reg_sel;
    reg clk;
    reg en;
    wire [7:0] data_out;

    register_bank uut (
        .data_in(data_in),
        .reg_sel(reg_sel),
        .clk(clk),
        .en(en),
        .data_out(data_out)
    );

    // Tact generator
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns

    initial begin
        // Init
        data_in = 8'b00000000;
        reg_sel = 3'b000;
        en = 0;

        // waiting 10 tacts
        #10;

        // Registry 0
        data_in = 8'hAA;  // 10101010
        reg_sel = 3'b000;
        en = 1;
        #10;

        // Registry 3
        data_in = 8'h55;  // 01010101
        reg_sel = 3'b011;
        en = 1;
        #10;

        // Registry 7
        data_in = 8'hFF;
        reg_sel = 3'b111;
        en = 1;
        #10;

        // Reading values
        en = 0;
        reg_sel = 3'b000;
        #10;
        $display("R0 = %b", data_out);

        reg_sel = 3'b011;
        #10;
        $display("R3 = %b", data_out);

        reg_sel = 3'b111;
        #10;
        $display("R7 = %b", data_out);

        $finish;
    end

endmodule