class switch_output extends uvm_sequence_item;
    `uvm_object_utils(switch_output)

    localparam ADDR_WIDTH = switch_pkg::ADDR_WIDTH;
    localparam DATA_WIDTH = switch_pkg::DATA_WIDTH;

    rand logic [ADDR_WIDTH-1:0] addr_a;
    rand logic [DATA_WIDTH-1:0] data_a;
    rand logic [ADDR_WIDTH-1:0] addr_b;
    rand logic [DATA_WIDTH-1:0] data_b;

    function new(string name = "");
        super.new(name);
    endfunction:new

    function string convert2string();
        return $sformatf("address_a: %2h   data_a: %2h, address_b: %2h   data_b: %2h", addr_a, data_a, addr_b, data_b);
    endfunction:convert2string

    function void do_copy(uvm_object rhs);
        switch_output RHS;
        super.do_copy(rhs);
        $cast(RHS,rhs);
        addr_a = RHS.addr_a;
        data_a = RHS.data_a;
        addr_b = RHS.addr_b;
        data_b = RHS.data_b;
    endfunction:do_copy

    function bit comp(uvm_object rhs);
        switch_output RHS;
        $cast(RHS,rhs);
        return ((addr_a == RHS.addr_a) & (data_a == RHS.data_a) & (addr_b == RHS.addr_b) & (data_b == RHS.data_b));
    endfunction

    function void load_data(logic[ADDR_WIDTH-1:0] a_a, logic[DATA_WIDTH-1:0] d_a, logic[ADDR_WIDTH-1:0] a_b, logic[DATA_WIDTH-1:0] d_b);
        addr_a = a_a;
        data_a = d_a;
        addr_b = a_b;
        data_b = d_b;
    endfunction:load_data

endclass