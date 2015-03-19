`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:37:23 05/15/2014 
// Design Name: 
// Module Name:    ALUctrl 
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
module ALUctrl(input wire [1:0]ALUop,input wire [5:0]Func,output wire [2:0]ALUoper);
assign ALUoper[2]=(~ALUop[1]&ALUop[0])|(ALUop[1]&~Func[3]&~Func[2]&Func[1]&~Func[0])
|(ALUop[1]&Func[3]&~Func[2]&Func[1]&~Func[0]);
assign ALUoper[1]=(~ALUop[1]&~ALUop[0])|(~ALUop[1]&ALUop[0])
|(ALUop[1]&~Func[3]&~Func[2]&~Func[1]&~Func[0])
|(ALUop[1]&~Func[3]&~Func[2]&Func[1]&~Func[0])|(ALUop[1]&Func[3]&~Func[2]&Func[1]&~Func[0]);
assign ALUoper[0]=(ALUop[1]&~Func[3]&Func[2]&~Func[1]&Func[0])
|(ALUoper[1]&Func[3]&~Func[2]&Func[1]&~Func[0]);			  
endmodule
