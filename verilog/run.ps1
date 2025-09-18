if (!(Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }

iverilog -o build/alu_registry.vvp `
    src/registry_file.v `
    src/alu.v `
    tbs/alu_registry_file_tb.v 

vvp build/alu_registry.vvp

#iverilog -o build/alu.vvp `
#    src/alu.v `
#    tbs/alu_tb.v 

#iverilog -o build/registry.vvp `
#    src/registry_file.v `
#    tbs/registry_file_tb.v 

#vvp build/alu.vvp
#vvp build/registry.vvp

# gtkwave wave.vcd