module WB_stage (
input clk,
input WBReg,
input signed [31:0] ReadDataMem,
input signed [31:0] AluResult,
input ExMemReg,
input [4:0] RegFileAdress,
output reg ExMemReg1,
output reg [4:0] RegFileAdress1,
output  signed [31:0]Result
);
mux2x1WB WB( WBReg,ReadDataMem ,AluResult ,clk , Result) ;
always @(posedge clk)

begin
RegFileAdress1<=RegFileAdress;
ExMemReg1<=ExMemReg;
end


endmodule
 