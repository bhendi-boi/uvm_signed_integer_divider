class base_sequence extends uvm_sequence;
  `uvm_object_utils(base_sequence)

  transaction tr;

  function new(string name = "base_sequence");
    super.new(name);
  endfunction

  task body();
    tr = transaction::type_id::create("tr");
    repeat (5) begin
      start_item(tr);
      tr.randomize() with {
        rst == 1;
        start == 1;
        divisor == 32'd2;
      };
      finish_item(tr);
    end
  endtask

endclass

class reset_sequence extends uvm_sequence;
  `uvm_object_utils(reset_sequence)

  transaction tr;

  function new(string name = "reset_sequence");
    super.new(name);
  endfunction

  task body();
    tr = transaction::type_id::create("tr");
    start_item(tr);
    tr.randomize() with {
      rst == 0;
      start == 0;
    };
    finish_item(tr);
  endtask

endclass
