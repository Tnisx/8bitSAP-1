module ram (
    input            clk,       // Connect this to your CPU clock
    input      [3:0] address,   // 4-bit address from MAR
    output [7:0] data_out   // 8-bit instruction/data bus
);

   
    reg [7:0] mem [0:15];

    
    initial begin
mem[0] = 8'h0F;  // LDA 15 
mem[1] = 8'h1E;  // ADD 14  
mem[2] = 8'hE0;  // OUT     
mem[3] = 8'hFF;  // HLT
mem[14] = 8'h05; // data: 5
mem[15] = 8'h03; // data: 3
    end

    
   
        assign data_out = mem[address];
    

endmodule
