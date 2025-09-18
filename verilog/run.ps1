if (!(Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }

iverilog -o build/out.vvp `
    src/full_adder.v `
    tbs/full_adder_tb.v 

vvp build/out.vvp

# gtkwave wave.vcd