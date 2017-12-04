module RegFile(
input RegWrite,
input Clk,
input [4:0]ReadR1 ,
input [4:0]ReadR2 ,
input [4:0]WriteR ,
input signed[31:0]WriteD,
output reg signed  [31:0]ReadD1,
output reg signed  [31:0]ReadD2);

reg signed [31:0] array [0:31];

	always @(posedge Clk)
	begin
		if (RegWrite == 1) 
		begin
		array[WriteR] <= WriteD;
		end
	end
	
	always @(negedge Clk)
	begin
		ReadD1 <= array [ReadR1];
		ReadD2 <= array [ReadR2];
	end

endmodule 
