`timescale 1ns/1ps
module tb_alu;
 reg [7:0] accumulator,operand;
 reg [1:0] alu_select;
 wire [7:0] result;
 alu DUT(.accumulator(accumulator),.operand(operand),
   .alu_select(alu_select),.result(result));
 task check;
   input [7:0] a,b,expected; input [1:0] sel;
   begin accumulator=a; operand=b; alu_select=sel; #1;
     if(result !== expected)
       $display("FAIL sel=%b A=%h B=%h result=%h expected=%h",sel,a,b,result,expected);
     else $display("PASS sel=%b A=%h B=%h result=%h",sel,a,b,result);
   end
 endtask
 initial begin
   $display("Testing ALU");
   check(8'h10,8'h30,8'h40,2'b00); // ADD
   check(8'hF3,8'h3C,8'h30,2'b01); // AND
   check(8'h30,8'h11,8'h21,2'b10); // XOR
   check(8'h21,8'h00,8'h10,2'b11); // SHR
   check(8'hFF,8'h01,8'h00,2'b00); // 8-bit overflow
   $display("alu test completed"); $finish;
 end
endmodule
