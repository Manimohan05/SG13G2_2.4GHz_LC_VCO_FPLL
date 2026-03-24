// ============================================================
// TOP MODULE: Connecting all blocks
// ============================================================
`include "Divide_by_4.v"
`include "Prescaler_4_5.v"
`include "Mod7_Counter.v"
`include "Modulus_Controller.v"
`include "Output_Div2.v"

module Frequency_Divider_240_248 (
    input wire freq_in,       // Frequency Input from VCO
    input wire reset,         // Global Reset
    input wire select_mode,   // 1 for Div-240, 0 for Div-248
    output wire freq_out      // Frequency Output to PFD
);

    // Interconnect wires
    wire dmd_in;                 // Output of Div-4, Input to Prescaler
    wire clk_jk;                 // Output of Prescaler, Clock for Mod7-Counter
    wire mc_sig;                 // Modulus control signal
    wire b, c, d, c_bar, d_bar;  // Counter bits

    // 1. Divide by 4
    Divide_by_4 div4 (
        .in(freq_in),
        .rst(reset),
        .out(dmd_in)
    );

    // 2. Prescaler 4/5
    Prescaler_4_5 pre45 (
        .clk(dmd_in),
        .rst(reset),
        .mc(mc_sig),
        .out(clk_jk)
    );

    // 3. Mod-7 Counter
    Mod7_Counter mod7 (
        .clk(clk_jk),
        .rst(reset),
        .bit1(b),
        .bit2(c),
        .bit3(c_bar),
        .bit4(d_bar),
        .out(d)
    );

    // 4. Modulus Controller
    Modulus_Controller mod_ctrl (
        .b(b),
        .c(c),
        .d(d),
        .c_bar(c_bar),
        .d_bar(d_bar),
        .select_in(select_mode),
        .mc(mc_sig)
    );

    // 5. Final Divide-by-2 (Duty Cycle Corrector)
    Output_Div2 out_stg (
        .clk(d), 
        .rst(reset),
        .out(freq_out)
    );

endmodule


