`timescale 1ns/1ps
module control_unit (
    input wire [3:0] opcode,
    output reg acc_write,
    output reg z_write,
    output reg immediate_to_acc,
    output reg [1:0] alu_select
);
    // ALU select: 00=ADD, 01=AND, 10=XOR, 11=SHR
    always @(*) begin
        acc_write = 1'b0;
        z_write = 1'b0;
        immediate_to_acc = 1'b0;
        alu_select = 2'b00;

        case (opcode)
            4'b0001: begin // LDI
                acc_write = 1'b1;
                z_write = 1'b1;
                immediate_to_acc = 1'b1;
            end
            4'b0010: begin // ADD
                acc_write = 1'b1;
                z_write = 1'b1;
                alu_select = 2'b00;
            end
            4'b0100: begin // AND
                acc_write = 1'b1;
                z_write = 1'b1;
                alu_select = 2'b01;
            end
            4'b0110: begin // XOR
                acc_write = 1'b1;
                z_write = 1'b1;
                alu_select = 2'b10;
            end
            4'b1001: begin // SHR
                acc_write = 1'b1;
                z_write = 1'b1;
                alu_select = 2'b11;
            end
            default: begin // Unsupported opcode = NOP
                acc_write = 1'b0;
                z_write = 1'b0;
                immediate_to_acc = 1'b0;
                alu_select = 2'b00;
            end
        endcase
    end
endmodule
