`timescale 1ns/1ps
module cpu_top (
    input wire CLK,
    input wire RESET,
    output wire [7:0] Q,
    output wire Z,
    output wire [3:0] PC
);
    wire [11:0] instruction;
    wire [3:0] opcode;
    wire [7:0] operand;
    wire [3:0] next_pc;
    wire acc_write;
    wire z_write;
    wire immediate_to_acc;
    wire [1:0] alu_select;
    wire [7:0] alu_result;
    wire [7:0] acc_data;
    wire [7:0] acc_value;
    wire [7:0] unused_r;

    assign opcode  = instruction[11:8];
    assign operand = instruction[7:0];
    assign next_pc = PC + 4'd1;
    assign acc_data = immediate_to_acc ? operand : alu_result;
    assign Q = acc_value;

    program_rom ROM (
        .address(PC),
        .instruction(instruction)
    );

    control_unit CU (
        .opcode(opcode),
        .acc_write(acc_write),
        .z_write(z_write),
        .immediate_to_acc(immediate_to_acc),
        .alu_select(alu_select)
    );

    alu ALU (
        .accumulator(acc_value),
        .operand(operand),
        .alu_select(alu_select),
        .result(alu_result)
    );

    pc PC_UNIT (
        .clk(CLK),
        .reset(RESET),
        .next_pc(next_pc),
        .pc_out(PC)
    );

    acc_r_z REGISTERS (
        .clk(CLK),
        .reset(RESET),
        .acc_write(acc_write),
        .z_write(z_write),
        .acc_in(acc_data),
        .acc(acc_value),
        .r(unused_r),
        .z(Z)
    );
endmodule
