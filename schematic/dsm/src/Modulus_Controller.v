// ===============================================
// Module 4: Modulus Controller
// Decodes counter state to control Prescaler (MC)
// ===============================================

module Modulus_Controller (
    input wire b, // LSB
    input wire c,
    input wire d, // MSB
    input wire c_bar,
    input wire d_bar,
    input wire select_in,  // 1->240, 0->248
    output wire mc
);
    wire logic_0, logic_1, logic_2;

    assign logic_0 = b;
    assign logic_1 = c_bar & d_bar;
    assign logic_2 = c & d & select_in;
    
    assign mc = logic_0 | logic_1 | logic_2;
endmodule
