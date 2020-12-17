module zeroFlag(zf,clk,zfLd,zfOut);
input zf,zfLd;
output zfOut;

reg zfReg;
assign zfOut = zfReg;

always @(posedge clk)
begin
    if(zfLd)
        zfReg <= zf;
end

initial
zfReg <= 1'b0;

endmodule