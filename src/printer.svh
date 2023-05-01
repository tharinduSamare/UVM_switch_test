class printer #(type T=switch_input) extends uvm_agent;
    `uvm_component_param_utils(printer #(T))

    uvm_tlm_analysis_fifo #(T) data_f;

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction:new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        data_f = new("data_f", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        T data;
        forever begin
            data_f.get(data);
            `uvm_info("run", data.convert2string(), UVM_MEDIUM)
        end
    endtask

endclass