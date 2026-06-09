module oreg(
    input        clk,
    input        load,
    input  [7:0] data_in,
    output reg [7:0] out
);

always @(posedge clk)begin
if(load)begin
out<=data_in;
end
end
endmodule