module decoder(    
    input  [7:0] instr_byte0,  // opcode
    input  [7:0] instr_byte1,  // operand one
    input  [7:0] instr_byte2,  // operand two
    input  [7:0] ext_instr_byte
);

    // [0] [opcode 7 bit]
    // [0] [opcode 7 bit] [operand 8 bit]
    // [0] [opcode 7 bit] [operand 8 bit] [operand 8 bit]
    // [0] [opcode 7 bit] [operand 16 bit]

    // [1] [opcode 7 bit] [operand 16 bit] [operand 8 bit]

    always @* begin

        case (instr_byte0)

            // NOP
            8'b00000000: /*No operation here*/;

            // LOAD 

            // ALU

            8'b00000001: ;  // ADD imm8 imm8
            8'b00000010: ;  // ADD reg8 imm8
            8'b00000011: ;  // ADD reg8 reg8
   
            8'b00010001: ;  // SUB imm8 imm8
            8'b00010010: ;  // SUB reg8 imm8
            8'b00010011: ;  // SUB reg8 reg8

            // STACK

            /*4'b0001: begin                                                     
               
            end*/

            //4'b0010: result_reg = bitwise_and_res;                             
        endcase
    end


endmodule