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
	input wire paused,
	input wire flap_button,
	output wire [6:0] seg,	//7-segment display LEDs
	output wire [3:0] an,	//7-segment display anode enable
	output wire dp,			//7-segment display decimal point
	output wire [2:0] red,	//red vga output - 3 bits
	output wire [2:0] green,//green vga output - 3 bits
	output wire [2:0] blue,	//blue vga output - 3 bits
	output wire hsync,		//horizontal sync out
	output wire vsync //vertical sync out
	//output wire dclk
	);

// 7-segment clock interconnect
wire segclk;
wire dclk;

// VGA display clock interconnect
wire clk_blink;
wire clk_game;
reg reset;
wire game_state;
wire [9:0] current_score;
wire [9:0] highest_score;
wire [9:0] bird_x;
wire [8:0] bird_y;

// disable the 7-segment decimal points
assign dp = 1;



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
	.bird_x(bird_x),
	.bird_y(bird_y),
	.game_state(game_state),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue)
	);

game U4(
	.clock(clk_game),  // 50 Hz
	.flap(flap_button),
	.pause(paused),
	.reset(reset),
	.game_state(game_state),
	.current_score(current_score),
	.highest_score(highest_score),
	.bird_x(bird_x),
	.bird_y(bird_y)
);

initial begin
    reset <= 0;
end

endmodule
