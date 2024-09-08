`timescale 1ns / 1ps

module tb_fa32;

  // Inputs
  reg [31:0] A;
  reg [31:0] B;
  reg Cin;

  // Outputs
  wire Cout;
  wire [31:0] S;
  wire PG, GG;

  // Instantiate the Unit Under Test (UUT)
  fa32 uut (
    .A(A), 
    .B(B), 
    .Cin(Cin), 
    .Cout(Cout), 
    .S(S),
    .PG(PG),
    .GG(GG)
  );

  initial begin
    // Initialize Inputs
    A = 32'h0;
    B = 32'h0;
    Cin = 0;

    // Wait 100 ns for global reset to finish
    #100;
        
    // Add stimulus here
    // Test Addition
    A = 32'h00000001; B = 32'h00000001; Cin = 0; #10;
    // Expected result: S = 32'h00000002, Cout = 0
    
    A = 32'hFFFFFFFF; B = 32'h00000001; Cin = 0; #10;
    // Expected result: S = 32'h00000000, Cout = 1

    // Test Subtraction
    A = 32'h00000002; B = 32'h00000001; Cin = 1; #10;
    // Expected result: S = 32'h00000001, Cout = 0
    
    A = 32'h00000001; B = 32'h00000001; Cin = 1; #10;
    // Expected result: S = 32'h00000000, Cout = 1 (since it performs 1 - 1 with Cin as 1, resulting in 0)

    A = 32'h00000000; B = 32'h00000001; Cin = 1; #10;
    // Expected result: S = 32'hFFFFFFFF, Cout = 0 (since it performs 0 - 1 with Cin as 1, resulting in -1 which is 0xFFFFFFFF)

    // You can add more test cases as needed

    // Finish the simulation
    #100;
    $stop;
  end
      
  initial begin
    $monitor("Time = %0dns, A = %h, B = %h, Cin = %b, S = %h, Cout = %b, PG = %b, GG = %b", 
              $time, A, B, Cin, S, Cout, PG, GG);
  end

  initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0,tb_fa32);
  end
endmodule
