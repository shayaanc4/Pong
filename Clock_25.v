module Clock_25(clk_out, reset, clk_in);

// I/O declarations
input clk_in, reset;
output reg clk_out;

// Making a 25MHz clock for the VGA driver
always@(posedge clk_in or posedge reset)
	begin
		if (reset) clk_out <= 0;
		else clk_out <= ~clk_out;
	end

endmodule