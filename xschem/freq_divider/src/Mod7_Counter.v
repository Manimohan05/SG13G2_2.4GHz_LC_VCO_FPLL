// =================================================
// Module 3: Mod-7 Synchronous Counter (Using JK-FF)
// Sequence: 000 -> 001 -> ... -> 110 -> 000
// =================================================
`include "JK_FF.v"

module Mod7_Counter (
    input wire clk,
    input wire rst,
    output wire bit1, bit2,
    output wire bit3, bit4,
    output wire out
);
    // Wires for feedback logic

    wire gate1_out, gate2_out, gate3_out;
    
    // Gate connections derived for structural implementation:
    assign gate1_out = bit4 | bit3;
    assign gate2_out = bit1 | out;
    assign gate3_out = bit1 & bit2;
    
    /* verilator lint_off PINCONNECTEMPTY */
    JK_FF jk1 (.clk(clk), .rst(rst), .j(gate1_out), .k(1'b1), .q(bit1), .q_bar());
    /* verilator lint_on PINCONNECTEMPTY */
    JK_FF jk2 (.clk(clk), .rst(rst), .j(bit1), .k(gate2_out), .q(bit2), .q_bar(bit3));
    JK_FF jk3 (.clk(clk), .rst(rst), .j(gate3_out), .k(bit2), .q(out), .q_bar(bit4));
endmodule
