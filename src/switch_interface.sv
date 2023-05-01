interface switch_interface #
    (
        parameter ADDR_WIDTH = 8,
        parameter DATA_WIDTH = 16,
        parameter ADDR_DIV = 8'h3F
    );
    
    logic clk;
    logic rstn;
    logic vld;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data;
    logic [ADDR_WIDTH-1:0] addr_a;
    logic [DATA_WIDTH-1:0] data_a;
    logic [ADDR_WIDTH-1:0] addr_b;
    logic [DATA_WIDTH-1:0] data_b;

    modport switch_modport (

        input clk,
        input rstn,
        input vld,
        input addr,
        input data,

        output addr_a,
        output data_a,
        output addr_b,
        output data_b
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
endinterface //switch_interface