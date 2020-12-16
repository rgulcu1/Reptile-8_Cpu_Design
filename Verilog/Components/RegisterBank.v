module RegisterBank(rd,Datain,registerLoad,clk,DataOut1,DataOut2,DataOut3,DataOut4,DataOut5,DataOut6,DataOut7,DataOut8);
input [2:0] rd;
input [15:0] Datain;
input registerLoad, clk;
output [15:0] DataOut1,DataOut2,DataOut3,DataOut4,DataOut5,DataOut6,DataOut7,DataOut8;

reg [15:0] registers[7:0];


always @(posedge clk)
begin
    if(registerLoad)
    begin
        case(rd)
            3'b000: registers[0] <= Datain;
            3'b001: registers[1] <= Datain;
            3'b010: registers[2] <= Datain;
            3'b011: registers[3] <= Datain;
            3'b100: registers[4] <= Datain;
            3'b101: registers[5] <= Datain;
            3'b110: registers[6] <= Datain;
            3'b111: registers[7] <= Datain;
        endcase
    end  
end

always @(*)
begin
    DataOut1 = registers[0];
    DataOut2 = registers[1];
    DataOut3 = registers[2];
    DataOut4 = registers[3];
    DataOut5 = registers[4];
    DataOut6 = registers[5];
    DataOut7 = registers[6];
    DataOut8 = registers[7];
end

initial
begin
    for(i=0; i<31; i=i+1)
        registers[i] <= 16'b0000000000000000; 
end
      
endmodule