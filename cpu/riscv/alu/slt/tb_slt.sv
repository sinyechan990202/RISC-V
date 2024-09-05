// Code your testbench here
// or browse Examples
module tb_slt;

  reg [31:0] opranda;
  reg [31:0] oprandb;
  wire signed [31:0] s_opranda, s_oprandb;
  assign s_opranda = opranda;
  assign s_oprandb = oprandb;
  reg unsigned_flag;
  wire slt_res;

  slt uut (
    .opranda(opranda),
    .oprandb(oprandb),
    .unsigned_flag(unsigned_flag),
    .slt_res(slt_res)
  );

  initial begin
    // Test case 1: Unsigned comparison, opranda < oprandb
    opranda = 32'h00000001;
    oprandb = 32'h00000002;
    unsigned_flag = 1'b1;
    #10;
    $display("Test case 1: opranda = %d, oprandb = %d, unsigned_flag = %b, slt_res = %b", opranda, oprandb, unsigned_flag, slt_res);

    // Test case 2: Unsigned comparison, opranda > oprandb
    opranda = 32'h00000003;
    oprandb = 32'h00000002;
    unsigned_flag = 1'b1;
    #10;
    $display("Test case 2: opranda = %d, oprandb = %d, unsigned_flag = %b, slt_res = %b", opranda, oprandb, unsigned_flag, slt_res);

    // Test case 3: Signed comparison, opranda < oprandb
    opranda = 32'h80000000; // -2147483648 in signed
    oprandb = 32'h00000001; // 1 in signed
    unsigned_flag = 1'b0;
    #10;
    $display("Test case 3: opranda = %d, oprandb = %d, unsigned_flag = %b, slt_res = %b", s_opranda, s_oprandb, unsigned_flag, slt_res);

    // Test case 4: Signed comparison, opranda > oprandb
    opranda = 32'h7FFFFFFF; // 2147483647 in signed
    oprandb = 32'hFFFFFFFF; // -1 in signed
    unsigned_flag = 1'b0;
    #10;
    $display("Test case 4: opranda = %d, oprandb = %d, unsigned_flag = %b, slt_res = %b", s_opranda, s_oprandb, unsigned_flag, slt_res);

    // Test case 5: Unsigned comparison, opranda == oprandb
    opranda = 32'hFFFFFFFF; // 4294967295 in unsigned
    oprandb = 32'hFFFFFFFF; // 4294967295 in unsigned
    unsigned_flag = 1'b1;
    #10;
    $display("Test case 5: opranda = %d, oprandb = %d, unsigned_flag = %b, slt_res = %b", opranda, oprandb, unsigned_flag, slt_res);

    // End simulation
    $finish;
  end

  initial begin
    $dumpfile("tb_slt.vcd");
    $dumpvars(0,tb_slt);
  end
endmodule

