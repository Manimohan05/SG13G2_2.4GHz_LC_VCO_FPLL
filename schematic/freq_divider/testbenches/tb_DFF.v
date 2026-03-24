`timescale 1ns/1ps
`include "../../DFF.v"

module tb_DFF;

    // Inputs
    reg clk;
    reg rst;
    reg d;
    // Outputs
    wire q;
    wire q_bar;

    // Instantiate the Unit Under Test (UUT)
    DFF uut (
        .clk(clk), 
        .rst(rst), 
        .d(d), 
        .q(q), 
        .q_bar(q_bar)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_DFF.vcd");
        $dumpvars;

        // Initialize Inputs
        clk = 0;
        rst = 1;
        d = 0;

        // Wait 20ns for global reset to finish
        #20;
        rst = 0;

        // Test 1: Set D=1
        #10 d = 1;
        
        // Test 2: Set D=0
        #8 d = 0;
        
        // Test 3: Set D=1 again
        #10 d = 1;
        
        // Test 4: Assert Reset while D is high (Asynchronous check)
        #10 rst = 1;
        #10 rst = 0;

        #7;
        $finish;
    end
endmodule
