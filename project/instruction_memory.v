module  PC (clk,next_PC,lw_hazard,PC);
input wire clk;
input wire [31:0]next_PC;
input wire lw_hazard;
output reg [31:0]PC;
initial PC=0;
always@(negedge clk)
 PC<=next_PC;//(lw_hazard==1)?PC:
endmodule

module mux2to1  ( input clk,input wire mux_ctrl , input wire [31:0] Input1 ,input wire [31:0] Input2  , output reg [31:0] Output ) ;

initial Output=0;
always @ ( Input1 or Input2 or mux_ctrl )
begin 
  case (mux_ctrl)

0:
begin
Output <= Input2 ;
end

1:
begin
Output <= Input1 ;
end

endcase 

end

endmodule 
module IMemory (clk,PC, instruction);
input clk;
reg [31:0] imemory[0:1024];
input wire [31:0]PC;
output reg [31:0] instruction;
initial
begin
//imemory [0]=32'b 0;
//imemory [4]=32'b 1;
//imemory [8]=32'b 0;
//imemory [12]=32'b 1;
//imemory [16]=32'b 0;
$readmemb ("instructionfile.txt",imemory);
end
always @(PC)
begin
instruction <= imemory[PC];
//$display("%b",PC);
end

endmodule

module add (input clk,input wire [31:0] PC,output reg[31:0]PC_4);
initial PC_4=0;
always @(PC)
 PC_4<=PC+1;

endmodule
module IF(clk,mux_ctrl,branch_PC,lw_hazard,instruction,output_pc);
input clk,mux_ctrl;
output wire [31:0] instruction;
output wire [31:0]output_pc;
input wire[31:0] branch_PC;
wire [31:0]next_PC;
wire [31:0]PC;
wire[31:0] PC_4;
input lw_hazard;
assign output_pc = PC_4;
add myAdd ( clk,PC,PC_4);
PC myPC (clk,next_PC,lw_hazard, PC);
mux2to1 myMux (  clk,mux_ctrl ,  branch_PC , PC_4 , next_PC ) ;
IMemory M (clk,PC_4, instruction);
endmodule
