`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:28:48 05/17/2014 
// Design Name: 
// Module Name:    MUX4x1 
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
module MUX4x1(
output [31:0] Result,
input [1:0] oper,
input [31:0] x0,
input [31:0] x1,
input [31:0] x2,
input [31:0] x3
);

assign Result = oper[1]?(oper[0]?x3:x2):(oper[0]?x1:x0);

endmodule
