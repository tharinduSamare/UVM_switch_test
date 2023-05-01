module switch_wrapper#
    (
        parameter ADDR_WIDTH = 8,
        parameter DATA_WIDTH = 16,
        parameter ADDR_DIV = 8'h3F
    )
    (switch_interface.switch_modport m);

    switch #(ADDR_WIDTH, DATA_WIDTH, ADDR_DIV)sw(
        .clk(m.clk),
        .rstn(m.rstn),
        .vld(m.vld),
        .addr(m.addr),
        .data(m.data),
        .addr_a(m.addr_a),
        .data_a(m.data_a),
        .addr_b(m.addr_b),
        .data_b(m.data_b)
    );


endmodule: switch_wrapper