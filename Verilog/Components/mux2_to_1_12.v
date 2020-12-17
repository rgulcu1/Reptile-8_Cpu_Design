module mult2_to_1_12(out, i0,i1,s0);
output [11:0] out;
input [11:0]i0,i1;
input s0;
assign out = s0 ? i1:i0;
endmodule
