`timescale 1ns/1ps
//---------------------------------------------------------------------
// Testbench for 9-bit Signed Delta-Sigma Modulator with Serial Input
// Full input sweep: -128 → +127
//---------------------------------------------------------------------

module dsm_top_tb;

    // Testbench signals
    reg clk_dsm;       // DSM clock
    reg rst;         // Active-high reset
    reg sclk;          // Serial clock
    reg sdata;         // Serial data input
    reg en;            // Shift enable
    wire dout;         // DSM output bitstream

    // Instantiate the DUT
    dsm_top uut (
        .clk_dsm(clk_dsm),
        .rst(rst),
        .sclk(sclk),
        .sdata(sdata),
        .en(en),
        .dout(dout)
    );

    //-----------------------------------------------------------------
    // DSM clock generation (runs continuously)
    //-----------------------------------------------------------------
    initial begin
        clk_dsm = 0;
        forever #5 clk_dsm = ~clk_dsm;   // 100 MHz DSM clock
    end

    //-----------------------------------------------------------------
    // Stimulus generation
    //-----------------------------------------------------------------
    integer i;
    integer ones_count;
    integer total_cycles;
    real average;
    reg signed [8:0] data_word;

    initial begin
        // Initialize
        rst = 1;
        en = 0;
        sdata = 0;
        sclk = 0;

        // VCD dump for GTKWave
        $dumpfile("dsm_top_tb.vcd");
        $dumpvars(0, dsm_top_tb);

        // Deassert reset
        #50 rst = 0;

        total_cycles = 2000;

        // Sweep input from -128 to +127
        for (data_word = -128; data_word <= 127; data_word = data_word + 1) begin
            send_serial_byte(data_word);
            //$display("Sent data: %09b", data_word);

            ones_count = 0;

            // Run DSM for fixed number of cycles
            for (i = 0; i < total_cycles; i = i + 1) begin
                @(posedge clk_dsm);
                if (dout)
                    ones_count = ones_count + 1;
            end

            // Compute average duty cycle
            average = ones_count * 1.0 / total_cycles;
            $display("%0d,%0.6f", data_word, average);  // CSV-style output
        end

        $display("Simulation complete.");
        $finish;
    end

    //-----------------------------------------------------------------
    // Task: Send a single 9-bit signed word serially (MSB first)
    //-----------------------------------------------------------------
    task send_serial_byte(input signed [8:0] data);
        integer j;
        begin
            en = 1;
            #10; // setup time before shifting starts

            for (j = 8; j >= 0; j = j - 1) begin
                sdata = data[j];
                #5;              // hold data before clock
                sclk = 1; #10;   // rising edge
                sclk = 0; #5;    // falling edge
            end

            en = 0;
            sdata = 0;
            #40; // delay after transmission
        end
    endtask

endmodule
