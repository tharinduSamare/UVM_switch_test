import uvm_pkg::*;
import switch_pkg::*;

module top ;

    localparam ADDR_WIDTH = switch_pkg::ADDR_WIDTH;
    localparam DATA_WIDTH = switch_pkg::DATA_WIDTH;
    localparam ADDR_DIV   = switch_pkg::ADDR_DIV;

    switch_interface #(.ADDR_WIDTH(ADDR_WIDTH),.DATA_WIDTH(DATA_WIDTH),.ADDR_DIV(ADDR_DIV)) switch_if() ;
    switch_wrapper #(.ADDR_WIDTH(ADDR_WIDTH),.DATA_WIDTH(DATA_WIDTH),.ADDR_DIV(ADDR_DIV)) switch_wrp(switch_if.switch_modport);

    initial begin
        string test_name;
        switch_pkg::global_sif = switch_if;

        run_test();
    end

endmodule: top

