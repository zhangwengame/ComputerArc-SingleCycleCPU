`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:53:23 05/14/2014 
// Design Name: 
// Module Name:    display 
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
module display(
input wire        clk,
input wire [7:0] digit,//显示的数据
output wire [1:0] memaddr,
output reg [3:0] node, //4个数码管的位选
output reg [7:0] segment,//七段+小数点
input wire [3:0] xw
);
reg [3:0]  code  =  4'b0;
reg [15:0] count = 15'b0;
assign memaddr=count[15:14];	
reg [3:0] node1;
always @(posedge clk) begin
    case (count[15:14])
   //与(count[1:0])的不同?起到分??的作用
        2'b00 : begin
            node1 <= 4'b1110; 
            segment <= digit;
            end
        2'b01 : begin
            node1 <= 4'b1101;
            segment <= digit;
            end
        2'b10 : begin
            node1 <= 4'b1011;
            segment <= digit;
            end
        2'b11 : begin
            node1 <= 4'b0111;
            segment <= digit;
            end
    endcase
	 node[3:0]=node1[3:0]|xw[3:0];
    count <= count + 1;
end
endmodule
