`timescale 1ns/1ps
module tb_control_unit;
 reg [3:0] opcode;
 wire acc_write,z_write,immediate_to_acc;
 wire [1:0] alu_select;
 control_unit DUT(.opcode(opcode),.acc_write(acc_write),.z_write(z_write),
   .immediate_to_acc(immediate_to_acc),.alu_select(alu_select));
 task check;
   input [3:0] op; input ew,ez,eimm; input [1:0] esel;
   begin opcode=op; #1;
     if({acc_write,z_write,immediate_to_acc,alu_select} !== {ew,ez,eimm,esel})
       $display("FAIL opcode=%h outputs=%b%b%b%b expected=%b%b%b%b",
         op,acc_write,z_write,immediate_to_acc,alu_select,ew,ez,eimm,esel);
     else $display("PASS opcode=%h",op);
   end
 endtask
 initial begin
   $display("Testing control_unit");
   check(4'h1,1,1,1,2'b00); // LDI
   check(4'h2,1,1,0,2'b00); // ADD
   check(4'h4,1,1,0,2'b01); // AND
   check(4'h6,1,1,0,2'b10); // XOR
   check(4'h9,1,1,0,2'b11); // SHR
   check(4'h0,0,0,0,2'b00); // NOP
   check(4'hF,0,0,0,2'b00); // unsupported
   $display("control_unit test completed"); $finish;
 end
endmodule
