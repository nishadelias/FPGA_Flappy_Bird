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
  
    
always begin
    #5 tb_clk = ~tb_clk;  //100 MHz clock
end
  
integer file_pointer;
    
    initial begin
      // Open file for writing
        file_pointer = $fopen("write.txt", "w");
        if (file_pointer == 0) begin
            $display("Failed to open file!");
            $finish;
        end
  	end
  
  always @(posedge tb_clk) begin
    // Write the time
        $fwrite(file_pointer, "%0t: ", $time);
        
        // Write the hsync
    	$fwrite(file_pointer, " %b", tb_hsync);
        
        // Write the vsync
    	$fwrite(file_pointer, " %b", tb_vsync);
        
        // Write the red
    	$fwrite(file_pointer, " %b", tb_red);
        
        // Write the green
    	$fwrite(file_pointer, " %b", tb_green);
        
        // Write the blue
    	$fwrite(file_pointer, " %b", tb_blue);
        
        // Write a new line
        $fwrite(file_pointer, "\n");
  end
  initial begin
        #1000; // Assuming your simulation runs until time 1000
        $fclose(file_pointer);
    	$finish;
  end
      
endmodule
