module processor(input clk);






endmodule


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



module ALU ( input signed [31:0] reg1 , signed [31:0] reg2 , wire [2:0] op , wire [3:0] shift , output reg signed [31:0] o1 );

always @(reg1 or reg2 or op or shift ) 

begin
case (op)
//and 
3'b000:o1 =reg1&reg2   ;

//or 
3'b001:o1 =reg1|reg2   ;

//add 
3'b010:o1 =reg1+reg2   ;

//sub 
3'b110:o1 =reg1-reg2   ;

//shift left
3'b011:o1 =reg1<<shift ;

//shift right
//3'b101:o1 =reg1>>shift ;
//greater than
//3'b111:o1 =reg1>reg2   ;
//smaller than
//3'b110:o1 =reg1<reg2   ;
endcase


end


endmodule 
