# Pong
This project implements the classic Pong game on an FPGA platform using Verilog. The game is fully hardware-based and displayed via Video Graphics Array (VGA). Players control paddles to bounce a ball back and forth, with score tracking and reset functionality.

Features

• VGA Output: Generates a 640x480 resolution display.

•	Game Logic:

	•	Ball movement with collision detection for paddles, top/bottom boundaries, and scoring zones.
	•	Paddle control via input keys.
	•	Automatic game reset on scoring.
 
•	Custom Hardware Modules:

	•	VGA timing generator (vga_timing.v).
	•	Game clock divider (game_clock.v).
	•	Game logic controller (game_logic.v).
	•	Object drawing logic (draw_objects.v).
	•	7-Segment Display driver (FullSegmentDisplay.bdf)
	•	Top-level game controller (vga_schematic.bdf)

 How to Run

	1.	Compile the Verilog modules and schematics using Quartus Prime.
	2.	Connect and configure the DE0-CV FPGA board pins using the .qsf file.
	3.	Connect the VGA output to a monitor.
	4.	Use the input keys to control the paddles and enjoy the game!
