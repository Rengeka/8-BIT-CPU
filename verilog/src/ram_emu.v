module ram_emu(
    input            clk,
    input            we,        
    input  [15:0]    addr,
    input  [7:0]     din,      
    output [7:0]     dout      
);
    reg [7:0] mem_array [0:65535];  // 64KB RAM

    assign dout = mem_array[addr];

    always @(posedge clk) begin
        if (we)
            mem_array[addr] <= din;
    end
endmodule