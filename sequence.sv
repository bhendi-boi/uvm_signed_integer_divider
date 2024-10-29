class base_sequence extends uvm_sequence;
  `uvm_object_utils(base_sequence)

  transaction tr;

  function new(string name = "base_sequence");
    super.new(name);
  endfunction

  task body();
    tr = transaction::type_id::create("tr");
    tr.div_is_multiple_of_2.constraint_mode(0);
    repeat (250) begin
      start_item(tr);
      tr.randomize();
      finish_item(tr);
    end
    tr.div_msb_is_zero.constraint_mode(0);
    repeat (250) begin
      start_item(tr);
      tr.randomize();
      finish_item(tr);
    end
  endtask

endclass
