class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  transaction tr;
  transaction trs[$];
  uvm_analysis_imp #(transaction, scoreboard) scoreboard_port;

  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scoreboard_port = new("scoreboard_port", this);
  endfunction

  function void write(transaction tr);
    `uvm_info("Scoreboard", "Received this transaction from monitor: ", UVM_NONE)
    tr.print();
    trs.push_back(tr);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    tr = transaction::type_id::create("tr", this);
    forever begin
      wait (!(trs.size() == 0));
      tr = trs.pop_front();
      compare(tr);
    end

  endtask

  bit sign_q, sign_r;
  bit [62:0] PR;
  bit [31:0] DR, q_tb, r_tb;
  integer i;

  task compare(transaction tr);

    sign_q = tr.dividend[31] ^ tr.divisor[31];
    sign_r = tr.dividend[31];

    DR = tr.divisor[31] ? (~tr.divisor) + 1 : tr.divisor;
    PR = 0;
    q_tb = 0;
    r_tb = 0;

    PR = {31'd0, tr.dividend[31] ? (~tr.dividend) + 1 : tr.dividend};
    for (i = 31; i >= 0; i = i - 1) begin
      if (PR[62:31] >= DR) begin
        PR[62:31] = PR[62:31] - DR;
        if (i != 0) PR = PR << 1;
        q_tb[i] = 1;
      end else begin
        q_tb[i] = 0;
        if (i != 0) PR = PR << 1;
      end
    end
    q_tb = sign_q ? (~q_tb) + 1 : q_tb;
    r_tb = sign_r ? (~PR[62:31]) + 1 : PR[62:31];

    if (q_tb != tr.quotient) `uvm_error("Scoreboard", "Quotient mismatch")
    else if (r_tb != tr.remainder) `uvm_error("Scoreboard", "Remainder mismatch")
    else `uvm_info("Scoreboard", "Both match", UVM_NONE)


  endtask

endclass
