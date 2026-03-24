`timescale 1ns/1ps
`include "../../Mod7_Counter.v"

module tb_Mod7_Counter;
    // Inputs
    reg clk;
    reg rst;
    // Outputs
    wire b; // LSB
    wire c;
    wire d; // MSB

    /* verilator lint_off PINCONNECTEMPTY */
    // Instantiate the Unit Under Test (UUT)
    Mod7_Counter uut (
        .clk(clk), 
        .rst(rst), 
        .bit1(b), 
        .bit2(c),
        .bit3(), // Unused in this testbench
        .bit4(), // Unused in this testbench
        .out(d)
    );
    /* verilator lint_on PINCONNECTEMPTY */

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_Mod7_Counter.vcd");
        $dumpvars;

        // Initialize Inputs
        clk = 0;
        rst = 1;

        // Wait 20ns for global reset to finish
        #20;
        rst = 0;

        // Run through multiple loops of the counter.
        // // Input period = 10ns. Output period expected = 70ns.
        #200;
        
        $finish;
    end
endmodule
