// ========================================================
// Basic Building Block: D Flip-Flop with Active High Reset
// ========================================================

module DFF (
    input wire clk,
    input wire rst,
    input wire d,
    output reg q,
    output wire q_bar
);
    assign q_bar = ~q;

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
