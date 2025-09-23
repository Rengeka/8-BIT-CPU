`timescale 1ns/1ps

module registry_file_tb;

    reg [2:0] read_reg1;
    reg [2:0] read_reg2;

    wire [7:0] read_data1;
    wire [7:0] read_data2;

    reg [2:0] write_reg;
    reg [7:0] write_data;

    reg write_en;
    reg clk;

    // Instantiate the register file
    registry_file uut (
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),

        .read_data1(read_data1),
        .read_data2(read_data2),

        .write_reg(write_reg),
        .write_data(write_data),

        .write_en(write_en),
        .clk(clk)
    );

    // Clock generator
    initial clk = 0;
    always #5 clk = ~clk;  // 10 ns period

    initial begin
        // Initialize signals
        write_en = 0;
        write_reg = 0;
        write_data = 0;
        read_reg1 = 0;
        read_reg2 = 1;

        #10;
        $display("t=%0t | read_data1=%b read_data2=%b", $time, read_data1, read_data2);

        // Write 0xAA to register 0
        write_en = 1;
        write_reg = 0;
        write_data = 8'hAA;
        #10; // wait one clock cycle
        write_en = 0;

        // Read registers after write
        read_reg1 = 0;
        read_reg2 = 1;
        #10;
        $display("t=%0t | read_data1=%b read_data2=%b", $time, read_data1, read_data2);

        // Write 0x55 to register 1
        write_en = 1;
        write_reg = 1;
        write_data = 8'h55;
        #10;
        write_en = 0;

        // Read registers again
        read_reg1 = 0;
        read_reg2 = 1;
        #10;
        $display("t=%0t | read_data1=%b read_data2=%b", $time, read_data1, read_data2);

        $finish;
    end

endmodule