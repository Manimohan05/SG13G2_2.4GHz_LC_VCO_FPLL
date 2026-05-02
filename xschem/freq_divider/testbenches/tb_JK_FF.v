`timescale 1ns/1ps
`include "../../JK_FF.v"

module tb_JK_FF;
    // Inputs
    reg clk;
    reg rst;
    reg j;
    reg k;
    // Outputs
    wire q;
    wire q_bar;

    // Instantiate the Unit Under Test (UUT)
    JK_FF uut (
        .clk(clk), 
        .rst(rst), 
        .j(j), 
        .k(k), 
        .q(q), 
        .q_bar(q_bar)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_JK_FF.vcd");
        $dumpvars;

        // Initialize Inputs
        clk = 0;
        rst = 1;
        j = 0; k = 0;

        // Wait 20ns for global reset to finish
        #20;
        rst = 0;

        // Case 1: Set (J=1, K=0) -> Q should become 1
        #10 j = 1; k = 0;
        
        // Case 2: Toggle (J=1, K=1) -> Q should invert
        #10 j = 1; k = 1;
        #10; // Wait one clock
        #10; // Wait another clock to see toggling
        #10; // Now Q should be back to 1

        // Case 3: Reset (J=0, K=1) -> Q should become 0
        #10 j = 0; k = 1;

        // Case 4: Hold (J=0, K=0) -> Q should stay 0
        #10 j = 0; k = 0;
        
        // Set to 1 then Hold
        #10 j = 1; k = 0; // Set
        #10 j = 0; k = 0; // Hold (should stay 1)

        #20;
        $finish;
    end
endmodule
