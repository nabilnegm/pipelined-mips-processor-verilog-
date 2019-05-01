//there are inputs and outputs that dont use the pipeline register and wont be included in this module
//the pipeline register inputs and outputs
module pipeline_register(input clk,//////////////////////////clock
input lw_hazard,
input [0:31] instruction_IF,input [0:31]PC_IF,/////////////////////////outputs of instruction fetch
input Regdst_ID,input alusrc_ID,input memtoreg_ID,input regwrite_ID,input memread_ID,input memwrite_ID,input [1:0] aluop_ID,
input  signed [31:0] reg1_ID,input signed [31:0] reg2_ID,input [4:0] readreg1_ID,
input [4:0] readreg2_ID,
input [4:0] rd_ID,
input [5:0] functn_ID,input  [4:0] shamt_ID,
input wire signed [31:0] extended_ID,//////////////////////////////outputs of instruction decode
input wire memtoreg_EXEout,
input wire memread_EXEout,
input wire memwrite_EXEout,
input wire regwrite_EXEout,
input signed [31:0] ALUresult_EXE,input [4:0] regDstMux_EXE,input signed[31:0] AddressMuxOut_EXE,///////////////////////////outputs of execute stage
input wire signed [31:0] AluResult_MEM, input  [31:0] dataOut_MEM ,input wire [4:0] rd_mem,  
input wire regwrite_mem ,
input wire MEMWBMemtoReg_MEM ,//////////////////////////outputs of memory stage
output reg  [31:0] instruction_ID,output reg [31:0]PC_IDin,//////////////////////////inputs of instruction decode
output reg Regdst_EXE,output reg alusrc_EXE,output reg memtoreg_EXEin,output reg regwrite_EXE,output reg memread_EXEin,output reg memwrite_EXEin,output reg [1:0] aluop_EXE,
output reg signed [31:0] reg1_EXE,output reg signed [31:0] reg2_EXE,output reg [4:0] readreg1_EXE,
output reg [4:0] readreg2_EXE,
output reg [4:0] rd_EXE,
output reg [5:0] functn_EXE,output reg [4:0] shamt_EXE,
output reg signed [31:0] extended_EXE,//////////////////////////////////////////inputs of execution stage
output reg memtoreg_MEM,
output reg memread_MEM,
output reg memwrite_MEM,
output reg regwrite_MEM,
output reg signed [31:0] ALUresult_MEM,output reg [4:0] regDstMux_MEM,output reg signed[31:0] AddressMuxOut_MEM,////////////////////////////////////inputs of memory stage
output reg signed [31:0] AluResult_WB, output reg  [31:0] dataOut_WB ,output reg [4:0] MEMWBrd_WB,  
output reg MEMWBRegWrite_WB ,
output reg MEMWBMemtoReg_WB///////////////////////////////////inputs of write back stage 
);
//the clock cycle will be long so all the inputs of the pipeline register will be ready before the posetive edge of the clock
//and at posetive edge all inputs will be put in outputs
always@ (posedge clk)
begin

instruction_ID<=instruction_IF;//////////////////////////hazard condition (lw_hazard)?0:
PC_IDin<=PC_IF;//////////////////ID stage ended
Regdst_EXE<=Regdst_ID;
alusrc_EXE<=alusrc_ID;
memtoreg_EXEin<=memtoreg_ID;
regwrite_EXE<=regwrite_ID;
memread_EXEin<=memread_ID;
memwrite_EXEin<=memwrite_ID;
aluop_EXE<=aluop_ID;
reg1_EXE<=reg1_ID;
reg2_EXE<=reg2_ID;
readreg1_EXE<=readreg1_ID;
readreg2_EXE<=readreg2_ID;
rd_EXE<=rd_ID;
functn_EXE<=functn_ID;
shamt_EXE<=shamt_ID;
extended_EXE<=extended_ID;////////////////////////exe stage ended
memtoreg_MEM <=memtoreg_EXEout ;
regwrite_MEM<=regwrite_EXEout;
memread_MEM <=memread_EXEout ;
memwrite_MEM <=memwrite_EXEout ;
ALUresult_MEM<=ALUresult_EXE;
regDstMux_MEM<=regDstMux_EXE;
AddressMuxOut_MEM<=AddressMuxOut_EXE;////////////////////mem stage ended
AluResult_WB<=AluResult_MEM;
dataOut_WB<=dataOut_MEM;
MEMWBrd_WB <=rd_mem;
MEMWBRegWrite_WB <=regwrite_mem ;
MEMWBMemtoReg_WB<=MEMWBMemtoReg_MEM ;/////////////////////wb stage ended



end




endmodule