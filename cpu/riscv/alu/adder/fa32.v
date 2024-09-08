module fa32(
  input [31:0]		A,B,
  input				Cin,
  output			Cout,
  output [31:0]		S,
  output 			PG,GG
);
  
  wire [31:0] 		C;
  wire [31:0]		w_B;
  
  assign w_B	= (Cin) ? ~B : B;
  
  genvar i;
  generate
    for(i=0;i<32;i=i+1) begin
      full_adder fa_inst(
        .A(A[i]),
        .B(w_B[i]),
        .Cin(C[i]),
        .S(S[i])
      );
    end
  endgenerate
  
  cla u_cla(
    .A(A),
    .B(w_B),
    .Cin(Cin),
    .C(C),
    .Cout(Cout),
    .PG(PG),
    .GG(GG)
  );
  
endmodule
