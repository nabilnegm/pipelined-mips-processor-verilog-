module ALU ( input signed [31:0] reg1 , input signed [31:0] reg2 ,input wire [2:0] op ,input wire [4:0] shift , output reg signed [31:0] o1 );

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