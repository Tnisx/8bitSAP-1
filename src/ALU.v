module alu(input [7:0]a,input[7:0]b,sub,output [7:0]sum);
assign sum = ~sub?a+b:a-b;
endmodule
