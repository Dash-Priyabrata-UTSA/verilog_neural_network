// Priority Encoder

`include "spfp_multiplier.v"
`include "spfp_adder_subtractor.v"





// Iteration
module Iteration(
	input [31:0] operand_1,
	input [31:0] operand_2,
	output [31:0] solution
	);

wire [31:0] Intermediate_Value1,Intermediate_Value2;

spfp_multiplier M1(operand_1,operand_2,,,,Intermediate_Value1);

//32'h4000_0000 -> 2.
spfp_adder_subtractor A1(32'h4000_0000,{1'b1,Intermediate_Value1[30:0]},1'b0,,Intermediate_Value2);

spfp_multiplier M2(operand_1,Intermediate_Value2,,,,solution);

endmodule

// Division
module division(
	input [31:0] a,
	input [31:0] b,
	output exception,
	output [31:0] res
);

wire sign;
wire [7:0] shift;
wire [7:0] exp_a;
wire [31:0] divisor;
wire [31:0] op_a;
wire [31:0] Intermediate_X0;
wire [31:0] Iteration_X0;
wire [31:0] Iteration_X1;
wire [31:0] Iteration_X2;
wire [31:0] Iteration_X3;
wire [31:0] solution;

wire [31:0] denominator;
wire [31:0] op_a_change;

assign exception = (&a[30:23]) | (&b[30:23]);

assign sign = a[31] ^ b[31];

assign shift = 8'd126 - b[30:23];

assign divisor = {1'b0,8'd126,b[22:0]};

assign denominator = divisor;

assign exp_a = a[30:23] + shift;

assign op_a = {a[31],exp_a,a[22:0]};

assign op_a_change = op_a;

//32'hC00B_4B4B = (-37)/17
spfp_multiplier x0(32'hC00B_4B4B,divisor,,,,Intermediate_X0);

//32'h4034_B4B5 = 48/17
spfp_adder_subtractor X0(Intermediate_X0,32'h4034_B4B5,1'b0,,Iteration_X0);

Iteration X1(Iteration_X0,divisor,Iteration_X1);

Iteration X2(Iteration_X1,divisor,Iteration_X2);

Iteration X3(Iteration_X2,divisor,Iteration_X3);

spfp_multiplier END(Iteration_X3,op_a,,,,solution);

assign res = {sign,solution[30:0]};
endmodule

//division DUT(a,b,exception,res);

