`timescale 1ns/1ps
module tb_acc_r_z;
 reg clk,reset,acc_write,z_write;
 reg [7:0] acc_in;
 wire [7:0] acc,r;
 wire z;
 acc_r_z DUT(.clk(clk),.reset(reset),.acc_write(acc_write),.z_write(z_write),
   .acc_in(acc_in),.acc(acc),.r(r),.z(z));
 initial clk=0;
 always #5 clk=~clk;
 initial begin
   $display("Testing acc_r_z");
   reset=1; acc_write=0; z_write=0; acc_in=0;
   @(posedge clk); #1;
   if(acc!==8'h00 || r!==8'h00 || z!==1'b1) $display("FAIL reset");
   else $display("PASS reset");
   @(negedge clk); reset=0; acc_write=1; z_write=1; acc_in=8'hA5;
   @(posedge clk); #1;
   if(acc!==8'hA5 || z!==1'b0) $display("FAIL load A5 acc=%h z=%b",acc,z);
   else $display("PASS load A5");
   @(negedge clk); acc_in=8'h00;
   @(posedge clk); #1;
   if(acc!==8'h00 || z!==1'b1) $display("FAIL load zero acc=%h z=%b",acc,z);
   else $display("PASS load zero");
   @(negedge clk); acc_write=0; z_write=0; acc_in=8'h77;
   @(posedge clk); #1;
   if(acc!==8'h00 || z!==1'b1) $display("FAIL hold");
   else $display("PASS hold when write disabled");
   $display("acc_r_z test completed"); $finish;
 end
endmodule
