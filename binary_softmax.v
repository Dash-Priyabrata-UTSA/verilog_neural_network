`include "e_power_x.v"
`include "spfp_adder_subtractor.v"
`include "spfp_division.v"

module binary_softmax(
    x_hat1,
    x_hat2,
    prob1,
    prob2,
); 
    //input output
    input [31:0] x_hat1;
    input [31:0] x_hat2;
    output [31:0] prob1;
    output [31:0] prob2;
    //port datatypes
    wire [31:0] x_hat1;
    wire [31:0] x_hat2;
    wire [31:0] prob1;
    wire [31:0] prob2;
    //logic
    wire [31:0] ex1;
    wire [31:0] ex2;
    e_power_x e1(
        x_hat1,
        ex1
    );
    e_power_x e2(
        x_hat2,
        ex2
    );
    //denominator
    wire [31:0] denum:
    spfp_adder_subtractor denum_calc(ex1, ex2, denum);

    //output probabilities
    division prob1_calc(ex1, denum, ,prob1);
    division prob2_calc(ex2, denum, ,prob2);
endmodule

module denominator(
    x_hat1,
    x_hat2,
    prob
);
    //input output
    input [31:0] x_hat1;
    input [31:0] x_hat2;
    output [31:0] prob;
    //port datatypes
    wire [31:0] x_hat1;
    wire [31:0] x_hat2;
    wire [31:0] prob;
    //logic
    wire [31:0] temp1
    e_power_x e1(
        x_hat1,
        temp
    );

endmodule