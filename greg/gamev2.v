// Code your design here
module game (
    input clk,       // Clock input
  	input flap,
  	output reg signed [8:0] y  // 9-bit y coordinate output
);
  
  //Constants
  //parameter [8:0] VERTICAL_BOUND = 9'd480;
  //parameter [9:0] HORIZONTAL_BOUND = 9'd640;
  //parameter [7:0] start_y = 9'd240;
  //parameter signed [7:0] GRAVITY = -8'd1;
  
  //Variables
  reg signed [7:0] velocity = 8'd0;
  reg signed [8:0] temp_y;
  

    // Initialize y coordinate
    initial begin
      y = 240;
      temp_y = y;
    end
  always @(posedge flap) begin
    velocity <= 8'd4;
  end
    always @(posedge clk) begin

      if(temp_y != 0 || flap == 1) begin
          velocity <= velocity + -8'd1;
          temp_y <= temp_y + velocity;
        end

        //Ground check
      if (temp_y[8] == 1) begin
           temp_y<= 9'd0;
          velocity <= 0;
        end
      else begin
        y = temp_y;
      end
      end 
endmodule
