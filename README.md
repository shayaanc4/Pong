# Pong
This project implements the classic Pong game on an FPGA platform using Verilog. The game is fully hardware-accelerated and displayed via a VGA output. Players control paddles to bounce a ball back and forth, with score tracking and reset functionality.

Features

	•	VGA Output: Generates a 640x480 resolution display.
	•	Game Logic:
	•	Ball movement with collision detection for paddles, top/bottom boundaries, and scoring zones.
	•	Paddle control via input keys.
	•	Automatic game reset on scoring.
	•	Custom Hardware Modules:
	•	VGA timing generator (vga_timing.v).
	•	Game clock divider (game_clock.v).
	•	Game logic controller (game_logic.v).
	•	Object drawing logic (draw_objects.v).
	•	Pin Configuration: Defined in DE0_CV_pins.qsf for the DE0-CV FPGA board.
