// =============================================
// Module 1: Divide-by-4 (Using 2 Cascaded DFFs)
// =============================================
//`include "DFF.v"

module Divide_by_4 (
    input wire in,
    input wire rst,
    output wire out
);
    wire q1, q1_bar;
    wire q2, q2_bar;

    // Stage 1: Divide by 2
    DFF dff1 (
        .clk(in),
        .rst(rst),
        .d(q1_bar), // Feedback inverted output
        .q(q1),
        .q_bar(q1_bar)
    );

    // Stage 2: Divide by 2 (Clocked by output of Stage 1)
    DFF dff2 (
        .clk(q1),
        .rst(rst),
        .d(q2_bar), // Feedback inverted output
        .q(q2), // Output is "out"
        .q_bar(q2_bar)
    );

    assign out = q2;
endmodule
