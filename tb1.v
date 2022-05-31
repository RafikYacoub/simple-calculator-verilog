`timescale 10ns / 10ns

module tb1();

reg clk, rst;
wire clk_out;

clockDivider #(10) test (.clk(clk), .rst(rst), .clk_out(clk_out));

initial begin

rst =1;
clk=0;
#1
rst=0;
forever #1 clk=~clk;
end



endmodule
