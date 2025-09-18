module full_adder(
    input a, b, cin,
    output sum, cout
);
    wire y_xor_1, y_and_1, y_and_2;

    assign y_xor_1 = a ^ b;
    assign y_and_1 = a & b;
    assign y_and_2 = y_xor_1 & cin;

    assign cout = y_and_1 | y_and_2;
    assign sum = y_xor_1 ^ cin;
endmodule