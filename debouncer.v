module debouncer(inout clk, in, output out);

reg meta,Q, Q1,Q2,Q3;

always @ (posedge clk) begin

meta <=in;
Q <= meta;


Q1 <= Q;
Q2 <= Q1;
Q3 <= Q2;

end

assign out = Q1&Q2&Q3;

endmodule
