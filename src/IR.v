module ir (
    input        clk,
    input        load,          // from CU
    input  [7:0] data_in,       // from bus
    output reg [3:0] opcode,        // upper 4 bits to to CU
    output reg [3:0] operand        // lower 4 bits to to MAR
);
always @(posedge clk)begin
if(load)begin
opcode<=data_in[7:4];
operand<=data_in[3:0];
end
end
endmodule
