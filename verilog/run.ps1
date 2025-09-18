if (!(Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }

iverilog -o build/adder.vvp `
    src/full_adder_8bit.v `
    tbs/full_adder_8bit_tb.v 

iverilog -o build/registry.vvp `
    src/registry_file.v `
    tbs/registry_file_tb.v 

vvp build/adder.vvp
vvp build/registry.vvp

# gtkwave wave.vcd