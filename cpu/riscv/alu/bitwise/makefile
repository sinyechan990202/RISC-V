CC = iverilog
FLAGS = -Wall -Winfloop

default : tb_bit_operator.sv bit_operator.sv
	$(CC) $(FLAGS) -g2012 tb_bit_operator.sv bit_operator.sv
	vvp a.out

	gtkwave tb_bit_operator.vcd
