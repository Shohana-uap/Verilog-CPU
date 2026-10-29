`timescale 1ns/1ps
module program_rom (
    input wire [3:0] address,
    output reg [11:0] instruction
);
    always @(*) begin
        case (address)
            4'd0: instruction = 12'h1F3; // LDI 0xF3
            4'd1: instruction = 12'h43C; // AND 0x3C
            4'd2: instruction = 12'h611; // XOR 0x11
            4'd3: instruction = 12'h900; // SHR
            4'd4: instruction = 12'h230; // ADD 0x30
            4'd5: instruction = 12'h640; // XOR 0x40
            default: instruction = 12'h000; // NOP
        endcase
    end
endmodule
