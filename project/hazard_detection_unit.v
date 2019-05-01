module stallUnit(IDRegRs,IDRegRt,EXRegRt,EXMemRead,lw_hazard);
 input [4:0] IDRegRs,IDRegRt,EXRegRt;
 input EXMemRead;
 output reg lw_hazard;


 always@(IDRegRs,IDRegRt,EXRegRt,EXMemRead)
 if(EXMemRead&((EXRegRt == IDRegRs)|(EXRegRt == IDRegRt)))
 begin//stall
 lw_hazard=1;
 end
 else
 begin//no stall
 lw_hazard=0;

 end
endmodule 
