`include "spfp_multiplier.v"
`include "spfp_adder_subtractor.v"
`include "relu.v"

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