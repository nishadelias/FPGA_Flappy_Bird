`timescale 1ns / 1ps

module clockdiv(
	input wire clk,		//master clock: 100MHz
	input wire clr,		//asynchronous reset
	output wire dclk,		//pixel clock: 25MHz
	output wire segclk,	//7-segment clock: 381.47Hz
  	output wire gclk
	);

// 17-bit counter variable
  reg[27:0] counter_dclk=28'd0;
  reg[27:0] counter_segclk=28'd0;
  reg[27:0] counter_gclk=28'd0;
  reg dclk_reg;
  reg segclk_reg;
  reg gclk_reg;
  parameter DIVISOR_dclk = 28'd2; //TESTBENCH VALUESS!!!!!!!!!
  parameter DIVISOR_segclk = 28'd100000;
  parameter DIVISOR_gclk = 28'd1000000;
//  parameter DIVISOR_segclk = 28'd10;
//  parameter DIVISOR_gclk = 28'd10;

 initial begin
 counter_dclk <= 0;
 counter_segclk <= 0;
 counter_gclk <= 0;
 dclk_reg <= 0;
 segclk_reg <= 0;
 gclk_reg <= 0;
 end

// Clock divider --
// Each bit in q is a clock signal that is
// only a fraction of the master clock.
always @(posedge clk)
begin
	// reset condition
  if (clr == 1) begin
		dclk_reg <= 0;
  		segclk_reg <= 0;
    	gclk_reg <= 0;
  end
	else begin
		counter_dclk <= counter_dclk +28'd1;
        counter_segclk <= counter_segclk + 28'd1;
      	counter_gclk <= counter_gclk + 28'd1;
    end
  //Divide
  if (counter_dclk == DIVISOR_dclk) begin
       dclk_reg <= ~dclk_reg;
       counter_dclk <= 0;
   end
  if (counter_segclk == DIVISOR_segclk) begin
       segclk_reg <= ~segclk_reg;
       counter_segclk <= 0;
   end
  if (counter_gclk == DIVISOR_gclk) begin
       gclk_reg <= ~gclk_reg;
       counter_gclk <= 0;
   end
end

assign gclk = gclk_reg;
assign segclk = segclk_reg;
assign dclk = dclk_reg;


endmodule
