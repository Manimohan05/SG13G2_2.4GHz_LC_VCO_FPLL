`timescale 1ns/1ps
`include "../../Modulus_Controller.v"

module tb_Modulus_Controller;
    // Inputs
    reg b, c, d;
    reg c_bar, d_bar;
    reg select_in;
    // Outputs
    wire mc;

    // Instantiate the Unit Under Test (UUT)
    Modulus_Controller uut (
        .b(b), 
        .c(c), 
        .d(d),
        .c_bar(c_bar),
        .d_bar(d_bar), 
        .select_in(select_in), 
        .mc(mc)
    );

    initial begin
        $dumpfile("tb_Modulus_Controller.vcd");
        $dumpvars;

        // Initialize Inputs
        {b, c, d, c_bar, d_bar} = 5'b00000; #10;

        select_in = 1; #10; // Divide by 240 mode
        // Test Case 1.1
        b = 1'b1; #10; // Expect MC=1
        // Test Case 1.2
        {b, c_bar, d_bar} = 3'b011; #10; // Expect MC=1
        // Test Case 1.3
        {c, d, c_bar, d_bar} = 4'b1100; #10; // Expect MC=1

        select_in = 0; // Divide by 248 mode
        // Test Case 1.1
        b = 1'b1; #10; // Expect MC=1
        // Test Case 1.2
        {b, c_bar, d_bar} = 3'b011; #10; // Expect MC=1
        // Test Case 1.3
        {c, d, c_bar, d_bar} = 4'b1100; #10; // Expect MC=0

        $finish;
    end
endmodule
