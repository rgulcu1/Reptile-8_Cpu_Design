module instructionSplitter(instruction,IRload,clk,AluCode,src1,src2,dest,relativeOffsett);
input [11:0] instruction;
input IRload,clk;
output [5:0] AluCode;
output [2:0] src1,src2,dest;
output [11:0] relativeOffsett;

reg [11:0] instructionReg;
wire registerWire;

assign registerWire = instructionRe;
assign AluCode = registerWire[11:6];
assign src1 = registerWire[8:6];
assign src2 = registerWire[5:3];
assign dest = registerWire[2:0];
assign relativeOffsett = registerWire;

always @(clk posedge)
begin
    if(IRload)
        instructionReg <= instruction;
end
endmodule


