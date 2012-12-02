
_InitGameShield:

;gaming-shield.h,246 :: 		void InitGameShield(){
;gaming-shield.h,252 :: 		upButtonDirection = 1;       //up
	BSET	TRISD, #14
;gaming-shield.h,253 :: 		downButtonDirection = 1;     //down
	BSET	TRISD, #15
;gaming-shield.h,254 :: 		rightButtonDirection = 1;    //right
	BSET	TRISD, #6
;gaming-shield.h,255 :: 		leftButtonDirection = 1;     //left
	BSET	TRISD, #9
;gaming-shield.h,256 :: 		triangleButtonDirection = 1; //triangle up
	BSET	TRISA, #9
;gaming-shield.h,257 :: 		xButtonDirection = 1;        //x down
	BSET	TRISA, #10
;gaming-shield.h,258 :: 		circleButtonDirection = 1;   //circle right
	BSET	TRISF, #0
;gaming-shield.h,259 :: 		squareButtonDirection = 1;   //square left
	BSET	TRISD, #7
;gaming-shield.h,260 :: 		startButtonDirection = 1;    //start
	BSET	TRISF, #1
;gaming-shield.h,265 :: 		LED1_Direction = 0; //led 1
	BCLR	TRISA, #12
;gaming-shield.h,266 :: 		LED2_Direction = 0; //led 2
	BCLR	TRISA, #13
;gaming-shield.h,267 :: 		LED3_Direction = 0; //led 3
	BCLR	TRISA, #14
;gaming-shield.h,268 :: 		LED4_Direction = 0; //led 4
	BCLR	TRISA, #15
;gaming-shield.h,270 :: 		Delay_ms(100);
	MOV	#17, W8
	MOV	#18095, W7
L_InitGameShield0:
	DEC	W7
	BRA NZ	L_InitGameShield0
	DEC	W8
	BRA NZ	L_InitGameShield0
;gaming-shield.h,272 :: 		LED1 = 0;
	BCLR	LATA, #12
;gaming-shield.h,273 :: 		LED2 = 0;
	BCLR	LATA, #13
;gaming-shield.h,274 :: 		LED3 = 0;
	BCLR	LATA, #14
;gaming-shield.h,275 :: 		LED4 = 0;
	BCLR	LATA, #15
;gaming-shield.h,276 :: 		}
L_end_InitGameShield:
	RETURN
; end of _InitGameShield

_Check_GS:

;mmbInput_events_code.c,15 :: 		void Check_GS(){
;mmbInput_events_code.c,19 :: 		if(frame_counter==0){
	PUSH	W10
	PUSH	W11
	MOV	_frame_counter, W0
	MOV	_frame_counter+2, W1
	CP	W0, #0
	CPB	W1, #0
	BRA Z	L__Check_GS32
	GOTO	L_Check_GS2
L__Check_GS32:
;mmbInput_events_code.c,21 :: 		LED1 = 0;
	BCLR	LATA, #12
;mmbInput_events_code.c,22 :: 		LED2 = 0;
	BCLR	LATA, #13
;mmbInput_events_code.c,23 :: 		LED3 = 0;
	BCLR	LATA, #14
;mmbInput_events_code.c,24 :: 		LED4 = 0;
	BCLR	LATA, #15
;mmbInput_events_code.c,30 :: 		strcpy(MCU_Caption, "dsPIC");
	MOV	#lo_addr(?lstr1_mmbInput_events_code), W11
	MOV	#lo_addr(_MCU_Caption), W10
	CALL	_strcpy
;mmbInput_events_code.c,31 :: 		DrawButton(&MCU);
	MOV	#lo_addr(_MCU), W10
	CALL	_DrawButton
;mmbInput_events_code.c,39 :: 		UpdateStatusLEDButtons();
	CALL	_UpdateStatusLEDButtons
;mmbInput_events_code.c,41 :: 		}
L_Check_GS2:
;mmbInput_events_code.c,44 :: 		if(leftButton)
	BTSS	PORTD, #9
	GOTO	L_Check_GS3
;mmbInput_events_code.c,46 :: 		left.Checked = 1;
	MOV	#lo_addr(_left+18), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,47 :: 		}
	GOTO	L_Check_GS4
L_Check_GS3:
;mmbInput_events_code.c,50 :: 		left.Checked = 0;
	MOV	#lo_addr(_left+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,51 :: 		}
L_Check_GS4:
;mmbInput_events_code.c,54 :: 		if(rightButton)
	BTSS	PORTD, #6
	GOTO	L_Check_GS5
;mmbInput_events_code.c,56 :: 		right.Checked = 1;
	MOV	#lo_addr(_right+18), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,57 :: 		}
	GOTO	L_Check_GS6
L_Check_GS5:
;mmbInput_events_code.c,60 :: 		right.Checked = 0;
	MOV	#lo_addr(_right+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,61 :: 		}
L_Check_GS6:
;mmbInput_events_code.c,64 :: 		if(upButton)
	BTSS	PORTD, #14
	GOTO	L_Check_GS7
;mmbInput_events_code.c,66 :: 		up.Checked = 1;
	MOV	#lo_addr(_up+18), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,67 :: 		}
	GOTO	L_Check_GS8
L_Check_GS7:
;mmbInput_events_code.c,70 :: 		up.Checked = 0;
	MOV	#lo_addr(_up+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,71 :: 		}
L_Check_GS8:
;mmbInput_events_code.c,74 :: 		if(downButton)
	BTSS	PORTD, #15
	GOTO	L_Check_GS9
;mmbInput_events_code.c,76 :: 		down.Checked = 1;
	MOV	#lo_addr(_down+18), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,77 :: 		}
	GOTO	L_Check_GS10
L_Check_GS9:
;mmbInput_events_code.c,80 :: 		down.Checked = 0;
	MOV	#lo_addr(_down+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,81 :: 		}
L_Check_GS10:
;mmbInput_events_code.c,84 :: 		if(squareButton)
	BTSS	PORTD, #7
	GOTO	L_Check_GS11
;mmbInput_events_code.c,86 :: 		square.Checked = 1;
	MOV	#lo_addr(_square+18), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,87 :: 		}
	GOTO	L_Check_GS12
L_Check_GS11:
;mmbInput_events_code.c,90 :: 		square.Checked = 0;
	MOV	#lo_addr(_square+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,91 :: 		}
L_Check_GS12:
;mmbInput_events_code.c,93 :: 		if(circleButton)
	BTSS	PORTF, #0
	GOTO	L_Check_GS13
;mmbInput_events_code.c,95 :: 		circle.Checked = 1;
	MOV	#lo_addr(_circle+18), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,96 :: 		}
	GOTO	L_Check_GS14
L_Check_GS13:
;mmbInput_events_code.c,99 :: 		circle.Checked = 0;
	MOV	#lo_addr(_circle+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,100 :: 		}
L_Check_GS14:
;mmbInput_events_code.c,104 :: 		if(triangleButton)
	BTSS	PORTA, #9
	GOTO	L_Check_GS15
;mmbInput_events_code.c,106 :: 		triangle.Checked = 1;
	MOV	#lo_addr(_triangle+18), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,107 :: 		}
	GOTO	L_Check_GS16
L_Check_GS15:
;mmbInput_events_code.c,110 :: 		triangle.Checked = 0;
	MOV	#lo_addr(_triangle+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,111 :: 		}
L_Check_GS16:
;mmbInput_events_code.c,115 :: 		if(xButton)
	BTSS	PORTA, #10
	GOTO	L_Check_GS17
;mmbInput_events_code.c,117 :: 		x.Checked = 1;
	MOV	#lo_addr(_x+18), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,119 :: 		}
	GOTO	L_Check_GS18
L_Check_GS17:
;mmbInput_events_code.c,122 :: 		x.Checked = 0;
	MOV	#lo_addr(_x+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,123 :: 		}
L_Check_GS18:
;mmbInput_events_code.c,126 :: 		if(startButton)
	BTSS	PORTF, #1
	GOTO	L_Check_GS19
;mmbInput_events_code.c,128 :: 		start.Checked = 1;
	MOV	#lo_addr(_start+18), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,130 :: 		}
	GOTO	L_Check_GS20
L_Check_GS19:
;mmbInput_events_code.c,133 :: 		start.Checked = 0;
	MOV	#lo_addr(_start+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_events_code.c,134 :: 		}
L_Check_GS20:
;mmbInput_events_code.c,140 :: 		if( upButtonOld != upButton){
	MOV	#lo_addr(_upButtonOld), W0
	BTST	PORTD, #14
	BTSC	[W0], BitPos(_upButtonOld+0)
	BRA	L__Check_GS35
	BRA Z	L__Check_GS34
L__Check_GS33:
	BRA	L__Check_GS36
L__Check_GS35:
	BRA Z	L__Check_GS33
L__Check_GS34:
	GOTO	L_Check_GS21
L__Check_GS36:
;mmbInput_events_code.c,141 :: 		DrawRadioButton(&up);
	MOV	#lo_addr(_up), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,142 :: 		}
L_Check_GS21:
;mmbInput_events_code.c,144 :: 		if( downButtonOld != downButton){
	MOV	#lo_addr(_downButtonOld), W0
	BTST	PORTD, #15
	BTSC	[W0], BitPos(_downButtonOld+0)
	BRA	L__Check_GS39
	BRA Z	L__Check_GS38
L__Check_GS37:
	BRA	L__Check_GS40
L__Check_GS39:
	BRA Z	L__Check_GS37
L__Check_GS38:
	GOTO	L_Check_GS22
L__Check_GS40:
;mmbInput_events_code.c,145 :: 		DrawRadioButton(&down);
	MOV	#lo_addr(_down), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,146 :: 		}
L_Check_GS22:
;mmbInput_events_code.c,148 :: 		if( rightButtonOld != rightButton){
	MOV	#lo_addr(_rightButtonOld), W0
	BTST	PORTD, #6
	BTSC	[W0], BitPos(_rightButtonOld+0)
	BRA	L__Check_GS43
	BRA Z	L__Check_GS42
L__Check_GS41:
	BRA	L__Check_GS44
L__Check_GS43:
	BRA Z	L__Check_GS41
L__Check_GS42:
	GOTO	L_Check_GS23
L__Check_GS44:
;mmbInput_events_code.c,149 :: 		DrawRadioButton(&right);
	MOV	#lo_addr(_right), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,150 :: 		}
L_Check_GS23:
;mmbInput_events_code.c,152 :: 		if( leftButtonOld != leftButton){
	MOV	#lo_addr(_leftButtonOld), W0
	BTST	PORTD, #9
	BTSC	[W0], BitPos(_leftButtonOld+0)
	BRA	L__Check_GS47
	BRA Z	L__Check_GS46
L__Check_GS45:
	BRA	L__Check_GS48
L__Check_GS47:
	BRA Z	L__Check_GS45
L__Check_GS46:
	GOTO	L_Check_GS24
L__Check_GS48:
;mmbInput_events_code.c,153 :: 		DrawRadioButton(&left);
	MOV	#lo_addr(_left), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,154 :: 		}
L_Check_GS24:
;mmbInput_events_code.c,156 :: 		if( triangleButtonOld != triangleButton){
	MOV	#lo_addr(_triangleButtonOld), W0
	BTST	PORTA, #9
	BTSC	[W0], BitPos(_triangleButtonOld+0)
	BRA	L__Check_GS51
	BRA Z	L__Check_GS50
L__Check_GS49:
	BRA	L__Check_GS52
L__Check_GS51:
	BRA Z	L__Check_GS49
L__Check_GS50:
	GOTO	L_Check_GS25
L__Check_GS52:
;mmbInput_events_code.c,157 :: 		DrawRadioButton(&triangle);
	MOV	#lo_addr(_triangle), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,158 :: 		}
L_Check_GS25:
;mmbInput_events_code.c,160 :: 		if( xButtonOld != xButton){
	MOV	#lo_addr(_xButtonOld), W0
	BTST	PORTA, #10
	BTSC	[W0], BitPos(_xButtonOld+0)
	BRA	L__Check_GS55
	BRA Z	L__Check_GS54
L__Check_GS53:
	BRA	L__Check_GS56
L__Check_GS55:
	BRA Z	L__Check_GS53
L__Check_GS54:
	GOTO	L_Check_GS26
L__Check_GS56:
;mmbInput_events_code.c,161 :: 		DrawRadioButton(&x);
	MOV	#lo_addr(_x), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,162 :: 		}
L_Check_GS26:
;mmbInput_events_code.c,164 :: 		if( circleButtonOld != circleButton){
	MOV	#lo_addr(_circleButtonOld), W0
	BTST	PORTF, #0
	BTSC	[W0], BitPos(_circleButtonOld+0)
	BRA	L__Check_GS59
	BRA Z	L__Check_GS58
L__Check_GS57:
	BRA	L__Check_GS60
L__Check_GS59:
	BRA Z	L__Check_GS57
L__Check_GS58:
	GOTO	L_Check_GS27
L__Check_GS60:
;mmbInput_events_code.c,165 :: 		DrawRadioButton(&circle);
	MOV	#lo_addr(_circle), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,166 :: 		}
L_Check_GS27:
;mmbInput_events_code.c,168 :: 		if( squareButtonOld != squareButton){
	MOV	#lo_addr(_squareButtonOld), W0
	BTST	PORTD, #7
	BTSC	[W0], BitPos(_squareButtonOld+0)
	BRA	L__Check_GS63
	BRA Z	L__Check_GS62
L__Check_GS61:
	BRA	L__Check_GS64
L__Check_GS63:
	BRA Z	L__Check_GS61
L__Check_GS62:
	GOTO	L_Check_GS28
L__Check_GS64:
;mmbInput_events_code.c,169 :: 		DrawRadioButton(&square);
	MOV	#lo_addr(_square), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,170 :: 		}
L_Check_GS28:
;mmbInput_events_code.c,172 :: 		if( startButtonOld != startButton){
	MOV	#lo_addr(_startButtonOld), W0
	BTST	PORTF, #1
	BTSC	[W0], BitPos(_startButtonOld+0)
	BRA	L__Check_GS67
	BRA Z	L__Check_GS66
L__Check_GS65:
	BRA	L__Check_GS68
L__Check_GS67:
	BRA Z	L__Check_GS65
L__Check_GS66:
	GOTO	L_Check_GS29
L__Check_GS68:
;mmbInput_events_code.c,173 :: 		DrawRadioButton(&start);
	MOV	#lo_addr(_start), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,174 :: 		}
L_Check_GS29:
;mmbInput_events_code.c,179 :: 		upButtonOld = upButton;
	MOV	#lo_addr(_upButtonOld), W0
	BSET	[W0], BitPos(_upButtonOld+0)
	BTSS	PORTD, #14
	BCLR	[W0], BitPos(_upButtonOld+0)
;mmbInput_events_code.c,180 :: 		downButtonOld = downButton;
	MOV	#lo_addr(_downButtonOld), W0
	BSET	[W0], BitPos(_downButtonOld+0)
	BTSS	PORTD, #15
	BCLR	[W0], BitPos(_downButtonOld+0)
;mmbInput_events_code.c,181 :: 		rightButtonOld = rightButton;
	MOV	#lo_addr(_rightButtonOld), W0
	BSET	[W0], BitPos(_rightButtonOld+0)
	BTSS	PORTD, #6
	BCLR	[W0], BitPos(_rightButtonOld+0)
;mmbInput_events_code.c,182 :: 		leftButtonOld = leftButton;
	MOV	#lo_addr(_leftButtonOld), W0
	BSET	[W0], BitPos(_leftButtonOld+0)
	BTSS	PORTD, #9
	BCLR	[W0], BitPos(_leftButtonOld+0)
;mmbInput_events_code.c,184 :: 		triangleButtonOld = triangleButton;
	MOV	#lo_addr(_triangleButtonOld), W0
	BSET	[W0], BitPos(_triangleButtonOld+0)
	BTSS	PORTA, #9
	BCLR	[W0], BitPos(_triangleButtonOld+0)
;mmbInput_events_code.c,185 :: 		xButtonOld = xButton;
	MOV	#lo_addr(_xButtonOld), W0
	BSET	[W0], BitPos(_xButtonOld+0)
	BTSS	PORTA, #10
	BCLR	[W0], BitPos(_xButtonOld+0)
;mmbInput_events_code.c,186 :: 		circleButtonOld = circleButton;
	MOV	#lo_addr(_circleButtonOld), W0
	BSET	[W0], BitPos(_circleButtonOld+0)
	BTSS	PORTF, #0
	BCLR	[W0], BitPos(_circleButtonOld+0)
;mmbInput_events_code.c,187 :: 		squareButtonOld = squareButton;
	MOV	#lo_addr(_squareButtonOld), W0
	BSET	[W0], BitPos(_squareButtonOld+0)
	BTSS	PORTD, #7
	BCLR	[W0], BitPos(_squareButtonOld+0)
;mmbInput_events_code.c,189 :: 		startButtonOld = startButton;
	MOV	#lo_addr(_startButtonOld), W0
	BSET	[W0], BitPos(_startButtonOld+0)
	BTSS	PORTF, #1
	BCLR	[W0], BitPos(_startButtonOld+0)
;mmbInput_events_code.c,192 :: 		}
L_end_Check_GS:
	POP	W11
	POP	W10
	RETURN
; end of _Check_GS

_UpdateStatusLEDButtons:

;mmbInput_events_code.c,196 :: 		void UpdateStatusLEDButtons(){
;mmbInput_events_code.c,198 :: 		Led1Button.Checked = !LED1;
	PUSH	W10
	BCLR	W1, #0
	BTSS	LATA, #12
	BSET	W1, #0
	MOV	#lo_addr(_Led1Button+18), W0
	CLR.B	[W0]
	BTSC	W1, #0
	INC.B	[W0], [W0]
;mmbInput_events_code.c,199 :: 		DrawRadioButton(&Led1Button);
	MOV	#lo_addr(_Led1Button), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,201 :: 		Led2Button.Checked = !LED2;
	BCLR	W1, #0
	BTSS	LATA, #13
	BSET	W1, #0
	MOV	#lo_addr(_Led2Button+18), W0
	CLR.B	[W0]
	BTSC	W1, #0
	INC.B	[W0], [W0]
;mmbInput_events_code.c,202 :: 		DrawRadioButton(&Led2Button);
	MOV	#lo_addr(_Led2Button), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,204 :: 		Led3Button.Checked = !LED3;
	BCLR	W1, #0
	BTSS	LATA, #14
	BSET	W1, #0
	MOV	#lo_addr(_Led3Button+18), W0
	CLR.B	[W0]
	BTSC	W1, #0
	INC.B	[W0], [W0]
;mmbInput_events_code.c,205 :: 		DrawRadioButton(&Led3Button);
	MOV	#lo_addr(_Led3Button), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,207 :: 		Led4Button.Checked = !LED4;
	BCLR	W1, #0
	BTSS	LATA, #15
	BSET	W1, #0
	MOV	#lo_addr(_Led4Button+18), W0
	CLR.B	[W0]
	BTSC	W1, #0
	INC.B	[W0], [W0]
;mmbInput_events_code.c,208 :: 		DrawRadioButton(&Led4Button);
	MOV	#lo_addr(_Led4Button), W10
	CALL	_DrawRadioButton
;mmbInput_events_code.c,210 :: 		}
L_end_UpdateStatusLEDButtons:
	POP	W10
	RETURN
; end of _UpdateStatusLEDButtons

_Led1ButtonOnClick:

;mmbInput_events_code.c,218 :: 		void Led1ButtonOnClick() {
;mmbInput_events_code.c,219 :: 		LED1 = ~LED1;               //Toggle the LED
	BTG	LATA, #12
;mmbInput_events_code.c,220 :: 		UpdateStatusLEDButtons();
	CALL	_UpdateStatusLEDButtons
;mmbInput_events_code.c,221 :: 		}
L_end_Led1ButtonOnClick:
	RETURN
; end of _Led1ButtonOnClick

_Led2ButtonOnClick:

;mmbInput_events_code.c,223 :: 		void Led2ButtonOnClick() {
;mmbInput_events_code.c,224 :: 		LED2 = ~LED2;               //Toggle the LED
	BTG	LATA, #13
;mmbInput_events_code.c,225 :: 		UpdateStatusLEDButtons();
	CALL	_UpdateStatusLEDButtons
;mmbInput_events_code.c,226 :: 		}
L_end_Led2ButtonOnClick:
	RETURN
; end of _Led2ButtonOnClick

_Led3ButtonOnClick:

;mmbInput_events_code.c,228 :: 		void Led3ButtonOnClick() {
;mmbInput_events_code.c,229 :: 		LED3 = ~LED3;               //Toggle the LED
	BTG	LATA, #14
;mmbInput_events_code.c,230 :: 		UpdateStatusLEDButtons();
	CALL	_UpdateStatusLEDButtons
;mmbInput_events_code.c,231 :: 		}
L_end_Led3ButtonOnClick:
	RETURN
; end of _Led3ButtonOnClick

_Led4ButtonOnClick:

;mmbInput_events_code.c,233 :: 		void Led4ButtonOnClick() {
;mmbInput_events_code.c,234 :: 		LED4 = ~LED4;              //Toggle the LED
	BTG	LATA, #15
;mmbInput_events_code.c,235 :: 		UpdateStatusLEDButtons();
	CALL	_UpdateStatusLEDButtons
;mmbInput_events_code.c,236 :: 		}
L_end_Led4ButtonOnClick:
	RETURN
; end of _Led4ButtonOnClick
