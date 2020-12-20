module main(pushButton,grounds,display);
input clk;
output [3:0] grounds;
output [6:0] display;

reg [15:0] RAM [31:0];

wire [15:0] Din,Dout;
wire [11:0] Addr;
wire pb;
wire Memload;

assign Din = RAM[Addr];
assign pb = ~pushbutton;

CPU cpu(Din,pb,Dout,Addr,MemLoad,grounds,display);

always @(posedge pb)
begin
    if(MemLoad)
        RAM[Addr] = Dout;
end


initial
begin
    $readmemh("RAM.dat",RAM);
    Addr = 12'h000;
end

endmodule