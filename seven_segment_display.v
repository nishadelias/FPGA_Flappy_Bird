`timescale 1ns / 1ps

module seven_segment_display(
    input clk_blink,
    input clk_fast,
    input lost,      // state for if the user has lost
    output reg [3:0] Anode_Activate,
    output reg [6:0] LED_out
    );
    reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
             // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
    reg [1:0] LED_activating_counter; 
    reg [1:0] text_couter;
                 // count     0    ->  1  ->  2  ->  3
              // activates    LED1    LED2   LED3   LED4
             // and repeat
    initial 
    begin
        LED_activating_counter = 0;
        blink_counter = 0;
    end
  	
    always @(posedge clk_fast) begin
        LED_activating_counter <= LED_activating_counter + 1;
    end

    always @(posedge clk_blink) begin
        blink_counter <= blink_counter + 1;
    end

    // anode activating signals for 4 LEDs, digit period of 2.6ms
    // decoder to generate anode signals 
    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
               end
        endcase
        if (lost) begin
        if( blink_counter == 0) begin
            // display YOU
            if (Anode_Activate == 4'b0111) begin
                LED_out = 7'b1111111;
            end else if (Anode_Activate == 4'b1011) begin
                LED_out = 7'b1001100;
            end else if (Anode_Activate = 4'b1101) begin
                LED_out = 7'b1111110;
            end else begin
                LED_out = 7'b0111110;
            end
        end else if (blink_counter == 2) begin
            // display LOSE
            if (Anode_Activate == 4'b0111) begin
                LED_out = 7'b1110001;
            end else if (Anode_Activate == 4'b1011) begin
                LED_out = 7'b1111110;
            end else if (Anode_Activate = 4'b1101) begin
                LED_out = 7'b0100100;
            end else begin
                LED_out = 7'b0110000;
            end
        end else begin
            LED_out = 7'b1111111;
        end
    end
    end else begin
        LED_out = 7'b1111111;
    end

 endmodule
 
