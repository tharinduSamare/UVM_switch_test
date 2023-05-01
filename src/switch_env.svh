`include "uvm_macros.svh"

class switch_env extends uvm_env;

    `uvm_component_utils(switch_env)
    
    driver  drv;
    uvm_sequencer #(switch_input, switch_output) sequencer;
    test_seq test_sequence;

    monitor mon;
    predictor pred;
    comparator comp;
    coverage cov;

    printer #(switch_input)printer_req;
    printer #(switch_output)printer_rsp;

    uvm_tlm_fifo #(switch_output) pred2comp_f;

    function new(string name="", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        drv       = driver::type_id::create("drv",this);
        sequencer = new("sequencer",this);
        test_sequence = test_seq::type_id::create("test_sequence",this);

        mon  = monitor::type_id::create("monitor",this);
        pred = predictor::type_id::create("pred",this);
        comp = comparator::type_id::create("comp",this);
        cov  = coverage::type_id::create("cov",this);
        pred2comp_f = new("pred2comp_f",this);

        printer_req = printer #(switch_input) ::type_id::create("printer_req",this);
        printer_rsp = printer #(switch_output)::type_id::create("printer_rsp",this);

    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sequencer.seq_item_export);

        mon.req_p.connect(pred.req_f.analysis_export);
        mon.rsp_p.connect(comp.actual_rsp_f.analysis_export);
        pred.rsp_p.connect(pred2comp_f.blocking_put_export);
        comp.pred_rsp_p.connect(pred2comp_f.blocking_get_export);

        mon.req_p.connect(cov.req_f.analysis_export);
        mon.rsp_p.connect(cov.rsp_f.analysis_export);

        mon.req_p.connect(printer_req.data_f.analysis_export);
        mon.rsp_p.connect(printer_rsp.data_f.analysis_export);

    endfunction

    task run_phase (uvm_phase phase);
        phase.raise_objection(this);
        test_sequence.start(sequencer);
        phase.drop_objection(this);
    endtask: run_phase


endclass