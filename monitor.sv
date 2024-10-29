class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  virtual divider_intf vif;
  uvm_analysis_port #(transaction) monitor_port;
  transaction tr;

  function new(string name = "monitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual divider_intf)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor", "Can't get vif in monitor!")
    tr = transaction::type_id::create("tr");
    monitor_port = new("monitor_port", this);
  endfunction


  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    wait (vif.rst);
    forever begin
      @(posedge vif.start);
      tr.divisor  = vif.divisor;
      tr.dividend = vif.dividend;
      @(posedge vif.ready);
      tr.quotient  = vif.quotient;
      tr.remainder = vif.remainder;
      `uvm_info("Monitor", "Sent a transaction over monitor_port", UVM_NONE)
      tr.print();
      monitor_port.write(tr);
    end

  endtask

endclass
