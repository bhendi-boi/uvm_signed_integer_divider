class driver extends uvm_driver #(transaction);
    `uvm_component_utils(driver)

    transaction tr;
    virtual divider_intf vif;

    function new(string name="driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        tr = transaction::get_id::create("tr");
        if(!uvm_config_db#(virtual divider_intf)::get(this,"","vif",vif)) begin
            `uvm_fatal("Driver", "Can't retriver vif in driver!")
        end
    endfunction

    task drive(transaction tr);
        @(posedge clk);
        vif.rst <= tr.rst;
        vif.start <= tr.start;
        vif.divisor <= tr.divisor;
        vif.dividend <= tr.dividend;

    endtask


    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(tr);
            drive(tr);
            tr.print("Driver")
            seq_item_port.item_done();
        end
    endtask

endclass

