`timescale 1ns / 1ps

module Calc_sim();

reg clk, rst, A,B,C,D,E, gen;
wire [6:0] LEDs;
wire [3:0] active;
wire point;
integer i = 0;

calc calc_tb (.clk(clk), .rst(rst), .A(A), .B(B), .C(C), .D(D), .E(E), .gen(gen), .LEDs(LEDs), .active(active), .point(point));

// initiallizing the clock
initial begin 
clk = 0;
forever #2 clk = ~clk; 
end 

initial begin

// reseting the display
rst = 0;
#5 
rst = 1;
#5
rst = 0;
#5

E = 0;
gen = 0;

#5
// adjusting the numbers 
for (i = 0; i < 9; i = i+1) begin
    A = 0; 
    B = 0;
    C = 0;
    D = 0; 
    #10
    A = 1;
    B = 1;
    C = 1;
    D = 1;
    #25
    A = 0;
    B = 0;
    C = 0;
    D = 0; 
end

#5
E = 1;
#5
A = 1;
#20
A = 0;
#35 
B = 1;
#20
B = 0;
#35
C = 1;
#20
C = 0;
#35
D = 1;
#20
D = 0; 
#10
gen = 1;
#10 
gen = 0;
#10

///////////////////
for (i = 0; i < 9; i = i+1) begin
    D = 0;
    #10
    D = 1;
    #25
    D = 0; 
end
#5
E = 0;
#10
E = 1;
#30
E = 0;
#10
B = 1;
#25
B = 0;
#35
D = 1;
#25
D = 0; 
//////////////////////
#10
gen = 1;
#10 
gen = 0;
#10
//////
for (i = 0; i < 4; i = i+1) begin
    A = 0;
    #10
    A = 1;
    #25
    A = 0; 
end
#20
for (i = 0; i < 3; i = i+1) begin
    B = 0;
    #10
    B = 1;
    #25
    B = 0; 
end

#5
E = 0;
#10
E = 1;
#30
E = 0;
#10
B = 1;
#25
B = 0;
#35
C = 1;
#25
C = 0;
#35
D = 1;
#25
D = 0; 
/////////////
#10
gen = 1;
#10 
gen = 0;
#10
/////////////
for (i = 0; i < 2; i = i+1) begin
    C = 0;
    #10
    C = 1;
    #25
    C = 0; 
end
#20
for (i = 0; i < 2; i = i+1) begin
    D = 0;
    #10
    D = 1;
    #25
    D = 0; 
end
#5
E = 0;
#10
E = 1;
#30
E = 0;
#10
D = 1;
#25
D = 0;   
end


endmodule
