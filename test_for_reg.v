`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:21:35 03/17/2015
// Design Name:   Reg
// Module Name:   G:/Prom/ISE/Single_Cycle/test_for_reg.v
// Project Name:  Single_Cycle
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Reg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_reg;

	// Inputs
	reg clk;
	reg bclk;
	reg RegWrite;
	reg [4:0] R1;
	reg [4:0] R2;
	reg [4:0] WR;
	reg [31:0] WData;

	// Outputs
	wire [31:0] RData1;
	wire [31:0] RData2;
	wire [1023:0] Check;

	// Instantiate the Unit Under Test (UUT)
	Reg uut (
		.clk(clk), 
		.bclk(bclk), 
		.RegWrite(RegWrite), 
		.R1(R1), 
		.R2(R2), 
		.WR(WR), 
		.WData(WData), 
		.RData1(RData1), 
		.RData2(RData2), 
		.Check(Check)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		bclk = 0;
		RegWrite = 0;
		R1 = 'b0000;
		R2 = 0;
		WR = 0;
		WData = 0;

		// Wait 100 ns for global reset to finish
		#100;
      WR=4'b0000;
		WData=32'b101;
		#10;
		RegWrite=1;
		#5;
		RegWrite=0;
		// Add stimulus here

	end
	always 
   begin
	   clk=0;
		#1;
		clk=1;
		#1;
   end   
      
endmodule

