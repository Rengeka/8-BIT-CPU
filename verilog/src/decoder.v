module decoder(    
    input  [7:0] instr_byte0,  // 1 bit flag + 7 bit opcode
    input  [7:0] instr_byte1,  
    input  [7:0] instr_byte2,  
    input  [7:0] instr_byte3 
);
    /* 
       [1 bit is extended flag] 
       [opcode 7 bit] 
       [2 bit mod]      OR      [operand 8 bit]
       [reg 3 bit]          
       [reg 3 bit] 

       [optional 8 bit]
       [optional 8 bit]
    */

    wire is_ext = instr_byte0[7];
    wire opcode = instr_byte0[6:0];

    localparam [2:0] 
        R0 = 3'b000, R1 = 3'b001, R2 = 3'b010, R3 = 3'b011,
        R4 = 3'b100, R5 = 3'b101, R6 = 3'b110, R7 = 3'b111;

    localparam [2:0]
        ER0 = 3'b000,  // R1:R0 - 16-bit reg
        ER1 = 3'b001,
        ER2 = 3'b010,
        ER3 = 3'b011,
        SP  = 3'b100,  // Stack Pointer
        PC  = 3'b101;  // Program Counter

    always @* begin

        case (opcode)

            // NOP
            8'b0000000: /*No operation here*/;

            // LOAD 


            // ALU

            /*  
                [0] [opcode 7 bit] [2 bit mod] [reg 3 bit] [reg 3 bit]

                ADD examples:

                ADD R4 R7       -> [0 000 0001 00 101 111]                         2 byte
                ADD R4 imm8     -> [0 000 0001 01 101 000 1001 1011]               3 byte
                ADD R4 [R7]     -> NOT AVAILABLE
                ADD R4 mem16    -> [0 000 0001 11 101 000 1001 1011 0010 1011]     4 byte    

                [1] [opcode 7 bit] [2 bit mod] [reg 3 bit] [reg 3 bit]

                ADD ER1 ER3     -> [1 000 0001 00 001 011]                         2 byte
                ADD ER1 imm16   -> [1 000 0001 01 001 000 1011 1001 1110 1111]     4 byte
                ADD ER1 [ER3]   -> [1 000 0001 10 001 011]                         2 byte
                ADD ER1 mem8    -> [1 000 0001 11 001 000 1001 1101 1101 1111]     4 byte

                mods: 
                    00 - reg reg
                    01 - reg imm
                    10 - reg [reg]
                    11 - reg mem
            */

            // ADD
            8'b0000001: ; 

            // SUB
            8'b0000010: ;

            /*
                [0] [opcode 7 bit] [2 bit mod] [1 bit is bitwise flag] [reg 3 bit] [00] [reg 3 bit] [00000]     3 byte

                LXOR examples:

                LXOR R4 R7       -> [0 000 0010 00 0 101 00 111 00000]               3 byte
                LXOR R4 imm8     -> [0 000 0010 01 0 101 00 1001 1011]               3 byte
                LXOR R4 [R7]     -> NOT AVAILABLE
                LXOR R4 mem8     -> [0 000 0010 11 0 101 00 1001 1011 0010 1011]     4 byte   

                BXOR examples:
                                
                BXOR R4 R7       -> [0 000 0010 00 1 101 00 111 00000]               3 byte
                BXOR R4 imm8     -> [0 000 0010 01 1 101 00 1001 1011]               3 byte
                BXOR R4 [R7]     -> NOT AVAILABLE
                BXOR R4 mem8     -> [0 000 0010 11 1 101 00 1001 1011 0010 1011]     4 byte  

                [1] [opcode 7 bit] [2 bit mod] [reg 3 bit] [reg 3 bit]

                LXOR examples:

                LXOR ER1 ER3     -> [1 000 0010 00 0 001 00 011 00000]                3 byte
                LXOR ER1 imm16   -> [1 000 0010 01 0 001 00 1011 1001 1110 1111]      4 byte
                LXOR ER1 [ER3]   -> [1 000 0010 10 0 001 00 011 00000]                3 byte                                    
                LXOR ER1 mem16   -> [1 000 0010 11 0 001 00 1001 1101 1101 1111]      4 byte 

                BXOR examples:

                BXOR ER1 ER3     -> [1 000 0010 00 1 001 00 011 00000]                3 byte
                BXOR ER1 imm16   -> [1 000 0010 01 1 001 00 1011 1001 1110 1111]      4 byte
                BXOR ER1 [ER3]   -> [1 000 0010 10 1 001 00 011 00000]                3 byte
                BXOR ER1 mem16   -> [1 000 0010 11 1 001 00 1001 1101 1101 1111]      4 byte 
            */

            // XOR
            8'b0000010: ;

            // AND
            8'b0000011: ;

            // OR
            8'b0000100: ;

            /*
                [0] [opcode 7 bit] [2 bit mod] [1 bit is bitwise flag] [reg 3 bit] [00] [reg 3 bit] [00000]     3 byte

                LNOT examples:

                LNOT R4          -> [0 000 0101 00 0 101 00]                         2 byte
                LNOT imm8        -> NOT AVAILABLE                                    
                LNOT [R4]        -> NOT AVAILABLE
                LNOT mem8        -> [0 000 0101 11 0 00000 1001 1011 0010 1011]      4 byte   

                BNOT examples:
                                
                BNOT R4          -> [0 000 0101 00 1 101 00]                         3 byte
                BNOT imm8        -> NOT AVAILABLE                                    
                BNOT [R4]        -> NOT AVAILABLE
                BNOT mem8        -> [0 000 0101 11 1 0000 1001 1011 0010 1011]       4 byte  

                [1] [opcode 7 bit] [2 bit mod] [reg 3 bit] [reg 3 bit]

                LNOT examples:

                LNOT ER1         -> [1 000 0101 00 0 001 00]                          2 byte
                LNOT imm16       -> NOT AVAILABLE                                     
                LNOT [ER1]       -> [1 000 0101 10 0 001 00 011 00000]                3 byte                                    
                LNOT mem16       -> [1 000 0101 11 0 001 00 1001 1101 1101 1111]      4 byte 

                BNOT examples:

                BNOT ER1         -> [1 000 0101 00 1 001 00]                          2 byte
                BNOT imm16       -> NOT AVAILABLE                                     
                BNOT [ER1]       -> [1 000 0101 10 1 001 00]                          2 byte
                BNOT mem16       -> [1 000 0101 11 1 001 00 1001 1101 1101 1111]      4 byte 
            */

            // NOT
            8'b0000101: ;

            // STACK

            /*4'b0001: begin                                                     
               
            end*/

            //4'b0010: result_reg = bitwise_and_res;                             
        endcase
    end


endmodule