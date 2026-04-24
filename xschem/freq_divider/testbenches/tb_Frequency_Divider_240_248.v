`timescale 1ns/1ps
`include "Frequency_Divider_240_248.v"

module tb_Frequency_Divider_240_248;
    // Inputs
    reg freq_in;
    reg reset;
    reg select_mode;
    // Outputs
    wire freq_out;

    // Instantiate Top Level
    Frequency_Divider_240_248 uut (
        .freq_in(freq_in), 
        .reset(reset), 
        .select_mode(select_mode), 
        .freq_out(freq_out)
    );

    // Generate Clock: 100MHz (10ns period)
    always #5 freq_in = ~freq_in; 

    // Variables to store time stamps
    real t1, t2;
    real period, frequency_mhz;

    initial begin
        $dumpfile("tb_Frequency_Divider_240_248.vcd");
        $dumpvars;

        // TEST CASE 1: Divide by 248 (Select = 0)
        freq_in = 0;
        reset = 1;
        select_mode = 0; 
        // Wait 20ns for global reset to finish
        #20;
        reset = 0;

        // Wait for the output to stabilize or toggle at least once
        @(posedge freq_out);
        // Capture time of first rising edge
        @(posedge freq_out); 
        t1 = $realtime;
        // Capture time of second rising edge
        @(posedge freq_out); 
        t2 = $realtime;

        // Calculate
        period = t2 - t1;
        
        $display("--------------------------------");
        $display("Mode: Divide-by-248 (Select=0)");
        $display("Time between edges: %0.2f ns", period);
        $display("Expected Period:    2480.00 ns");
        $display("--------------------------------"); 
        
        // TEST CASE 2: Divide by 240 (Select = 1)
        select_mode = 1;
        reset = 1; // Pulse reset when switching modes
        // Wait 20ns for global reset to finish
        #20;
        reset = 0;
        
        // Wait for the output to stabilize or toggle at least once
        @(posedge freq_out);
        // Capture time of first rising edge
        @(posedge freq_out); 
        t1 = $realtime;
        // Capture time of second rising edge
        @(posedge freq_out); 
        t2 = $realtime;

        // Calculate
        period = t2 - t1;
        
        $display("--------------------------------");
        $display("Mode: Divide-by-240 (Select=1)");
        $display("Time between edges: %0.2f ns", period);
        $display("Expected Period:    2400.00 ns");
        $display("--------------------------------"); 

        $finish;
    end
endmodule
