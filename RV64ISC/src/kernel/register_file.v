module register_file(
    input  wire         clk,
    input  wire         reset,
    input  wire         we,         // write enable
    input  wire  [4:0]  waddr,      // write address (5 bit for 32 registers)
    input  wire  [63:0] wdata,      // write data

    input  wire  [4:0]  raddr1,     
    output wire  [63:0] rdata1,    

    input  wire  [4:0]  raddr2,     
    output wire  [63:0] rdata2  
);
    reg [63:0] regs [31:0];

    assign rdata1 = (raddr1 != 0) ? regs[raddr1] : 64'b0; 
    /* 
        Register x0 is allways 0
        It is present here as an element of array, but in fact will disappear after synthesis
        It will not affect cpu performance and physical layout
    */
    assign rdata2 = (raddr2 != 0) ? regs[raddr2] : 64'b0;

    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 1; i < 32; i = i + 1)
                regs[i] <= 64'b0;
        end else if (we && (waddr != 0)) begin
            regs[waddr] <= wdata; 
        end
    end

endmodule