`timescale 1ns/1ps
module tb_program_rom;
 reg [3:0] address;
 wire [11:0] instruction;
 program_rom DUT(.address(address), .instruction(instruction));
 task check;
   input [3:0] a; input [11:0] expected;
   begin address=a; #1;
     if(instruction !== expected)
       $display("FAIL ROM[%h]=%h expected=%h",a,instruction,expected);
     else $display("PASS ROM[%h]=%h",a,instruction);
   end
 endtask
 integer i;
 initial begin
   $display("Testing program_rom");
   check(4'd0,12'h1F3); check(4'd1,12'h43C);
   check(4'd2,12'h611); check(4'd3,12'h900);
   check(4'd4,12'h230); check(4'd5,12'h640);
   for(i=6;i<16;i=i+1) check(i,12'h000);
   $display("program_rom test completed"); $finish;
 end
endmodule
