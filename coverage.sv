class coverage extends uvm_subscriber #(transaction);
  `uvm_component_utils(coverage)

  transaction tr;
  uvm_analysis_imp #(transaction, coverage) coverage_port;

  covergroup func;
    option.per_instance = 1;
    option.auto_bin_max = 4;
    divisor: coverpoint tr.divisor;
    dividend: coverpoint tr.dividend;
    quotient: coverpoint tr.quotient {bins b0 = {[0 : 32727]}; bins b1 = {[32728 : $]};}
    remainder: coverpoint tr.remainder {bins b0 = {[0 : $]};}

  endgroup

  function new(string name = "coverage", uvm_component parent);
    super.new(name, parent);
    func = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    coverage_port = new("coverage_port", this);
  endfunction

  function void write(transaction t);
    tr = t;
    func.sample();
  endfunction

endclass
