_InitGameShield:
;gaming-shield.h,174 :: 		void InitGameShield(){
;gaming-shield.h,180 :: 		upButtonDirection = 1;       //up
LBU	R2, Offset(TRISA+0)(GP)
ORI	R2, R2, 64
SB	R2, Offset(TRISA+0)(GP)
;gaming-shield.h,181 :: 		downButtonDirection = 1;     //down
LBU	R2, Offset(TRISA+0)(GP)
ORI	R2, R2, 128
SB	R2, Offset(TRISA+0)(GP)
;gaming-shield.h,182 :: 		rightButtonDirection = 1;    //right
LBU	R2, Offset(TRISD+1)(GP)
ORI	R2, R2, 4
SB	R2, Offset(TRISD+1)(GP)
;gaming-shield.h,183 :: 		leftButtonDirection = 1;     //left
LBU	R2, Offset(TRISA+0)(GP)
ORI	R2, R2, 32
SB	R2, Offset(TRISA+0)(GP)
;gaming-shield.h,184 :: 		triangleButtonDirection = 1; //triangle up
LBU	R2, Offset(TRISD+1)(GP)
ORI	R2, R2, 64
SB	R2, Offset(TRISD+1)(GP)
;gaming-shield.h,185 :: 		xButtonDirection = 1;        //x down
LBU	R2, Offset(TRISD+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(TRISD+1)(GP)
;gaming-shield.h,186 :: 		circleButtonDirection = 1;   //circle right
LBU	R2, Offset(TRISF+0)(GP)
ORI	R2, R2, 16
SB	R2, Offset(TRISF+0)(GP)
;gaming-shield.h,187 :: 		squareButtonDirection = 1;   //square left
LBU	R2, Offset(TRISD+1)(GP)
ORI	R2, R2, 8
SB	R2, Offset(TRISD+1)(GP)
;gaming-shield.h,188 :: 		startButtonDirection = 1;    //start
LBU	R2, Offset(TRISF+0)(GP)
ORI	R2, R2, 32
SB	R2, Offset(TRISF+0)(GP)
;gaming-shield.h,193 :: 		LED1_Direction = 0; //led 1
LBU	R2, Offset(TRISE+1)(GP)
INS	R2, R0, 0, 1
SB	R2, Offset(TRISE+1)(GP)
;gaming-shield.h,194 :: 		LED2_Direction = 0; //led 2
LBU	R2, Offset(TRISE+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(TRISE+1)(GP)
;gaming-shield.h,195 :: 		LED3_Direction = 0; //led 3
LBU	R2, Offset(TRISA+1)(GP)
INS	R2, R0, 6, 1
SB	R2, Offset(TRISA+1)(GP)
;gaming-shield.h,196 :: 		LED4_Direction = 0; //led 4
LBU	R2, Offset(TRISA+1)(GP)
INS	R2, R0, 7, 1
SB	R2, Offset(TRISA+1)(GP)
;gaming-shield.h,198 :: 		Delay_ms(100);
LUI	R24, 40
ORI	R24, R24, 45226
L_InitGameShield0:
ADDIU	R24, R24, -1
BNE	R24, R0, L_InitGameShield0
NOP	
;gaming-shield.h,200 :: 		LED1 = 0;
LBU	R2, Offset(LATE+1)(GP)
INS	R2, R0, 0, 1
SB	R2, Offset(LATE+1)(GP)
;gaming-shield.h,201 :: 		LED2 = 0;
LBU	R2, Offset(LATE+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(LATE+1)(GP)
;gaming-shield.h,202 :: 		LED3 = 0;
LBU	R2, Offset(LATA+1)(GP)
INS	R2, R0, 6, 1
SB	R2, Offset(LATA+1)(GP)
;gaming-shield.h,203 :: 		LED4 = 0;
LBU	R2, Offset(LATA+1)(GP)
INS	R2, R0, 7, 1
SB	R2, Offset(LATA+1)(GP)
;gaming-shield.h,204 :: 		}
L_end_InitGameShield:
JR	RA
NOP	
; end of _InitGameShield
_Check_GS:
;mmbInput_events_code.c,15 :: 		void Check_GS(){
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mmbInput_events_code.c,19 :: 		if(frame_counter==0){
SW	R25, 4(SP)
SW	R26, 8(SP)
LW	R2, Offset(_frame_counter+0)(GP)
BEQ	R2, R0, L__Check_GS32
NOP	
J	L_Check_GS2
NOP	
L__Check_GS32:
;mmbInput_events_code.c,21 :: 		LED1 = 0;
LBU	R2, Offset(LATE+1)(GP)
INS	R2, R0, 0, 1
SB	R2, Offset(LATE+1)(GP)
;mmbInput_events_code.c,22 :: 		LED2 = 0;
LBU	R2, Offset(LATE+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(LATE+1)(GP)
;mmbInput_events_code.c,23 :: 		LED3 = 0;
LBU	R2, Offset(LATA+1)(GP)
INS	R2, R0, 6, 1
SB	R2, Offset(LATA+1)(GP)
;mmbInput_events_code.c,24 :: 		LED4 = 0;
LBU	R2, Offset(LATA+1)(GP)
INS	R2, R0, 7, 1
SB	R2, Offset(LATA+1)(GP)
;mmbInput_events_code.c,35 :: 		strcpy(MCU_Caption, "PIC32");
LUI	R26, #hi_addr(?lstr1_mmbInput_events_code+0)
ORI	R26, R26, #lo_addr(?lstr1_mmbInput_events_code+0)
LUI	R25, #hi_addr(_MCU_Caption+0)
ORI	R25, R25, #lo_addr(_MCU_Caption+0)
JAL	_strcpy+0
NOP	
;mmbInput_events_code.c,36 :: 		DrawButton(&MCU);
LUI	R25, #hi_addr(_MCU+0)
ORI	R25, R25, #lo_addr(_MCU+0)
JAL	_DrawButton+0
NOP	
;mmbInput_events_code.c,39 :: 		UpdateStatusLEDButtons();
JAL	_UpdateStatusLEDButtons+0
NOP	
;mmbInput_events_code.c,41 :: 		}
L_Check_GS2:
;mmbInput_events_code.c,44 :: 		if(leftButton)
LBU	R2, Offset(PORTA+0)(GP)
EXT	R2, R2, 5, 1
BNE	R2, R0, L__Check_GS34
NOP	
J	L_Check_GS3
NOP	
L__Check_GS34:
;mmbInput_events_code.c,46 :: 		left.Checked = 1;
ORI	R2, R0, 1
SB	R2, Offset(_left+20)(GP)
;mmbInput_events_code.c,47 :: 		}
J	L_Check_GS4
NOP	
L_Check_GS3:
;mmbInput_events_code.c,50 :: 		left.Checked = 0;
SB	R0, Offset(_left+20)(GP)
;mmbInput_events_code.c,51 :: 		}
L_Check_GS4:
;mmbInput_events_code.c,54 :: 		if(rightButton)
LBU	R2, Offset(PORTD+1)(GP)
EXT	R2, R2, 2, 1
BNE	R2, R0, L__Check_GS36
NOP	
J	L_Check_GS5
NOP	
L__Check_GS36:
;mmbInput_events_code.c,56 :: 		right.Checked = 1;
ORI	R2, R0, 1
SB	R2, Offset(_right+20)(GP)
;mmbInput_events_code.c,57 :: 		}
J	L_Check_GS6
NOP	
L_Check_GS5:
;mmbInput_events_code.c,60 :: 		right.Checked = 0;
SB	R0, Offset(_right+20)(GP)
;mmbInput_events_code.c,61 :: 		}
L_Check_GS6:
;mmbInput_events_code.c,64 :: 		if(upButton)
LBU	R2, Offset(PORTA+0)(GP)
EXT	R2, R2, 6, 1
BNE	R2, R0, L__Check_GS38
NOP	
J	L_Check_GS7
NOP	
L__Check_GS38:
;mmbInput_events_code.c,66 :: 		up.Checked = 1;
ORI	R2, R0, 1
SB	R2, Offset(_up+20)(GP)
;mmbInput_events_code.c,67 :: 		}
J	L_Check_GS8
NOP	
L_Check_GS7:
;mmbInput_events_code.c,70 :: 		up.Checked = 0;
SB	R0, Offset(_up+20)(GP)
;mmbInput_events_code.c,71 :: 		}
L_Check_GS8:
;mmbInput_events_code.c,74 :: 		if(downButton)
LBU	R2, Offset(PORTA+0)(GP)
EXT	R2, R2, 7, 1
BNE	R2, R0, L__Check_GS40
NOP	
J	L_Check_GS9
NOP	
L__Check_GS40:
;mmbInput_events_code.c,76 :: 		down.Checked = 1;
ORI	R2, R0, 1
SB	R2, Offset(_down+20)(GP)
;mmbInput_events_code.c,77 :: 		}
J	L_Check_GS10
NOP	
L_Check_GS9:
;mmbInput_events_code.c,80 :: 		down.Checked = 0;
SB	R0, Offset(_down+20)(GP)
;mmbInput_events_code.c,81 :: 		}
L_Check_GS10:
;mmbInput_events_code.c,84 :: 		if(squareButton)
LBU	R2, Offset(PORTD+1)(GP)
EXT	R2, R2, 3, 1
BNE	R2, R0, L__Check_GS42
NOP	
J	L_Check_GS11
NOP	
L__Check_GS42:
;mmbInput_events_code.c,86 :: 		square.Checked = 1;
ORI	R2, R0, 1
SB	R2, Offset(_square+20)(GP)
;mmbInput_events_code.c,87 :: 		}
J	L_Check_GS12
NOP	
L_Check_GS11:
;mmbInput_events_code.c,90 :: 		square.Checked = 0;
SB	R0, Offset(_square+20)(GP)
;mmbInput_events_code.c,91 :: 		}
L_Check_GS12:
;mmbInput_events_code.c,93 :: 		if(circleButton)
LBU	R2, Offset(PORTF+0)(GP)
EXT	R2, R2, 4, 1
BNE	R2, R0, L__Check_GS44
NOP	
J	L_Check_GS13
NOP	
L__Check_GS44:
;mmbInput_events_code.c,95 :: 		circle.Checked = 1;
ORI	R2, R0, 1
SB	R2, Offset(_circle+20)(GP)
;mmbInput_events_code.c,96 :: 		}
J	L_Check_GS14
NOP	
L_Check_GS13:
;mmbInput_events_code.c,99 :: 		circle.Checked = 0;
SB	R0, Offset(_circle+20)(GP)
;mmbInput_events_code.c,100 :: 		}
L_Check_GS14:
;mmbInput_events_code.c,104 :: 		if(triangleButton)
LBU	R2, Offset(PORTD+1)(GP)
EXT	R2, R2, 6, 1
BNE	R2, R0, L__Check_GS46
NOP	
J	L_Check_GS15
NOP	
L__Check_GS46:
;mmbInput_events_code.c,106 :: 		triangle.Checked = 1;
ORI	R2, R0, 1
SB	R2, Offset(_triangle+20)(GP)
;mmbInput_events_code.c,107 :: 		}
J	L_Check_GS16
NOP	
L_Check_GS15:
;mmbInput_events_code.c,110 :: 		triangle.Checked = 0;
SB	R0, Offset(_triangle+20)(GP)
;mmbInput_events_code.c,111 :: 		}
L_Check_GS16:
;mmbInput_events_code.c,115 :: 		if(xButton)
LBU	R2, Offset(PORTD+1)(GP)
EXT	R2, R2, 7, 1
BNE	R2, R0, L__Check_GS48
NOP	
J	L_Check_GS17
NOP	
L__Check_GS48:
;mmbInput_events_code.c,117 :: 		x.Checked = 1;
ORI	R2, R0, 1
SB	R2, Offset(_x+20)(GP)
;mmbInput_events_code.c,119 :: 		}
J	L_Check_GS18
NOP	
L_Check_GS17:
;mmbInput_events_code.c,122 :: 		x.Checked = 0;
SB	R0, Offset(_x+20)(GP)
;mmbInput_events_code.c,123 :: 		}
L_Check_GS18:
;mmbInput_events_code.c,126 :: 		if(startButton)
LBU	R2, Offset(PORTF+0)(GP)
EXT	R2, R2, 5, 1
BNE	R2, R0, L__Check_GS50
NOP	
J	L_Check_GS19
NOP	
L__Check_GS50:
;mmbInput_events_code.c,128 :: 		start.Checked = 1;
ORI	R2, R0, 1
SB	R2, Offset(_start+20)(GP)
;mmbInput_events_code.c,130 :: 		}
J	L_Check_GS20
NOP	
L_Check_GS19:
;mmbInput_events_code.c,133 :: 		start.Checked = 0;
SB	R0, Offset(_start+20)(GP)
;mmbInput_events_code.c,134 :: 		}
L_Check_GS20:
;mmbInput_events_code.c,140 :: 		if( upButtonOld != upButton){
LBU	R2, Offset(PORTA+0)(GP)
EXT	R3, R2, 6, 1
LBU	R2, Offset(_upButtonOld+0)(GP)
EXT	R2, R2, BitPos(_upButtonOld+0), 1
BNE	R2, R3, L__Check_GS52
NOP	
J	L_Check_GS21
NOP	
L__Check_GS52:
;mmbInput_events_code.c,141 :: 		DrawRadioButton(&up);
LUI	R25, #hi_addr(_up+0)
ORI	R25, R25, #lo_addr(_up+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,142 :: 		}
L_Check_GS21:
;mmbInput_events_code.c,144 :: 		if( downButtonOld != downButton){
LBU	R2, Offset(PORTA+0)(GP)
EXT	R3, R2, 7, 1
LBU	R2, Offset(_downButtonOld+0)(GP)
EXT	R2, R2, BitPos(_downButtonOld+0), 1
BNE	R2, R3, L__Check_GS54
NOP	
J	L_Check_GS22
NOP	
L__Check_GS54:
;mmbInput_events_code.c,145 :: 		DrawRadioButton(&down);
LUI	R25, #hi_addr(_down+0)
ORI	R25, R25, #lo_addr(_down+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,146 :: 		}
L_Check_GS22:
;mmbInput_events_code.c,148 :: 		if( rightButtonOld != rightButton){
LBU	R2, Offset(PORTD+1)(GP)
EXT	R3, R2, 2, 1
LBU	R2, Offset(_rightButtonOld+0)(GP)
EXT	R2, R2, BitPos(_rightButtonOld+0), 1
BNE	R2, R3, L__Check_GS56
NOP	
J	L_Check_GS23
NOP	
L__Check_GS56:
;mmbInput_events_code.c,149 :: 		DrawRadioButton(&right);
LUI	R25, #hi_addr(_right+0)
ORI	R25, R25, #lo_addr(_right+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,150 :: 		}
L_Check_GS23:
;mmbInput_events_code.c,152 :: 		if( leftButtonOld != leftButton){
LBU	R2, Offset(PORTA+0)(GP)
EXT	R3, R2, 5, 1
LBU	R2, Offset(_leftButtonOld+0)(GP)
EXT	R2, R2, BitPos(_leftButtonOld+0), 1
BNE	R2, R3, L__Check_GS58
NOP	
J	L_Check_GS24
NOP	
L__Check_GS58:
;mmbInput_events_code.c,153 :: 		DrawRadioButton(&left);
LUI	R25, #hi_addr(_left+0)
ORI	R25, R25, #lo_addr(_left+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,154 :: 		}
L_Check_GS24:
;mmbInput_events_code.c,156 :: 		if( triangleButtonOld != triangleButton){
LBU	R2, Offset(PORTD+1)(GP)
EXT	R3, R2, 6, 1
LBU	R2, Offset(_triangleButtonOld+0)(GP)
EXT	R2, R2, BitPos(_triangleButtonOld+0), 1
BNE	R2, R3, L__Check_GS60
NOP	
J	L_Check_GS25
NOP	
L__Check_GS60:
;mmbInput_events_code.c,157 :: 		DrawRadioButton(&triangle);
LUI	R25, #hi_addr(_triangle+0)
ORI	R25, R25, #lo_addr(_triangle+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,158 :: 		}
L_Check_GS25:
;mmbInput_events_code.c,160 :: 		if( xButtonOld != xButton){
LBU	R2, Offset(PORTD+1)(GP)
EXT	R3, R2, 7, 1
LBU	R2, Offset(_xButtonOld+0)(GP)
EXT	R2, R2, BitPos(_xButtonOld+0), 1
BNE	R2, R3, L__Check_GS62
NOP	
J	L_Check_GS26
NOP	
L__Check_GS62:
;mmbInput_events_code.c,161 :: 		DrawRadioButton(&x);
LUI	R25, #hi_addr(_x+0)
ORI	R25, R25, #lo_addr(_x+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,162 :: 		}
L_Check_GS26:
;mmbInput_events_code.c,164 :: 		if( circleButtonOld != circleButton){
LBU	R2, Offset(PORTF+0)(GP)
EXT	R3, R2, 4, 1
LBU	R2, Offset(_circleButtonOld+0)(GP)
EXT	R2, R2, BitPos(_circleButtonOld+0), 1
BNE	R2, R3, L__Check_GS64
NOP	
J	L_Check_GS27
NOP	
L__Check_GS64:
;mmbInput_events_code.c,165 :: 		DrawRadioButton(&circle);
LUI	R25, #hi_addr(_circle+0)
ORI	R25, R25, #lo_addr(_circle+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,166 :: 		}
L_Check_GS27:
;mmbInput_events_code.c,168 :: 		if( squareButtonOld != squareButton){
LBU	R2, Offset(PORTD+1)(GP)
EXT	R3, R2, 3, 1
LBU	R2, Offset(_squareButtonOld+0)(GP)
EXT	R2, R2, BitPos(_squareButtonOld+0), 1
BNE	R2, R3, L__Check_GS66
NOP	
J	L_Check_GS28
NOP	
L__Check_GS66:
;mmbInput_events_code.c,169 :: 		DrawRadioButton(&square);
LUI	R25, #hi_addr(_square+0)
ORI	R25, R25, #lo_addr(_square+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,170 :: 		}
L_Check_GS28:
;mmbInput_events_code.c,172 :: 		if( startButtonOld != startButton){
LBU	R2, Offset(PORTF+0)(GP)
EXT	R3, R2, 5, 1
LBU	R2, Offset(_startButtonOld+0)(GP)
EXT	R2, R2, BitPos(_startButtonOld+0), 1
BNE	R2, R3, L__Check_GS68
NOP	
J	L_Check_GS29
NOP	
L__Check_GS68:
;mmbInput_events_code.c,173 :: 		DrawRadioButton(&start);
LUI	R25, #hi_addr(_start+0)
ORI	R25, R25, #lo_addr(_start+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,174 :: 		}
L_Check_GS29:
;mmbInput_events_code.c,179 :: 		upButtonOld = upButton;
LBU	R2, Offset(PORTA+0)(GP)
EXT	R3, R2, 6, 1
LBU	R2, Offset(_upButtonOld+0)(GP)
INS	R2, R3, BitPos(_upButtonOld+0), 1
SB	R2, Offset(_upButtonOld+0)(GP)
;mmbInput_events_code.c,180 :: 		downButtonOld = downButton;
LBU	R2, Offset(PORTA+0)(GP)
EXT	R3, R2, 7, 1
LBU	R2, Offset(_downButtonOld+0)(GP)
INS	R2, R3, BitPos(_downButtonOld+0), 1
SB	R2, Offset(_downButtonOld+0)(GP)
;mmbInput_events_code.c,181 :: 		rightButtonOld = rightButton;
LBU	R2, Offset(PORTD+1)(GP)
EXT	R3, R2, 2, 1
LBU	R2, Offset(_rightButtonOld+0)(GP)
INS	R2, R3, BitPos(_rightButtonOld+0), 1
SB	R2, Offset(_rightButtonOld+0)(GP)
;mmbInput_events_code.c,182 :: 		leftButtonOld = leftButton;
LBU	R2, Offset(PORTA+0)(GP)
EXT	R3, R2, 5, 1
LBU	R2, Offset(_leftButtonOld+0)(GP)
INS	R2, R3, BitPos(_leftButtonOld+0), 1
SB	R2, Offset(_leftButtonOld+0)(GP)
;mmbInput_events_code.c,184 :: 		triangleButtonOld = triangleButton;
LBU	R2, Offset(PORTD+1)(GP)
EXT	R3, R2, 6, 1
LBU	R2, Offset(_triangleButtonOld+0)(GP)
INS	R2, R3, BitPos(_triangleButtonOld+0), 1
SB	R2, Offset(_triangleButtonOld+0)(GP)
;mmbInput_events_code.c,185 :: 		xButtonOld = xButton;
LBU	R2, Offset(PORTD+1)(GP)
EXT	R3, R2, 7, 1
LBU	R2, Offset(_xButtonOld+0)(GP)
INS	R2, R3, BitPos(_xButtonOld+0), 1
SB	R2, Offset(_xButtonOld+0)(GP)
;mmbInput_events_code.c,186 :: 		circleButtonOld = circleButton;
LBU	R2, Offset(PORTF+0)(GP)
EXT	R3, R2, 4, 1
LBU	R2, Offset(_circleButtonOld+0)(GP)
INS	R2, R3, BitPos(_circleButtonOld+0), 1
SB	R2, Offset(_circleButtonOld+0)(GP)
;mmbInput_events_code.c,187 :: 		squareButtonOld = squareButton;
LBU	R2, Offset(PORTD+1)(GP)
EXT	R3, R2, 3, 1
LBU	R2, Offset(_squareButtonOld+0)(GP)
INS	R2, R3, BitPos(_squareButtonOld+0), 1
SB	R2, Offset(_squareButtonOld+0)(GP)
;mmbInput_events_code.c,189 :: 		startButtonOld = startButton;
LBU	R2, Offset(PORTF+0)(GP)
EXT	R3, R2, 5, 1
LBU	R2, Offset(_startButtonOld+0)(GP)
INS	R2, R3, BitPos(_startButtonOld+0), 1
SB	R2, Offset(_startButtonOld+0)(GP)
;mmbInput_events_code.c,192 :: 		}
L_end_Check_GS:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _Check_GS
_UpdateStatusLEDButtons:
;mmbInput_events_code.c,196 :: 		void UpdateStatusLEDButtons(){
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;mmbInput_events_code.c,198 :: 		Led1Button.Checked = !LED1;
SW	R25, 4(SP)
LBU	R2, Offset(LATE+1)(GP)
EXT	R2, R2, 0, 1
XORI	R2, R2, 1
SB	R2, Offset(_Led1Button+20)(GP)
;mmbInput_events_code.c,199 :: 		DrawRadioButton(&Led1Button);
LUI	R25, #hi_addr(_Led1Button+0)
ORI	R25, R25, #lo_addr(_Led1Button+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,201 :: 		Led2Button.Checked = !LED2;
LBU	R2, Offset(LATE+1)(GP)
EXT	R2, R2, 1, 1
XORI	R2, R2, 1
SB	R2, Offset(_Led2Button+20)(GP)
;mmbInput_events_code.c,202 :: 		DrawRadioButton(&Led2Button);
LUI	R25, #hi_addr(_Led2Button+0)
ORI	R25, R25, #lo_addr(_Led2Button+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,204 :: 		Led3Button.Checked = !LED3;
LBU	R2, Offset(LATA+1)(GP)
EXT	R2, R2, 6, 1
XORI	R2, R2, 1
SB	R2, Offset(_Led3Button+20)(GP)
;mmbInput_events_code.c,205 :: 		DrawRadioButton(&Led3Button);
LUI	R25, #hi_addr(_Led3Button+0)
ORI	R25, R25, #lo_addr(_Led3Button+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,207 :: 		Led4Button.Checked = !LED4;
LBU	R2, Offset(LATA+1)(GP)
EXT	R2, R2, 7, 1
XORI	R2, R2, 1
SB	R2, Offset(_Led4Button+20)(GP)
;mmbInput_events_code.c,208 :: 		DrawRadioButton(&Led4Button);
LUI	R25, #hi_addr(_Led4Button+0)
ORI	R25, R25, #lo_addr(_Led4Button+0)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_events_code.c,210 :: 		}
L_end_UpdateStatusLEDButtons:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _UpdateStatusLEDButtons
_Led1ButtonOnClick:
;mmbInput_events_code.c,218 :: 		void Led1ButtonOnClick() {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_events_code.c,219 :: 		LED1 = ~LED1;               //Toggle the LED
LBU	R2, Offset(LATE+1)(GP)
EXT	R2, R2, 0, 1
XORI	R3, R2, 1
LBU	R2, Offset(LATE+1)(GP)
INS	R2, R3, 0, 1
SB	R2, Offset(LATE+1)(GP)
;mmbInput_events_code.c,220 :: 		UpdateStatusLEDButtons();
JAL	_UpdateStatusLEDButtons+0
NOP	
;mmbInput_events_code.c,221 :: 		}
L_end_Led1ButtonOnClick:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Led1ButtonOnClick
_Led2ButtonOnClick:
;mmbInput_events_code.c,223 :: 		void Led2ButtonOnClick() {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_events_code.c,224 :: 		LED2 = ~LED2;               //Toggle the LED
LBU	R2, Offset(LATE+1)(GP)
EXT	R2, R2, 1, 1
XORI	R3, R2, 1
LBU	R2, Offset(LATE+1)(GP)
INS	R2, R3, 1, 1
SB	R2, Offset(LATE+1)(GP)
;mmbInput_events_code.c,225 :: 		UpdateStatusLEDButtons();
JAL	_UpdateStatusLEDButtons+0
NOP	
;mmbInput_events_code.c,226 :: 		}
L_end_Led2ButtonOnClick:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Led2ButtonOnClick
_Led3ButtonOnClick:
;mmbInput_events_code.c,228 :: 		void Led3ButtonOnClick() {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_events_code.c,229 :: 		LED3 = ~LED3;               //Toggle the LED
LBU	R2, Offset(LATA+1)(GP)
EXT	R2, R2, 6, 1
XORI	R3, R2, 1
LBU	R2, Offset(LATA+1)(GP)
INS	R2, R3, 6, 1
SB	R2, Offset(LATA+1)(GP)
;mmbInput_events_code.c,230 :: 		UpdateStatusLEDButtons();
JAL	_UpdateStatusLEDButtons+0
NOP	
;mmbInput_events_code.c,231 :: 		}
L_end_Led3ButtonOnClick:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Led3ButtonOnClick
_Led4ButtonOnClick:
;mmbInput_events_code.c,233 :: 		void Led4ButtonOnClick() {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_events_code.c,234 :: 		LED4 = ~LED4;              //Toggle the LED
LBU	R2, Offset(LATA+1)(GP)
EXT	R2, R2, 7, 1
XORI	R3, R2, 1
LBU	R2, Offset(LATA+1)(GP)
INS	R2, R3, 7, 1
SB	R2, Offset(LATA+1)(GP)
;mmbInput_events_code.c,235 :: 		UpdateStatusLEDButtons();
JAL	_UpdateStatusLEDButtons+0
NOP	
;mmbInput_events_code.c,236 :: 		}
L_end_Led4ButtonOnClick:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Led4ButtonOnClick
