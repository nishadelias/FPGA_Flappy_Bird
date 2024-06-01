// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

module tb;
  
  reg tb_clock;
  reg flap;
  
  wire [8:0] tb_y;
  reg [8:0] y_reg;
  
  game game_inst(
    .clk(tb_clock),
    .flap(flap),
    .y(tb_y)
  );
  
  initial begin
    tb_clock = 0;
    flap = 0;
  end
  
  always begin
    #5 tb_clock = ~tb_clock;  //100 MHz clock
  end
  
  always @(posedge tb_clock) begin
    $display("%d", tb_y); 
    $display("%b", tb_y); 
  end
  
  
  //Testing
  
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars;
    #1000
    flap = 1;
    $display("FLAP"); 
    #10
    flap = 0;
    #10
    flap = 1;
    $display("FLAP"); 
    #10
    flap = 0;
    #100
    $finish;
  end
endmodule
