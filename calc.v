module calc(input clk, rst, A,B,C,D,E, gen, output reg [6:0] LEDs, output reg [3:0] active, output reg point);


wire [1:0] bin_counter_out;
wire [6:0] out1, out2, out3, out4;
reg [3:0] tens1, ones1, tens2, ones2, add_tens, add_ones, add_hund, substract_tens, substract_ones, ones1_rst, ones2_rst, tens1_rst, tens2_rst, mult_ones, mult_tens, mult_hund, mult_thous;
reg [6:0] num1, num2;
reg signed [15:0] result;
reg [7:0] result_sub;
reg neg, opres;
wire clk_out;

wire debouncerA,debouncerB,debouncerC,debouncerD, debouncerE; 
wire edgeDecA,edgeDecB,edgeDecC,edgeDecD, edgeDecE;

debouncer de1 (clk, A, debouncerA);
debouncer de2 (clk, B, debouncerB);
debouncer de3 (clk, C, debouncerC);
debouncer de4 (clk, D, debouncerD);
debouncer de5 (clk, E, debouncerE);

risingEdge_dec re1 (clk, rst, debouncerA, edgeDecA);  
risingEdge_dec re2 (clk, rst, debouncerB, edgeDecB);  
risingEdge_dec re3 (clk, rst, debouncerC, edgeDecC);  
risingEdge_dec re4 (clk, rst, debouncerD, edgeDecD);
risingEdge_dec re5 (clk, rst, debouncerE, edgeDecE);

reg mode_out;

always @(posedge clk) begin
    if (rst)begin
        tens1 = 4'd0;
        ones1 = 4'd0;
        tens2 = 4'd0;
        ones2 = 4'd0;
        neg = 0;
        opres = 0;
        mode_out <= 0;
    end
    
    else begin
        if(gen)begin
            tens1 = tens1_rst;
            ones1 = ones1_rst;
            tens2 = tens2_rst;
            ones2 = ones2_rst;
            neg = 0;
            opres = 0;
            mode_out <= 0;
        end
        
        if (edgeDecE)
            mode_out <= ~mode_out;
            
        if (!mode_out) begin
            opres = 0;
            neg = 0;
            if(edgeDecA)begin
                if (tens1 == 9)
                    tens1 <= 0;
                else
                    tens1 <= tens1 + 1;
            end
            
            if(edgeDecB)begin
                if (ones1 == 9)
                    ones1 <= 0;
                else
                    ones1 <= ones1 + 1;
            end
            
            if(edgeDecC)begin
                if (tens2 == 9)
                    tens2 <= 0;
                else
                    tens2 <= tens2 + 1;
            end
            
            if(edgeDecD)begin
                if (ones2 == 9)
                    ones2 <= 0;
                else
                   ones2 <= ones2 + 1;
            end
            
            tens1_rst = tens1;
            ones1_rst = ones1;
            tens2_rst = tens2;
            ones2_rst = ones2;
        end
        
        else begin
             if(edgeDecA)begin
                opres = 1;
                neg = 0;
                tens1 = tens1_rst;
                ones1 = ones1_rst;
                tens2 = tens2_rst;
                ones2 = ones2_rst;
                               
                num1 = tens1*10 + ones1;
                num2 = tens2*10 + ones2;
                result = num1 + num2;
                
                if (result > 99) begin 
                    add_ones = (result % 100) % 10; 
                    add_tens = (result % 100) / 10;
                    add_hund = result / 100; 
                    tens2 = add_tens;
                    ones2 = add_ones;
                    ones1 = add_hund;
                    tens1 = 10;
                end
                
                else begin 
                    add_ones = result % 10; 
                    add_tens = result / 10;
                    tens2 = add_tens;
                    ones2 = add_ones;
                    ones1 = 10;
                    tens1 = 10;
                end
            end
            if (edgeDecB)begin
                opres = 1;
                tens1 = tens1_rst;
                ones1 = ones1_rst;
                tens2 = tens2_rst;
                ones2 = ones2_rst;   
                    
                num1 = tens1*10 + ones1;
                num2 = tens2*10 + ones2;
                
                if (num2 > num1) begin
                    result = num1 - num2;
                    result_sub = -result;
                    substract_tens = result_sub / 10;
                    substract_ones = result_sub %10;
                    neg = 1;
                    tens1 = 10;
                    ones1 = 11; 
                    tens2 = substract_tens;
                    ones2 = substract_ones;
                end 
                
                else begin
                    result = num1 - num2;
                    substract_tens = result / 10;
                    substract_ones = result %10;
                    neg = 0;
                    tens1 = 10;
                    ones1 = 10; 
                    tens2 = substract_tens;     
                    ones2 = substract_ones;
                end
            end
            
            if (edgeDecC) begin
                opres = 1;
                neg = 0;
                tens1 = tens1_rst;
                ones1 = ones1_rst;
                tens2 = tens2_rst;
                ones2 = ones2_rst;
                               
                num1 = tens1*10 + ones1;
                num2 = tens2*10 + ones2;
                
                result = num1 * num2;
                if (result > 999) begin
                    mult_ones = ((result % 100) % 100) % 10; 
                    mult_tens = ((result % 1000) % 100) / 10;
                    mult_hund = (result % 1000) / 100; 
                    mult_thous = result / 1000;
                    tens1 = mult_thous;
                    ones1 = mult_hund;
                    tens2 = mult_tens;
                    ones2 = mult_ones;
                end
                
                else if (result > 99) begin
                    mult_ones = (result % 100) % 10; 
                    mult_tens = (result % 100) / 10;
                    mult_hund = result / 100; 
                    tens1 = 10;
                    ones1 = mult_hund;
                    tens2 = mult_tens;
                    ones2 = mult_ones;
                end
                
                else begin
                    mult_ones = result % 10; 
                    mult_tens = result / 10;
                    tens1 = 10;
                    ones1 = 10;
                    tens2 = mult_tens;
                    ones2 = mult_ones;
                end
            end
            
            if (edgeDecD) begin
                opres = 1;
                neg = 0;
                tens1 = tens1_rst;
                ones1 = ones1_rst;
                tens2 = tens2_rst;
                ones2 = ones2_rst;
                               
                num1 = tens1*10 + ones1;
                num2 = tens2*10 + ones2;
                
                result = num1 / num2; 
                
                tens1 = 10;
                ones1 = 10;
                tens2 = 10;
                ones2 = result;
            end
             
         end // for the else condition for the other mode type
    end // for the rst condition
end //for the always block

clockDivider  #(5000) clk_div (clk, rst, clk_out);
counter_2bits counter (clk_out, rst, bin_counter_out);


BCD segA (tens1, out1);
BCD segB (ones1, out2);
BCD segC (tens2, out3);
BCD segD (ones2, out4);

always @(*) begin

if(bin_counter_out==0) begin
    LEDs=out4;
    active=4'b1110;
    point = 1;
    end
else if(bin_counter_out==1) begin
        LEDs=out3;
        active=4'b1101;
        point = 1;
        end
else if(bin_counter_out==2) begin
        active=4'b1011;
        if (opres)
            point = 1;
        else 
            point = 0;
        if (neg)
          LEDs = 7'b1111_110;
        else
          LEDs=out2;
        end
else begin
        LEDs=out1;
        active=4'b0111;
        point = 1;
        end
   
end
 
endmodule