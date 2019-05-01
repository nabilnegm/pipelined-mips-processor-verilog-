
module control_unit(OPCODE,Regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop,lw_hazard);
input lw_hazard;
input wire [5:0] OPCODE;

output reg  Regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch;
output reg [1:0] aluop;
parameter LW =6'b 100011,SW=6'b 101011,BEQ=6'b 000100,R_TYPE=6'b  000000,I_TYPE=6'b001000;

always @(OPCODE or lw_hazard)
begin
if (lw_hazard==1)
begin
Regdst=0;
alusrc=0;
memtoreg=0;
regwrite=0;
memread=0;
memwrite=0;
branch=0;
aluop=2'b 11;
end
else
begin
case (OPCODE)
R_TYPE:
begin
Regdst=1;
alusrc=0;
memtoreg=0;
regwrite=1;
memread=0;
memwrite=0;
branch=0;
aluop=2'b 10;
end
I_TYPE:
begin
Regdst=0;
alusrc=1;
memtoreg=0;
regwrite=1;
memread=0;
memwrite=0;
branch=0;
aluop=2'b 00;
end
LW:
begin 
Regdst=0;
alusrc=1;
memtoreg=1;
regwrite=1;
memread=1;
memwrite=0;
branch=0;
aluop=2'b 0;
end
SW:
begin 
Regdst=1'b x;
alusrc=1;
memtoreg=1'b x;
regwrite=0;
memread=0;
memwrite=1;
branch=0;
aluop=2'b 0;
end

BEQ:
begin 
Regdst=1'b x;
alusrc=0;
memtoreg=1'b x;
regwrite=0;
memread=0;
memwrite=0;
branch=1;
aluop=2'b 01;
end
endcase
/*if (lw_hazard==1)
begin
Regdst=0;
alusrc=0;
memtoreg=0;
regwrite=0;
memread=0;
memwrite=0;
branch=0;
aluop=2'b 11;
end*/
end
end
//end

endmodule