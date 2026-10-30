`timescale 1ns/1ps
module alu (
    input wire [7:0] accumulator,
    input wire [7:0] operand,
    input wire [1:0] alu_select,
    output reg [7:0] result
);
    // 00=ADD, 01=AND, 10=XOR, 11=SHR
    always @(*) begin
        case (alu_select)
            2'b00: result = accumulator + operand; // 8-bit result; carry discarded
            2'b01: result = accumulator & operand;
            2'b10: result = accumulator ^ operand;
            2'b11: result = accumulator >> 1;      // zero enters MSB
            default: result = 8'h00;
        endcase
    end
endmodule
