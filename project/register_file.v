module RegFile(
input regwrite,
input [4:0]readreg1 ,
input [4:0]readreg2 ,
input [4:0]writereg ,
input signed[31:0]writedata,
output reg signed  [31:0]readdata1,
output reg signed  [31:0]readdata2);
//00000000010001000010100000100000
reg signed [31:0] array [0:31];
reg [31:0]x;
reg [31:0]y;
//integer registerfile;

	initial
		begin
		$readmemb("registerfile.txt",array);
	
		end
	 

	always @(readreg1 or readreg2)
	begin

		readdata1 <= array [readreg1];
			readdata2 <= array [readreg2];
				


	end
	
	

	always @(regwrite or writedata or writereg)
	begin

	if (regwrite == 1) 
		begin
		array[writereg] <= writedata;
		$writememb("registerfile.txt", array);
		//$despl(registerfile,"%b",array);

		
		end
	end

endmodule 
