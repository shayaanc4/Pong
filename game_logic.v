module game_logic(clk, reset, KEY, ball_x, ball_y, paddle1_y, paddle2_y, score1, score2);

// Constants regarding sizes of the screen and objects
parameter ACTIVE_WIDTH = 640;
parameter ACTIVE_HEIGHT = 480;
parameter PADDLE_WIDTH = 10; //pixels
parameter PADDLE_HEIGHT = 50; //pixels
parameter BALL_WIDTH = 10;
parameter BALL_HEIGHT = 10;
parameter PADDLE_SPEED = 2;

// I/O declarations
input clk, reset;
input [3:0] KEY;
output reg [9:0] ball_x, ball_y, paddle1_y, paddle2_y;
output reg [3:0] score1, score2;

// Registers + wires
reg signed [1:0] ball_dx, ball_dy;
wire paddle1_up, paddle1_down, paddle2_up, paddle2_down;

// Assigning up and down paddle signals to keys on DE0-CV board
assign paddle1_up = KEY[3];
assign paddle1_down = KEY[2];
assign paddle2_up = KEY[1];
assign paddle2_down = KEY[0];

// Ball movement
always@(posedge clk or posedge reset) begin
	
	// Resetting the game environment
	if (reset) begin
	  ball_x <= ACTIVE_WIDTH / 2;
	  ball_y <= ACTIVE_HEIGHT / 2;
	  ball_dx <= 1;
	  ball_dy <= 1;
	  score1 <= 0;
	  score2 <= 0;
	end
	
	// When not resetting
   else begin
		
		// Updating ball position based on velocities
		ball_x <= $signed({1'b0, ball_x}) + ball_dx;
		ball_y <= $signed({1'b0, ball_y}) + ball_dy;

		// Bounce off top and bottom edges
		if (ball_y <= 0) begin
			ball_y <= 1;
			ball_dy <= -ball_dy;
		end else if (ball_y >= ACTIVE_HEIGHT - BALL_HEIGHT) begin
			ball_y <= ACTIVE_HEIGHT - BALL_HEIGHT - 1;
			ball_dy <= -ball_dy;
		end

		// Resetting the ball when a player scores (goes off opponent's side)
		if (ball_x <= 0 || ball_x >= ACTIVE_WIDTH - BALL_WIDTH) begin
			ball_x <= ACTIVE_WIDTH / 2;
			ball_y <= ACTIVE_HEIGHT / 2;
			ball_dx <= 1;
			ball_dy <= 1;
			if (ball_x <= 0) score1 <= score1 + 1;
			else score2 <= score2 + 1;
		end

		// Bounce off paddles
		if (ball_x <= PADDLE_WIDTH && ball_y >= paddle1_y && ball_y <= paddle1_y + PADDLE_HEIGHT) begin
			ball_dx <= -ball_dx;
			ball_x <= PADDLE_WIDTH + PADDLE_SPEED - 1;
		end else if (ball_x >= ACTIVE_WIDTH - PADDLE_WIDTH - BALL_WIDTH && ball_y >= paddle2_y && ball_y <= paddle2_y + PADDLE_HEIGHT) begin
			ball_dx <= -ball_dx;
			ball_x <= ACTIVE_WIDTH - PADDLE_WIDTH - BALL_WIDTH - PADDLE_SPEED + 1;
		end
	end
end

// Paddle movement
always@(posedge clk or posedge reset) begin
	
	// Resetting the paddles
	if (reset) begin
		paddle1_y <= (ACTIVE_HEIGHT - PADDLE_HEIGHT)/2; 
		paddle2_y <= (ACTIVE_HEIGHT - PADDLE_HEIGHT)/2;
	end 
	
	// When not resetting, update paddle positions based on input signals
	else begin
		if (paddle1_up && paddle1_y > PADDLE_SPEED - 1) 
			paddle1_y <= paddle1_y - PADDLE_SPEED; // Move paddle up
		if (paddle1_down && paddle1_y < ACTIVE_HEIGHT - PADDLE_HEIGHT - PADDLE_SPEED + 1)
			paddle1_y <= paddle1_y + PADDLE_SPEED; // Move paddle down
		if (paddle2_up && paddle2_y > PADDLE_SPEED - 1) 
			paddle2_y <= paddle2_y - PADDLE_SPEED; // Move paddle up
		if (paddle2_down && paddle2_y < ACTIVE_HEIGHT - PADDLE_HEIGHT - PADDLE_SPEED + 1)
			paddle2_y <= paddle2_y + PADDLE_SPEED; // Move paddle down
	end
end

endmodule
