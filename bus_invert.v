module bus_invert(a,b);
input [3:0] a;
output [3:0] b;

assign b = ~a;

endmodule