`timescale 1ns/1ps
module tb_cpu_top;
    reg CLK;
    reg RESET;
    wire [7:0] Q;
    wire Z;
    wire [3:0] PC;

    cpu_top DUT (
        .CLK(CLK),
        .RESET(RESET),
        .Q(Q),
        .Z(Z),
        .PC(PC)
    );

    // 10 ns clock period
    initial CLK = 1'b0;
    always #5 CLK = ~CLK;

    task check_result;
        input [3:0] expected_pc;
        input [7:0] expected_acc;
        input expected_z;
        input [127:0] label_text;
        begin
            #1;
            if (PC !== expected_pc || Q !== expected_acc || Z !== expected_z) begin
                $display("FAIL: %0s | PC=%h expected=%h, ACC=%h expected=%h, Z=%b expected=%b",
                         label_text, PC, expected_pc, Q, expected_acc, Z, expected_z);
                $stop;
            end else begin
                $display("PASS: %0s | PC=%h ACC=%h Z=%b",
                         label_text, PC, Q, Z);
            end
        end
    endtask

    initial begin
        $dumpfile("set7_cpu.vcd");
        $dumpvars(0, tb_cpu_top);

        RESET = 1'b1;

        // Synchronous reset: registers reset on the next rising edge.
        @(posedge CLK);
        check_result(4'h0, 8'h00, 1'b1, "RESET");

        @(negedge CLK);
        RESET = 1'b0;

        // Instruction at ROM[0]: LDI 0xF3
        @(posedge CLK);
        check_result(4'h1, 8'hF3, 1'b0, "LDI F3");

        // Instruction at ROM[1]: AND 0x3C -> 0x30
        @(posedge CLK);
        check_result(4'h2, 8'h30, 1'b0, "AND 3C");

        // Instruction at ROM[2]: XOR 0x11 -> 0x21
        @(posedge CLK);
        check_result(4'h3, 8'h21, 1'b0, "XOR 11");

        // Instruction at ROM[3]: SHR -> 0x10
        @(posedge CLK);
        check_result(4'h4, 8'h10, 1'b0, "SHR");

        // Instruction at ROM[4]: ADD 0x30 -> 0x40
        @(posedge CLK);
        check_result(4'h5, 8'h40, 1'b0, "ADD 30");

        // Instruction at ROM[5]: XOR 0x40 -> 0x00, so Z=1
        @(posedge CLK);
        check_result(4'h6, 8'h00, 1'b1, "XOR 40");

        $display("ALL SET 7 TESTS PASSED.");
        $finish;
    end
endmodule
