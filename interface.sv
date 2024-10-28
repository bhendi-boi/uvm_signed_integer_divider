interface divider_intf (
    input bit clk
);

  logic rst, start, ready;
  logic [31:0] dividend, divisor, quotient, remainder;
endinterface
