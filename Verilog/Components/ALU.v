module ALU(sum,src1,src2,zeroFlag,aluControl);
output [15:0] sum;
input [15:0] src1,src2; 
input [5:0] aluControl;
output zeroFlag;

wire[15:0] firstMuxResult;

always @(*)
begin
    case(aluControl[2:0])
        3'b000: firstMuxResult = src1;
        3'b001: firstMuxResult = ~src1;
        3'b010: firstMuxResult = src1 + 16'h0001;
        3'b011: firstMuxResult = src1 - 16'h0001;
        default: firstMuxResult=16'bx;	
    endcase
end

always @(*)
begin
    case(aluControl[5:3])
        3'b000: sum = src1 + src2;
        3'b001: sum = src1 - src2;
        3'b010: sum = src1 & src2;
        3'b011: sum = src1 | src2;
        3'b100: sum = src1 ^ src2;
        3'b111: sum = firstMuxResult;
        default: sum=16'bx;	
    endcase

    zeroFlag =~(|sum);
end
endmodule