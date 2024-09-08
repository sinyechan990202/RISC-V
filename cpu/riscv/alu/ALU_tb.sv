module ALU_tb;

  // 파라미터 정의
  parameter DATA_WIDTH = 32;

  // 테스트벤치 신호 정의
  reg clk;
  reg rstn;
  reg [2:0] funct3;
  reg funct7;
  reg [DATA_WIDTH-1:0] opranda, oprandb;
  wire [DATA_WIDTH-1:0] res;
  reg [DATA_WIDTH-1:0] expected;

  // 테스트할 ALU 인스턴스화
  ALU #(
    .DATA_WIDTH(DATA_WIDTH)
  ) uut (
    .clk(clk),
    .rstn(rstn),
    .funct3(funct3),
    .funct7(funct7),
    .opranda(opranda),
    .oprandb(oprandb),
    .res(res)
  );

  // 클럭 신호 생성
  always #5 clk = ~clk;

  initial begin
    // 초기값 설정
    clk = 0;
    rstn = 0;
    funct3 = 3'b000;
    funct7 = 0;
    opranda = 32'd0;
    oprandb = 32'd0;
    expected = 32'd0;

    // 리셋 해제
    #10 rstn = 1;

    // 테스트 케이스 1: 덧셈 (funct3 = 000)
    #10 opranda = 32'd10; oprandb = 32'd5; funct3 = 3'b000; funct7 = 0; expected = 32'd15;
    #10 $display("Test Case 1 - Add: opranda = %d, oprandb = %d, expected = %d, result = %d", opranda, oprandb, expected, res);

    // 테스트 케이스 2: 뺄셈 (funct3 = 000, funct7 = 1)
    #10 opranda = 32'd15; oprandb = 32'd3; funct3 = 3'b000; funct7 = 1; expected = 32'd12;
    #10 $display("Test Case 2 - Sub: opranda = %d, oprandb = %d, expected = %d, result = %d", opranda, oprandb, expected, res);

    // 테스트 케이스 3: 비트 AND (funct3 = 111)
    #10 opranda = 32'hFF00FF00; oprandb = 32'h00FF00FF; funct3 = 3'b111; funct7 = 0; expected = 32'h00000000;
    #10 $display("Test Case 3 - AND: opranda = %h, oprandb = %h, expected = %h, result = %h", opranda, oprandb, expected, res);

    // 테스트 케이스 4: 비트 OR (funct3 = 110)
    #10 opranda = 32'h0F0F0F0F; oprandb = 32'hF0F0F0F0; funct3 = 3'b110; funct7 = 0; expected = 32'hFFFFFFFF;
    #10 $display("Test Case 4 - OR: opranda = %h, oprandb = %h, expected = %h, result = %h", opranda, oprandb, expected, res);

    // 테스트 케이스 5: 논리적 쉬프트 왼쪽 (funct3 = 001)
    #10 opranda = 32'd1; oprandb = 32'd4; funct3 = 3'b001; funct7 = 0; expected = 32'd16;
    #10 $display("Test Case 5 - Shift Left Logical: opranda = %d, oprandb = %d, expected = %d, result = %d", opranda, oprandb, expected, res);

    // 테스트 케이스 6: 논리적 쉬프트 오른쪽 (funct3 = 101, funct7 = 0)
    #10 opranda = 32'd16; oprandb = 32'd2; funct3 = 3'b101; funct7 = 0; expected = 32'd4;
    #10 $display("Test Case 6 - Shift Right Logical: opranda = %d, oprandb = %d, expected = %d, result = %d", opranda, oprandb, expected, res);

    // 테스트 케이스 7: 산술적 쉬프트 오른쪽 (funct3 = 101, funct7 = 1)
    #10 opranda = -32'd16; oprandb = 32'd2; funct3 = 3'b101; funct7 = 1; expected = -32'd4;
    #10 $display("Test Case 7 - Shift Right Arithmetic: opranda = %d, oprandb = %d, expected = %d, result = %d", opranda, oprandb, expected, res);

    // 테스트 케이스 8: SLT (funct3 = 010)
    #10 opranda = 32'd10; oprandb = 32'd20; funct3 = 3'b010; funct7 = 0; expected = 32'd1;
    #10 $display("Test Case 8 - Set Less Than: opranda = %d, oprandb = %d, expected = %d, result = %d", opranda, oprandb, expected, res);

    // 테스트 케이스 9: SLTU (funct3 = 011)
    #10 opranda = 32'd10; oprandb = 32'd20; funct3 = 3'b011; funct7 = 0; expected = 32'd1;
    #10 $display("Test Case 9 - Set Less Than Unsigned: opranda = %d, oprandb = %d, expected = %d, result = %d", opranda, oprandb, expected, res);

    // 시뮬레이션 종료
    #100 $finish;
  end

  initial begin
    $dumpfile("ALU_tb.vcd");
    $dumpvars(0, ALU_tb);
  end

endmodule
