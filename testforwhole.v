`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:16:59 03/22/2015
// Design Name:   top
// Module Name:   G:/Prom/ISE/SingleCycl_LCD/testforwhole.v
// Project Name:  SingleCycl_LCD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testforwhole;

	// Inputs
	reg CCLK;
	reg BTN2;
	reg [3:0] SW;

	// Outputs
	wire LCDRS;
	wire LCDRW;
	wire LCDE;
	wire [3:0] LCDDAT;
	wire [7:0] LED;
	wire [31:0] disp_num;
   wire [31:0] PC;
	// Instantiate the Unit Under Test (UUT)
	top uut (
		.CCLK(CCLK), 
		.BTN2(BTN2), 
		.SW(SW), 
		.LCDRS(LCDRS), 
		.LCDRW(LCDRW), 
		.LCDE(LCDE), 
		.LCDDAT(LCDDAT), 
		.LED(LED), 
		.disp_num(disp_num),
		.PC(PC)
	);

	initial begin
		// Initialize Inputs
		CCLK = 0;
		BTN2 = 0;
		SW = 4'b1011;
		
		
		// Wait 100 ns for global reset to finish
		#100;
      BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;      
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		// Add stimulus here

	end
         always 
	begin
	#1;
	CCLK=0;
	#1;
	CCLK=1;
	end
endmodule

