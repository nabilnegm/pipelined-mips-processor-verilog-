module ExecStage(
	input  Regdst,
	input  alusrc,
	input  memtoregIn,
	input  memreadIn,
	input  memwriteIn,
	input  regwriteIn,
	output reg memtoregOut,
	output reg memreadOut,
	output reg memwriteOut,
	output reg regwriteOut,
	output signed [31:0] ALUresult,
	input signed [31:0] ALUresultOld,
	input signed [31:0] WBresult,
	input [1:0] aluop,
	input signed [31:0] reg1,
	input signed [31:0] reg2,
	input signed [31:0] signEx, 
	input [4:0] rs,
	input [4:0] rt, 
	input [4:0] rd,
	input [5:0] functn_EXE,
	input [4:0] shamt,
	output [4:0] regDstMuxOut,
	input regwrite_mem,
	input regwrite_wb,
	input [4:0]rd_wb,
	input [4:0]rd_mem,
	output signed [31:0]muxOut2
	);

	
	wire [1:0]sel1;
	wire [1:0]sel2;
	wire [2:0] ALUcontrolOut;
	wire signed [31:0] muxOut1;
	//wire signed [31:0] muxOut2; 
	wire signed [31:0] AddressMuxOut;

	always @(memtoregIn)
	begin
	
		memtoregOut <= memtoregIn;
		memreadOut <= memreadIn;
		memwriteOut <= memwriteIn;
		regwriteOut <= regwriteIn;
		
	end
	
	ALUControl aluControl(functn_EXE, aluop,ALUcontrolOut);
	// ALUControl aluControl(00000010101001101110000000100000, aluop,ALUcontrolOut);
	ALUmux3x1 alumux1(reg1, ALUresultOld, WBresult, sel1,  muxOut1);
	ALUmux3x1 alumux2(reg2, ALUresultOld, WBresult, sel2,  muxOut2);

	AddressMux2x1  addressMux2x1 (alusrc , muxOut2, signEx, AddressMuxOut) ;

	ALU alu(muxOut1, AddressMuxOut, ALUcontrolOut, shamt, ALUresult);

	ALUmux2to1  aluMux2x1( Regdst , rt, rd,  regDstMuxOut) ;

	fw_hazard forwardhazard( regwrite_mem,regwrite_wb,rd_wb,rd_mem,rt,rs,sel1,sel2);

//00000010101001101110000000100000

endmodule
