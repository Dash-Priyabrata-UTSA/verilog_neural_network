`include "neuron_mac.v"

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


