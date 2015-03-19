`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:13 05/15/2014 
// Design Name: 
// Module Name:    DataMemUnit 
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
//读出 写入约需2周期 应分配2/4周期
module DataMemUnit(input wire clk,input wire bclk,input wire MemRead,input wire MemWrite,
input wire [31:0]addr,input wire [31:0]DataIn,input wire [1:0]DisMemIn,output reg [31:0]DataOut,output wire [7:0]Dismem);
wire ena,Memwrite;
reg memwrite,dismemwrite;
reg [7:0] datain0,datain1,datain2,datain3,datain4;
wire [7:0] dataout0,dataout1,dataout2,dataout3;
reg [8:0] addr0,addr1,addr2,addr3;
reg [4:0] count;
//integer count;
reg [1:0] addr4;
//timer_1ms t0(clk,clk_1ms);
assign ena=MemRead|MemWrite;
DateMem DM0(.clka(clk),.ena(ena),.wea(memwrite),.addra(addr0[8:0]),.dina(datain0[7:0]),.douta(dataout0)); 
DateMem DM1(.clka(clk),.ena(ena),.wea(memwrite),.addra(addr1[8:0]),.dina(datain1[7:0]),.douta(dataout1)); 
DateMem DM2(.clka(clk),.ena(ena),.wea(memwrite),.addra(addr2[8:0]),.dina(datain2[7:0]),.douta(dataout2)); 
DateMem DM3(.clka(clk),.ena(ena),.wea(memwrite),.addra(addr3[8:0]),.dina(datain3[7:0]),.douta(dataout3)); 
DisMem DISM0(.clka(clk),.wea(dismemwrite),.addra({2'b00,addr4}),.dina(datain4),.clkb(clk),.addrb({2'b00,DisMemIn[1:0]}),.doutb(Dismem[7:0]));
initial
begin
  memwrite=0;
  dismemwrite=0;
  count=0;
end
always @(posedge clk /*or posedge bclk*/)
begin
	if (count<20)
		count=(count+1)&{5{~{bclk|~MemWrite}}};
	else
		count=count&{5{~{bclk|~MemWrite}}};
end
assign Memwrite=count==20?1:0;
always @(negedge clk)
begin
	memwrite<=Memwrite&~addr[11];
	dismemwrite<=Memwrite&addr[11];
	addr4<=addr[1:0];
	datain4<=DataIn[7:0];
	case (addr[1:0])
		2'b00:begin
					addr0<=addr[10:2];
					addr1<=addr[10:2];
					addr2<=addr[10:2];
					addr3<=addr[10:2];					
					datain0<=DataIn[31:24];
					datain1<=DataIn[23:16];
					datain2<=DataIn[15:8];
					datain3<=DataIn[7:0];
				end
		2'b01:begin
					addr0<=addr[10:2]+1;
					addr1<=addr[10:2];
					addr2<=addr[10:2];
					addr3<=addr[10:2];
					datain1<=DataIn[31:24];
					datain2<=DataIn[23:16];
					datain3<=DataIn[15:8];
					datain0<=DataIn[7:0];
				end
		2'b10:begin
					addr0<=addr[10:2]+1;
					addr1<=addr[10:2]+1;
					addr2<=addr[10:2];
					addr3<=addr[10:2];
					datain2<=DataIn[31:24];
					datain3<=DataIn[23:16];
					datain0<=DataIn[15:8];
					datain1<=DataIn[7:0];
				end
		2'b11:begin
					addr0<=addr[10:2]+1;
					addr1<=addr[10:2]+1;
					addr2<=addr[10:2]+1;
					addr3<=addr[10:2];
					datain3<=DataIn[31:24];
					datain0<=DataIn[23:16];
					datain1<=DataIn[15:8];
					datain2<=DataIn[7:0];
				end
	endcase	
end
always @(posedge clk)
begin
	case (addr[1:0])
		2'b00:begin
					DataOut[31:24]<=dataout0;
					DataOut[23:16]<=dataout1;
					DataOut[15:8]<=dataout2;
					DataOut[7:0]<=dataout3;
				end
		2'b01:begin
					DataOut[31:24]<=dataout1;
					DataOut[23:16]<=dataout2;
					DataOut[15:8]<=dataout3;
					DataOut[7:0]<=dataout0;
				end
		2'b10:begin
					DataOut[31:24]<=dataout2;
					DataOut[23:16]<=dataout3;
					DataOut[15:8]<=dataout0;
					DataOut[7:0]<=dataout1;
				end
		2'b11:begin
					DataOut[31:24]<=dataout3;
					DataOut[23:16]<=dataout0;
					DataOut[15:8]<=dataout1;
					DataOut[7:0]<=dataout2;
				end
	endcase
end
endmodule
