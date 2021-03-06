`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:12:14 05/17/2014 
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
module ALU(
input [31:0] Adat,
input [31:0] Bdat,
input [2:0] ALUoper,
output [31:0] Result,
output zero,
output carryout,
output overflow
);
wire slt, caryt, overf;
wire[31:0] andt, orxt, addsub,sll,srl,sra; 
wire signed[31:0] signedBdat;
assign signedBdat=Bdat;
assign andt = Adat&Bdat;//And
assign orxt = Adat|Bdat;//Or
assign sll  = Bdat<<Adat;
assign srl  = Bdat>>Adat;
assign sra  = signedBdat>>>Adat;
Adder32 a32a(Adat, Bdat, ALUoper[2], ALUoper[2], addsub, caryt, overf); //Add/Sub
xor(cyt, caryt, ALUoper[2]); //SUB
xor(slt, overf, addsub[31]); //SLT
MUX8x1 mx8(Result, {ALUoper[2],ALUoper[1],ALUoper[0]}, andt, orxt, addsub, sll, srl, sra, addsub, {31'h0,slt});

and(carryout, ALUoper[1], ~ALUoper[0], cyt); //carryout
and(overflow, ALUoper[1], ~ALUoper[0], overf); //overflow
nor(zero, Result[0], Result[ 1], Result[ 2], Result[ 3],
Result[ 4], Result[ 5], Result[ 6], Result[ 7],
Result[ 8], Result[ 9], Result[10], Result[11],
Result[12], Result[13], Result[14], Result[15],
Result[16], Result[17], Result[18], Result[19],
Result[20], Result[21], Result[22], Result[23],
Result[24], Result[25], Result[26], Result[27],
Result[28], Result[29], Result[30], Result[31]);
endmodule
/*000 And
001 Or
010 Add
011 Sll
100 Srl
101 Sra
110 Sub
111 SLT*/