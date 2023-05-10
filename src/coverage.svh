class coverage extends uvm_agent;
    `uvm_component_utils(coverage)

    uvm_tlm_analysis_fifo #(switch_input) req_f;
    uvm_tlm_analysis_fifo #(switch_output) rsp_f;

    localparam ADDR_WIDTH = switch_pkg::ADDR_WIDTH;
    localparam DATA_WIDTH = switch_pkg::DATA_WIDTH;
    localparam ADDR_DIV   = switch_pkg::ADDR_DIV;

    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data;
    logic vld;

    covergroup c_valid;
        coverpoint vld;
    endgroup

    covergroup c_addr;
        coverpoint addr {
            bins address_a = {[0:ADDR_DIV]};
            bins address_b = {[ADDR_DIV:{ADDR_WIDTH{1'b1}}]};
            bins a2b = ([0:ADDR_DIV] => [ADDR_DIV:{ADDR_WIDTH{1'b1}}]);
            bins b2a = ([ADDR_DIV:{ADDR_WIDTH{1'b1}}] => [0:ADDR_DIV]);
        }
    endgroup

    covergroup c_data;
        coverpoint data {
            bins zero = {0};
            bins non_zero = {[1:{DATA_WIDTH{1'b1}}]};
        }
    endgroup

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        c_valid = new();
        c_addr = new();
        c_data = new();
    endfunction:new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        req_f = new("req_f",this);
        rsp_f = new("rsp_f",this);
    endfunction:build_phase

    task run_phase(uvm_phase phase);
        switch_input req;
        switch_output rsp;
        forever begin
            req_f.get(req);
            rsp_f.get(rsp);
            addr = req.addr;
            data = req.data;
            vld = req.vld;

            c_addr.sample();
            c_data.sample();
            c_valid.sample();
        end

    endtask:run_phase

endclass