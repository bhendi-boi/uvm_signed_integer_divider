import uvm_pkg::*;

`include "uvm_macros.svh"
`include "seq_item.sv"
`include "sequence.sv"
`include "monitor.sv"
`include "driver.sv"
`include "agent.sv"
`include "environment.sv"
`include "random_test.sv"
`include "interface.sv"

module top ();

  logic clk;
  initial begin
    clk = 0;
  end
  always #10 clk = ~clk;

  divider_intf intf (.clk(clk));

  divider_dshift dut (
      .i_clk(intf.clk),
      .i_rst(intf.rst),
      .i_dividend(intf.dividend),
      .i_divisor(intf.divisor),
      .i_start(intf.start),
      .o_ready(intf.ready),
      .o_quotient(intf.quotient),
      .o_remainder(intf.remainder)
  );

  initial begin
    uvm_config_db#(virtual divider_intf)::set(null, "*", "vif", intf);
    run_test("random_test");
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end

endmodule
