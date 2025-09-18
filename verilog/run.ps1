if (!(Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }

iverilog -o build/out.vvp and_gate.v tbs/and_gate_tb.v
vvp build/out.vvp

# gtkwave wave.vcd