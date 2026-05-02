// ====================================================
// Module 5: Output Divide-by-2 & Duty Cycle Correction
// ====================================================
//`include "DFF.v"

module Output_Div2 (
    input wire clk,
    input wire rst,
    output wire out
);
    wire q_out, q_bar_out;

    DFF dff_out (
        .clk(clk),
        .rst(rst),
        .d(q_bar_out), // Toggles every rising edge
        .q(q_out),
        .q_bar(q_bar_out)
    );

    assign out = q_out;
endmodule
