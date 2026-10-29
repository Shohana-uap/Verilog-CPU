`timescale 1ns/1ps
module pc (
    input wire clk,
    input wire reset,
    input wire [3:0] next_pc,
    output reg [3:0] pc_out
);
    always @(posedge clk) begin
        if (reset)
            pc_out <= 4'd0;
        else
            pc_out <= next_pc;
    end
endmodule
