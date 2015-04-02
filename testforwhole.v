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
	reg BTN3;
	reg [3:0] SW;

	// Outputs
	wire LCDRS;
	wire LCDRW;
	wire LCDE;
	wire [3:0] LCDDAT;
	wire [7:0] LED;
	wire [31:0] disp_num;
   wire [31:0] PC,AAdat,BBdat,Result;
	wire [2:0]ALUoper;
	// Instantiate the Unit Under Test (UUT)
	top uut (
		.CCLK(CCLK), 
		.BTN2(BTN2), 
		.BTN3(BTN3),
		.SW(SW), 
		.LCDRS(LCDRS), 
		.LCDRW(LCDRW), 
		.LCDE(LCDE), 
		.LCDDAT(LCDDAT), 
		.LED(LED), 
		.disp_num(disp_num),
		.PC(PC),
		.AAdat(AAdat),
		.BBdat(BBdat),
		.Result(Result),
		.ALUoper(ALUoper)
	);

	initial begin
		// Initialize Inputs
		CCLK = 0;
		BTN2 = 0;
		BTN3 = 0;
		SW = 4'b1011;
		
		
		// Wait 100 ns for global reset to finish
		#100;
		SW = 4'b1011; //Sll $11,$12,3
      BTN2=1;
		#10;
		BTN2=0;
		#200;
		BTN2=1; //Srl $11,$12,2
		#10;
		BTN2=0;
		#200; 
		SW = 4'b0001;	//Addi $1,$0,-37
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		SW = 4'b1011;	// Sra, $11,$1,2
		BTN2=1;
		#10;
		BTN2=0;
		#100;
		BTN2=1; // Addi $11,$12,5
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Andi $11,$12,6 
		#10;
		BTN2=0; 
		#100;
		BTN2=1; //Ori  $11,$12,11/
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Bne $1,$1,2 
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Bne $0,$1,1
		#10;
		BTN2=0;
		#100;
		SW = 4'b0000;
		BTN3=1;
		BTN2=1; //Addi $16,$0,4
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Beq $16,$4,2
		#10;
		BTN2=0;
		#100;
		SW = 4'b0001;
		BTN3=1;
		BTN2=1; //Add $17,$2,$17
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Add $17,$4,$17
		#10;
		BTN2=0;
		#100;
		SW = 4'b1101;
		BTN3 =1;
		BTN2=1; //Sw $24,0($29)
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Add $29,$29,4
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Sw $25,0($29)
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Add $29,$29,4
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Sub $29,$29,8
		#10;
		BTN2=0;
		#100;
		SW = 4'b1111;
		BTN3=1;
		BTN2=1; //Lw $31,4($29)
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Lw $31,0($29)
		#10;
		BTN2=0;
		#100;
		SW = 4'b1101;
		BTN3=0;
		BTN2=1; //And $11,$9,$10
		#10;
		BTN2=0;
		#100;
		BTN2=1; //Or $11,$9,$10
		#10;
		BTN2=0;
		#100;		
		BTN2=1; //J 13
		#10;
		BTN2=0;
		#100;	
		SW = 4'b0001;
		BTN3 =1;
		BTN2=1; //Add $17,$1,$17
		#10;
		BTN2=0;
		#100;	
		BTN2=1; //J 13
		#10;
		BTN2=0;
		#100;	
		BTN2=1; //Add $17,$1,$17
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

