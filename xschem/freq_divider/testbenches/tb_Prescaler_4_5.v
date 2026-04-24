`timescale 1ns/1ps
`include "../../Prescaler_4_5.v"

module tb_Prescaler_4_5;
    // Inputs
    reg clk;
    reg rst;
    reg mc;
    // Output
    wire out;

    // Instantiate the Unit Under Test (UUT)
    Prescaler_4_5 uut (
        .clk(clk), 
        .rst(rst), 
        .mc(mc), 
        .out(out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_Prescaler_4_5.vcd");
        $dumpvars;

        // Initialize Inputs
        clk = 0;
        rst = 1;
        mc = 0;

        // Wait 20ns for global reset to finish
        #20;
        rst = 0;

        // Part 1: Test Divide by 5 (MC = 0)
        // Input period = 10ns. Output period expected = 50ns.
        #200; 
        
        // Part 2: Test Divide by 4 (MC = 1)
        // Input period = 10ns. Output period expected = 40ns.
        mc = 1;
        #200;

        $finish;
    end
endmodule
