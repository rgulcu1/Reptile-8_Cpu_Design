module PC(jumpAddress,PCInc,PCLoad,clk,pc);
input [11:0] jumpAddress;
input PCInc,PCLoad,clk;
output [11:0] pc;

reg [11:0] pcRegister;

assign pc = pcRegister;

always @(posedge clk)
begin
    if(PCLoad)
    begin
        if(PCInc)
            pcRegister <= pc + 12'h001;
        else
            pcRegister <= jumpAddress;
    end
end

initial
    pc <= 12'h000;
endmodule