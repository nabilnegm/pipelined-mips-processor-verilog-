module DataMemory(clk, address, memRead, memWrite, dataIn, dateOut);

    output reg [31:0] dataOut;
    
    input [31:0] dataIn;

    input [31:0] address;

    input clk, memRead, memWrite;

    always @(clk)
    begin
        if (memWrite == 1)
        begin

        end

        else if (memRead == 1)
        begin

        end
    end

    

endmodule