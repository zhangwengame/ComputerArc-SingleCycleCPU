`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:16:06 05/17/2014 
// Design Name: 
// Module Name:    counter_26bit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
	module counter_26bit(clk, reset, clk_1ms, count_out);
	parameter COUNTER=26;
	
	input clk;
	input reset;
	output clk_1ms;
	output [COUNTER-1:0] count_out;
	
	reg [COUNTER-1:0] count;//对应于count_out。
	reg second_m;//对应于clk_1ms，每毫秒出现一次脉冲。
	wire clk;
	wire [COUNTER-1:0] count_out;
	
	initial count<=0;
	
	assign clk_1ms=second_m;
	assign count_out=count;
		
	always@(posedge clk)begin
		//后16位满50000后向前进一位，同时输出毫秒脉冲。
		if(!reset || (count[15:0]==49999))begin
			count[15:0]<=0;
			count[25:16]<=count[25:16]+1;
			second_m<=1;
		end
		else begin
			count[15:0] <= count+1;
			second_m<=0;
		end
	end
	
endmodule


