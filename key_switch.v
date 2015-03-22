`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:36 05/17/2014 
// Design Name: 
// Module Name:    key_switch 
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
module key_switch(clk, count_out, push, sw, push_out,sw_out);
	parameter COUNTER=26;
	parameter num=21;
	
	input clk;
	input [COUNTER-1:0] count_out;
	input [3:0] push;
	input [7:0] sw;
	output [3:0] push_out;
	output [7:0]sw_out;
	
	wire clk;
	wire [COUNTER-1:0] count_out;
	reg [7:0] direct;
	reg [3:0] push_out;
	reg keydirection;
	
	assign keypush=|push;//ֻҪpush����һ��Ϊ1��keypush��Ϊ1��

	always@(posedge clk)
		//û�а�ʱkeydirectionΪ0
		if (!keypush)begin
			keydirection<=0;
			direct[7:4]<=push;
		end
		//���²���count_out[21:19]Ϊ100ʱ������keydirection��Ϊ1
		else if(keypush && count_out[num]&& count_out[num-1]==0 && count_out[num-2]==0)
			keydirection<=1;
	
	always@(negedge clk)
		//���²���count_out[21:19]Ϊ011����keydirectionΪ1ʱ����ʵ�ʼ��������
		if (push!=4'b0000 && count_out[num]==0 && count_out[num-1] && count_out[num-2] && keydirection==1)
		begin
			push_out<=push;
			direct[3:0]<=push;
		end
		//��keydirectionΪ0ʱ��Ϊ�ް�������
		else if(!keydirection)
			push_out<=0;

endmodule
