`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:25 03/19/2013 
// Design Name: 
// Module Name:    NERP_demo_top 
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
module NERP_demo_top(
	input wire clk,			//master clock = 100MHz
	input wire clr_btn,			//right-most pushbutton for reset
	input wire pause_btn,
	input wire flap_btn,
	output wire [6:0] seg,	//7-segment display LEDs
	output wire [3:0] an,	//7-segment display anode enable
	output wire dp,			//7-segment display decimal point
	output wire [2:0] red,	//red vga output - 3 bits
	output wire [2:0] green,//green vga output - 3 bits
	output wire [2:0] blue,	//blue vga output - 3 bits
	output wire hsync,		//horizontal sync out
	output wire vsync			//vertical sync out
	);
	
//Debounced inputs
wire clr, pause, flap;

// 7-segment clock interconnect
wire segclk;

// VGA display clock interconnect
wire dclk, gclk, debclk;
	
//Bird y coordinate
wire y;
	

// disable the 7-segment decimal points
assign dp = 1;


// generate 7-segment clock & display clock
clockdiv U1(
	.clk(clk),
	.clr(clr),
	.segclk(segclk),
	.dclk(dclk),
	.gclk(glk),
	.deb_clk(debclk)
	);

// 7-segment display controller
segdisplay U2(
	.segclk(segclk),
	.clr(clr),
	.seg(seg),
	.an(an)
	);

// VGA controller
vga640x480 U3(
	.dclk(dclk),
	.clr(clr),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue)
	);
	
// Debounced inputs
debouncer clr_debounce(.clk(debclk), .button_in(clr_btn), .button_out(clr));
debouncer pause_debounce(.clk(ddbclk), .button_in(pause_btn), .button_out(pause));
debouncer flap_debounce(.clk(debclk), .button_in(flap_btn), .button_out(flap));

//Game module
game U4(
	.clk(clk),
	.flap(flap),
	.y(y)
);

endmodule
