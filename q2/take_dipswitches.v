module take_dipswitches(input [3:0] ds, input pushbutton1, output[3:0] outValue);

	wire [3:0] switch;
	assign switch = ds;
	assign outValue = entered_num;
	reg[3:0] entered_num;

always @(posedge pushbutton1)
	begin
		entered_num <= switch;
	end
initial
    begin
		entered_num = 0;
	 end
endmodule