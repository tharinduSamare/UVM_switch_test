class test_seq extends uvm_sequence #(switch_input, switch_output);
    `uvm_object_utils(test_seq)

    switch_input req;
    switch_output rsp;

    function new(string name="");
        super.new(name);
    endfunction: new

    task body();
        repeat(20) begin
            req = new();
            start_item(req);
            req.randomize();
            `uvm_info("test_seq", {"sending transaction ",req.convert2string()},UVM_MEDIUM)

            finish_item(req);

            get_response(rsp);
            `uvm_info("test_seq",{"got response ",rsp.convert2string()}, UVM_MEDIUM)
            
        end

    endtask

endclass