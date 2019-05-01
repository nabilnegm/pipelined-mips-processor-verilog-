module WB_stage (
input memtoreg,
input signed [31:0] dataout,
input signed [31:0] AluResult,
input regwrite,
input [4:0] RegFileAdress,
output reg regwrite1,
output reg [4:0] RegFileAdress1,
output  signed [31:0]Result
);
Mux2x1_WB_stage WB( memtoreg,dataout ,AluResult , Result) ;
always @(RegFileAdress or Result or regwrite)

begin
RegFileAdress1<=RegFileAdress;
#5
regwrite1=regwrite;
#1
regwrite1=0;
end


endmodule
 
