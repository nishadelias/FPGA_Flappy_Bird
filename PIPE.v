//If the bird x is in pillar range
            if(bird_x >= pillar_x && bird_x <= pillar_x+40) begin

                //If bird is in the gap
                if(bird_y > pillar_y && bird_y < pillar_y + 50 && !overlap) begin
                    score <= score+1
                    overlap <= 1;
                end
                else gamestate = 1;
            end
            else begin
                overlap <= 0;
            end
