module ALUControl (Instruction,ALUOpType,ALUControlOutput);


//---------------//
//--InputPorts--//
//-------------//

input [5:0] Instruction; //Function Used
input [1:0] ALUOpType; //Output from Control Unit

//---------------------------------------------------------------//

//----------------//
//--OutputPorts--//
//--------------//

output [2:0] ALUControlOutput; //Output from ALU Control and Input to ALU

//---------------------------------------------------------------//

//----------------//
//---Temp Reg----//
//--------------//

reg [2:0] result;

assign ALUControlOutput = result;

//--------------------------------------------------------------//
always@ (Instruction or ALUOpType )
begin

		     //--ALUOp--// //--Operation--/    //--Function--//

	if (ALUOpType == 2'b00)  // Load Or Store
		begin
			result = 3'b010;                 // Add
		end
	else if(ALUOpType == 2'b01) //Beq
		begin
			result = 3'b110;                 // Sub
		end
	else if(ALUOpType == 2'b10) //Arithmetic
		begin
			case (Instruction)
			    //---Instruction---//   //--Output--//      //--Function--//
				6'b100000:
					begin
						result = 3'b010;             // Add
					end
				6'b100010: 
					begin
     						result = 3'b110; 	     // Sub
					end
				6'b100100:
					begin
						result = 3'b000;             // And
					end
				6'b100101:
					begin
						result = 3'b001;             // Or
					end
				6'b000000:
					begin
						result = 3'b011;            // Sll (Shift Left Logically)
					end

			endcase
		end
	else
		begin
		result = 3'bxxx;
		end

end


endmodule


module ALUControlTestBench;

reg [5:0] Instruction;
reg [1:0] ALUOpType;

wire [2:0] ALUControlOutput;

initial
begin

$monitor ("Instruction = %b ALUOpType = %b ALUControlOutput = %b",Instruction,ALUOpType,ALUControlOutput);

#5
ALUOpType = 2'b00;
#5
ALUOpType = 2'b01;
#5
ALUOpType = 2'b10;
Instruction = 6'b10_0000;
#5
ALUOpType = 2'b10;
Instruction = 6'b00_0000;
#5
ALUOpType = 2'b10;
Instruction = 6'b10_0010;
#5
ALUOpType = 2'b10;
Instruction = 6'b100100;
#5
ALUOpType = 2'b10;
Instruction = 6'b100101;
#5
ALUOpType = 2'b11;
Instruction = 6'b100101;



end

ALUControl aluctrl (Instruction,ALUOpType,ALUControlOutput);

endmodule

