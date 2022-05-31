module BCD (input[3:0] in, output reg[6:0] out);

always @(*) begin

case(in)

4'h0 : out = 7'b0000_001;
4'h1 : out = 7'b1001_111;
4'h2 : out = 7'b0010_010;
4'h3 : out = 7'b0000_110;
4'h4 : out = 7'b1001_100;
4'h5 : out = 7'b0100_100;
4'h6 : out = 7'b0100_000;
4'h7 : out = 7'b0001_111;
4'h8 : out = 7'b0000_000;
4'h9 : out = 7'b0000_100;
default: out = 7'b1111_111; 

endcase

end

endmodule