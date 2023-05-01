class predictor extends uvm_agent;
    `uvm_component_utils(predictor)

    uvm_tlm_analysis_fifo #(switch_input) req_f;
    uvm_put_port #(switch_output) rsp_p;
    switch_input req;
    switch_output rsp,cln;

    function new(string name = "", uvm_component parent);
        super.new(name,parent);
    endfunction:new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rsp_p = new("rsp_p",this);
        req_f = new("req_f",this);
    endfunction:build_phase

    task run_phase(uvm_phase phase);
        rsp = new();
        rsp.load_data('b0, 'b0, 'b0, 'b0); // initialize
        forever begin
            req_f.get(req);
            if (req.vld) begin
                if(req.addr <= switch_pkg::ADDR_DIV) begin
                    rsp.load_data(req.addr, req.data, 'b0, 'b0);
                end
                else if(req.addr > switch_pkg::ADDR_DIV) begin
                    rsp.load_data('b0, 'b0, req.addr, req.data);
                end
            end
            $cast(cln, rsp.clone());
            rsp_p.put(cln);
            `uvm_info("run", $sformatf("Predictor predicts %s", rsp.convert2string()), UVM_DEBUG)
        end        
    endtask:run_phase

endclass