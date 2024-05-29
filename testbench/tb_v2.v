// Code your testbench here
// or browse Examples

//FOR THE SIMULATION MAKE THE PIXEL CLOCK MUCH FASTER and SAMPLE AT A SLOWER RATE
`timescale 1ns / 1ps


module tb;
  
  //Instantiate top module
  
  reg tb_clk;
  reg tb_clr;
  reg tb_dclk;
  wire [6:0] tb_seg;
  wire [3:0] tb_an;
  wire tb_dp;
  wire [2:0] tb_red;
  wire [2:0] tb_green;
  wire [2:0] tb_blue;
  wire tb_hsync;
  wire tb_vsync;
  
  NERP_demo_top top_inst(
    .clk(tb_clk),
    .clr(tb_clr),
    .seg(tb_seg),
    .an(tb_an),
    .dp(tb_dp),
    .red(tb_red),
    .green(tb_green),
    .blue(tb_blue),
    .hsync(tb_hsync),
    .vsync(tb_vsync),
    .dclk(tb_dclk)
  );
  
  initial begin
    tb_clk = 0;
    tb_clr = 1;  // Assert reset
    #100;
    tb_clr = 0;  // Deassert reset after 100 ns
    $dumpfile("simulation.vcd"); // Specify the name of the dump file
    $dumpvars(0, tb); // Dump all variables in the testbench

  end
    
always begin
    #5 tb_clk = ~tb_clk;  //100 MHz clock
end 
  
  always @(posedge tb_dclk) begin //CHANGED SAMPLE CLOCK TO SLOWER CLOCK
    //$display("%0t ns: %b %b %b %b %b", $time, tb_hsync, tb_vsync, tb_red, 	tb_green, tb_blue);
  end
  initial begin
        #1000000;
    	$finish;
  end
      
endmodule
