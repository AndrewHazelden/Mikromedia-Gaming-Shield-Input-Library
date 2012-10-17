
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;mmbInput_main.c,39 :: 		void main() {
;mmbInput_main.c,41 :: 		Start_TP();
	CALL	_Start_TP
;mmbInput_main.c,42 :: 		InitGameShield();    //Setup the gameshield inputs and outputs
	CALL	_InitGameShield
;mmbInput_main.c,45 :: 		while (1) {
L_main0:
;mmbInput_main.c,46 :: 		Check_TP(); //Check the Mikromedia Touch Panel
	CALL	_Check_TP
;mmbInput_main.c,47 :: 		Check_GS(); //Check for Game Shield input
	CALL	_Check_GS
;mmbInput_main.c,49 :: 		frame_counter++;  //Increment the frame counter
	MOV	#1, W1
	MOV	#0, W2
	MOV	#lo_addr(_frame_counter), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
;mmbInput_main.c,51 :: 		}
	GOTO	L_main0
;mmbInput_main.c,53 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
