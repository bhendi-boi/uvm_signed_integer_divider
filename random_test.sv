class random_test extends uvm_test;
  `uvm_component_utils(random_test)

  environment   env;
  base_sequence base_seq;

  function new(string name = "random_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    base_seq = base_sequence::type_id::create("base_seq");
    quo_seq  = quotient_sequence::type_id::create("quo_seq");

    base_seq.start(env.agnt.seqr);
    `uvm_info("Random Test", "Base Sequence over", UVM_NONE)
    phase.drop_objection(this);
  endtask

endclass
