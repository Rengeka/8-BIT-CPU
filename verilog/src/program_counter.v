module program_counter(    
    input                  clk,
    input                  reset,  
        
    input          [15:0]  next_pc,
    output  logic  [15:0]  pc          // 16-bit register for 64KB programs
);
    always @(posedge clk or posedge reset)
        if (reset)
            pc <= 16'h0000;
        else
            pc <= next_pc;

endmodule