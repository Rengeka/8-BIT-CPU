module registry_file(
    input  [2:0] read_reg1,
    input  [2:0] read_reg2,

    output [7:0] read_data1,
    output [7:0] read_data2,

    input  [2:0] write_reg,
    input  [7:0] write_data,

    input        write_en,
    input        clk
);
    reg [7:0] Q[7:0]; 

    // Synchronous writing
    always @(posedge clk) begin
        if (write_en)
            Q[write_reg] <= write_data;
    end

    // Asynchronous reading
    assign read_data1 = Q[read_reg1];
    assign read_data2 = Q[read_reg2];

endmodule