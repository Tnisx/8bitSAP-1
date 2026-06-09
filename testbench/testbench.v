module tb;
reg clk, rst;
wire [7:0] out;

sap1 uut(.clk(clk), .rst(rst), .out(out));

initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("sap1.vcd");
    $dumpvars(0, tb);
    rst = 1;
    #20 rst = 0;
    #500;
    $finish;
end

initial begin
    $monitor("time=%0t state=%0d out=%0d", 
              $time, uut.cu1.state, out);
end
initial begin
    $monitor("time=%0t state=%0d pc=%0d mar=%0d ram=%0d ir=%0d opcode=%0d operand=%0d a=%0d b=%0d alu=%0d out=%0d", 
    $time, 
    uut.cu1.state,
    uut.pc1.out,
    uut.mar1.out,
    uut.ram1.data_out,
    uut.ir1.opcode,
    uut.ir1.opcode,
    uut.ir1.operand,
    uut.a1.q,
    uut.b1.q,
    uut.alu1.sum,
    out);
end
endmodule