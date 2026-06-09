module mar(input clk,
input load,       // load enable
input [3:0]addr, // address coming from bus
output [3:0] mar_out);  // goes to RAM

reg [3:0]out;
always @(posedge clk)begin
if(load)begin
   out<=addr;
end
end
assign mar_out =out;
endmodule