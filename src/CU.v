module cu(
    input        clk,
    input        rst,
    input  [3:0] opcode,      // from IR
    output reg   load_MAR,
    output reg   load_IR,
    output reg   load_A,
    output reg   load_B,
    output reg   load_OUT,
    output reg   inc_PC,
    output reg   enable_PC,
    output reg   enable_RAM,
    output reg   enable_IR,
    output reg   enable_A,
    output reg   enable_ALU,
    output reg   sub,
    output reg   halt
);
//enable simply means to allow it to output to bus while load allows it to take the input from bus

// states
parameter T1=3'd0, T2=3'd1, T3=3'd2,
          T4=3'd3, T5=3'd4, T6=3'd5;

// opcodes
parameter LDA=4'h0, ADD=4'h1, 
          SUB=4'h2, OUT=4'hE, HLT=4'hF;

reg [2:0] state;

// state transition
always @(posedge clk) begin
    if(rst)
        state <= T1;
    else if(halt)
        state <= state; // stop
    else
        state <= (state == T6) ? T1 : state + 1; //increment
end

// output logic
always @(*) begin
    // default everything to 0 at start of cycle 
    load_MAR=0; load_IR=0; load_A=0;
    load_B=0; load_OUT=0; inc_PC=0;
    enable_PC=0; enable_RAM=0;
    enable_IR=0; enable_A=0;
    enable_ALU=0; sub=0; halt=0;

    case(state)
        T1: begin
            load_MAR=1;
            enable_PC=1;
end
        T2: begin
         inc_PC=1;
end
        T3:begin
       load_IR=1;
       enable_RAM=1;
end
        T4:begin
      load_MAR=1;
      enable_IR=1;
end
    T5:begin
     case(opcode)
      4'h0:begin
       load_MAR=1;
       enable_IR=1;
end
      4'h1:begin
        load_B=1; 
        enable_RAM=1;
end
      4'h2:begin
      load_B=1; 
      enable_RAM=1;
end
      4'hE:begin
      load_OUT=1;
      enable_A=1;
end
      4'hF:begin
       halt=1;
end
endcase
end

           T6:begin
     case(opcode)
      4'h0:begin
       load_A=1; 
       enable_RAM=1;
end
      4'h1:begin
        load_A=1; 
        enable_ALU=1;
end
      4'h2:begin
     load_A=1; 
     enable_ALU=1;
     sub=1;
end
  default: ;
endcase
end          
    endcase 
end          
endmodule