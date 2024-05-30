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
	input wire clr,			//right-most pushbutton for reset
	output wire [6:0] seg,	//7-segment display LEDs
	output wire [3:0] an,	//7-segment display anode enable
	output wire dp,			//7-segment display decimal point
	output wire [2:0] red,	//red vga output - 3 bits
	output wire [2:0] green,//green vga output - 3 bits
	output wire [2:0] blue,	//blue vga output - 3 bits
	output wire hsync,		//horizontal sync out
	output wire vsync, //vertical sync out
	output wire dclk,
	);

// 7-segment clock interconnect
wire segclk;

// VGA display clock interconnect
wire clk_blink;
wire clk_game;

// disable the 7-segment decimal points
assign dp = 1;

wire flap(),
reg paused = 0;
wire reset = 0;
reg game_state = 0;
reg [9:0] current_score = 0;
reg [9:0] highest_score = 0;
reg [7:0] bird_x;
reg [8:0] bird_y;

// generate 7-segment clock & display clock
clockdiv U1(
	.clk(clk),
	.clr(clr),
	.segclk(segclk),
	.dclk(dclk),
	.clk_blink(clk_blink),
	.clk_game(clk_game)
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

game U4(
	.clock(clk_game),  // 50 Hz
	.flap(flap),
	.pause(pause),
	.reset(reset),
	.game_state(game_state),
	.current_score(current_score),
	.highest_score(highest_score),
	.bird_x(bird_x),
	.bird_y(bird(y)
);

initial begin
	game_state <=0;
	#1000000000
	game_state <= 1;
	flap <= 1;
	#10000000
	flap <= 0;
	#1000000000
	flap <= 1;
	#10000000
	flap <= 0;
	#1000000000
	flap <= 1;
	#10000000
	flap <= 0;
	#1000000000
	flap <= 1;
	#10000000
	flap <= 0;
	#1000000000
end
	

endmodule
