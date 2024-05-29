module game(
  input clock,  // 50 Hz
  input flap,
  input pause,
  input reset,
  output game_state,
  output wire [9:0] current_score,
  output wire [9:0] highest_score,
  output wire [7:0] bird_x,
  output wire [8:0] bird_y
);

  reg [6:0] velocity;
  reg positive;    // keep track of whether the velocity is positive or negative

  initial begin
    game_state <= 0;
    current score <= 0;
    highest score <= 0;
    bird_x <= 140;
    bird_y <= 280;
    velocity <= 0;
    positive <= 1;
  end

  always @(*) begin
    if (reset) begin
      game_state <= 0;
      current score <= 0;
      highest score <= 0;
      bird_x <= 140;
      bird_y <= 280;
      velocity <= 0;
      positive <= 1;
    end else if (!pause) begin
      if (!game_state && flap) begin
        game_state <= 1;
        velocity <= 10;
      end else if (game_state && !flap) begin
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

      if (game_state) begin
        if (positive) begin
          bird_y <= bird_y + velocity;
        end else begin
          bird_y <= bird_y - velocity;
        end
      end
    end


  end

endmodule
