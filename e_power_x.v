`include "spfp_multiplier.v"
`include "spfp_adder_subtractor.v"
`include "spfp_division.v"

module e_power_x(
    x_in,
    out
); 
    //input output declaration
    input [31:0] x_in;
    input [31:0] out;
    // port data types
    wire [31:0] x_in;
    wire [31:0] out;

    //temp vars
    wire [31:0] x_2;
    wire [31:0] x_3;
    wire [31:0] x_4;
    wire [31:0] x_5;

    // base 2
    wire [31:0] temp1;
    spfp_multiplier base2(x_in,x_in, , , ,temp1);
    division base2out(temp1,32'h40800000, ,x_2);

    // base 3
    wire [31:0] temp2;
    spfp_multiplier base3(temp1,x_in, , , ,temp2);
    division base3out(temp2,32'h40c00000, ,x_3);

    // base 4
    wire [31:0] temp3;
    spfp_multiplier base4(temp2,x_in, , , ,temp3);
    division base4out(temp3,32'h41c00000, ,x_4);

    // base 5
    wire [31:0] temp4;
    spfp_multiplier base5(temp3,x_in, , , ,temp4);
    division base5out(temp4,32'h42f00000, ,x_5);

    //add 1 and x
    wire [31:0] temp5;
    spfp_adder_subtractor u1 (32'h3f800000, x_in, temp5);
    //temp5 + base_2
    wire [31:0] temp6;
    spfp_adder_subtractor u2 (temp5, x_2, 1'b1,  ,temp6);
    //temp6 + base_3
    wire [31:0] temp7;
    spfp_adder_subtractor u3 (temp6, x_3, 1'b1,  , temp7);
    //temp7 + base_4
    wire [31:0] temp8;
    spfp_adder_subtractor u4 (temp7, x_4, 1'b1,  , temp8);
    //temp7 + base_5
    spfp_adder_subtractor u5 (temp8, x_5, 1'b1,  , out);

endmodule