class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)

    rand bit rst,start;
    bit ready;
    rand bit [31:0] divisor, dividend;
    bit [31:0] quotient, remainder;
   
    constraint divisor_lesser_than_dividend {divisor < dividend;}
    constraint div_is_multiple_of_2 {
      dividend % 2 == 0;
    }
    constraint div_msb_is_zero {
          dividend[31] == 0;
    }
    function new(string name="transaction");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("Divisor",divisor,$bits(divisor),UVM_HEX);
        printer.print_field_int("Dividend",dividend,$bits(dividend),UVM_HEX);
        printer.print_field_int("Quotient",quotient,$bits(quotient),UVM_HEX);
        printer.print_field_int("Remainder",remainder,$bits(remainder),UVM_HEX);
    endfunction

endclass
