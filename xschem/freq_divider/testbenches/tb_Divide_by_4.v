`timescale 1ns/1ps
`include "../../Divide_by_4.v"

module tb_Divide_by_4;
    // Inputs
    reg freq_in;
    reg rst;
    // Output
    wire freq_out;

    Divide_by_4 uut (
        .in(freq_in), 
        .rst(rst), 
        .out(freq_out)
    );

    always #5 freq_in = ~freq_in; // 10ns period

    initial begin
        $dumpfile("tb_Divide_by_4.vcd");
        $dumpvars;

        freq_in = 0;
        rst = 1;

        // Wait 20ns for global reset to finish
        #20;
        rst = 0;
        
        // Run long enough to see several output cycles
        // Input period = 10ns. Output period expected = 40ns.
        #200;
        
        $finish;
    end
endmodule