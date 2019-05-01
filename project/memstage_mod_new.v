

module DataMemory( address, memRead, memWrite, dataIn, dataOut);

    output reg [31:0] dataOut;
    
    input [31:0] dataIn;

    input [31:0] address;

    input  memRead, memWrite;

    reg [31:0] memory [0:127];

    initial 
     begin
        // read from memory file
        $readmemb("memory.txt", memory);
    end

 

    always @(memWrite or memRead or dataIn or address)
    begin
        if (memWrite == 1)
        begin
            memory[address] <= dataIn;
	$writememb("memory.txt", memory);
        end
        
        else if (memRead == 1)
        begin
            dataOut <= memory[address];
        end

    end

 
endmodule



module memstagenew(RegWrite , MemtoReg , MemRead ,MemWrite,address ,dataIn ,rd ,dataOut , MEMWBaluresult, MEMWBMemtoReg ,RegWriteFWUnit , rdFWUnit   ) ;




//control lines---- 

  //forWB
input RegWrite ;
input MemtoReg ;
  //forMEM
input MemRead ;
input MemWrite ;


//inputs for the mem------
  //ALU result = address for the memory
input [31:0] address ;
input [31:0] dataIn ;

//
input [4:0]  rd ;

output  [31:0] dataOut ;
output reg signed [31:0] MEMWBaluresult;

output reg MEMWBMemtoReg ;
output reg RegWriteFWUnit ;
output reg [4:0] rdFWUnit ;
wire memR ;
wire memWrt ;
wire [31:0]aluresult ; 
wire regwrite ;
//wire [4:0] rd ;
//wire [31:0] dataout ;


//assign dataout = dataOut ;
assign aluresult = address ;
assign regwrite = RegWrite ;
assign memR =MemRead ;
assign memWrt = MemWrite ;


always@(regwrite or aluresult or rd  or MemtoReg  )
begin

 RegWriteFWUnit=regwrite;


 MEMWBaluresult=aluresult ;


 rdFWUnit=rd;
 

 MEMWBMemtoReg =MemtoReg ;





end

 DataMemory data1 ( aluresult, memR, memWrt, dataIn, dataOut);




endmodule 





module memstagetbnew ();


reg clk ;

//control lines---- 

  //forWB
reg RegWrite ;
reg MemtoReg ;
  //forMEM
reg MemRead ;
reg MemWrite ;

//inputs for the mem------
  //ALU result = address for the memory
reg [31:0] address ;
reg [31:0] dataIn ;

//
reg [4:0]  rd ;

wire [31:0] dataOut ;
wire [31:0] MEMWBaluresult;

wire MEMWBMemtoReg ;


wire RegWriteFWUnit ;
wire [4:0] rdFWUnit ;


memstagenew memstagenew11 (RegWrite , MemtoReg , MemRead ,MemWrite,address ,dataIn ,rd ,dataOut , MEMWBaluresult, MEMWBMemtoReg ,RegWriteFWUnit , rdFWUnit   ) ;


always 
begin
#5
clk=~clk;
end




initial 
begin


clk=0;
//$monitor ( "op=%d  in1=%d  in2=%d  o1=%d" , dataOut , dataIn , RegWriteFWUnit , rdFWUnit );

#5

//control lines---- 

  //forWB
RegWrite=0;
MemtoReg=1;
  //forMEM
 MemRead=0 ;
MemWrite=1 ;

//inputs for the mem------
  //ALU result = address for the memory
address=2 ;
dataIn=4 ;

//
rd =6 ;
#5
$display( "DATAOUT=%d  DATAIN=%d  in2=%d  o1=%d"   , dataOut , dataIn , RegWriteFWUnit , rdFWUnit  );
#5
address=2 ;
MemRead=1 ;
MemWrite=0 ;
RegWrite=1;
#5
$display( "DATAOUT =%d  DATAIN=%d  in2=%d  o1=%d" , dataOut , dataIn , RegWriteFWUnit , rdFWUnit );
#5
address=0 ;
MemRead=0 ;
MemWrite=1 ;
RegWrite=1;

dataIn=2 ;
#5
$display( "DATAOUT =%d  DATAIN=%d  in2=%d  rd1=%d rd2=%d  " , dataOut , dataIn , RegWriteFWUnit , rdFWUnit, MemWrite);


end    


endmodule 