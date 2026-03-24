module dsm_and_freq_divider (
    input wire freq_in,       // Frequency Input from VCO
    input  wire rst,          // Active-high reset 
    input  wire sclk,         // Serial clock for shift register
    input  wire sdata,        // Serial data input (MSB first)
    input  wire en,           // Enable loading of serial data
    output wire freq_out      // Frequency Output to PFD
);

    //-------------------------------------------------------------
    // Internal Signals
    //-------------------------------------------------------------
    wire [8:0] data_word;     // Parallel data from shift register
    wire dout;                // dsm output, mode select input

    //-------------------------------------------------------------
    // Serial-to-Parallel Shift Register
    //-------------------------------------------------------------
    shift_reg_serial u_shift (
        .sclk(sclk),
        .rst(rst),
        .en(en),
        .sdata(sdata),
        .q(data_word)
    );

    //-------------------------------------------------------------
    // Delta-Sigma Modulator (8-bit input)
    //-------------------------------------------------------------
    dsm_9bit u_dsm (
        .clk(freq_out),
        .rst(rst),
        .DI(data_word),
        .DO(dout)
    );

    //-------------------------------------------------------------
    // Multi-modulus-divider-240-248 
    //-------------------------------------------------------------
    Frequency_Divider_240_248 uut (
        .freq_in(freq_in), 
        .reset(rst), 
        .select_mode(dout), 
        .freq_out(freq_out)
    );

endmodule

//======================================================================
// 8-bit Delta-Sigma Modulator with Serial Input Interface
//======================================================================
