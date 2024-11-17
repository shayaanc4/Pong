module vga_timing(hsync, vsync, x, y, clk, reset);
	
	// Constants for a VGA display resolution
	parameter H_DISPLAY = 640;
	parameter H_FRONT_PORCH = 16;
	parameter H_BACK_PORCH = 48;
	parameter H_SYNC = 96;
	parameter H_TOTAL = H_DISPLAY + H_FRONT_PORCH + H_BACK_PORCH + H_SYNC;
	parameter V_DISPLAY = 480;
	parameter V_FRONT_PORCH = 10;
	parameter V_BACK_PORCH = 33;
	parameter V_SYNC = 2;
	parameter V_TOTAL = V_DISPLAY + V_FRONT_PORCH + V_BACK_PORCH + V_SYNC;
	
	// I/O declarations
	input clk, reset;
	output reg hsync, vsync;
	output reg [9:0] x, y;

	// Registers for counters
	reg [9:0] h_counter;
	reg [9:0] v_counter;

	// Updating counter values
	always@(posedge clk or posedge reset) begin
		if (reset) begin
			h_counter <= 0;
			v_counter <= 0;
		end else begin
			if (h_counter == H_TOTAL - 1) begin
					h_counter <= 0;	
					if (v_counter == V_TOTAL - 1) v_counter <= 0;
					else v_counter = v_counter + 1;
			end else h_counter <= h_counter + 1;
		end
	end
	
	// Assigning hsync and vsync signals based on counters and parameters
	always@* hsync = ~(h_counter >= H_DISPLAY + H_FRONT_PORCH && h_counter < H_DISPLAY + H_FRONT_PORCH + H_SYNC);
	always@* vsync = ~(v_counter >= V_DISPLAY + V_FRONT_PORCH && v_counter < V_DISPLAY + V_FRONT_PORCH + V_SYNC);
	
	// Assigning counter signals to output signals x and y for ease of understanding
	always@* begin
		x = h_counter;
		y = v_counter;
	end

endmodule

						

