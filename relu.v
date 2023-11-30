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

module relu_testbench;
    // ports
    reg [31:0] inp;
    wire [31:0] out;
    //initial block
    initial begin 
        $dumpfile("relu.vcd");
        $dumpvars(0, relu_testbench);
        $display("inp\tout");
        $monitor("%h %h", inp, out);
        //testbenches
        inp = 32'b11000000000000000111000000000000; //-2
        #10
        inp = 32'b01000000000000000000000000000000; //2
        #10
        inp = 32'b00111110011100000000011010001110; //0.2344
        #10
        inp = 32'b00000000000000000000000000000000; //0
        #10
        $finish;
    end
    ReLU relu(
        .inp(inp),
        .out(out)
    );
endmodule