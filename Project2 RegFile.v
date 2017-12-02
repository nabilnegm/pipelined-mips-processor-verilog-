module RegFile(
input clk,
input enable,
input [4:0]ReadR1 ,
input [4:0]ReadR2 ,
input [4:0]WriteR ,
input signed[31:0]WriteD ,
input muxcontrol,
input signed  [31:0]Result,
output signed [31:0]ReadD1,
output signed [31:0]ReadD2);

reg signed [31:0] array [31:0];


assign ReadD1 = array [ReadR1];
assign ReadD2 = array [ReadR2];

always@(posedge clk )
begin
if (enable)

begin
array[WriteR]<=(muxcontrol)?Result:WriteD;
end
end
endmodule 
