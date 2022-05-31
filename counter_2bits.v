
module counter_2bits (input clk, rst, output reg [1:0] count);

always @ (posedge clk, posedge rst)
begin
    if(rst==1)
        count=2'b0;
    else
        count <= count+1;
end
endmodule
