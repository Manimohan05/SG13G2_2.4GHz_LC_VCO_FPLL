`timescale 1ns/1ps
//---------------------------------------------------------------------
// Testbench for 9-bit Signed Delta-Sigma Modulator and divider 240/248
// Full input sweep: -128 → +127
//---------------------------------------------------------------------

module tb_dsm_and_freq_divider;

    // Testbench signals
    reg freq_in;       // VCO clk
    reg rst;           // Active-high reset
    reg sclk;          // Serial clock
    reg sdata;         // Serial data input
    reg en;            // Shift enable
    wire freq_out;     // Fractional Divided clk

    // Instantiate the DUT
    dsm_and_freq_divider uut (
        .freq_in(freq_in),
        .rst(rst),
        .sclk(sclk),
        .sdata(sdata),
        .en(en),
        .freq_out(freq_out)
    );

    //-----------------------------------------------------------------
    // VCO clock generation (runs continuously)
    //-----------------------------------------------------------------
    initial begin
        freq_in = 0; 
        forever #5 freq_in = ~freq_in;   // 100 MHz VCO clock
    end

    //-----------------------------------------------------------------
    // Stimulus generation
    //-----------------------------------------------------------------
    integer i;
    integer ones_count;
    integer total_cycles;
    real average;
    reg signed [8:0] data_word;

    real t1;
    real t2;
    real period_sum;
    real avg_period;

    initial begin
        // Initialize
        rst = 1;
        en = 0;
        sdata = 0;
        sclk = 0;

        // VCD dump for GTKWave
        $dumpfile("dsm_and_freq_divider.vcd");
        $dumpvars(0, tb_dsm_and_freq_divider);

        // Apply reset
        #50 rst = 0;

        total_cycles = 500;

        // Sweep input from -128 to +127
        for (data_word = -128; data_word <= 127; data_word = data_word + 4) begin
            send_serial_byte(data_word);
            //$display("Sent data: %09b", data_word);

            // Variables for period measurement
            t1 = 0;
            t2 = 0;
            period_sum = 0;
            avg_period = 0;
            
            // Wait for the output to stabilize or toggle at least once
            @(posedge freq_out);

            // Capture time of first rising edge
            @(posedge freq_out); 
            t1 = $realtime;

            // Capture a few periods for averaging
            for (i = 0; i < total_cycles; i = i + 1) begin

                // Capture time of second rising edge
                @(posedge freq_out); 
                t2 = $realtime;

                period_sum = period_sum + (t2-t1);

                //set second rising edge as first of next period
                t1 = t2; 
            end
            
            // Calculate average period and frequency
            avg_period = period_sum / total_cycles ; // in nano seconds

            
            // Print data_word, average period, and average frequency
            $display("%0d,%0.6f", data_word, avg_period);  // CSV-style output
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
