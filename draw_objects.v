module draw_objects(r, g, b, x, y, ball_x, ball_y, paddle1_y, paddle2_y);

	// Constants regarding sizes of the screen and objects
	parameter ACTIVE_WIDTH = 640;
	parameter ACTIVE_HEIGHT = 480;
	parameter PADDLE_WIDTH = 10; //pixels
	parameter PADDLE_HEIGHT = 50; //pixels
	parameter BALL_WIDTH = 10;
	parameter BALL_HEIGHT = 10;
	
	// I/O declarations
	input [9:0] x, y, ball_x, ball_y, paddle1_y, paddle2_y;
	output reg [3:0] r,g,b;
	
	// Drawing at every pixel (x,y) in the current frame
	always@* begin
		// Drawing the ball 
		if (x >= ball_x && x < ball_x + BALL_WIDTH && y >= ball_y && y < ball_y + BALL_HEIGHT) begin
			r <= 4'd15;
			g <= 4'd15;
			b <= 4'd15;
		end 
		
		// Drawing the left and right paddles
		else if (x >= 0 && x < PADDLE_WIDTH && y >= paddle1_y && y < paddle1_y + PADDLE_HEIGHT) begin
			r <= 4'd15;
			g <= 4'd15;
			b <= 4'd15;
		end else if (x >= ACTIVE_WIDTH - PADDLE_WIDTH && x < ACTIVE_WIDTH && y >= paddle2_y && y < paddle2_y + PADDLE_HEIGHT) begin
			r <= 4'd15;
			g <= 4'd15;
			b <= 4'd15;
		end 
		
		// Drawing the background
		else begin
			r <= 4'd0;
			g <= 4'd0;
			b <= 4'd0;
		end
	end
endmodule
