module sap1(
    input  clk,
    input  rst,
    output [7:0] out  
);
// bus
wire [7:0] bus;

// control signals from CU
wire load_MAR, load_IR, load_A;
wire load_B, load_OUT, inc_PC;
wire enable_PC, enable_RAM, enable_IR;
wire enable_A, enable_ALU, sub, halt;

// module interconnects
wire [3:0] pc_out;
wire [3:0] mar_out;
wire [7:0] ram_out;
wire [3:0] opcode, operand;
wire [7:0] a_out, b_out, alu_out;

assign bus = enable_PC  ? {4'b0, pc_out} :
             enable_RAM ? ram_out         :
             enable_IR  ? {4'b0, operand} :
             enable_A   ? a_out           :
             enable_ALU ? alu_out         :
             8'bz;

cu cu1(clk,rst,opcode,
load_MAR,load_IR,load_A,load_B,load_OUT,inc_PC,
enable_PC,enable_RAM,enable_IR,
enable_A,enable_ALU,sub,halt);

pc pc1(clk,rst,inc_PC,0,0,pc_out);
mar mar1(clk,load_MAR,bus[3:0],mar_out);
ram ram1(clk,mar_out,ram_out);
ir ir1(clk,load_IR,bus[7:0],opcode,operand);

//defining registers
register1 a1(bus[7:0],clk,load_A,rst,a_out);//Accumalator
register1 b1(bus[7:0],clk,load_B,rst,b_out);//B register
oreg out1(clk,load_OUT,bus[7:0],out);//output register`

alu alu1(a_out,b_out,sub,alu_out);

endmodule

