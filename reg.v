`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:14 05/14/2014 
// Design Name: 
// Module Name:    reg 
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
module Reg(input wire clk,input wire bclk, input wire RegWrite, input wire [4:0]R1, input wire [4:0]R2, input wire [4:0]WR, input wire [31:0]WData,
output reg [31:0]RData1, output reg [31:0]RData2,output wire [1023:0] Check);
reg [31:0]r[31:0];
reg [31:0]LWData;
reg [4:0]state;
wire flag;
wire wclk;
initial
begin
	r[0]=0;r[1]=0;r[2]=0;r[3]=0;r[4]=0;r[5]=0;r[6]=0;r[7]=0;r[8]=0;r[9]=0;r[10]=0;
	r[11]=0;r[12]=0;r[13]=0;r[14]=0;r[15]=0;r[16]=0;r[17]=0;r[18]=0;r[19]=0;r[20]=0;
	r[21]=0;r[22]=0;r[23]=0;r[24]=0;r[25]=0;r[26]=0;r[27]=0;r[28]=0;r[29]=2047;r[30]=0;
	r[31]=0;
	state=0;
end
assign wclk=clk&RegWrite;
always @ (posedge clk)
begin
	if (wclk==1)
		r[WR]<=WData;
	else
	begin
		RData1<=r[R1];
		RData2<=r[R2];
	end
end
assign Check={r[0],r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9],r[10],r[11],r[12],r[13],r[14],
r[15],r[16],r[17],r[18],r[19],r[20],r[21],r[22],r[23],r[24],r[25],r[26],r[27],r[
28],r[29],r[30],r[31]};
endmodule
