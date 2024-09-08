// Code your design here
module slt(
  input [31:0] opranda,oprandb,
  input unsigned_flag,
  output slt_res
);
  wire signed [31:0] s_opranda, s_oprandb;
  assign s_opranda = opranda;
  assign s_oprandb = oprandb;
  assign slt_res = (unsigned_flag) ? (opranda < oprandb) : (s_opranda < s_oprandb);
  
endmodule
