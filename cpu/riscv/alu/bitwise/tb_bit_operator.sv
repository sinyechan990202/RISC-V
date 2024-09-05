module tb_bit_operator;

  reg [31:0] opranda;
  reg [31:0] oprandb;
  reg [1:0] op_sel;
  wire [31:0] res;

  bit_operator uut (
    .opranda(opranda),
    .oprandb(oprandb),
    .op_sel(op_sel),
    .res(res)
  );

  initial begin
    // Monitor the changes
    $monitor("Time: %0d, opranda: %h, oprandb: %h, op_sel: %b, res: %h", $time, opranda, oprandb, op_sel, res);

    // Test case 1: AND operation
    opranda = 32'hA5A5A5A5;
    oprandb = 32'h5A5A5A5A;
    op_sel = 2'b11;
    #10;
    $display("Test case 1: opranda = %h, oprandb = %h, op_sel = %b, res = %h", opranda, oprandb, op_sel, res);

    // Test case 2: OR operation
    opranda = 32'hA5A5A5A5;
    oprandb = 32'h5A5A5A5A;
    op_sel = 2'b10;
    #10;
    $display("Test case 2: opranda = %h, oprandb = %h, op_sel = %b, res = %h", opranda, oprandb, op_sel, res);

    // Test case 3: XOR operation
    opranda = 32'hA5A5A5A5;
    oprandb = 32'h5A5A5A5A;
    op_sel = 2'b00;
    #10;
    $display("Test case 3: opranda = %h, oprandb = %h, op_sel = %b, res = %h", opranda, oprandb, op_sel, res);

    // Test case 4: Default case
    opranda = 32'hFFFFFFFF;
    oprandb = 32'h00000000;
    op_sel = 2'b01;
    #10;
    $display("Test case 4: opranda = %h, oprandb = %h, op_sel = %b, res = %h", opranda, oprandb, op_sel, res);

    // End simulation
    $finish;
  end

  initial begin
    $dumpfile("tb_bit_operator.vcd");
    $dumpvars(0,tb_bit_operator);
  end
endmodule

