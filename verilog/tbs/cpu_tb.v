`timescale 1ns/1ps

module cpu_tb;

    // -------------------
    // Clock & Reset
    // -------------------
    reg clk;
    reg reset;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period => 100MHz
    end

    cpu cpu_inst(
        .clk(clk),
        .reset(reset)
    );


    initial begin
        $display("Starting CPU testbench...");

        reset = 1;
        #20;
        reset = 0;

        cpu_inst.ram_inst.mem_array[0] = 8'h00; // NOP
        cpu_inst.ram_inst.mem_array[1] = 8'h00; // NOP
        cpu_inst.ram_inst.mem_array[2] = 8'h00; // NOP
        cpu_inst.ram_inst.mem_array[3] = 8'h00; // NOP

        // Run for 20 clock cycles
        repeat (20) @(posedge clk);

        // Display register values
        $display("R0 = %h", cpu_inst.regfile_inst.Q[0]);
        $display("R1 = %h", cpu_inst.regfile_inst.Q[1]);
        $display("PC = %h", cpu_inst.pc_inst.pc);

        $finish;
    end

endmodule
