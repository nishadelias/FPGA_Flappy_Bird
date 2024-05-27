`timescale 1ns / 1ps

module clk_div(
input clock_in, // 100 MHz master clock, V10 on board
input rst,
output clk_slide,
output clk_game,
output clk_fast,
);
 
 reg[27:0] counter_slide=28'd0;
 reg[27:0] counter_game=28'd0;
 reg[27:0] counter_fast=28'd0;
 reg clk_slide_reg;
 reg clk_game_reg;
 reg clk_fast_reg;
 reg clk_blink_reg;
 parameter DIVISOR_slide = 28'd12500000;  // 4 Hz
 parameter DIVISOR_game = 28'd1000000;    // 50 Hz
 parameter DIVISOR_fast = 28'd100000;     // 500 Hz
// parameter DIVISOR_slide = 28'd5;
// parameter DIVISOR_game = 28'd10;
// parameter DIVISOR_fast = 28'd2;

 initial begin
counter_slide <= 0;
 counter_game <= 0;
 counter_fast <= 0;
 clk_slide_reg <= 0;
 clk_game_reg <= 0;
 clk_fast_reg <= 0;
 end
 
 // The frequency of the output clk_out =  The frequency of the input clk_in divided by DIVISOR
 always @(posedge clock_in)
begin
  //Increment counters
  counter_slide <= counter_slide + 28'd1;
  counter_game <= counter_game + 28'd1;
  counter_fast <= counter_fast + 28'd1;
   
   // Generate clock outputs based on counters
   if (counter_slide == DIVISOR_slide) begin
       clk_slide_reg <= ~clk_slide_reg;
       counter_slide <= 0;
   end
   if (counter_game == DIVISOR_game) begin
       clk_game_reg <= ~clk_game_reg;
       counter_game <= 0;
   end
   if (counter_fast == DIVISOR_fast) begin
       clk_fast_reg <= ~clk_fast_reg;
       counter_fast <= 0;
   end
 end
 
 assign clk_slide = clk_slide_reg;
 assign clk_game = clk_game_reg;
 assign clk_fast = clk_fast_reg;
 
endmodule

