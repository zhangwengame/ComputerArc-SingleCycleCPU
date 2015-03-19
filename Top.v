`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:20 05/14/2014 
// Design Name: 
// Module Name:    Top 
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
module Top(input wire CCLK, input wire [3:0]BTN_IN, input wire [3:0]SW, 
output wire LCDE, LCDRS, LCDRW, output wire [3:0]LCDDAT);
wire [11:0]btn_out;
reg [31:0]disnum_32;
reg [31:0]PC;
wire [1023:0]Check;
wire [31:0]Ins,RData1,RData2,ALUB,S,DataOut,WData,BeqPC,NormalPC,NextPC1,JPC,NextPC2;
wire [9:0]sCtrl,b,s;
wire [4:0]WR;
wire [2:0]ALUoper;
wire [7:0]Dismem;
wire zero;
wire [1:0]DisMemIn;
initial
begin
	PC=0;
end
/*assign Out=PC;
assign Out2=Ins;
assign Out3=Dismem;*/
assign WR=(Ins[20:16]&{5{~sCtrl[7]}})|(Ins[15:11]&{5{sCtrl[7]}});
assign ALUB[31:0]=(RData2[31:0]&{32{~sCtrl[6]}})|({{16{Ins[15]}},Ins[15:0]}&{32{sCtrl[6]}});
assign WData[31:0]=(S[31:0]&{32{~sCtrl[5]}})|(DataOut[31:0]&{32{sCtrl[5]}});
assign NormalPC[31:0]=PC[31:0]+4;
assign JPC[31:0]={NormalPC[31:28],Ins[25:0],2'b00};
assign BeqPC[31:0]=NormalPC[31:0]+{{14{Ins[15]}},Ins[15:0],2'b00};
assign NextPC1[31:0]=(NormalPC[31:0]&{32{~(zero&sCtrl[1])}})|(BeqPC[31:0]&{32{(zero&sCtrl[1])}});
assign NextPC2=(NextPC1&{32{~sCtrl[0]}})|(JPC&{32{sCtrl[0]}});
/*assign sCtrl[9:8] = ALUop[1:0];
assign sCtrl[7] = RegDst;
assign sCtrl[6] = ALUsrc;
assign sCtrl[5] = MemtoReg;
assign sCtrl[4] = RegWrite;
assign sCtrl[3] = MemRead;
assign sCtrl[2] = MemWrite;
assign sCtrl[1] = Branch;
assign sCtrl[0] = Jump;*/
InsMem i0(.clka(clk),.wea(0),.addra(PC[11:2]),.dina(0),.douta(Ins[31:0])); 
SingleCtrl s0(.OP(Ins[31:26]),.sCtrl(sCtrl[9:0]));
Reg r0(.clk(clk),.bclk(btn_out[2]),.RegWrite(sCtrl[4]),.R1(Ins[25:21]),.R2(Ins[20:16]),.WR(WR[4:0]),.WData(WData[31:0]),.RData1(RData1[31:0]),.RData2(RData2[31:0]),.Check(Check[1023:0]));
ALU A0(.clk(clk),.A(RData1[31:0]),.B(ALUB[31:0]),.ALUC(ALUoper[2:0]),.S(S[31:0]),.zero(zero));
ALUctrl Ac0(.ALUop(sCtrl[9:8]),.Func(Ins[5:0]),.ALUoper(ALUoper[2:0]));
DataMemUnit D0(.clk(clk),.bclk(btn_out[2]),.MemRead(sCtrl[3]),.MemWrite(sCtrl[2]),.addr(S[31:0]),.DataIn(RData2[31:0]),.DisMemIn(DisMemIn[1:0]),.DataOut(DataOut[31:0]),.Dismem(Dismem[7:0]));
display d2(.clk(clk),.digit(Dismem[7:0]),.memaddr(DisMemIn[1:0]),.node(anode[3:0]),.segment(segment[7:0]),.xw(4'b0000));

pbdebounce p0(clk,btn_in[0],btn_out[0]);
pbdebounce p1(clk,btn_in[1],btn_out[1]);
pbdebounce p2(clk,btn_in[2],btn_out[2]);
always @(posedge btn_out[2])
begin
	PC<=NextPC2;
end
display32bits d1(clk,disnum_32,anode[11:4],segment[15:8]);
always @(posedge clk)
begin
	case (switch[4:0])
		5'b00000: disnum_32=Check[1023:992];
		5'b00001: disnum_32=Check[991:960];
		5'b00010: disnum_32=Check[959:928];
		5'b00011: disnum_32=Check[927:896];
		5'b00100: disnum_32=Check[895:864];
		5'b00101: disnum_32=Check[863:832];
		5'b00110: disnum_32=Check[831:800];
		5'b00111: disnum_32=Check[799:768];
		5'b01000: disnum_32=Check[767:736];
		5'b01001: disnum_32=Check[735:704];
		5'b01010: disnum_32=Check[703:672];
		5'b01011: disnum_32=Check[671:640];
		5'b01100: disnum_32=Check[639:608];
		5'b01101: disnum_32=Check[607:576];
		5'b01110: disnum_32=Check[575:544];
		5'b01111: disnum_32=Check[543:512];
		5'b10000: disnum_32=Check[511:480];
		5'b10001: disnum_32=Check[479:448];
		5'b10010: disnum_32=Check[447:416];
		5'b10011: disnum_32=Check[415:384];
		5'b10100: disnum_32=Check[383:352];
		5'b10101: disnum_32=Check[351:320];
		5'b10110: disnum_32=Check[319:288];
		5'b10111: disnum_32=Check[287:256];
		5'b11000: disnum_32=Check[255:224];
		5'b11001: disnum_32=Check[223:192];
		5'b11010: disnum_32=Check[191:160];
		5'b11011: disnum_32=Check[159:128];
		5'b11100: disnum_32=Check[127:96];
		5'b11101: disnum_32=Check[95:64];
		5'b11110: disnum_32=Check[63:32];
		5'b11111: disnum_32=Check[31:0];	
	endcase
end
endmodule
