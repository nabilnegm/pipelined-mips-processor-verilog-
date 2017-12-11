
module IMemory (PC, instruction);



reg [31:0] imemory[0:1024];
input wire [0:31]PC;
output reg [0:31] instruction;


initial
begin

$readmemb ("instructionfile.txt",imemory);



end
always @(PC)
begin

instruction <= imemory[PC];
#1
$display("%b",instruction);

end




endmodule