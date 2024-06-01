`timescale 1ns / 1ps
`include "clockdiv.v"
`include "segdisplay.v"
`include "vga640x480.v"
`include "debouncer.v"
`include "game.v"



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
	output wire vsync,		//vertical sync out
  output wire [8:0] tb_y
	);
	
//Debounced inputs
wire clr, pause, flap;

// 7-segment clock interconnect
wire segclk;

// VGA display clock interconnect
wire dclk, gclk;
	
//Bird y coordinate
wire [8:0] y;
assign tb_y = y;

// disable the 7-segment decimal points
assign dp = 1;


// generate 7-segment clock & display clock
clockdiv U1(
	.clk(clk),
	.clr(clr),
	.dclk(dclk),
  	.segclk(segclk),
  	.gclk(gclk)
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
  debouncer clr_debounce(.clk(segclk), .button_in(clr_btn), .button_out(clr));
  debouncer pause_debounce(.clk(segclk), .button_in(pause_btn), .button_out(pause));
  debouncer flap_debounce(.clk(segclk), .button_in(flap_btn), .button_out(flap));

//Game module
game U4(
  	.clk(clk),
  .flap(flap_btn),
	.y(y)
);

endmodule
