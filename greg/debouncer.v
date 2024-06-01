module debouncer (
   input clk,
   input button_in,
   output reg button_out
 );
     
    reg [1:0] count;
    parameter DEBOUNCE_THRESHOLD = 3;
   
   initial begin
     count = 0;
     button_out <= 0;
   end
 
   always @(posedge clk) begin
       if (button_in == button_out) begin
           count <= 0;
       end else begin
           count <= count + 1;
           if (count >= DEBOUNCE_THRESHOLD) begin
               button_out <= button_in;
               count <= 0;
           end
       end
   end
 endmodule
