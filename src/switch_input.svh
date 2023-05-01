class switch_input extends uvm_sequence_item;
    `uvm_object_utils(switch_input)

    localparam ADDR_WIDTH = switch_pkg::ADDR_WIDTH;
    localparam DATA_WIDTH = switch_pkg::DATA_WIDTH;

    rand logic [ADDR_WIDTH-1:0] addr;
    rand logic [DATA_WIDTH-1:0] data;
    rand logic vld;

    function new(string name = "");
        super.new(name);
    endfunction:new

    function string convert2string();
        return $sformatf("valid: %1b address_in: %2h   data_in: %2h", vld, addr, data );
    endfunction:convert2string

    function void do_copy(uvm_object rhs);
        switch_input RHS;
        super.do_copy(rhs);
        $cast(RHS,rhs);
        addr = RHS.addr;
        data = RHS.data;
        vld = RHS.vld;
    endfunction:do_copy

    function bit comp(uvm_object rhs);
        switch_input RHS;
        $cast(RHS,rhs);
        return (!vld | ((addr == RHS.addr) & (data == RHS.data)));
    endfunction

    function void load_data(logic v, logic[ADDR_WIDTH-1:0] a, logic[DATA_WIDTH-1:0] d);
        addr = a;
        data = d;
        vld = v;
    endfunction:load_data

endclass