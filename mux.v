module mux(
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
module dense_layer8x_X(
    in_layer,
    weight_layer,
    out_layer
);
    parameter ROWS = 8;// number of OUTPUT neurons
    parameter COLUMNS = 8; //number of INPUT neurons

    //input output declaration
    input wire [31:0] in_layer [COLUMNS-1:0];
    input wire [31:0] weight_layer [ROWS-1:0][COLUMNS-1:0];
    output wire [31:0] out_layer [ROWS-1:0];

    //integer i;
    genvar i;
    generate
        for (i=0;i<ROWS; i=i+1) begin 
            neuron_mac8 mac(
                in_layer, 
                weight_layer[i], 
                out_layer[i]
                );
        end
    
    endgenerate

endmodule

module dense_layer16x_X(
    in_layer,
    weight_layer,
    out_layer
);
    parameter ROWS = 8;// number of OUTPUT neurons
    parameter COLUMNS = 16; //number of INPUT neurons

    //input output declaration
    input wire [31:0] in_layer [COLUMNS-1:0];
    input wire [31:0] weight_layer [ROWS-1:0][COLUMNS-1:0];
    output wire [31:0] out_layer [ROWS-1:0];

    //integer i;
    genvar i;
    generate
        for (i=0;i<ROWS; i=i+1) begin 
            neuron_mac16 mac(
                in_layer, 
                weight_layer[i], 
                out_layer[i]
                );
        end
    
    endgenerate

endmodule

module dense_layer32x_X(
    in_layer,
    weight_layer,
    out_layer
);
    parameter ROWS = 8;// number of OUTPUT neurons
    parameter COLUMNS = 32; //number of INPUT neurons

    //input output declaration
    input wire [31:0] in_layer [COLUMNS-1:0];
    input wire [31:0] weight_layer [ROWS-1:0][COLUMNS-1:0];
    output wire [31:0] out_layer [ROWS-1:0];

    //integer i;
    genvar i;
    generate
        for (i=0;i<ROWS; i=i+1) begin 
            neuron_mac32 mac(
                in_layer, 
                weight_layer[i], 
                out_layer[i]
                );
        end
    
    endgenerate

endmodule

module dense_layer64x_X(
    in_layer,
    weight_layer,
    out_layer
);
    parameter ROWS = 8;// number of OUTPUT neurons
    parameter COLUMNS = 64; //number of INPUT neurons

    //input output declaration
    input wire [31:0] in_layer [COLUMNS-1:0];
    input wire [31:0] weight_layer [ROWS-1:0][COLUMNS-1:0];
    output wire [31:0] out_layer [ROWS-1:0];

    //integer i;
    genvar i;
    generate
        for (i=0;i<ROWS; i=i+1) begin 
            neuron_mac64 mac(
                in_layer, 
                weight_layer[i], 
                out_layer[i]
                );
        end
    
    endgenerate

endmodule



// neurons_mac8
module neuron_mac8(
    in_layer,
    weight_column,
    out_neuron
);
    parameter COLUMNS = 8; // number of input neurons

    //input output declaration
    input wire [31:0] in_layer [COLUMNS-1:0];
    input wire [31:0] weight_column [COLUMNS-1:0];
    output wire [31:0] out_neuron;

    // temp_reg to store all column products
    wire [31:0] column_products [COLUMNS-1:0];

    //integer i;
    genvar i;
    generate 
        for (i=0; i<COLUMNS; i=i+1) begin
            //  spfp_multiplier m (in_layer[i], weight_column[i], column_products[i], , ); 
            spfp_multiplier m (in_layer[i], weight_column[i], , , ,column_products[i]);           
        end
    endgenerate
    
    //sum all the elements present in column_products register
    //temp reg to store 
    wire [31:0] temp1;
    wire [31:0] temp2;
    wire [31:0] temp3;
    wire [31:0] temp4;
    wire [31:0] temp5;
    wire [31:0] temp6;
    wire [31:0] temp7;

    //tmp output
    wire [31:0] temp_out;

    // # of COLUMNS adder = 8
    spfp_adder_subtractor n1 (column_products[0], 32'd0, 1'b1, ,temp1);
    spfp_adder_subtractor n2 (column_products[1], temp1, 1'b1, , temp2);
    spfp_adder_subtractor n3 (column_products[2], temp2, 1'b1, , temp3);
    spfp_adder_subtractor n4 (column_products[3], temp3, 1'b1, , temp4);
    spfp_adder_subtractor n5 (column_products[4], temp4, 1'b1, , temp5);
    spfp_adder_subtractor n6 (column_products[5], temp5, 1'b1, , temp6);
    spfp_adder_subtractor n7 (column_products[6], temp6, 1'b1, , temp7);
    spfp_adder_subtractor n8 (column_products[7], temp7, 1'b1, , temp_out);

    //relu activation
    ReLU relu(
        temp_out,
        out_neuron
    ); 
    

endmodule

//mac with 16 neurons
module neuron_mac16(
    in_layer,
    weight_column,
    out_neuron
);
    parameter COLUMNS = 16; // number of input neurons

    //input output declaration
    input wire [31:0] in_layer [COLUMNS-1:0];
    input wire [31:0] weight_column [COLUMNS-1:0];
    output wire [31:0] out_neuron;

    // temp_reg to store all column products
    wire [31:0] column_products [COLUMNS-1:0];

    //integer i;
    genvar i;
    generate 
        for (i=0; i<COLUMNS; i=i+1) begin
            //  spfp_multiplier m (in_layer[i], weight_column[i], column_products[i], , );
            spfp_multiplier m (in_layer[i], weight_column[i], , , ,column_products[i]);          
        end
    endgenerate
     
    
    //sum all the elements present in column_products register
    //temp reg to store 
    wire [31:0] temp1;
    wire [31:0] temp2;
    wire [31:0] temp3;
    wire [31:0] temp4;
    wire [31:0] temp5;
    wire [31:0] temp6;
    wire [31:0] temp7;
    wire [31:0] temp8;
    wire [31:0] temp9;
    wire [31:0] temp10;
    wire [31:0] temp11;
    wire [31:0] temp12;
    wire [31:0] temp13;
    wire [31:0] temp14;
    wire [31:0] temp15;

    //tmp output
    wire [31:0] temp_out;

    // # of COLUMNS-1 adder
    // # of COLUMNS adder = 8
    spfp_adder_subtractor n1 (column_products[0], 32'd0, 1'b1, , temp1);
    spfp_adder_subtractor n2 (column_products[1], temp1, 1'b1, , temp2);
    spfp_adder_subtractor n3 (column_products[2], temp2, 1'b1, , temp3);
    spfp_adder_subtractor n4 (column_products[3], temp3, 1'b1, , temp4);
    spfp_adder_subtractor n5 (column_products[4], temp4, 1'b1, , temp5);
    spfp_adder_subtractor n6 (column_products[5], temp5, 1'b1, , temp6);
    spfp_adder_subtractor n7 (column_products[6], temp6, 1'b1, , temp7);
    spfp_adder_subtractor n8 (column_products[7], temp7, 1'b1, , temp8);
    spfp_adder_subtractor n9 (column_products[8], temp8, 1'b1, , temp9);
    spfp_adder_subtractor n10 (column_products[9], temp9, 1'b1, , temp10);
    spfp_adder_subtractor n11 (column_products[10], temp10, 1'b1, , temp11);
    spfp_adder_subtractor n12 (column_products[11], temp11, 1'b1, , temp12);
    spfp_adder_subtractor n13 (column_products[12], temp12, 1'b1, , temp13);
    spfp_adder_subtractor n14 (column_products[13], temp13, 1'b1, , temp14);
    spfp_adder_subtractor n15 (column_products[14], temp14, 1'b1, , temp15);
    spfp_adder_subtractor n16 (column_products[15], temp15, 1'b1, , temp_out);

    //relu activation
    ReLU relu(
        temp_out,
        out_neuron
    ); 

endmodule

// mac with 32 neurons
module neuron_mac32(
    in_layer,
    weight_column,
    out_neuron
);
    parameter COLUMNS = 32; // number of input neurons

    //input output declaration
    input wire [31:0] in_layer [COLUMNS-1:0];
    input wire [31:0] weight_column [COLUMNS-1:0];
    output wire [31:0] out_neuron;

    // temp_reg to store all column products
    wire [31:0] column_products [COLUMNS-1:0];

    //integer i;
    genvar i;
    generate 
        for (i=0; i<COLUMNS; i=i+1) begin
            //  spfp_multiplier m (in_layer[i], weight_column[i], column_products[i], , );  
            spfp_multiplier m (in_layer[i], weight_column[i], , , ,column_products[i]);          
        end
    endgenerate
    
    //sum all the elements present in column_products register
    //temp reg to store 
    wire [31:0] temp1;
    wire [31:0] temp2;
    wire [31:0] temp3;
    wire [31:0] temp4;
    wire [31:0] temp5;
    wire [31:0] temp6;
    wire [31:0] temp7;
    wire [31:0] temp8;
    wire [31:0] temp9;
    wire [31:0] temp10;
    wire [31:0] temp11;
    wire [31:0] temp12;
    wire [31:0] temp13;
    wire [31:0] temp14;
    wire [31:0] temp15;
    wire [31:0] temp16;
    wire [31:0] temp17;
    wire [31:0] temp18;
    wire [31:0] temp19;
    wire [31:0] temp20;
    wire [31:0] temp21;
    wire [31:0] temp22;
    wire [31:0] temp23;
    wire [31:0] temp24;
    wire [31:0] temp25;
    wire [31:0] temp26;
    wire [31:0] temp27;
    wire [31:0] temp28;
    wire [31:0] temp29;
    wire [31:0] temp30;
    wire [31:0] temp31;

    //tmp output
    wire [31:0] temp_out;

    // # of COLUMNS adder
    // # of COLUMNS adder = 32
    spfp_adder_subtractor n1 (column_products[0], 32'd0, 1'b1, , temp1);
    spfp_adder_subtractor n2 (column_products[1], temp1, 1'b1, , temp2);
    spfp_adder_subtractor n3 (column_products[2], temp2, 1'b1, , temp3);
    spfp_adder_subtractor n4 (column_products[3], temp3, 1'b1, , temp4);
    spfp_adder_subtractor n5 (column_products[4], temp4, 1'b1, , temp5);
    spfp_adder_subtractor n6 (column_products[5], temp5, 1'b1, , temp6);
    spfp_adder_subtractor n7 (column_products[6], temp6, 1'b1, , temp7);
    spfp_adder_subtractor n8 (column_products[7], temp7, 1'b1, , temp8);
    spfp_adder_subtractor n9 (column_products[8], temp8, 1'b1, , temp9);
    spfp_adder_subtractor n10 (column_products[9], temp9, 1'b1, , temp10);
    spfp_adder_subtractor n11 (column_products[10], temp10, 1'b1, , temp11);
    spfp_adder_subtractor n12 (column_products[11], temp11, 1'b1, , temp12);
    spfp_adder_subtractor n13 (column_products[12], temp12, 1'b1, , temp13);
    spfp_adder_subtractor n14 (column_products[13], temp13, 1'b1, , temp14);
    spfp_adder_subtractor n15 (column_products[14], temp14, 1'b1, , temp15);
    spfp_adder_subtractor n16 (column_products[15], temp15, 1'b1, , temp16);
    spfp_adder_subtractor n17 (column_products[16], temp16, 1'b1, , temp17);
    spfp_adder_subtractor n18 (column_products[17], temp17, 1'b1, , temp18);
    spfp_adder_subtractor n19 (column_products[18], temp18, 1'b1, , temp19);
    spfp_adder_subtractor n20 (column_products[19], temp19, 1'b1, , temp20);
    spfp_adder_subtractor n21 (column_products[20], temp20, 1'b1, , temp21);
    spfp_adder_subtractor n22 (column_products[21], temp21, 1'b1, , temp22);
    spfp_adder_subtractor n23 (column_products[22], temp22, 1'b1, , temp23);
    spfp_adder_subtractor n24 (column_products[23], temp23, 1'b1, , temp24);
    spfp_adder_subtractor n25 (column_products[24], temp24, 1'b1, , temp25);
    spfp_adder_subtractor n26 (column_products[25], temp25, 1'b1, , temp26);
    spfp_adder_subtractor n27 (column_products[26], temp26, 1'b1, , temp27);
    spfp_adder_subtractor n28 (column_products[27], temp27, 1'b1, , temp28);
    spfp_adder_subtractor n29 (column_products[28], temp28, 1'b1, , temp29);
    spfp_adder_subtractor n30 (column_products[29], temp29, 1'b1, , temp30);
    spfp_adder_subtractor n31 (column_products[30], temp30, 1'b1, , temp31);
    spfp_adder_subtractor n32 (column_products[31], temp31, 1'b1, , temp_out);

    //relu activation
    ReLU relu(
        temp_out,
        out_neuron
    ); 

endmodule

//mac with 64 neurons
module neuron_mac64(
    in_layer,
    weight_column,
    out_neuron
);
    parameter COLUMNS = 64; // number of input neurons

    //input output declaration
    input wire [31:0] in_layer [COLUMNS-1:0];
    input wire [31:0] weight_column [COLUMNS-1:0];
    output wire [31:0] out_neuron;

    // temp_reg to store all column products
    wire [31:0] column_products [COLUMNS-1:0];

    //integer i;
    genvar i;
    generate 
        for (i=0; i<COLUMNS; i=i+1) begin
            //  spfp_multiplier m (in_layer[i], weight_column[i], column_products[i], , );  
            spfp_multiplier m (in_layer[i], weight_column[i], , , ,column_products[i]);          
        end
    endgenerate
    
    //sum all the elements present in column_products register
    //temp reg to store 
    wire [31:0] temp1;
    wire [31:0] temp2;
    wire [31:0] temp3;
    wire [31:0] temp4;
    wire [31:0] temp5;
    wire [31:0] temp6;
    wire [31:0] temp7;
    wire [31:0] temp8;
    wire [31:0] temp9;
    wire [31:0] temp10;
    wire [31:0] temp11;
    wire [31:0] temp12;
    wire [31:0] temp13;
    wire [31:0] temp14;
    wire [31:0] temp15;
    wire [31:0] temp16;
    wire [31:0] temp17;
    wire [31:0] temp18;
    wire [31:0] temp19;
    wire [31:0] temp20;
    wire [31:0] temp21;
    wire [31:0] temp22;
    wire [31:0] temp23;
    wire [31:0] temp24;
    wire [31:0] temp25;
    wire [31:0] temp26;
    wire [31:0] temp27;
    wire [31:0] temp28;
    wire [31:0] temp29;
    wire [31:0] temp30;
    wire [31:0] temp31;
    wire [31:0] temp32;
    wire [31:0] temp33;
    wire [31:0] temp34;
    wire [31:0] temp35;
    wire [31:0] temp36;
    wire [31:0] temp37;
    wire [31:0] temp38;
    wire [31:0] temp39;
    wire [31:0] temp40;
    wire [31:0] temp41;
    wire [31:0] temp42;
    wire [31:0] temp43;
    wire [31:0] temp44;
    wire [31:0] temp45;
    wire [31:0] temp46;
    wire [31:0] temp47;
    wire [31:0] temp48;
    wire [31:0] temp49;
    wire [31:0] temp50;
    wire [31:0] temp51;
    wire [31:0] temp52;
    wire [31:0] temp53;
    wire [31:0] temp54;
    wire [31:0] temp55;
    wire [31:0] temp56;
    wire [31:0] temp57;
    wire [31:0] temp58;
    wire [31:0] temp59;
    wire [31:0] temp60;
    wire [31:0] temp61;
    wire [31:0] temp62;
    wire [31:0] temp63;

    //tmp output
    wire [31:0] temp_out;

    // # of COLUMNS adder
    // # of COLUMNS adder = 32
    spfp_adder_subtractor n1 (column_products[0], 32'd0, 1'b1, , temp1);
    spfp_adder_subtractor n2 (column_products[1], temp1, 1'b1, , temp2);
    spfp_adder_subtractor n3 (column_products[2], temp2, 1'b1, , temp3);
    spfp_adder_subtractor n4 (column_products[3], temp3, 1'b1, , temp4);
    spfp_adder_subtractor n5 (column_products[4], temp4, 1'b1, , temp5);
    spfp_adder_subtractor n6 (column_products[5], temp5, 1'b1, , temp6);
    spfp_adder_subtractor n7 (column_products[6], temp6, 1'b1, , temp7);
    spfp_adder_subtractor n8 (column_products[7], temp7, 1'b1, , temp8);
    spfp_adder_subtractor n9 (column_products[8], temp8, 1'b1, , temp9);
    spfp_adder_subtractor n10 (column_products[9], temp9, 1'b1, , temp10);
    spfp_adder_subtractor n11 (column_products[10], temp10, 1'b1, , temp11);
    spfp_adder_subtractor n12 (column_products[11], temp11, 1'b1, , temp12);
    spfp_adder_subtractor n13 (column_products[12], temp12, 1'b1, , temp13);
    spfp_adder_subtractor n14 (column_products[13], temp13, 1'b1, , temp14);
    spfp_adder_subtractor n15 (column_products[14], temp14, 1'b1, , temp15);
    spfp_adder_subtractor n16 (column_products[15], temp15, 1'b1, , temp16);
    spfp_adder_subtractor n17 (column_products[16], temp16, 1'b1, , temp17);
    spfp_adder_subtractor n18 (column_products[17], temp17, 1'b1, , temp18);
    spfp_adder_subtractor n19 (column_products[18], temp18, 1'b1, , temp19);
    spfp_adder_subtractor n20 (column_products[19], temp19, 1'b1, , temp20);
    spfp_adder_subtractor n21 (column_products[20], temp20, 1'b1, , temp21);
    spfp_adder_subtractor n22 (column_products[21], temp21, 1'b1, , temp22);
    spfp_adder_subtractor n23 (column_products[22], temp22, 1'b1, , temp23);
    spfp_adder_subtractor n24 (column_products[23], temp23, 1'b1, , temp24);
    spfp_adder_subtractor n25 (column_products[24], temp24, 1'b1, , temp25);
    spfp_adder_subtractor n26 (column_products[25], temp25, 1'b1, , temp26);
    spfp_adder_subtractor n27 (column_products[26], temp26, 1'b1, , temp27);
    spfp_adder_subtractor n28 (column_products[27], temp27, 1'b1, , temp28);
    spfp_adder_subtractor n29 (column_products[28], temp28, 1'b1, , temp29);
    spfp_adder_subtractor n30 (column_products[29], temp29, 1'b1, , temp30);
    spfp_adder_subtractor n31 (column_products[30], temp30, 1'b1, , temp31);
    spfp_adder_subtractor n32 (column_products[31], temp31, 1'b1, , temp32);
    spfp_adder_subtractor n33 (column_products[32], temp32, 1'b1, , temp33);
    spfp_adder_subtractor n34 (column_products[33], temp33, 1'b1, , temp34);
    spfp_adder_subtractor n35 (column_products[34], temp34, 1'b1, , temp35);
    spfp_adder_subtractor n36 (column_products[35], temp35, 1'b1, , temp36);
    spfp_adder_subtractor n37 (column_products[36], temp36, 1'b1, , temp37);
    spfp_adder_subtractor n38 (column_products[37], temp37, 1'b1, , temp38);
    spfp_adder_subtractor n39 (column_products[38], temp38, 1'b1, , temp39);
    spfp_adder_subtractor n40 (column_products[39], temp39, 1'b1, , temp40);
    spfp_adder_subtractor n41 (column_products[40], temp40, 1'b1, , temp41);
    spfp_adder_subtractor n42 (column_products[41], temp41, 1'b1, , temp42);
    spfp_adder_subtractor n43 (column_products[42], temp42, 1'b1, , temp43);
    spfp_adder_subtractor n44 (column_products[43], temp43, 1'b1, , temp44);
    spfp_adder_subtractor n45 (column_products[44], temp44, 1'b1, , temp45);
    spfp_adder_subtractor n46 (column_products[45], temp45, 1'b1, , temp46);
    spfp_adder_subtractor n47 (column_products[46], temp46, 1'b1, , temp47);
    spfp_adder_subtractor n48 (column_products[47], temp47, 1'b1, , temp48);
    spfp_adder_subtractor n49 (column_products[48], temp48, 1'b1, , temp49);
    spfp_adder_subtractor n50 (column_products[49], temp49, 1'b1, , temp50);
    spfp_adder_subtractor n51 (column_products[50], temp50, 1'b1, , temp51);
    spfp_adder_subtractor n52 (column_products[51], temp51, 1'b1, , temp52);
    spfp_adder_subtractor n53 (column_products[52], temp52, 1'b1, , temp53);
    spfp_adder_subtractor n54 (column_products[53], temp53, 1'b1, , temp54);
    spfp_adder_subtractor n55 (column_products[54], temp54, 1'b1, , temp55);
    spfp_adder_subtractor n56 (column_products[55], temp55, 1'b1, , temp56);
    spfp_adder_subtractor n57 (column_products[56], temp56, 1'b1, ,  temp57);
    spfp_adder_subtractor n58 (column_products[57], temp57, 1'b1, , temp58);
    spfp_adder_subtractor n59 (column_products[58], temp58, 1'b1, , temp59);
    spfp_adder_subtractor n60 (column_products[59], temp59, 1'b1, , temp60);
    spfp_adder_subtractor n61 (column_products[60], temp60, 1'b1, , temp61);
    spfp_adder_subtractor n62 (column_products[61], temp61, 1'b1, , temp62);
    spfp_adder_subtractor n63 (column_products[62], temp62, 1'b1, , temp63);
    spfp_adder_subtractor n64 (column_products[63], temp63, 1'b1, , temp_out);

    //relu activation
    ReLU relu(
        temp_out,
        out_neuron
    ); 

endmodule

module ReLU(
    inp,
    out
); 
    // Input and Output declaration
    input [31:0] inp;
    output [31:0] out;
    // Port datatypes
    wire [31:0] inp;
    wire [31:0] out;
    // logic
    assign out = (inp[31] == 1'b1)? 32'h00000000 :
                 (inp[30:0] == 31'b0)? 32'h00000000: 
                  inp;
endmodule

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


// Multiplication
module spfp_multiplier(
		input [31:0] a,
		input [31:0] b,
		output exception,overflow,underflow,
		output [31:0] res
		);

	wire sign,product_round,normalised,zero;
	wire [8:0] exponent,sum_exponent;
	wire [22:0] product_mantissa;
	wire [23:0] op_a,op_b;
	wire [47:0] product,product_normalised; //48 Bits


	assign sign = a[31] ^ b[31];   													// XOR of 32nd bit

	assign exception = (&a[30:23]) | (&b[30:23]);											// Execption sets to 1 when exponent of any a or b is 255
																	// If exponent is 0, hidden bit is 0



	assign op_a = (|a[30:23]) ? {1'b1,a[22:0]} : {1'b0,a[22:0]};

	assign op_b = (|b[30:23]) ? {1'b1,b[22:0]} : {1'b0,b[22:0]};

	assign product = op_a * op_b;													// Product

	assign product_round = |product_normalised[22:0];  									        // Last 22 bits are ORed for rounding off purpose

	assign normalised = product[47] ? 1'b1 : 1'b0;	

	assign product_normalised = normalised ? product : product << 1;								// Normalized value based on 48th bit

	assign product_mantissa = product_normalised[46:24] + {21'b0,(product_normalised[23] & product_round)};				// Mantissa

	assign zero = exception ? 1'b0 : (product_mantissa == 23'd0) ? 1'b1 : 1'b0;

	assign sum_exponent = a[30:23] + b[30:23];

	assign exponent = sum_exponent - 8'd127 + normalised;

	assign overflow = ((exponent[8] & !exponent[7]) & !zero) ;									// Overall exponent is greater than 255 then Overflow

	assign underflow = ((exponent[8] & exponent[7]) & !zero) ? 1'b1 : 1'b0; 							// Sum of exponents is less than 255 then Underflow 

	assign res = exception ? 32'd0 : zero ? {sign,31'd0} : overflow ? {sign,8'hFF,23'd0} : underflow ? {sign,31'd0} : {sign,exponent[7:0],product_mantissa};


endmodule


//Addition and Subtraction

module spfp_adder_subtractor(
input [31:0] a,b,
input add_sub_signal,														// If 1 then addition otherwise subtraction
output exception,
output [31:0] res      
);

wire operation_add_sub_signal;
wire enable;
wire output_sign;

wire [31:0] op_a,op_b;
wire [23:0] significand_a,significand_b;
wire [7:0] exponent_diff;


wire [23:0] significand_b_add_sub;
wire [7:0] exp_b_add_sub;

wire [24:0] significand_add;
wire [30:0] add_sum;

wire [23:0] significand_sub_complement;
wire [24:0] significand_sub;
wire [30:0] sub_diff;
wire [24:0] subtraction_diff; 
wire [7:0] exp_sub;

assign {enable,op_a,op_b} = (a[30:0] < b[30:0]) ? {1'b1,b,a} : {1'b0,a,b};							// For operations always op_a must not be less than b

assign exp_a = op_a[30:23];
assign exp_b = op_b[30:23];

assign exception = (&op_a[30:23]) | (&op_b[30:23]);										// Exception flag sets 1 if either one of the exponent is 255.

assign output_sign = add_sub_signal ? enable ? !op_a[31] : op_a[31] : op_a[31] ;

assign operation_add_sub_signal = add_sub_signal ? op_a[31] ^ op_b[31] : ~(op_a[31] ^ op_b[31]);				// Assign significand values according to Hidden Bit.

assign significand_a = (|op_a[30:23]) ? {1'b1,op_a[22:0]} : {1'b0,op_a[22:0]};							// If exponent is zero,hidden bit = 0,else 1
assign significand_b = (|op_b[30:23]) ? {1'b1,op_b[22:0]} : {1'b0,op_b[22:0]};

assign exponent_diff = op_a[30:23] - op_b[30:23];										// Exponent difference calculation

assign significand_b_add_sub = significand_b >> exponent_diff;

assign exp_b_add_sub = op_b[30:23] + exponent_diff; 

assign perform = (op_a[30:23] == exp_b_add_sub);										// Checking if exponents are same

// Add Block //
assign significand_add = (perform & operation_add_sub_signal) ? (significand_a + significand_b_add_sub) : 25'd0; 

assign add_sum[22:0] = significand_add[24] ? significand_add[23:1] : significand_add[22:0];					// res will be most 23 bits if carry generated, else least 22 bits.

assign add_sum[30:23] = significand_add[24] ? (1'b1 + op_a[30:23]) : op_a[30:23];						// If carry generates in sum value then exponent is added with 1 else feed as it is.

// Sub Block //
assign significand_sub_complement = (perform & !operation_add_sub_signal) ? ~(significand_b_add_sub) + 24'd1 : 24'd0 ; 

assign significand_sub = perform ? (significand_a + significand_sub_complement) : 25'd0;

priority_encoder pe1(significand_sub,op_a[30:23],subtraction_diff,exp_sub);

assign sub_diff[30:23] = exp_sub;

assign sub_diff[22:0] = subtraction_diff[22:0];


// Output //
assign res = exception ? 32'b0 : ((!operation_add_sub_signal) ? {output_sign,sub_diff} : {output_sign,add_sum});

endmodule

module priority_encoder(
			input [24:0] significand,
			input [7:0] exp_a,
			output reg [24:0] Significand,
			output [7:0] exp_sub
			);

    reg [4:0] shift;

    always @(significand)
    begin
        casex (significand)
            25'b1_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx :	begin
                                                        Significand = significand;
                                                        shift = 5'd0;
                                                    end
            25'b1_01xx_xxxx_xxxx_xxxx_xxxx_xxxx : 	begin						
                                                        Significand = significand << 1;
                                                        shift = 5'd1;
                                                    end

            25'b1_001x_xxxx_xxxx_xxxx_xxxx_xxxx : 	begin						
                                                        Significand = significand << 2;
                                                        shift = 5'd2;
                                                    end

            25'b1_0001_xxxx_xxxx_xxxx_xxxx_xxxx : 	begin 							
                                                        Significand = significand << 3;
                                                        shift = 5'd3;
                                                    end

            25'b1_0000_1xxx_xxxx_xxxx_xxxx_xxxx : 	begin						
                                                        Significand = significand << 4;
                                                        shift = 5'd4;
                                                    end

            25'b1_0000_01xx_xxxx_xxxx_xxxx_xxxx : 	begin						
                                                        Significand = significand << 5;
                                                        shift = 5'd5;
                                                    end

            25'b1_0000_001x_xxxx_xxxx_xxxx_xxxx : 	begin						// 24'h020000
                                                        Significand = significand << 6;
                                                        shift = 5'd6;
                                                    end

            25'b1_0000_0001_xxxx_xxxx_xxxx_xxxx : 	begin						// 24'h010000
                                                        Significand = significand << 7;
                                                        shift = 5'd7;
                                                    end

            25'b1_0000_0000_1xxx_xxxx_xxxx_xxxx : 	begin						// 24'h008000
                                                        Significand = significand << 8;
                                                        shift = 5'd8;
                                                    end

            25'b1_0000_0000_01xx_xxxx_xxxx_xxxx : 	begin						// 24'h004000
                                                        Significand = significand << 9;
                                                        shift = 5'd9;
                                                    end

            25'b1_0000_0000_001x_xxxx_xxxx_xxxx : 	begin						// 24'h002000
                                                        Significand = significand << 10;
                                                        shift = 5'd10;
                                                    end

            25'b1_0000_0000_0001_xxxx_xxxx_xxxx : 	begin						// 24'h001000
                                                        Significand = significand << 11;
                                                        shift = 5'd11;
                                                    end

            25'b1_0000_0000_0000_1xxx_xxxx_xxxx : 	begin						// 24'h000800
                                                        Significand = significand << 12;
                                                        shift = 5'd12;
                                                    end

            25'b1_0000_0000_0000_01xx_xxxx_xxxx : 	begin						// 24'h000400
                                                        Significand = significand << 13;
                                                        shift = 5'd13;
                                                    end

            25'b1_0000_0000_0000_001x_xxxx_xxxx : 	begin						// 24'h000200
                                                        Significand = significand << 14;
                                                        shift = 5'd14;
                                                    end

            25'b1_0000_0000_0000_0001_xxxx_xxxx  : 	begin						// 24'h000100
                                                        Significand = significand << 15;
                                                        shift = 5'd15;
                                                    end

            25'b1_0000_0000_0000_0000_1xxx_xxxx : 	begin						// 24'h000080
                                                        Significand = significand << 16;
                                                        shift = 5'd16;
                                                    end

            25'b1_0000_0000_0000_0000_01xx_xxxx : 	begin						// 24'h000040
                                                        Significand = significand << 17;
                                                        shift = 5'd17;
                                                    end

            25'b1_0000_0000_0000_0000_001x_xxxx : 	begin						// 24'h000020
                                                        Significand = significand << 18;
                                                        shift = 5'd18;
                                                    end

            25'b1_0000_0000_0000_0000_0001_xxxx : 	begin						// 24'h000010
                                                        Significand = significand << 19;
                                                        shift = 5'd19;
                                                    end

            25'b1_0000_0000_0000_0000_0000_1xxx :	begin						// 24'h000008
                                                        Significand = significand << 20;
                                                        shift = 5'd20;
                                                    end

            25'b1_0000_0000_0000_0000_0000_01xx : 	begin						// 24'h000004
                                                        Significand = significand << 21;
                                                        shift = 5'd21;
                                                    end

            25'b1_0000_0000_0000_0000_0000_001x : 	begin						// 24'h000002
                                                        Significand = significand << 22;
                                                        shift = 5'd22;
                                                    end

            25'b1_0000_0000_0000_0000_0000_0001 : 	begin						// 24'h000001
                                                        Significand = significand << 23;
                                                        shift = 5'd23;
                                                    end

            25'b1_0000_0000_0000_0000_0000_0000 : 	begin						// 24'h000000
                                                        Significand = significand << 24;
                                                        shift = 5'd24;
                                                    end
            default : 	begin
                            Significand = (~significand) + 1'b1;
                            shift = 8'd0;
                        end

        endcase
    end
    assign exp_sub = exp_a - shift;

endmodule