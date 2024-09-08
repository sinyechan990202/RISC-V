module barrel_shifter_optimized (
  input [31:0] opranda,
  input [4:0] oprandb,
  input right_flag,
  input right_arith_flag,
  output [31:0] res
);
  wire [31:0] stage1, stage2, stage3, stage4;
  wire sign_bit = opranda[31]; // 산술 시프트를 위한 부호 비트

  // Stage 1
  assign stage1 = (right_flag) ?
                  ((oprandb[0]) ? {right_arith_flag ? sign_bit : 1'b0, opranda[31:1]} : opranda) :
                  ((oprandb[0]) ? {opranda[30:0], 1'b0} : opranda);

  // Stage 2
  assign stage2 = (right_flag) ?
                  ((oprandb[1]) ? {right_arith_flag ? {2{sign_bit}} : 2'b00, stage1[31:2]} : stage1) :
                  ((oprandb[1]) ? {stage1[29:0], 2'b00} : stage1);

  // Stage 3
  assign stage3 = (right_flag) ?
                  ((oprandb[2]) ? {right_arith_flag ? {4{sign_bit}} : 4'b0000, stage2[31:4]} : stage2) :
                  ((oprandb[2]) ? {stage2[27:0], 4'b0000} : stage2);

  // Stage 4
  assign stage4 = (right_flag) ?
                  ((oprandb[3]) ? {right_arith_flag ? {8{sign_bit}} : 8'b00000000, stage3[31:8]} : stage3) :
                  ((oprandb[3]) ? {stage3[23:0], 8'b00000000} : stage3);

  // Final Stage
  assign res = (right_flag) ?
               ((oprandb[4]) ? {right_arith_flag ? {16{sign_bit}} : 16'b0000000000000000, stage4[31:16]} : stage4) :
               ((oprandb[4]) ? {stage4[15:0], 16'b0000000000000000} : stage4);
endmodule
