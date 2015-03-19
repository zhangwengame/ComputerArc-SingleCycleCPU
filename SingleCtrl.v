`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:07:14 05/15/2014 
// Design Name: 
// Module Name:    SingleCtrl 
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
module SingleCtrl(input wire [5:0]OP,output wire [9:0]sCtrl);
wire [1:0] ALUop;
wire RegDst, ALUsrc, MemtoReg, RegWrite,
MemRead, MemWrite, Branch, Jump, Lw, Sw, R, Beq, Addi, J;
assign sCtrl[9:8] = ALUop[1:0];
assign sCtrl[7] = RegDst;
assign sCtrl[6] = ALUsrc;
assign sCtrl[5] = MemtoReg;
assign sCtrl[4] = RegWrite;
assign sCtrl[3] = MemRead;
assign sCtrl[2] = MemWrite;
assign sCtrl[1] = Branch;
assign sCtrl[0] = Jump;
assign R=~OP[5]&~OP[4]&~OP[3]&~OP[2]&~OP[1]&~OP[0];
assign Lw=OP[5]&~OP[4]&~OP[3]&~OP[2]&OP[1]&OP[0];
assign Sw=OP[5]&~OP[4]&OP[3]&~OP[2]&OP[1]&OP[0];
assign Beq=~OP[5]&~OP[4]&~OP[3]&OP[2]&~OP[1]&~OP[0];
assign Addi=~OP[5]&~OP[4]&OP[3]&~OP[2]&~OP[1]&~OP[0];
assign J=~OP[5]&~OP[4]&~OP[3]&~OP[2]&OP[1]&~OP[0];
assign RegDst=R;
assign ALUsrc=Lw|Sw|Addi;
assign MemtoReg=Lw;
assign RegWrite=R|Lw|Addi;
assign MemRead=Lw;
assign MemWrite=Sw;
assign Branch=Beq;
assign ALUop[1]=R;
assign ALUop[0]=Beq;
assign Jump=J;
endmodule