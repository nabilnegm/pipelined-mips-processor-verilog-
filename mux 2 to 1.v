

module mux2to1  ( input wire mux_ctrl , input wire [31:0] Input1 ,input wire [31:0] Input2  , output reg [31:0] Output ) ;

always @ ( Input1 or Input2 or mux_ctrl )
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