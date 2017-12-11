module pc (clk,next_PC,lw_hazard,PC);
input wire clk;
input wire [0:31]next_PC;
input wire lw_hazard;
output reg [0:31]PC;

always@(posedge clk)
PC<=(lw_hazard==1)?PC:next_PC;

endmodule
