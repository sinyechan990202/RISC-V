module full_adder(
  input 	A, B, Cin,
  output 	S
);
  assign 	S 	= 	A ^ B ^ Cin;
endmodule
