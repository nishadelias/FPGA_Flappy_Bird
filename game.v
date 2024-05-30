module game(
  input clock,  // 50 Hz
  input flap,
  input pause,
  input reset,
  output wire game_state,
  output wire [9:0] current_score,
  output wire [9:0] highest_score,
  output wire [9:0] bird_x,
  output wire [8:0] bird_y
);

reg gs;
reg [9:0] curr_score;
reg[9:0] high_score;
reg[9:0] x;
reg[8:0] y;

  reg [6:0] velocity;
  reg positive;    // keep track of whether the velocity is positive or negative

  initial begin
    gs <= 0;
    curr_score <= 0;
    high_score <= 0;
    x <= 140;
    y <= 280;
    velocity <= 0;
    positive <= 1;
  end

  always @(*) begin
    if (reset) begin
      gs <= 0;
      curr_score <= 0;
      high_score <= 0;
      x <= 140;
      y <= 280;
      velocity <= 0;
      positive <= 1;
    end else if (!pause) begin
      if (!gs && flap) begin
        gs <= 1;
        velocity <= 10;
      end else if (gs && !flap) begin
        if (velocity == 0) begin
          positive <= 0;
          velocity <= velocity + 1;
        end else begin
          velocity <= velocity - 1;
        end
      end else if(game_state && flap) begin
        velocity <= 10;
        positive <= 1;
      end

      if (gs) begin
        if (positive && y < 465) begin
          y <= y + velocity;
        end else if (!positive && y > 40) begin
          y <= y - velocity;
        end
      end
    end
   
    

  end
  
  assign game_state = gs;
  assign current_score = curr_score;
  assign highest_score = high_score;
  assign bird_x = x;
  assign bird_y = y;

endmodule
