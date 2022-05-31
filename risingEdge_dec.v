
module risingEdge_dec (clk, rst, level, tick);  
input clk, rst, level;  
output tick;  
 
reg [1:0] state, nextState;  
 
parameter [1:0] Zero=2'b00, Edge=2'b01, One=2'b10;
// Next state generation  
always @ (level or state)      

case (state)  
Zero: if (level) nextState = Edge;  
else nextState = Zero;  
Edge: if (level) nextState = One;  
else nextState = Zero;    
One: if (level) nextState = One;  
else nextState = Zero;    

endcase  
// Update state FF's with the triggering edge of the clock  
always @ (posedge clk or negedge rst)   
if(rst)  
state <= Zero;  
else  
state <= nextState;  


assign tick = (state == Edge)? 1:0;
endmodule
