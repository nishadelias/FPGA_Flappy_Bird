`timescale 1ns / 1ps

module seven_segment_display(
    input clk_blink,
    input clk_fast,
    input lost,      // state for if the user has lost
    output reg [3:0] Anode_Activate,
    output reg [6:0] LED_out
    );
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
             // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
    reg [1:0] LED_activating_counter; 
                 // count     0    ->  1  ->  2  ->  3
              // activates    LED1    LED2   LED3   LED4
             // and repeat
    initial 
    begin
    LED_activating_counter = 0;
    end
  	
    always @(posedge clk_fast) begin
        LED_activating_counter <= LED_activating_counter + 1;
    end

    // anode activating signals for 4 LEDs, digit period of 2.6ms
    // decoder to generate anode signals 
    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = minutes/10;
            // the first digit of the 16-bit number
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = minutes%10;
            // the second digit of the 16-bit number
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = seconds/10;
            // the third digit of the 16-bit number
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = seconds%10;
            // the fourth digit of the 16-bit number    
               end
        endcase
        
        if(blink_clk && adjust)begin
          case(LED_BCD)
            4'b0000: LED_out = 7'b0000001; // "0"     
            4'b0001: LED_out = 7'b1001111; // "1" 
            4'b0010: LED_out = 7'b0010010; // "2" 
            4'b0011: LED_out = 7'b0000110; // "3" 
            4'b0100: LED_out = 7'b1001100; // "4" 
            4'b0101: LED_out = 7'b0100100; // "5" 
            4'b0110: LED_out = 7'b0100000; // "6" 
            4'b0111: LED_out = 7'b0001111; // "7" 
            4'b1000: LED_out = 7'b0000000; // "8"     
            4'b1001: LED_out = 7'b0000100; // "9" 
            default: LED_out = 7'b0000001; // "0"
          endcase
        end
    end

 endmodule
 
