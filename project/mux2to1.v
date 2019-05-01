module ALUmux2to1  ( input mux_ctrl , 
	input signed [31:0] Input1 ,
	input signed [31:0] Input2  , 
	output reg signed [31:0] Output ) ;

always @ ( mux_ctrl or Input1 or Input2)
begin 
  case (mux_ctrl)

0:
begin
Output = Input1 ;
end

1:
begin
Output = Input2 ;
end

endcase 

end

endmodule 