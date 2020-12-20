module play_matchstick_game(clk, ds, pushbutton1, pushbutton2, display, grounds, entered_num );
input clk;
input [3:0] ds;
input pushbutton1;
input pushbutton2;
wire pb1;
wire pb2;
assign pb1 = ~pushbutton1;
assign pb2 = ~pushbutton2;

wire d_pb1;
wire d_pb2;
wire correctness_wire;
reg correctness;
assign correctness_wire = correctness;
reg [7:0] sum;
wire [7:0] sum_wire;
assign sum_wire = sum;
reg [1:0] state;

wire [3:0] turn_wire;
reg [3:0] turn;
assign turn_wire = turn;

output wire [3:0] entered_num;
reg [7:0] max_val;
output wire [3:0] grounds;
output wire [6:0] display;



show_ssegment ssdisplay (.clk(clk), .grounds(grounds), .display(display), .turn(turn_wire), .sum(sum_wire), .correctness(correctness_wire));

take_dipswitches take_ds (.ds(ds), .pushbutton1(d_pb1), .outValue(entered_num));

debounced debounced_pb1 (.dsin(pb1), .dsout_wire(d_pb1), .clk(clk));

debounced debounced_pb2 (.dsin(pb2), .dsout_wire(d_pb2), .clk(clk));


always @(negedge d_pb1 or posedge d_pb2) 
   begin
		if(d_pb2)
				begin
					sum <= 100;
					state <= 2'b00;
					turn <= 1;
					max_val <= 10;
					correctness <= 1;
				end
		else
			begin
			case(state)
			2'b00:
				begin
							if (sum <= max_val)
								max_val = sum;
							
							if(entered_num > 0 && entered_num <= max_val )
								begin
									correctness = 1;
									sum <= sum - entered_num;
									turn <= 2; 
										
								if(sum == 0) //PLAYER 2 KAZANDI
									state<=2'b10;
								else
									state <= 2'b01;
								end
							else if(entered_num == 0)
								state <= state;
							else
								begin
									correctness = 0;
									state<=state;
									turn <= 1;
								end
				end
					2'b01:
						begin
									if (sum <= max_val)
										max_val = sum;
									if(entered_num > 0 && entered_num < (max_val +1))
										begin
											correctness = 1;
											sum <= sum - entered_num;
											turn<=1;
											if(sum == 0)  //PLAYER 1 KAZANDI
												state<=2'b10;
											else
												state<=2'b00;
										end
										
									else if(entered_num == 0)
										state <= state;
										
									else
										begin
											correctness = 0;
											state<=state;
											turn <= 2;
										end
							end
					default:
						state<=state;
			endcase
		end
		
	end

initial
    begin
      sum <= 100;
		state <= 2'b00;
		turn <= 1;
		max_val <= 10;
		correctness <= 1;
		//reset_required <= 0;
    end

endmodule