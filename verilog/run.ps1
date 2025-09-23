if (!(Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }

iverilog -o build/alu_register.vvp `
    src/register_file.v `
    src/alu.v `
    tbs/alu_register_file_tb.v 

vvp build/alu_register.vvp

#iverilog -o build/pc.vvp src/program_counter.v tbs/program_counter_tb.v

#iverilog -o build/alu.vvp `
#    src/alu.v `
#    tbs/alu_tb.v 

#iverilog -o build/register.vvp `
#    src/register_file.v `
#    tbs/register_file_tb.v 

#vvp build/alu.vvp
#vvp build/register.vvp

# gtkwave wave.vcd