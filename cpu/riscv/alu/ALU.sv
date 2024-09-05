module ALU #
(
  parameter DATA_WIDTH = 32
)(
  input clk, rstn,
  input [2:0] funct3,
  input funct7,
  input [DATA_WIDTH-1:0] opranda, oprandb,
  output [DATA_WIDTH-1:0] res
);
  wire [DATA_WIDTH-1:0] w_adder_a, w_adder_b, w_bw_a, w_bw_b, w_shifter_a, w_shifter_b, w_slt_a, w_slt_b;
  wire [DATA_WIDTH-1:0] a_res, bw_res, sft_res, slt_res;
  logic [DATA_WIDTH-1:0] r_res;

  always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      r_res <= 32'd0; // 수정: 세미콜론 추가
    end else begin
      case(funct3)
        3'b000: r_res <= a_res; // 덧셈 결과 할당
        3'b111: r_res <= bw_res; // 비트 AND 결과 할당
        3'b110: r_res <= bw_res; // 비트 OR 결과 할당
        3'b101: r_res <= sft_res; // 쉬프트 결과 할당
        3'b001: r_res <= sft_res;
        3'b010: r_res <= slt_res; // 비교 결과 할당
        3'b011: r_res <= slt_res; // 비교 결과 할당
        default: r_res <= 32'd0;
      endcase
    end
  end

  // 연산 결과를 위한 배선 할당
  assign w_adder_a = (funct3 == 3'b000) ? opranda : 32'd0;
  assign w_adder_b = (funct3 == 3'b000) ? oprandb : 32'd0;
  assign w_bw_a = (funct3 == 3'b111 || funct3 == 3'b110 || funct3 == 3'b100) ? opranda : 32'd0;
  assign w_bw_b = (funct3 == 3'b111 || funct3 == 3'b110 || funct3 == 3'b100) ? oprandb : 32'd0;
  assign w_shifter_a = (funct3 == 3'b101 || funct3 == 3'b001) ? opranda : 32'd0;
  assign w_shifter_b = (funct3 == 3'b101 || funct3 == 3'b001) ? oprandb : 32'd0;
  assign w_slt_a = (funct3 == 3'b010 || funct3 == 3'b011) ? opranda : 32'd0;
  assign w_slt_b = (funct3 == 3'b010 || funct3 == 3'b011) ? oprandb : 32'd0;

  // 수정: 모듈 인스턴스화 오류 수정
  fa32 u_fa32 (
    .A(opranda),  // 덧셈 및 뺄셈 입력
    .B(oprandb),  // 덧셈 및 뺄셈 입력
    .Cin(funct7),
    .Cout(),
    .S(a_res),
    .PG(),
    .GG()
  );

  bit_operator u_bit_operator (
    .opranda(w_bw_a), // 수정: 변수 이름 수정
    .oprandb(w_bw_b), // 수정: 변수 이름 수정
    .op_sel(funct3[1:0]),
    .res(bw_res)
  );

  barrel_shifter_optimized u_barrel_shifter_optimized (
    .opranda(w_shifter_a), // 수정: 변수 이름 수정
    .oprandb(w_shifter_b[4:0]), // 수정: 잘못된 버스 크기 수정
    .right_flag(funct3[2]),
    .right_arith_flag(funct7),
    .res(sft_res)
  );

  slt u_slt (
    .opranda(w_slt_a), // 수정: 변수 이름 수정
    .oprandb(w_slt_b), // 수정: 변수 이름 수정
    .unsigned_flag(funct3[0]),
    .slt_res(slt_res)
  );

  assign res = r_res;

endmodule
