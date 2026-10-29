`timescale 1ns/1ps
module tb_pc;
 reg clk, reset;
 reg [3:0] next_pc;
 wire [3:0] pc_out;
 pc DUT(.clk(clk), .reset(reset), .next_pc(next_pc), .pc_out(pc_out));
 initial clk=0;
 always #5 clk=~clk;
 initial begin
   $display("Testing pc");
   reset=1; next_pc=4'd5;
   @(posedge clk); #1;
   if(pc_out !== 4'd0) $display("FAIL reset PC=%h",pc_out);
   else $display("PASS reset");
   @(negedge clk); reset=0; next_pc=4'd3;
   @(posedge clk); #1;
   if(pc_out !== 4'd3) $display("FAIL load PC=%h",pc_out);
   else $display("PASS next_pc=3");
   @(negedge clk); next_pc=4'd15;
   @(posedge clk); #1;
   if(pc_out !== 4'd15) $display("FAIL load PC=%h",pc_out);
   else $display("PASS next_pc=F");
   $display("pc test completed"); $finish;
 end
endmodule
