`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:11:17 05/17/2014 
// Design Name: 
// Module Name:    top 
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
module top(	input CCLK, BTN2, input [3:0] SW, output LCDRS, LCDRW, LCDE, 
					output [3:0] LCDDAT, output [7:0] LED,output [31:0] disp_num,output [31:0]PC);
	 
//	parameter COUNTER=26;
//	wire [COUNTER-1:0] count_out;
	wire clk_1ms;
	wire BTN2_OUT;
	reg reset=1;
	wire [3:0] lcdd;
   wire rslcd, rwlcd, elcd;
	reg [255:0]strdata = "0123456789abcdefHello world!0000";
	reg [3:0] temp=0;
	reg [19:0] disp_code;
	reg [4:0] sww;
	wire [31:0] disp_num;
	
	assign LCDDAT[3]=lcdd[3];
	assign LCDDAT[2]=lcdd[2];
	assign LCDDAT[1]=lcdd[1];
	assign LCDDAT[0]=lcdd[0];

	assign LCDRS=rslcd;
	assign LCDRW=rwlcd;
	assign LCDE=elcd;

	assign LED[0] = SW[0];
	assign LED[1] = SW[1];
	assign LED[2] = SW[2];
	assign LED[3] = SW[3];
	assign LED[4] = temp[0];
	assign LED[5] = temp[1];
	assign LED[6] = temp[2];
	assign LED[7] = temp[3];

	display M0 (CCLK, debpb0, strdata, rslcd, rwlcd, elcd, lcdd);      
	
	clock M2 (CCLK, 25000, clk_1ms);
   pbdebounce M1 (clk_1ms, BTN2, BTN2_OUT);
	
	always @(posedge BTN2_OUT)
	begin
		temp = temp +1;
		case(temp) 
			4'b0000:strdata[7:0] <= "0";
			4'b0001:strdata[7:0] <= "1";
			4'b0010:strdata[7:0] <= "2";
			4'b0011:strdata[7:0] <= "3";
			4'b0100:strdata[7:0] <= "4";
			4'b0101:strdata[7:0] <= "5";
			4'b0110:strdata[7:0] <= "6";
			4'b0111:strdata[7:0] <= "7";
			4'b1000:strdata[7:0] <= "8";
			4'b1001:strdata[7:0] <= "9";
			4'b1010:strdata[7:0] <= "A";
			4'b1011:strdata[7:0] <= "B";
			4'b1100:strdata[7:0] <= "C";
			4'b1101:strdata[7:0] <= "D";
			4'b1110:strdata[7:0] <= "E";
			4'b1111:strdata[7:0] <= "F";
			default:strdata[7:0] <= "0";
			endcase
	end
//	counter_26bit m1(clk, reset, clk_1ms, count_out);
//	key_switch m2(clk_1ms, count_out, push, sw, push_out, sw_out); 	
//	display m3(clk, count_out, disp_code, blinking, digit_anode, display);
//	display_x m4(clk,disp_num,anode,segment);
	
	wire [31:0] OP;	
	wire [31:0] PC4;
	wire [31:0] NextPC;
	wire [31:0] ReadData;
	wire [31:0] Result;
	wire [2:0] ALUop;
	wire [1:0] Branch;
	wire RegDst, ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite,  Jump;
	wire zero, PCclk;
	wire [4:0] regA, regB, regW;
	wire [31:0] Adat, Bdat, BBdat, Wdat;
	wire [2:0] ALUoper;
	wire [9:0] PCclk_;
	wire [5:0] Func;
	wire [31:0] BranchTo;
	
	wire [55:0] tempdata;
	
	reg [31:0] PC;
	initial PC = 0;
	
	always@(posedge CCLK)begin
	case(SW[3:0])
		0:disp_code={Bdat[9:0],2'b00,Result[7:0]};
		//0:disp_code={1'b0,Adat[7:4],1'b0,Adat[3:0],1'b0,Bdat[7:4],1'b0,Bdat[3:0]};
		1:disp_code={1'b0,Result[15:12],1'b0,Result[11:8],1'b0,Result[7:4],1'b0,Result[3:0]};
		2:disp_code={1'b0,1'b0,ALUoper[2:0],regW[4:0],1'b0,ReadData[7:4],1'b0,ReadData[3:0]};
		3:disp_code={1'b0,Wdat[15:12],1'b0,Wdat[11:8],1'b0,Wdat[7:4],1'b0,Wdat[3:0]};
		4:disp_code={1'b0,ReadData[15:12],1'b0,ReadData[11:8],1'b0,ReadData[7:4],1'b0,ReadData[3:0]};
		5:disp_code=tempdata[19:0];
		6:disp_code=tempdata[39:20];
		7:disp_code={4'd0,tempdata[55:40]};
		8:disp_code={1'b0,PC[15:12],1'b0,PC[11:8],1'b0,PC[7:4],1'b0,PC[3:0]};
		9:disp_code={1'b0,NextPC[15:12],1'b0,NextPC[11:8],1'b0,NextPC[7:4],1'b0,NextPC[3:0]};
		10:disp_code={4'b0,zero,4'b0,Branch,1'b0,BranchTo[7:4],1'b0,BranchTo[3:0]};
	endcase
	end
	
	assign PCclk = BTN2;//BTN2_OUT;	
	assign PC4 = PC + 4;
	assign NextPC = Jump?{PC4[31:28],OP[25:0],2'b00}:((zero&Branch[0]|~zero&Branch[1])?BranchTo:PC4);
	assign regA = OP[25:21];
	assign regB = OP[20:16];
	assign regW = RegDst?OP[15:11]:OP[20:16];
	assign Wdat = MemtoReg?ReadData:Result;
	assign Func = OP[5:0];
	assign BBdat = ALUsrc?{16'd0,OP[15:0]}:Bdat;
	
	always@(posedge PCclk) PC <= NextPC;
	
	SingleCtrl m5(OP[31:26], ALUop, RegDst, ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump);
	RegFile m6(PCclk, PCclk_, regA, regB, regW, Wdat, Adat, Bdat, RegWrite, {1'b0,SW[3:0]}, disp_num);	
	ALU m7 (Adat,BBdat,ALUoper,Result,zero,,);
	ALUctr m8(ALUop, Func, ALUoper);
	InstrMem m9(.clka(CCLK),.addra(PC[9:2]),.douta(OP));
	ALU m10(PC4,{{14{OP[15]}},OP[15:0],2'b00},3'b010,BranchTo,,,);
	DataMems m11(PCclk_[4], Result[7:0],Bdat, MemRead, MemWrite, ReadData,tempdata);
	delay m12(PCclk,CCLK,PCclk_,);
	
	
endmodule
