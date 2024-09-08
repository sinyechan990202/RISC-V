`timescale 1ns / 1ps

module register_file(
  input clk, rstn,
  input we,
  input [4:0] addr,
  input [31:0] d,
  output logic [31:0] q //d is write data, q is read data
);

logic [31:0] register [0:31];

integer i;
always @(posedge clk or negedge rstn) begin
  if(!rstn) begin
    for(i=0;i<32;i=i+1) begin
      register[i] <= 0;
    end
  end else begin
      if(we) begin
        register[addr] <= d;
      end else begin
        q <= register[addr];
      end
  end 
end


endmodule
