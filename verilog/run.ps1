if (!(Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }

iverilog -o build/out.vvp `
    src/full_adder_8bit.v `
    tbs/full_adder_8bit_tb.v 

iverilog -o build/out.vvp `
    src/registry_bank.v `
    tbs/registry_bank_tb.v 

vvp build/out.vvp

# gtkwave wave.vcd