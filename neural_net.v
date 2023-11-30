`include "dense_layer.v"
module neural_network(
    x_input,
    weight_layer1,
    weight_layer2,
    weight_layer3,
    weight_layer4,
    predictions
);  
    
    parameter wl1_col = 16;
    parameter wl1_row = 32;
    parameter wl2_col = 32;
    parameter wl2_row = 64;
    parameter wl3_col = 64;
    parameter wl3_row = 32;
    parameter wl4_col = 32;
    parameter wl4_row = 2;
    //input_layer
    input [31:0] x_input[7:0];
    input [31:0] weight_layer1[wl1_row-1:0][wl1_col-1:0];
    input [31:0] weight_layer2[wl2_row-1:0][wl2_col-1:0];
    input [31:0] weight_layer3[wl3_row-1:0][wl3_col-1:0];
    input [31:0] weight_layer4[wl4_row-1:0][wl4_col-1:0];
    output [31:0] predictions[1:0];
    // datatype ports
    wire [31:0] x_input[7:0];
    wire [31:0] weight_layer1[wl1_row-1:0][wl1_col-1:0];
    wire [31:0] weight_layer2[wl2_row-1:0][wl2_col-1:0];
    wire [31:0] weight_layer3[wl3_row-1:0][wl3_col-1:0];
    wire [31:0] weight_layer4[wl4_row-1:0][wl4_col-1:0];
    wire [31:0] predictions [1:0];

    // temp weight output variables
    //16x32
    wire [31:0] H1 [wl1_row-1:0];
    dense_layer16x_X #(wl1_row, wl1_col) dense16x32(
        x_input,
        weight_layer1,
        H1
    );
    //32x64
    wire [31:0] H2 [wl2_row-1:0];
    dense_layer32x_X #(wl2_row, wl2_col) dense32x64(
        H1,
        weight_layer2,
        H2
    );
    //64x32
    wire [31:0] H3 [wl3_row-1:0];
    dense_layer64x_X #(wl3_row, wl3_col) dense64x32(
        H2,
        weight_layer3,
        H3
    );
    //32x2
    dense_layer32x_X #(wl4_row, wl4_col) dense32x2(
        x_input,
        weight_layer1,
        predictions
    );

endmodule