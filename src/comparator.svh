class comparator extends uvm_agent;
    `uvm_component_utils(comparator)

    uvm_tlm_analysis_fifo #(switch_output) actual_rsp_f;
    uvm_get_port #(switch_output) pred_rsp_p;

    switch_output actual_rsp, pred_rsp;

    function new (string name = "", uvm_component parent);
        super.new(name,parent);
    endfunction:new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        actual_rsp_f = new("actual_rsp_f",this);
        pred_rsp_p   = new("pred_rsp_p",this);
    endfunction:build_phase

    task run_phase (uvm_phase phase);
        forever begin
            actual_rsp_f.get(actual_rsp);
            `uvm_info("run",$sformatf("Comparator actual   : %s",actual_rsp.convert2string()),UVM_DEBUG);
            pred_rsp_p.get(pred_rsp);
            `uvm_info("run",$sformatf("Comparator predicted: %s",pred_rsp.convert2string()),UVM_DEBUG);

            if (actual_rsp.comp(pred_rsp)) begin
                `uvm_info("run",$sformatf("Passed: %s", actual_rsp.convert2string()), UVM_MEDIUM)
            end
            else begin
                `uvm_error("run",$sformatf("Failed: Expected: %s, Actual: %s",pred_rsp.convert2string(), actual_rsp.convert2string()))
            end
        end
    endtask


endclass