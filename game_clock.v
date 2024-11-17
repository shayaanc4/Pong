module game_clock(CLOCK_50, reset, game_clk);

// Parameter for divisor to determine by what factor to cut the 50 MHz clock
parameter DIVIDER = 833333; // 50 x 10^6 / 60

// I/O declarations
input CLOCK_50, reset;
output reg game_clk;

// Register for counter
reg [19:0] counter;

// Generating a 60 Hz Clock for the game 
always@(posedge CLOCK_50 or posedge reset) begin
	if (reset) begin
		counter <= 0;
		game_clk <= 0;
	end else if (counter == DIVIDER) begin
		counter <= 0;
		game_clk <= ~game_clk;
	end else begin
		counter <= counter + 1;
	end
end
endmodule
