`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:04:22 05/15/2014
// Design Name:   Top
// Module Name:   E:/verilog/Cpu_Single/Ins_Mem_Test.v
// Project Name:  Cpu_Single
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Ins_Mem_Test;

	// Inputs
	reg clk;
	reg [11:0] btn_in;
	reg [15:0] switch;
	reg [9:0] add;

	// Outputs
	wire [11:0] anode;
	wire [15:0] segment;
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.btn_in(btn_in), 
		.switch(switch), 
		.add(add), 
		.anode(anode), 
		.segment(segment), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		btn_in = 0;
		switch = 0;
		add = 0;
		#8;
		add=1;
		#8;
		add=2;
		#8;
		add=3;
	end
   always 
	begin
	#1;
	clk=0;
	#1;
	clk=1;
	end
endmodule

