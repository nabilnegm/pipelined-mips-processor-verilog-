module Mux3x1(
input [3:0] A,input [1:0] Sel,
output reg F);
always @(Sel or A)
	begin
	case(Sel)
	0: F=A[0];
	1: F=A[0];
	2: F=A[0];
	3: F=2'bxx;
	endcase
	end

endmodule

