`timescale 1ns / 1ps

module clockdiv(
    input wire clk,        // master clock: 100MHz
    input wire clr,        // asynchronous reset
    output wire dclk,      // pixel clock: 25MHz
    output wire segclk,    // 7-segment clock: 381.47Hz
    output wire clk_blink, // about 1.5Hz
    output wire clk_game   // about 50Hz
    );

// Counter variables
 reg [25:0] q;


// Always block for master counter
always @(posedge clk or posedge clr)
begin
    if (clr)
    begin
        q <= 0;
    end
    else
    begin
        q <= q + 1;
    end
end

// Clock outputs
assign segclk = q[17];
assign dclk = q[2];
assign clk_blink = q[25];
assign clk_game = q[20];

endmodule

