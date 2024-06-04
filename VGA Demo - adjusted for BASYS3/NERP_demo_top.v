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
wire game_state = 0;
wire [9:0] current_score;
wire [9:0] highest_score;
wire [9:0] bird_y;
wire [8:0] pillar1;
wire [8:0] pillar2;

wire lost = 1;
wire [6:0] Anode_Activate;
wire [3:0] LED_out;


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
seven_segment_display U2(
	.game_state(game_state),
	.score(score),
	.clk_blink(clk_blink),
	.clk_fast(segclk),
	.lost(lost),      // state for if the user has lost
	.Anode_Activate(Anode_Activate),
	.LED_out(LED_out)
	);

// VGA controller
vga640x480 U3(
	.dclk(dclk),
	.clr(clr),
	.bird_y(bird_y),
	.game_state(game_state),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue)
	);

game U4(
	.clk(clk_game),  // 50 Hz
	.rst(reset),
	.flap(flap_button),
	.y(bird_y),
	.p1(pillar1),
	.p2(pillar2)
);

initial begin
    reset <= 0;
end

endmodule
