
module program_counter_tb;
    reg     [15:0]  next_pc;
    wire    [15:0]  pc;
    reg             clk;
    reg             reset;

    program_counter uut (
        .next_pc(next_pc),
        .pc(pc),
        .reset(reset),
        .clk(clk)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, program_counter_tb);
    end

    initial begin
        $monitor("t=%0dns | next_pc=%016b | pc=%016b | reset=%b",
                  $time, next_pc, pc, reset);
    end

    initial clk = 0;
    always #5 clk = ~clk;  // 10 ns period

    initial begin

        reset = 1;
        next_pc = 16'h1111;
        @(posedge clk);  
        
        reset = 0;
        next_pc = 16'h1111;
        @(posedge clk);  
        next_pc = 16'h2222;
        @(posedge clk);
        next_pc = 16'h3333;
        @(posedge clk);

        $finish;
    end
endmodule