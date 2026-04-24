// ===============================================================
// Module 2: 4/5 Pre-scaler (Dual Modulus Divider)
// Logic: Divides by 4 normally. If MC=0, swallows a pulse (Div 5).
// ===============================================================
//`include "DFF.v"

module Prescaler_4_5 (
    input wire clk,     // Input from Div-4 block
    input wire rst,
    input wire mc,     // Modulus Control
    output wire out    // Output to Mod-7 Counter
);
    wire q1_n, q2, q3;
    wire d1, d2, d3;
    wire mc_gated;

    // Implementing gate structure:
    assign d2 = q1_n;
    assign d3 = q2;
    
    // Logic to enable division by 5 when MC is low
    assign mc_gated = mc | q3; 
    assign d1 = q2 & mc_gated;

    /* verilator lint_off PINCONNECTEMPTY */
    DFF ff1 (.clk(clk), .rst(rst), .d(d1), .q(), .q_bar(q1_n));
    DFF ff2 (.clk(clk), .rst(rst), .d(d2), .q(q2), .q_bar());
    DFF ff3 (.clk(clk), .rst(rst), .d(d3), .q(q3), .q_bar());
    /* verilator lint_on PINCONNECTEMPTY */

    assign out = q3; // Output taken from last stage
endmodule
