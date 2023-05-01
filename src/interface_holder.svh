class interface_holder extends uvm_object;
    virtual interface switch_interface switch_if;

    function new (virtual interface switch_interface switch_if_inst);
        switch_if = switch_if_inst;
    endfunction: new

endclass