CC = iverilog
FLAGS = -Wall -Winfloop

default : tb_barrel_shifter_optimized.sv barrel_shifter_optimized.sv
	$(CC) $(FLAGS) -g2012 tb_barrel_shifter_optimized.sv barrel_shifter_optimized.sv
	vvp a.out

	gtkwave tb_barrel_shifter_optimized.vcd
