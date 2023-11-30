`include "spfp_division.v"
`include "spfp_adder_subtractor.v"


module ln_x(
    x_in,
    out
); 
    // input output declaration
    input [31:0] x_in;
    output [31:0] out;
    //port datatypes
    wire [31:0] x_in;
    wire [31:0] out;

    // calculate x_in-1
    wire [31:0] x_1;
    spfp_adder_subtractor s1(x_in,32'h3f800000,1'b0, ,x_1);
    //power 2 calculation
    wire [31:0] temp1;
    wire [31:0] x_2;
    spfp_multiplier p2(x_1,x_1,temp1, , );
    division p2out(temp1, 32'h40000000, ,x_2);
    //power 3 calculation
    wire [31:0] temp2;
    wire [31:0] x_3;
    spfp_multiplier p3(x_1,temp1,temp2, , );
    division p3out(temp2, 32'h40400000, ,x_3);
    //power 4 calculation
    wire [31:0] temp3;
    wire [31:0] x_4;
    spfp_multiplier p4(x_1,temp2,temp3, , );
    division p4out(temp3, 32'h40800000, ,x_4);
    //power 4 calculation
    wire [31:0] temp4;
    wire [31:0] x_5;
    spfp_multiplier p5(x_1,temp3,temp4, , );
    division p5out(temp4, 32'h40a00000, ,x_5);

    // add all the bases
    wire [31:0] ad1;
    wire [31:0] ad2;
    wire [31:0] ad3;

    spfp_adder_subtractor s2(x_1, x_2, 1'b0, , ad1);
    spfp_adder_subtractor s3(ad1, x_3, 1'b1, , ad2);
    spfp_adder_subtractor s4(ad2, x_4, 1'b0, , ad3);
    spfp_adder_subtractor s5(ad3, x_5, 1'b1, , out);

endmodule