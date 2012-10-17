_main:
;mmbInput_main.c,41 :: 		void main() {
;mmbInput_main.c,43 :: 		Start_TP();
JAL	_Start_TP+0
NOP	
;mmbInput_main.c,44 :: 		InitGameShield();    //Setup the gameshield inputs and outputs
JAL	_InitGameShield+0
NOP	
;mmbInput_main.c,47 :: 		while (1) {
L_main0:
;mmbInput_main.c,48 :: 		Check_TP(); //Check the Mikromedia Touch Panel
JAL	_Check_TP+0
NOP	
;mmbInput_main.c,49 :: 		Check_GS(); //Check for Game Shield input
JAL	_Check_GS+0
NOP	
;mmbInput_main.c,51 :: 		frame_counter++;  //Increment the frame counter
LW	R2, Offset(_frame_counter+0)(GP)
ADDIU	R2, R2, 1
SW	R2, Offset(_frame_counter+0)(GP)
;mmbInput_main.c,53 :: 		}
J	L_main0
NOP	
;mmbInput_main.c,55 :: 		}
L_end_main:
L__main_end_loop:
J	L__main_end_loop
NOP	
; end of _main
