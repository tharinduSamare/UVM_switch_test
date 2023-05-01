class monitor extends uvm_agent;
    `uvm_component_utils(monitor)

    uvm_analysis_port #(switch_input) req_p;
    uvm_analysis_port #(switch_output) rsp_p;

    switch_input req;
    switch_output rsp;

    virtual interface switch_interface i;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i = switch_pkg::global_sif;

        req_p = new("req_p",this);
        rsp_p = new("rsp_p",this);
    endfunction:build_phase

    task run_phase(uvm_phase phase);
        req = new();
        rsp = new();

        forever begin
            
            
            @(posedge i.rstn);
            #1;
            req.data = i.data;
            req.addr = i.addr;
            
            rsp.data_a = i.data_a;
            rsp.addr_b = i.addr_b;
            rsp.data_b = i.data_b;
            rsp.addr_b = i.addr_b;
            
            rsp_p.write(rsp);
            req_p.write(req);
            `uvm_info("run", $sformatf("Monitor got request %s",req.convert2string()), UVM_DEBUG)
            `uvm_info("run", $sformatf("Monitor got response %s",rsp.convert2string()), UVM_DEBUG)
        
        end


    endtask



endclass