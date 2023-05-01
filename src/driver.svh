class driver extends uvm_driver #(switch_input, switch_output);
    `uvm_component_utils(driver)

    virtual interface switch_interface i;
        switch_input req;
        switch_output rsp;

    function new(string name = "", uvm_component parent);
        super.new(name,parent);
    endfunction:new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i = switch_pkg::global_sif;
    endfunction:build_phase

    task run_phase(uvm_phase phase);
        @(negedge i.clk);
        i.rstn = 1'b0;
        @(negedge i.clk);
        i.rstn = 1'b1;

        forever begin
            seq_item_port.get_next_item(req);

            if (req!=null) begin:got_req
                seq_item_port.item_done();
                `uvm_info("run", $sformatf("Driver got %s",req.convert2string()), UVM_DEBUG)

                i.data = req.data;
                i.addr = req.addr;
                i.vld  = req.vld;

            end: got_req

            @(posedge i.clk);
            #1;
            rsp = new();
            rsp.data_a = i.data_a;
            rsp.addr_a = i.addr_a;
            rsp.data_b = i.data_b;
            rsp.addr_b = i.addr_b;

            rsp.set_id_info(req);
            seq_item_port.put_response(rsp);

        end
    endtask
endclass