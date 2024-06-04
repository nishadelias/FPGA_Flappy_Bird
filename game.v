module game (
    input clk,                   // Clock input
    input rst,                   // Reset input (not present in your original design - consider adding)
  	input flap,
    output reg signed [9:0] y,    // 9-bit y coordinate output
    output reg [9:0] p1,
    output reg [9:0] p2
);
  
  
  // Internal Variables
  reg signed [7:0] velocity = 0;
    reg [10:0] count;
    reg [4:0] pillars;

    initial begin
        y <= 240;
        count <= 0;
        pillars <= 0;
        p1 <= 0;
        p2 <= 0;
    end

    // Initialize y coordinate
    always @(posedge clk or posedge rst) begin
      if (rst) begin
        y <= 240; // Reset to initial y position
        velocity <= 0;  // Reset velocity to zero
      end else if (flap && y > 0 && y < 480) begin
        // Flapping gives an upward velocity impulse
        velocity <= 4;
        y <= y + velocity; // Apply the velocity immediately to simulate impulse
      end else begin
        // Gravity continuously affects velocity
          velocity <= velocity + (-1);
        
        // Update position based on velocity, but ensure it stays within bounds
        if (y + velocity < 0) begin
          // If bird hits the ground, stop its movement
          velocity <= 0;
          y <= 0;
        end else if (y + velocity > 480) begin
          // If bird goes above the screen, stop its upward movement
          velocity <= 0;
          y <= 480;
        end else begin
          // Normal case, update bird's y position
          y <= y + velocity;
        end
      end
    end

    always @(posedge clk) begin
        if (rst) begin
            count <= 0;
        end else begin
            if (count == 2000) begin
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end

        pillars <= count/200;    // increases every 4 seconds
        case (pillars)
            0: p1 <= 240;
            1: p2 <= 300;
            2: p1 <= 250;
            3: p2 <= 150;
            4: p1 <= 400;
            5: p2 <= 320;
            6: p1 <= 200;
            7: p2 <= 180;
            8: p1 <= 260;
            9: p2 <= 350;
            default: begin
                p1 <= 0;
                p2 <= 0;
            end
        endcase
    
    end
endmodule
