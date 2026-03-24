module dsm_9bit (
    input  wire        clk,     // DSM clock
    input  wire        rst,   // Active-low reset
    input  wire [8:0]  DI,      // 8-bit digital input
    output reg         DO       // 1-bit output (bitstream)
);

    // Signed arithmetic for feedback loop
    reg signed [8:0] integrator;      // Extra bit for overflow
    reg signed [8:0] feedback_value;

    // Feedback levels (± full-scale)
    localparam signed [8:0] POS_LEVEL =  9'sd127;
    localparam signed [8:0] NEG_LEVEL = -9'sd128;

    always @(*) begin
        DO = (integrator >= 0);
        feedback_value = DO ? POS_LEVEL : NEG_LEVEL;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            integrator <= 0;
        else
            integrator <= integrator + (DI - feedback_value);
    end

endmodule

//======================================================================
// First-Order 8-bit Delta-Sigma Modulator
//======================================================================