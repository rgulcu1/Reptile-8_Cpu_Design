module CPU(Din,clk,Dout,Addr,MemLoad);
input [15:0] Din;
input clk;
output [15:0] Dout;
output [11:0] Addr;
output MemLoad;

wire [11:0] Din_0_11,relativeOffset , pc , jumpAddress , src2_11_0;
wire Armux,memLd,PcLoad,PcInc,RegLoad,ZfLoad,mux,IrLoad; // control signals
wire zf , zfOut;
wire [2:0] opcode,src1,src2,dest;
wire [5:0] AluCode;
wire [15:0] RegOut1,RegOut2,RegOut3,RegOut4,RegOut5,RegOut6,RegOut7,RegOut8 , src1Data , src2Data , aluResult , registerDin;


assign Din_0_11 = Din[11:0];
assign opcode =Din[14:12];
assign src2_11_0 = src2Data[11:0];
assign Dout = src1Data;
assign MemLoad = memLd;

instructionSplitter ins(Din_0_11,IrLoad,clk,AluCode,src1,src2,dest,relativeOffset);

ControlUnit cu(opcode,clk,Armux,memLd,PcLoad,PcInc,RegLoad,ZfLoad,mux,IrLoad);

mult8_to_1_16 registerMux1(src1Data,RegOut1,RegOut2,RegOut3,RegOut4,RegOut5,RegOut6,RegOut7,RegOut8,src1);

mult8_to_1_16 registerMux2(src2Data,RegOut1,RegOut2,RegOut3,RegOut4,RegOut5,RegOut6,RegOut7,RegOut8,src2);

ALU alu(aluResult,src1Data,src2Data,zf,AluCode);

zeroFlag zf(zf,clk,ZfLoad,zfOut);

mult2_to_1_16 aluOrDataMux(registerDin, aluResult,Din,mux);

RegisterBank rb(dest,registerDin,RegLoad,clk,RegOut1,RegOut2,RegOut3,RegOut4,RegOut5,RegOut6,RegOut7,RegOut8);

adder_12 adder(pc,relativeOffset,out);

PC pc(jumpAddress,PcInc,PcLoad,clk,pc);

mult2_to_1_12 addressMux(Addr, pc,src2_11_0,Armux);

endmodule