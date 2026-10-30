`timescale 1ns/1ps
module acc_r_z (
    input wire clk,
    input wire reset,
    input wire acc_write,
    input wire z_write,
    input wire [7:0] acc_in,
    output reg [7:0] acc,
    output reg [7:0] r,
    output reg z
);
    // R is included as required by the assignment architecture,
    // but Set 7 has no STA/LDR instruction, so R is only reset.
    always @(posedge clk) begin
        if (reset) begin
            acc <= 8'h00;
            r   <= 8'h00;
            z   <= 1'b1;
        end else begin
            if (acc_write)
                acc <= acc_in;
            if (z_write && acc_write)
                z <= (acc_in == 8'h00);
        end
    end
endmodule
