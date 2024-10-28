class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)

  rand logic rst, start;
  logic ready;
  rand logic [31:0] divisor, dividend;
  logic [31:0] quotient, remainder;

  function new(string name = "transaction");
    super.new(name);
  endfunction

  //function disp(string id);
  //  `uvm_info(id, $sformat("Divisor: %d, Dividend: %d, Quotient: %d, Remainder: %d\n Reset: %d, Start: %d, Ready: %d",this.divisor,this.dividend,this.quotient,this.remainder,this.rst,this.start,this.ready),UVM_NONE)
  //  endfunction

endclass