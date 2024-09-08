CC = iverilog
FLAGS = -Wall -Winfloop

default : tb_slt.sv slt.sv
	$(CC) $(FLAGS) -g2012 tb_slt.sv slt.sv
	vvp a.out

	gtkwave tb_slt.vcd
