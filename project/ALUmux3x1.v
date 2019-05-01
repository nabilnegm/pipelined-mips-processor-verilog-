module ALUmux3x1 (input signed [31:0] reg1, 
	input signed [31:0] ALUresult, 
	input signed [31:0] WBresult, 	
	input [1:0] sel,  
	output reg signed [31:0] muxOut);

	always@(sel or ALUresult or WBresult or reg1)
	begin
		
		case(sel)
		
			2'b00: muxOut = reg1;
			2'b01: muxOut = ALUresult;
			2'b10: muxOut = WBresult;
		
		endcase

	end

endmodule
