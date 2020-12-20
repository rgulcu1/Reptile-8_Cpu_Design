module debounced(dsin, dsout_wire, clk);
	input dsin;
	output dsout_wire;

	assign dsout_wire = dsout;
   reg dsout;
	input clk;
	
	reg [25:0] clk1;


	always @(posedge clk)
	begin
		clk1 <= clk1 + 1;
	end


	reg [127:0] cnt;

	always @(posedge clk1[11])
		cnt <= {cnt[126:0],dsin};


	always @(posedge clk)
	begin
		if (cnt==128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
			dsout<= 1'b1;
		else if(cnt == 128'h00000000000000000000000000000000)
			dsout <= 1'b0;
	end

	initial
		begin
			cnt <= 128'h00000000000000000000000000000000;
			dsout <= 1'b0;
		end
endmodule