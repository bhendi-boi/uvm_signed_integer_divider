class random_test extends uvm_test;
  `uvm_component_utils(random_test)

  environment env;
  reset_sequence rst_seq;
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

    rst_seq  = reset_sequence::type_id::create("rst_seq");
    base_seq = base_sequence::type_id::create("base_seq");

    rst_seq.start(env.agnt.seqr);
    base_seq.start(env.agnt.seqr);

    phase.drop_objection(this);
  endtask

endclass
