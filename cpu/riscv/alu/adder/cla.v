module cla(
  input [31:0] 		A, B,
  input 			Cin,
  output [31:0]		C,
  output 			Cout, PG, GG
);
  wire [31:0]	P, G;
  assign C[0] = Cin;
  genvar i;
  generate
    for(i=0;i<32;i++) begin
      assign P[i]	=	A[i] ^ B[i];
      assign G[i]	=	A[i] & B[i];
      if(i==31) begin
        assign Cout =	G[i] | (P[i] & C[i]);
      end else begin
        assign C[i+1] =	G[i] | (P[i] & C[i]);
      end
    end
  endgenerate
endmodule
