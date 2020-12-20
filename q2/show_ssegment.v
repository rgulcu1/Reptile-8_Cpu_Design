module show_ssegment( clk, grounds, display, turn, sum, correctness );
input clk;
input correctness;
output reg [3:0] grounds;
output reg [6:0] display;
input wire [3:0] turn;
input wire [7:0] sum;
 
reg [3:0] data1;
reg [3:0] data2;
reg [6:0] display1;
reg [6:0] display2;
reg [6:0] display3;
reg [6:0] display4;
reg [25:0] clk1;
reg [1:0] count;

always @(posedge clk)
	begin
		clk1 <= clk1 + 1;
	end

always @(posedge clk1[14])
	begin
		count <=count+1;
		grounds <= {grounds[2:0],grounds[3]};
	end

always @(*)
	begin
		case(count)
			0: display = display1;
			1: display = display2;
			2: display = display3;
			3: display = display4;
			default : display = display;
		endcase
	end

	
always @*
	begin
		if (correctness ==1)
			begin
				case(sum)
				0:
					begin
						display1=7'b0000001; //-
						case (turn) //1 or 2
							1:display2=7'b0110000; 
							2:display2=7'b1101101;
							default display2=7'b0000001;
						endcase
						display3=7'b0000001; //-
						display4=7'b0000001; //-
					end
					
				100: 
					begin
						display1=7'b0110000; //Turn 1
						display2=7'b0110000; //1
						display3=7'b1111110; //0
						display4=7'b1111110; //0
					end
		
				default: 
					begin
						data1 = sum / 10;
						data2 = sum % 10;
						case (turn) //1 or 2
							1:display1=7'b0110000; 
							2:display1=7'b1101101;
							default display1=7'b0000001;
						endcase
						display2=7'b1111110; //0
						
						case(data1)
							0:display3=7'b1111110; 
							1:display3=7'b0110000;
							2:display3=7'b1101101;
							3:display3=7'b1111001;
							4:display3=7'b0110011;
							5:display3=7'b1011011;
							6:display3=7'b1011111;
							7:display3=7'b1110000;
							8:display3=7'b1111111;
							9:display3=7'b1111011;
							default display3=7'b1111111;
						endcase
						case(data2)
							0:display4=7'b1111110; 
							1:display4=7'b0110000;
							2:display4=7'b1101101;
							3:display4=7'b1111001;
							4:display4=7'b0110011;
							5:display4=7'b1011011;
							6:display4=7'b1011111;
							7:display4=7'b1110000;
							8:display4=7'b1111111;
							9:display4=7'b1111011;
							default display4=7'b1111111;
						endcase
					end
			endcase
			end
		else
			begin
				case (turn) //1 or 2
					1:display1=7'b0110000; 
					2:display1=7'b1101101;
					default display1=7'b0000001;
				endcase
					display2=7'b0000001; //-
					display3=7'b0000001; //-
					display4=7'b0000001; //-
			end
	end
		
initial 
	begin
		grounds=4'b1110;
		display1=7'b0110000;
		display2=7'b0110000;
		display3=7'b1111110;
		display4=7'b1111110;
	end
endmodule