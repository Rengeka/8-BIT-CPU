module full_adder(
    input  [7:0] a, b,
    input  [3:0] opcode,
    input        cin,
    output [7:0] result, 

    // Flags
    output zero, carry, overflow, negative
    /* 
       overflow is a flag that indicates signed arithmetic overflow.
       It becomes 1 when the result of adding two signed 8-bit numbers
       cannot be represented in 8 bits. This happens when:
       - adding two positive numbers gives a negative result, or
       - adding two negative numbers gives a positive result.
    */
);
    // Initilize
    
    wire [7:0] sum_res;
    wire [7:0] sub_res;

    wire [7:0] bitwise_and_res;
    wire [7:0] bitwise_xor_res;
    wire [7:0] bitwise_or_res;
    wire [7:0] bitwise_not_res;

    wire [7:0] logical_and_res;
    wire [7:0] logical_xor_res;
    wire [7:0] logical_or_res;
    wire [7:0] logical_not_res;

    wire sum_carry;
    wire sub_carry;

    // Act

    assign {sum_carry, sum_res} = a + b + cin;
    assign {sub_carry, sub_res} = a - b;

    // Assigning bitwise results
    assign bitwise_and_res = a & b;
    assign bitwise_xor_res = a ^ b;
    assign bitwise_or_res = a | b;
    assign bitwise_not_res = ~a;                    // Ignoring b

    // Assigning logical results
    assign logical_and_res = (a != 0) && (b != 0); 
    assign logical_or_res  = (a != 0) || (b != 0); 
    assign logical_xor_res = ((a != 0) ^ (b != 0));
    assign logical_not_res = !(a != 0);             // Ignoring b        

    reg [7:0] result_reg;
    reg carry_reg;
    reg overflow_reg;

    // MUX
    always @* begin
        result_reg   = 8'b0;
        carry_reg    = 1'b0;
        overflow_reg = 1'b0;

        case (opcode)
            4'b0000: begin                                                      // ADD
                result_reg   = sum_res;
                carry_reg    = sum_carry;
                overflow_reg = (a[7] == b[7]) && (sum_res[7] != a[7]);
            end
            4'b0001: begin                                                      // SUB
                result_reg   = sub_res;
                carry_reg    = sub_carry;  
                overflow_reg = (a[7] != b[7]) && (sub_res[7] != a[7]);
            end

            4'b0010: result_reg = bitwise_and_res;                              // Bitwise AND
            4'b0011: result_reg = bitwise_or_res;                               // Bitwise OR
            4'b0100: result_reg = bitwise_xor_res;                              // Bitwise XOR
            4'b0101: result_reg = bitwise_not_res;                              // Bitwise NOT

            4'b0110: result_reg = logical_and_res ? 8'b11111111 : 8'b00000000;  // Logical AND
            4'b0111: result_reg = logical_or_res  ? 8'b11111111 : 8'b00000000;  // Logical OR
            4'b1000: result_reg = logical_xor_res ? 8'b11111111 : 8'b00000000;  // Logical XOR
            4'b1001: result_reg = logical_not_res ? 8'b11111111 : 8'b00000000;  // Logical NOT
        endcase
    end

    assign result   = result_reg;
    assign carry    = carry_reg;
    assign overflow = overflow_reg;
    assign zero     = (result_reg == 8'b0);
    assign negative = result_reg[7];

endmodule