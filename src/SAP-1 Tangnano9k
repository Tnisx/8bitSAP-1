// This file is specifically for my board only

// Clock divider module 
module clk_div_1hz (input  wire clk_27mhz,output reg  clk_1hz
);
 reg [24:0] counter;
    always @(posedge clk_27mhz) begin
        if (counter == 25'd2699999) begin
            counter <= 25'd0;
            clk_1hz <= ~clk_1hz;
        end else begin
            counter <= counter + 1'b1;
        end
    end
    initial begin counter = 0; clk_1hz = 0; end
endmodule

// Top module
module sap1(
input  clk,
input  rst,
output [7:0] out,  
output [3:0] pc_led
);
wire rst_i = ~rst;  // active low button for reset
// Clock divider
wire clk_slow;
clk_div_1hz div (.clk_27mhz(clk), .clk_1hz(clk_slow));

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
 enable_ALU ? alu_out         :8'bz;

// LED output
assign pc_led = ~pc_out;  //Active Low TangNano9k

//Connecting Modules
cu       cu1  (clk_slow, rst_i, opcode,
load_MAR, load_IR, load_A, load_B, load_OUT, inc_PC,
enable_PC, enable_RAM, enable_IR,
enable_A, enable_ALU, sub, halt);
pc       pc1  (clk_slow, rst_i, inc_PC, 0, 0, pc_out);
mar      mar1 (clk_slow, load_MAR, bus[3:0], mar_out);
ram      ram1 (clk_slow, mar_out, ram_out);
ir       ir1  (clk_slow, load_IR, bus[7:0], opcode, operand);
register1 a1  (bus[7:0], clk_slow, load_A, rst_i, a_out);
register1 b1  (bus[7:0], clk_slow, load_B, rst_i, b_out);
oreg     out1 (clk_slow, load_OUT, bus[7:0], out);
alu      alu1 (a_out, b_out, sub, alu_out);

endmodule
