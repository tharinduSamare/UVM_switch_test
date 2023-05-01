class verbose_test extends switch_test;

    `uvm_component_utils(verbose_test)    
  
     function new(string name = "", uvm_component parent);
       super.new(name, parent);
     endfunction : new
  
     function void end_of_elaboration();
        `uvm_info("check", "started elaboration phase", UVM_DEBUG)
        super.end_of_elaboration();
        switch_pkg::verbose=1;
        env.set_report_verbosity_level_hier(UVM_DEBUG);
        `uvm_info("check", "finihsed elaboration phase", UVM_DEBUG)
     endfunction : end_of_elaboration
  endclass : verbose_test
  