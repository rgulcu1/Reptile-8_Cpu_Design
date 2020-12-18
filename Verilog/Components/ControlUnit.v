module ControlUnit(opcode,clk,zf,Armux,MemLoad,PcLoad,PcInc,RegLoad,ZfLoad,mux,IrLoad);
input [2:0] opcode;
input zf,clk;
output Armux,MemLoad,PcLoad,PcInc,RegLoad,ZfLoad,mux,IrLoad;

reg [11:0] ROM [7:0];
reg [2:0] opcodeReg;

wire jumpZero;
wire select;
wire [2:0] firstMuxResult,secondMuxResult,registerResult;
wire fetch;
wire [11:0] signalResult;

assign jumpZero = (opcode[2] & ~opcode[1] & ~opcode[0]);
assign select = {jumpZero,zf};
assign fetch = signalResult[8];
assign PcLoad = signalResult[7];
assign PcInc = signalResult[6];
assign Armux = signalResult[5];
assign RegLoad = signalResult[4];
assign ZfLoad = signalResult[3];
assign mux = signalResult[2];
assign MemLoad = signalResult[1];
assign IrLoad = signalResult[0];
assign registerResult = opcodeReg;
assign signalResult = ROM[registerResult];

mult4_to_1_3 firstMux(firstMuxResult,opcode,opode,3'b000,3'b101,select);

mult2_to_1_3 secondMux(secondMuxResult, 3'b000,firstMuxResult,fetch);

always @(posedge clk)
begin
    opcodeReg <= secondMuxResult;
end


initial
$readmemh("ROM.dat",ROM);

endmodule
