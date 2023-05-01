`include "uvm_macros.svh"

class switch_test extends uvm_test;
    `uvm_component_utils(switch_test)

    switch_env env;

    function new(string name = "", uvm_component parent);
        super.new(name,parent);
    endfunction:new

    function void build_phase(uvm_phase phase);
        `uvm_info("check", "started build phase", UVM_DEBUG)
        super.build_phase(phase);
        env = switch_env::type_id::create("env",this);
        `uvm_info("check", "finished build phase", UVM_DEBUG)
    endfunction:build_phase

endclass:switch_test