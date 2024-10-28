class driver extends uvm_driver #(transaction);
  `uvm_component_utils(driver)

  transaction tr;
  virtual divider_intf vif;

  function new(string name = "driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    tr = transaction::type_id::create("tr");
    if (!uvm_config_db#(virtual divider_intf)::get(this, "", "vif", vif)) begin
      `uvm_fatal("Driver", "Can't retriver vif in driver!")
    end
  endfunction

  task drive(transaction tr);
    @(posedge vif.clk);
    vif.start <= 1;
    vif.divisor <= tr.divisor;
    vif.dividend <= tr.dividend;
    @(posedge vif.ready);
    vif.start <= 0;
  endtask


  task run_phase(uvm_phase phase);
    vif.rst <= 0;
    vif.quotient <= 0;
    vif.remainder <= 0;
    vif.divisor <= 0;
    vif.dividend <= 0;
    @(negedge vif.clk);
    vif.rst <= 1;
    forever begin
      seq_item_port.get_next_item(tr);
      `uvm_info("Driver d", "time", UVM_NONE)
      drive(tr);
      `uvm_info("Driver d", "time", UVM_NONE)
      `uvm_info("Driver", "Drove this transaction", UVM_NONE)
      tr.print();
      seq_item_port.item_done();
    end
  endtask

endclass

