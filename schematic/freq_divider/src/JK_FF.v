// =========================================================
// Basic Building Block: JK Flip-Flop (Constructed from DFF)
// =========================================================
//`include "DFF.v"

module JK_FF (
    input wire clk,
    input wire rst,
    input wire j,
    input wire k,
    output wire q,
    output wire q_bar
);
    wire d_in;
    wire q_curr, q_bar_curr;
    
    // Logic: D = J & ~Q | ~K & Q
    assign d_in = (j & q_bar_curr) | (~k & q_curr);
    
    DFF dff_inst (
        .clk(clk),
        .rst(rst),
        .d(d_in),
        .q(q),
        .q_bar(q_bar)
    );
    
    // Internal wiring to allow feedback
    assign q_curr = q;
    assign q_bar_curr = q_bar;
endmodule
