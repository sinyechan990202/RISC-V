module tb_barrel_shifter_optimized;

  reg [31:0] opranda;
  reg [4:0] oprandb;
  reg right_flag;
  reg right_arith_flag;
  wire [31:0] res;

  barrel_shifter_optimized uut (
    .opranda(opranda),
    .oprandb(oprandb),
    .right_flag(right_flag),
    .right_arith_flag(right_arith_flag),
    .res(res)
  );

  initial begin
    // Monitor the changes
    $monitor("Time: %0d, opranda: %h, oprandb: %d, right_flag: %b, right_arith_flag: %b, res: %h", $time, opranda, oprandb, right_flag, right_arith_flag, res);

    // Test case 1: Right logical shift by 1
    opranda = 32'hA5A5A5A5;
    oprandb = 5'd1;
    right_flag = 1'b1;
    right_arith_flag = 1'b0;
    #10 $display("Test case 1: expected: %b, result: %b", 32'h52D2D2D2, res);

    // Test case 2: Right logical shift by 16
    opranda = 32'hA5A5A5A5;
    oprandb = 5'd16;
    right_flag = 1'b1;
    right_arith_flag = 1'b0;
    #10 $display("Test case 2: expected: %b, result: %b", 32'h0000A5A5, res);

    // Test case 3: Left shift by 1
    opranda = 32'hA5A5A5A5;
    oprandb = 5'd1;
    right_flag = 1'b0;
    right_arith_flag = 1'b0;
    #10 $display("Test case 3: expected: %b, result: %b", 32'h4B4B4B4A, res);

    // Test case 4: Left shift by 16
    opranda = 32'hA5A5A5A5;
    oprandb = 5'd16;
    right_flag = 1'b0;
    right_arith_flag = 1'b0;
    #10 $display("Test case 4: expected: %b, result: %b", 32'hA5A50000, res);

    // Test case 5: No shift
    opranda = 32'hA5A5A5A5;
    oprandb = 5'd0;
    right_flag = 1'b1;
    right_arith_flag = 1'b0;
    #10 $display("Test case 5: expected: %b, result: %b", 32'hA5A5A5A5, res);

    // Test case 6: Right arithmetic shift by 1
    opranda = 32'hA5A5A5A5;
    oprandb = 5'd1;
    right_flag = 1'b1;
    right_arith_flag = 1'b1;
    #10 $display("Test case 6: expected: %b, result: %b", 32'hD2D2D2D2, res);

    // Test case 7: Right arithmetic shift by 16
    opranda = 32'hA5A5A5A5;
    oprandb = 5'd16;
    right_flag = 1'b1;
    right_arith_flag = 1'b1;
    #10 $display("Test case 7: expected: %b, result: %b", 32'hFFFFA5A5, res);

    // Test case 8: Right arithmetic shift by 31
    opranda = 32'h80000001;
    oprandb = 5'd31;
    right_flag = 1'b1;
    right_arith_flag = 1'b1;
    #10 $display("Test case 8: expected: %b, result: %b", 32'hFFFFFFFF, res);

    // Test case 9: Left shift by 31
    opranda = 32'h00000001;
    oprandb = 5'd31;
    right_flag = 1'b0;
    right_arith_flag = 1'b0;
    #10 $display("Test case 9: expected: %b, result: %b", 32'h80000000, res);

    // End simulation
    $finish;
  end

  initial begin
    $dumpfile("tb_barrel_shifter_optimized.vcd");
    $dumpvars(0,tb_barrel_shifter_optimized);
  end
endmodule
