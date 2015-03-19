`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:46:08 05/14/2014 
// Design Name: 
// Module Name:    ALU 
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
module ALU(input wire clk,input wire [31:0]A, input wire [31:0]B, input wire [2:0]ALUC, output reg [31:0]S, output reg zero);
always @(posedge clk)
begin
	case (ALUC[2:0])
		3'b000:S=A&B;
		3'b001:S=A|B;
		3'b010:S=A+B;
		3'b110:S=A-B;
		3'b111:if (A<B) S=1;
				 else S=0;
		default:S=A+B;
   endcase		
	if (A==B) zero=1;
	else zero=0;
end
/*assign zero=~S[0]&~S[1]&~S[2]&~S[3]&~S[4]&~S[5]&~S[6]&~S[7]&~S[8]&~S[9]&~S[10]&
            ~S[11]&~S[12]&~S[13]&~S[14]&~S[15]&~S[16]&~S[17]&~S[18]&~S[19]&~S[20]&
				~S[21]&~S[22]&~S[23]&~S[24]&~S[25]&~S[26]&~S[27]&~S[28]&~S[29]&~S[30]&~S[31];*/
endmodule
