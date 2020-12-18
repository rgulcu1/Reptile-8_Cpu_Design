module main(clk);
input clk;

reg [15:0] RAM [31:0];

wire [15:0] Din,Dout;
wire [11:0] Addr;
wire Memload;


CPU cpu(Din,clk,Dout,Addr,MemLoad);

always @(posedge clk)
begin
    Din = RAM[Addr];
    if(MemLoad)
        RAM[Addr] = Dout;
end


initial
begin
    $readmemh("RAM.dat",RAM);
    Addr = 12'h000;
end

endmodule