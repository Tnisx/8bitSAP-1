module pc (
    input        clk,
    input        rst,      // synchronous reset, sets PC to 0
    input        inc,      // increment PC by 1
    input        load,     // load a new value into PC
    input  [3:0] pc_in,    // value to load when load=1
    output [3:0] pc_out    // current PC value
);
reg [3:0]out;

always @(posedge clk)begin
if(rst)begin
out<=0;
end
else begin
   if(load)begin
       out<=pc_in;
            end
      else if(inc)begin
            out<=out+1;
end 
end
end 
assign pc_out=out;
endmodule
