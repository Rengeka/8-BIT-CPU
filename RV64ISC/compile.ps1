
iverilog -o build/base_alu.vvp src/kernel/alu/base_alu.v tbs/kernel/alu/base_alu_tb.v
vvp build/base_alu.vvp

iverilog -o build/alu.vvp src/kernel/alu/alu.v src/kernel/alu/base_alu.v tbs/kernel/alu/alu_tb.v
vvp build/alu.vvp

yosys synth/synth.ys