class agent extends uvm_agent;
  `uvm_component_utils(agent)

  driver drv;
  uvm_sequencer #(transaction) seqr;

  function new(string name = "driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv  = driver::type_id::create("drv", this);
    seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass
