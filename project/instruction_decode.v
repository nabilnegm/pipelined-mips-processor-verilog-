module ID_stage( input wire [31:0] instruction,input wire[31:0]PC,input regwriteold,input wire [4:0]writereg,
input wire[31:0]writedata,input memread_EXE,input [4:0] rt_EXE,
output  Regdst,output  alusrc,output  memtoreg,output  regwrite,output  memread,output  memwrite,output [1:0] aluop,
output  signed [31:0] reg1,output signed [31:0] reg2,output reg [31:0] branchPC,output [4:0] readreg1,
output [4:0] readreg2,
output [4:0] rd,
output [5:0] functn,
output [4:0] shamt,
output reg signed [31:0] extended,
output reg muxselect,
output lw_hazard);
//00000000010001000011000000100000

wire branch;
reg eql;
wire signed [15:0] beforesignextend;
wire [5:0]OPCODE;
assign OPCODE=instruction[31:26];
assign readreg1=instruction[25:21];
assign readreg2=instruction[20:16];
assign rd=instruction[15:11];
assign functn=instruction[5:0];
assign shamt =instruction[4:0];
assign beforesignextend =instruction[15:0];


always @( beforesignextend )
 begin
    extended[31:0] <= { {16{beforesignextend[15]}}, beforesignextend[15:0] };
end

always@(reg1 or reg2)
eql=(reg1==reg2)?1:0;

always@(extended)
branchPC=PC+extended;
//initial muxselect=0;

//initial
//muxselect=0;

//always
//muxselect<=(muxselect=1'bx)0:muxselect;
always @(PC or eql or branch)
begin
muxselect<=(eql&branch);//(PC==0 )?0:
end
stallUnit s1(readreg1,readreg2,rt_EXE,memread_EXE,lw_hazard);
control_unit c1(OPCODE,Regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop,lw_hazard);
RegFile r1(regwriteold,readreg1 ,readreg2 ,writereg ,writedata,reg1,reg2);


endmodule