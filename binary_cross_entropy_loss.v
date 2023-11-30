`include "ln_x.v"
`include "spfp_multiplier.v"
`include "spfp_adder_subtractor.v"

module binary_cross_entropy_loss(
    truth1,
    truth2,
    y_hat1,
    y_hat2,
    loss_val
);
    //input output declaration
    input [31:0] truth1;
    input [31:0] truth2;
    input [31:0] y_hat1;
    input [31:0] y_hat2;
    output [31:0] loss_val;
    //port datatypes
    wire [31:0] truth1;
    wire [31:0] truth2;
    wire [31:0] y_hat1;
    wire [31:0] y_hat2;
    wire [31:0] loss_val;

    // calculate logarithm of y_hat's
    wire [31:0] ln_y_hat1;
    ln_x l1( y_hat1, ln_y_hat1);
    wire [31:0] ln_y_hat2;
    ln_x l2( y_hat2, ln_y_hat2);
    // multiplication with truth values
    wire [31:0] yt1; 
    spfp_multiplier l3(ln_y_hat1,truth1,yt1, , );
    wire [31:0] yt2; 
    spfp_multiplier l4(ln_y_hat2,truth2,yt2, , );
    // add both of the multiplicand
    wire [31:0] summation;
    spfp_adder_subtractor add(yt1, yt2, 1'b1, , summation);
    spfp_adder_subtractor subt(32'h00000000, summation, 1'b0, , loss_val);

endmodule