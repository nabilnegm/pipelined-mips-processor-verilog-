module processor();

reg clk;
wire mux_ctrl;
wire lw_hazard;
wire [31:0] instruction_IF;
wire [31:0] PC_IF;
wire [31:0] instruction_ID;
wire [31:0]PC_IDin;
wire regwriteold;
wire [4:0]writereg;
wire[31:0]writedata;
wire memread_EXE;
wire[4:0] rt_EXE;
wire Regdst_ID;
wire alusrc_ID;
wire memtoreg_ID;
wire regwrite_ID;
wire memread_ID;
wire memwrite_ID;
wire [1:0] aluop_ID;
wire signed [31:0] reg1_ID;
wire signed [31:0] reg2_ID;
wire [31:0] branchPC;
wire [4:0] readreg1_ID;
wire [4:0] readreg2_ID;
wire [4:0] rd_ID;
wire [5:0] functn_ID;
wire signed [31:0] extended_ID;
wire [31:0]PCout_ID;
wire [4:0]shamt_ID;
wire Regdst_EXE;
wire alusrc_EXE;
wire memtoreg_EXEin;
wire memread_EXEin;
wire memwrite_EXEin;
wire regwrite_EXEin;
wire memtoreg_EXEout;
wire memread_EXEout;
wire memwrite_EXEout;
wire regwrite_EXEout;
wire signed [31:0] ALUresult_EXE;
wire signed [31:0] ALUresultOLD;
wire signed [31:0] WBresult;
wire branch;
wire [1:0] aluop_EXE;
wire signed [31:0] reg1_EXE;
wire signed [31:0] reg2_EXE;
wire signed [31:0] extended_EXE;
wire [4:0] readreg1_EXE;
wire [4:0] readreg2_EXE;
wire [4:0] rd_EXE;
wire [5:0] functn_EXE;
wire [4:0] shamt_EXE;
wire [4:0] regDstMux_EXE;
wire regwrite_mem;
wire regwrite_wb;
wire [4:0]rd_wb;
wire [4:0]rd_mem;
wire regwrite_MEM;
wire memtoreg_MEM;
wire memread_MEM;
wire memwrite_MEM;
wire [31:0] ALUresult_MEM;
wire [4:0] regDstMux_MEM;
wire [31:0] dataOut_MEM;
wire [31:0]AluResult_MEM;
wire MEMWBRegWrite_MEM;
wire MEMWBMemtoReg_MEM;
wire MEMWBrd_MEM;
wire signed [31:0] AluResult_WB;
wire signed [31:0] dataOut_WB;
wire [4:0] MEMWBrd_WB;
wire[31:0] dataIn;
wire MEMWBMemtoReg_WB;
wire MEMWBRegWrite_WB;
wire signed [31:0] AddressMuxOut_MEM;
wire signed [31:0]AddressMuxOut_EXE;

always
begin

#100 clk=~clk;

end

initial
clk=0;



IF instructionfetch(clk,mux_ctrl,branchPC,lw_hazard,instruction_IF,PC_IF);

ID_stage instructiondecode(instruction_ID,PC_IDin, regwrite_wb,writereg,writedata,memread_EXEin, readreg2_EXE,
Regdst_ID,alusrc_ID,memtoreg_ID,regwrite_ID,memread_ID,memwrite_ID,aluop_ID,
reg1_ID, reg2_ID, branchPC,readreg1_ID,readreg2_ID,rd_ID,
functn_ID,shamt_ID,extended_ID,mux_ctrl,lw_hazard);

ExecStage executestage( Regdst_EXE,alusrc_EXE,memtoreg_EXEin,memread_EXEin,
memwrite_EXEin,regwrite_EXEin,memtoreg_EXEout,memread_EXEout,memwrite_EXEout,
regwrite_EXEout, ALUresult_EXE,ALUresult_MEM, AluResult_WB,
aluop_EXE,reg1_EXE,reg2_EXE,extended_EXE, readreg1_EXE,readreg2_EXE, rd_EXE,functn_EXE,
shamt_EXE,regDstMux_EXE,regwrite_mem,regwrite_wb,writereg,rd_mem ,AddressMuxOut_EXE);

memstage memorystage( regwrite_MEM , memtoreg_MEM , memread_MEM ,
memwrite_MEM ,ALUresult_MEM ,AddressMuxOut_MEM ,
regDstMux_MEM ,dataOut_MEM , AluResult_MEM, MEMWBMemtoReg_MEM ,regwrite_mem , rd_mem   ) ;

WB_stage wbstage( MEMWBMemtoReg_WB,dataOut_WB,AluResult_WB, MEMWBRegWrite_WB,MEMWBrd_WB,
regwrite_wb,writereg,writedata);

pipeline_register pipelineregister( clk,lw_hazard,
instruction_IF, PC_IF, Regdst_ID, alusrc_ID, memtoreg_ID, regwrite_ID,memread_ID , memwrite_ID, aluop_ID,
reg1_ID, reg2_ID, readreg1_ID,readreg2_ID,rd_ID, functn_ID,shamt_ID,extended_ID,memtoreg_EXEout,memread_EXEout,
memwrite_EXEout,regwrite_EXEout, ALUresult_EXE, regDstMux_EXE,AddressMuxOut_EXE, AluResult_MEM,  dataOut_MEM , rd_mem,  regwrite_mem ,MEMWBMemtoReg_MEM ,
instruction_ID,PC_IDin,Regdst_EXE, alusrc_EXE, memtoreg_EXEin, regwrite_EXEin,memread_EXEin,memwrite_EXEin, aluop_EXE,
reg1_EXE, reg2_EXE, readreg1_EXE,readreg2_EXE,rd_EXE,functn_EXE,shamt_EXE,extended_EXE,memtoreg_MEM, memread_MEM,memwrite_MEM,
regwrite_MEM,ALUresult_MEM, regDstMux_MEM,  AddressMuxOut_MEM, AluResult_WB,  dataOut_WB , MEMWBrd_WB,  MEMWBRegWrite_WB ,
MEMWBMemtoReg_WB);






endmodule
