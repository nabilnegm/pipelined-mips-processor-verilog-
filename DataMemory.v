module DataMemory(clk, address, memRead, memWrite, dataIn, dataOut);

    output reg [31:0] dataOut;
    
    input [31:0] dataIn;

    input [31:0] address;

    input clk, memRead, memWrite;

    reg [31:0] memory [0:127];

    initial 
    begin
        // read from memory file
        $readmemb("memory.txt", memory);
    end

    always @(clk)
    begin
        if (memWrite == 1)
        begin
            memory[address] <= dataIn;
        end
        
        else if (memRead == 1)
        begin
            dataOut <= memory[address];
        end
    end

    initial 
    begin
        // write in memory file
        $writememb("memory.txt", memory);
    end

endmodule