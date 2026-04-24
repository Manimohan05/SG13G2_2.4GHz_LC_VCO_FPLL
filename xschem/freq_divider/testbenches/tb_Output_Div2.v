`timescale 1ns/1ps
`include "../../Output_Div2.v"

module tb_Output_Div2;
    // Inputs
    reg clk_in;
    reg rst;
    // Output
    wire freq_out;

    // Instantiate the Unit Under Test (UUT)
    Output_Div2 uut (
        .clk(clk_in), 
        .rst(rst), 
        .out(freq_out)
    );

    // Clock generation
    always #5 clk_in = ~clk_in;

    initial begin
        $dumpfile("tb_Output_Div2.vcd");
        $dumpvars;

        // Initialize Inputs
        clk_in = 0;
        rst = 1;

        // Wait 20ns for global reset to finish
        #20;
        rst = 0;

        // Run long enough to see several output cycles
        // Input period = 10ns. Output period expected = 20ns.
        #100;
        $finish;
    end
endmodule
