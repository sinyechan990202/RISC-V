module bit_operator(
  input [31:0] opranda, oprandb,
  input [1:0] op_sel,
  output [31:0] res
);

  assign res = (op_sel == 2'b11) ? (opranda & oprandb) :
               (op_sel == 2'b10) ? (opranda | oprandb) :
               (op_sel == 2'b00) ? (opranda ^ oprandb) :
               32'b0;
  
endmodule
