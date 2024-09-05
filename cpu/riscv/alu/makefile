CC = iverilog
FLAGS = -Wall -Winfloop

default : ALU_tb.sv ALU.sv ./shifter/barrel_shifter_optimized.sv ./adder/fa32.v ./adder/cla.v ./adder/full_adder.v ./bitwise/bit_operator.sv ./slt/slt.sv
	$(CC) $(FLAGS) -g2012 ALU_tb.sv ALU.sv ./shifter/barrel_shifter_optimized.sv ./adder/fa32.v ./adder/cla.v ./adder/full_adder.v ./bitwise/bit_operator.sv ./slt/slt.sv
	vvp a.out

	gtkwave ALU_tb.vcd
