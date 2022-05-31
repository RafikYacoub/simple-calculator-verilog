`timescale 1ns / 1ps
module tb2 ;

reg clk, rst ;
wire [1:0] count;


counter_2bits test (.clk(clk), .rst(rst), .count(count));

initial begin

clk =0;
forever #50 clk= ~ clk;
end
initial begin
rst=0;
#10;
rst = 1;
#10
rst = 0;






end
endmodule