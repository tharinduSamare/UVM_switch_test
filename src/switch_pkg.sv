package switch_pkg;
    import uvm_pkg::*;

    localparam ADDR_WIDTH = 8;
    localparam DATA_WIDTH = 16;
    localparam ADDR_DIV = 8'h3F;

    bit verbose = 0;

    virtual interface switch_interface global_sif;

    `include "uvm_macros.svh"

    `include "interface_holder.svh"

    `include "switch_input.svh"
    `include "switch_output.svh"
    `include "test_seq.svh"

    `include "driver.svh"

    `include "comparator.svh"
    `include "predictor.svh"
    `include "monitor.svh"
    `include "printer.svh"
    `include "coverage.svh"

    `include "switch_env.svh"
    `include "switch_test.svh"
    `include "verbose_test.svh"
    
    
endpackage