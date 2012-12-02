
_Set_Index:

;mmbInput_driver.c,66 :: 		void Set_Index(unsigned short index) {
;mmbInput_driver.c,67 :: 		TFT_RS = 0;
	BCLR	LATB15_bit, #15
;mmbInput_driver.c,68 :: 		Lo(LATA) = index;
	MOV	#lo_addr(LATA), W0
	MOV.B	W10, [W0]
;mmbInput_driver.c,69 :: 		TFT_WR = 0;
	BCLR	LATD13_bit, #13
;mmbInput_driver.c,70 :: 		TFT_WR = 1;
	BSET	LATD13_bit, #13
;mmbInput_driver.c,71 :: 		}
L_end_Set_Index:
	RETURN
; end of _Set_Index

_Write_Command:

;mmbInput_driver.c,74 :: 		void Write_Command(unsigned short cmd) {
;mmbInput_driver.c,75 :: 		TFT_RS = 1;
	BSET	LATB15_bit, #15
;mmbInput_driver.c,76 :: 		Lo(LATA) = cmd;
	MOV	#lo_addr(LATA), W0
	MOV.B	W10, [W0]
;mmbInput_driver.c,77 :: 		TFT_WR = 0;
	BCLR	LATD13_bit, #13
;mmbInput_driver.c,78 :: 		TFT_WR = 1;
	BSET	LATD13_bit, #13
;mmbInput_driver.c,79 :: 		}
L_end_Write_Command:
	RETURN
; end of _Write_Command

_Write_Data:

;mmbInput_driver.c,82 :: 		void Write_Data(unsigned int _data) {
;mmbInput_driver.c,83 :: 		TFT_RS = 1;
	BSET	LATB15_bit, #15
;mmbInput_driver.c,84 :: 		Lo(LATE) = Hi(_data);
	MOV	#lo_addr(W10), W0
	INC	W0
	MOV.B	[W0], W1
	MOV	#lo_addr(LATE), W0
	MOV.B	W1, [W0]
;mmbInput_driver.c,85 :: 		Lo(LATA) = Lo(_data);
	MOV	#lo_addr(LATA), W0
	MOV.B	W10, [W0]
;mmbInput_driver.c,86 :: 		TFT_WR = 0;
	BCLR	LATD13_bit, #13
;mmbInput_driver.c,87 :: 		TFT_WR = 1;
	BSET	LATD13_bit, #13
;mmbInput_driver.c,88 :: 		}
L_end_Write_Data:
	RETURN
; end of _Write_Data

_Init_ADC:

;mmbInput_driver.c,91 :: 		void Init_ADC() {
;mmbInput_driver.c,92 :: 		AD1PCFGL = 0xCFFF;
	MOV	#53247, W0
	MOV	WREG, AD1PCFGL
;mmbInput_driver.c,93 :: 		AD1PCFGH = 0xCFFF;
	MOV	#53247, W0
	MOV	WREG, AD1PCFGH
;mmbInput_driver.c,94 :: 		ADC1_Init();
	CALL	_ADC1_Init
;mmbInput_driver.c,95 :: 		}
L_end_Init_ADC:
	RETURN
; end of _Init_ADC

_TFT_Get_Data:
	LNK	#6

;mmbInput_driver.c,97 :: 		char* TFT_Get_Data(unsigned long offset, unsigned int count, unsigned int *num) {
;mmbInput_driver.c,101 :: 		start_sector = Mmc_Get_File_Write_Sector() + offset/512;
	PUSH	W10
	PUSH	W11
	CALL	_Mmc_Get_File_Write_Sector
	MOV	#9, W4
	MOV.D	W10, W2
L__TFT_Get_Data145:
	DEC	W4, W4
	BRA LT	L__TFT_Get_Data146
	LSR	W3, W3
	RRC	W2, W2
	BRA	L__TFT_Get_Data145
L__TFT_Get_Data146:
	ADD	W0, W2, W2
	ADDC	W1, W3, W3
	MOV	W2, [W14+0]
	MOV	W3, [W14+2]
;mmbInput_driver.c,102 :: 		pos = (unsigned long)offset%512;
	MOV	#511, W0
	MOV	#0, W1
	AND	W10, W0, W0
	AND	W11, W1, W1
	MOV	W0, [W14+4]
;mmbInput_driver.c,104 :: 		if(start_sector == currentSector+1) {
	MOV	_currentSector, W0
	MOV	_currentSector+2, W1
	ADD	W0, #1, W0
	ADDC	W1, #0, W1
	CP	W2, W0
	CPB	W3, W1
	BRA Z	L__TFT_Get_Data147
	GOTO	L_TFT_Get_Data0
L__TFT_Get_Data147:
;mmbInput_driver.c,105 :: 		Mmc_Multi_Read_Sector(f16_sector.fSect);
	PUSH.D	W12
	MOV	#lo_addr(_f16_sector), W10
	CALL	_Mmc_Multi_Read_Sector
	POP.D	W12
;mmbInput_driver.c,106 :: 		currentSector = start_sector;
	MOV	[W14+0], W0
	MOV	[W14+2], W1
	MOV	W0, _currentSector
	MOV	W1, _currentSector+2
;mmbInput_driver.c,107 :: 		} else if (start_sector != currentSector) {
	GOTO	L_TFT_Get_Data1
L_TFT_Get_Data0:
	MOV	[W14+0], W1
	MOV	[W14+2], W2
	MOV	#lo_addr(_currentSector), W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__TFT_Get_Data148
	GOTO	L_TFT_Get_Data2
L__TFT_Get_Data148:
;mmbInput_driver.c,108 :: 		if(currentSector != -1)
	MOV	#65535, W1
	MOV	#65535, W2
	MOV	#lo_addr(_currentSector), W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA NZ	L__TFT_Get_Data149
	GOTO	L_TFT_Get_Data3
L__TFT_Get_Data149:
;mmbInput_driver.c,109 :: 		Mmc_Multi_Read_Stop();
	PUSH.D	W12
	CALL	_Mmc_Multi_Read_Stop
	POP.D	W12
L_TFT_Get_Data3:
;mmbInput_driver.c,110 :: 		Mmc_Multi_Read_Start(start_sector);
	PUSH.D	W12
	MOV	[W14+0], W10
	MOV	[W14+2], W11
	CALL	_Mmc_Multi_Read_Start
;mmbInput_driver.c,111 :: 		Mmc_Multi_Read_Sector(f16_sector.fSect);
	MOV	#lo_addr(_f16_sector), W10
	CALL	_Mmc_Multi_Read_Sector
	POP.D	W12
;mmbInput_driver.c,112 :: 		currentSector = start_sector;
	MOV	[W14+0], W0
	MOV	[W14+2], W1
	MOV	W0, _currentSector
	MOV	W1, _currentSector+2
;mmbInput_driver.c,113 :: 		}
L_TFT_Get_Data2:
L_TFT_Get_Data1:
;mmbInput_driver.c,115 :: 		if(count>512-pos)
	MOV	#512, W1
	ADD	W14, #4, W0
	SUB	W1, [W0], W0
	CP	W12, W0
	BRA GTU	L__TFT_Get_Data150
	GOTO	L_TFT_Get_Data4
L__TFT_Get_Data150:
;mmbInput_driver.c,116 :: 		*num = 512-pos;
	MOV	#512, W1
	ADD	W14, #4, W0
	SUB	W1, [W0], W0
	MOV	W0, [W13]
	GOTO	L_TFT_Get_Data5
L_TFT_Get_Data4:
;mmbInput_driver.c,118 :: 		*num = count;
	MOV	W12, [W13]
L_TFT_Get_Data5:
;mmbInput_driver.c,120 :: 		return f16_sector.fSect+pos;
	MOV	#lo_addr(_f16_sector), W1
	ADD	W14, #4, W0
	ADD	W1, [W0], W0
;mmbInput_driver.c,121 :: 		}
;mmbInput_driver.c,120 :: 		return f16_sector.fSect+pos;
;mmbInput_driver.c,121 :: 		}
L_end_TFT_Get_Data:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _TFT_Get_Data

mmbInput_driver_InitializeTouchPanel:

;mmbInput_driver.c,122 :: 		static void InitializeTouchPanel() {
;mmbInput_driver.c,123 :: 		Init_ADC();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	CALL	_Init_ADC
;mmbInput_driver.c,124 :: 		TFT_Set_Active(Set_Index, Write_Command, Write_Data);
	MOV	#lo_addr(_Write_Data), W12
	MOV	#lo_addr(_Write_Command), W11
	MOV	#lo_addr(_Set_Index), W10
	CALL	_TFT_Set_Active
;mmbInput_driver.c,125 :: 		TFT_Init(320, 240);
	MOV	#240, W11
	MOV	#320, W10
	CALL	_TFT_Init
;mmbInput_driver.c,126 :: 		TFT_Set_Ext_Buffer(TFT_Get_Data);
	MOV	#lo_addr(_TFT_Get_Data), W10
	CALL	_TFT_Set_Ext_Buffer
;mmbInput_driver.c,128 :: 		TP_TFT_Init(320, 240, 13, 12);                                  // Initialize touch panel
	MOV.B	#12, W13
	MOV.B	#13, W12
	MOV	#240, W11
	MOV	#320, W10
	CALL	_TP_TFT_Init
;mmbInput_driver.c,129 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
	MOV	#800, W10
	CALL	_TP_TFT_Set_ADC_Threshold
;mmbInput_driver.c,131 :: 		PenDown = 0;
	MOV	#lo_addr(_PenDown), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,132 :: 		PressedObject = 0;
	CLR	W0
	MOV	W0, _PressedObject
;mmbInput_driver.c,133 :: 		PressedObjectType = -1;
	MOV	#65535, W0
	MOV	W0, _PressedObjectType
;mmbInput_driver.c,134 :: 		}
L_end_InitializeTouchPanel:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of mmbInput_driver_InitializeTouchPanel

mmbInput_driver_InitializeObjects:

;mmbInput_driver.c,220 :: 		static void InitializeObjects() {
;mmbInput_driver.c,221 :: 		Screen1.Color                     = 0x0000;
	CLR	W0
	MOV	W0, _Screen1
;mmbInput_driver.c,222 :: 		Screen1.Width                     = 320;
	MOV	#320, W0
	MOV	W0, _Screen1+2
;mmbInput_driver.c,223 :: 		Screen1.Height                    = 240;
	MOV	#240, W0
	MOV	W0, _Screen1+4
;mmbInput_driver.c,224 :: 		Screen1.ButtonsCount              = 3;
	MOV	#3, W0
	MOV	W0, _Screen1+8
;mmbInput_driver.c,225 :: 		Screen1.Buttons                   = Screen1_Buttons;
	MOV	#lo_addr(_Screen1_Buttons), W0
	MOV	#higher_addr(_Screen1_Buttons), W1
	MOV	W0, _Screen1+10
	MOV	W1, _Screen1+12
;mmbInput_driver.c,226 :: 		Screen1.ImagesCount               = 1;
	MOV	#1, W0
	MOV	W0, _Screen1+14
;mmbInput_driver.c,227 :: 		Screen1.Images                    = Screen1_Images;
	MOV	#lo_addr(_Screen1_Images), W0
	MOV	#higher_addr(_Screen1_Images), W1
	MOV	W0, _Screen1+16
	MOV	W1, _Screen1+18
;mmbInput_driver.c,228 :: 		Screen1.RadioButtonsCount           = 13;
	MOV	#13, W0
	MOV	W0, _Screen1+20
;mmbInput_driver.c,229 :: 		Screen1.RadioButtons                = Screen1_RadioButtons;
	MOV	#lo_addr(_Screen1_RadioButtons), W0
	MOV	#higher_addr(_Screen1_RadioButtons), W1
	MOV	W0, _Screen1+22
	MOV	W1, _Screen1+24
;mmbInput_driver.c,230 :: 		Screen1.ObjectsCount              = 17;
	MOV	#lo_addr(_Screen1+6), W1
	MOV.B	#17, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,233 :: 		Image1.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _Image1
;mmbInput_driver.c,234 :: 		Image1.Order          = 0;
	MOV	#lo_addr(_Image1+2), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,235 :: 		Image1.Left           = 0;
	CLR	W0
	MOV	W0, _Image1+4
;mmbInput_driver.c,236 :: 		Image1.Top            = 0;
	CLR	W0
	MOV	W0, _Image1+6
;mmbInput_driver.c,237 :: 		Image1.Width          = 320;
	MOV	#320, W0
	MOV	W0, _Image1+8
;mmbInput_driver.c,238 :: 		Image1.Height         = 240;
	MOV	#240, W0
	MOV	W0, _Image1+10
;mmbInput_driver.c,239 :: 		Image1.Picture_Type   = 0;
	MOV	#lo_addr(_Image1+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,240 :: 		Image1.Picture_Ratio  = 1;
	MOV	#lo_addr(_Image1+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,241 :: 		Image1.Picture_Name   = carbon_bmp;
	MOV	#9798, W0
	MOV	#0, W1
	MOV	W0, _Image1+12
	MOV	W1, _Image1+14
;mmbInput_driver.c,242 :: 		Image1.Visible        = 1;
	MOV	#lo_addr(_Image1+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,243 :: 		Image1.Active         = 1;
	MOV	#lo_addr(_Image1+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,244 :: 		Image1.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _Image1+20
;mmbInput_driver.c,245 :: 		Image1.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _Image1+22
;mmbInput_driver.c,246 :: 		Image1.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _Image1+24
;mmbInput_driver.c,247 :: 		Image1.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _Image1+26
;mmbInput_driver.c,249 :: 		Led1Button.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _Led1Button
;mmbInput_driver.c,250 :: 		Led1Button.Order           = 1;
	MOV	#lo_addr(_Led1Button+2), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,251 :: 		Led1Button.Left            = 72;
	MOV	#72, W0
	MOV	W0, _Led1Button+4
;mmbInput_driver.c,252 :: 		Led1Button.Top             = 63;
	MOV	#63, W0
	MOV	W0, _Led1Button+6
;mmbInput_driver.c,253 :: 		Led1Button.Width           = 32;
	MOV	#32, W0
	MOV	W0, _Led1Button+8
;mmbInput_driver.c,254 :: 		Led1Button.Height          = 32;
	MOV	#32, W0
	MOV	W0, _Led1Button+10
;mmbInput_driver.c,255 :: 		Led1Button.Pen_Width       = 1;
	MOV	#lo_addr(_Led1Button+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,256 :: 		Led1Button.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _Led1Button+14
;mmbInput_driver.c,257 :: 		Led1Button.Visible         = 1;
	MOV	#lo_addr(_Led1Button+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,258 :: 		Led1Button.Active          = 1;
	MOV	#lo_addr(_Led1Button+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,259 :: 		Led1Button.Checked          = 0;
	MOV	#lo_addr(_Led1Button+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,260 :: 		Led1Button.Transparent     = 1;
	MOV	#lo_addr(_Led1Button+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,261 :: 		Led1Button.Caption         = Led1Button_Caption;
	MOV	#lo_addr(_Led1Button_Caption), W0
	MOV	W0, _Led1Button+20
;mmbInput_driver.c,262 :: 		Led1Button.TextAlign            = _taLeft;
	MOV	#lo_addr(_Led1Button+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,263 :: 		Led1Button.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _Led1Button+24
	MOV	W1, _Led1Button+26
;mmbInput_driver.c,264 :: 		Led1Button.PressColEnabled = 1;
	MOV	#lo_addr(_Led1Button+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,265 :: 		Led1Button.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _Led1Button+28
;mmbInput_driver.c,266 :: 		Led1Button.Gradient        = 1;
	MOV	#lo_addr(_Led1Button+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,267 :: 		Led1Button.Gradient_Orientation    = 1;
	MOV	#lo_addr(_Led1Button+31), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,268 :: 		Led1Button.Gradient_Start_Color    = 0xF800;
	MOV	#63488, W0
	MOV	W0, _Led1Button+32
;mmbInput_driver.c,269 :: 		Led1Button.Gradient_End_Color      = 0xA800;
	MOV	#43008, W0
	MOV	W0, _Led1Button+34
;mmbInput_driver.c,270 :: 		Led1Button.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _Led1Button+36
;mmbInput_driver.c,271 :: 		Led1Button.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _Led1Button+42
;mmbInput_driver.c,272 :: 		Led1Button.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _Led1Button+38
;mmbInput_driver.c,273 :: 		Led1Button.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _Led1Button+44
;mmbInput_driver.c,274 :: 		Led1Button.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _Led1Button+46
;mmbInput_driver.c,275 :: 		Led1Button.OnClickPtr      = Led1ButtonOnClick;
	MOV	#lo_addr(_Led1ButtonOnClick), W0
	MOV	W0, _Led1Button+48
;mmbInput_driver.c,276 :: 		Led1Button.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _Led1Button+50
;mmbInput_driver.c,278 :: 		Led2Button.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _Led2Button
;mmbInput_driver.c,279 :: 		Led2Button.Order           = 2;
	MOV	#lo_addr(_Led2Button+2), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,280 :: 		Led2Button.Left            = 114;
	MOV	#114, W0
	MOV	W0, _Led2Button+4
;mmbInput_driver.c,281 :: 		Led2Button.Top             = 63;
	MOV	#63, W0
	MOV	W0, _Led2Button+6
;mmbInput_driver.c,282 :: 		Led2Button.Width           = 32;
	MOV	#32, W0
	MOV	W0, _Led2Button+8
;mmbInput_driver.c,283 :: 		Led2Button.Height          = 32;
	MOV	#32, W0
	MOV	W0, _Led2Button+10
;mmbInput_driver.c,284 :: 		Led2Button.Pen_Width       = 1;
	MOV	#lo_addr(_Led2Button+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,285 :: 		Led2Button.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _Led2Button+14
;mmbInput_driver.c,286 :: 		Led2Button.Visible         = 1;
	MOV	#lo_addr(_Led2Button+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,287 :: 		Led2Button.Active          = 1;
	MOV	#lo_addr(_Led2Button+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,288 :: 		Led2Button.Checked          = 0;
	MOV	#lo_addr(_Led2Button+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,289 :: 		Led2Button.Transparent     = 1;
	MOV	#lo_addr(_Led2Button+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,290 :: 		Led2Button.Caption         = Led2Button_Caption;
	MOV	#lo_addr(_Led2Button_Caption), W0
	MOV	W0, _Led2Button+20
;mmbInput_driver.c,291 :: 		Led2Button.TextAlign            = _taLeft;
	MOV	#lo_addr(_Led2Button+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,292 :: 		Led2Button.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _Led2Button+24
	MOV	W1, _Led2Button+26
;mmbInput_driver.c,293 :: 		Led2Button.PressColEnabled = 1;
	MOV	#lo_addr(_Led2Button+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,294 :: 		Led2Button.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _Led2Button+28
;mmbInput_driver.c,295 :: 		Led2Button.Gradient        = 1;
	MOV	#lo_addr(_Led2Button+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,296 :: 		Led2Button.Gradient_Orientation    = 1;
	MOV	#lo_addr(_Led2Button+31), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,297 :: 		Led2Button.Gradient_Start_Color    = 0xF800;
	MOV	#63488, W0
	MOV	W0, _Led2Button+32
;mmbInput_driver.c,298 :: 		Led2Button.Gradient_End_Color      = 0xA800;
	MOV	#43008, W0
	MOV	W0, _Led2Button+34
;mmbInput_driver.c,299 :: 		Led2Button.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _Led2Button+36
;mmbInput_driver.c,300 :: 		Led2Button.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _Led2Button+42
;mmbInput_driver.c,301 :: 		Led2Button.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _Led2Button+38
;mmbInput_driver.c,302 :: 		Led2Button.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _Led2Button+44
;mmbInput_driver.c,303 :: 		Led2Button.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _Led2Button+46
;mmbInput_driver.c,304 :: 		Led2Button.OnClickPtr      = Led2ButtonOnClick;
	MOV	#lo_addr(_Led2ButtonOnClick), W0
	MOV	W0, _Led2Button+48
;mmbInput_driver.c,305 :: 		Led2Button.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _Led2Button+50
;mmbInput_driver.c,307 :: 		Led3Button.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _Led3Button
;mmbInput_driver.c,308 :: 		Led3Button.Order           = 3;
	MOV	#lo_addr(_Led3Button+2), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,309 :: 		Led3Button.Left            = 156;
	MOV	#156, W0
	MOV	W0, _Led3Button+4
;mmbInput_driver.c,310 :: 		Led3Button.Top             = 63;
	MOV	#63, W0
	MOV	W0, _Led3Button+6
;mmbInput_driver.c,311 :: 		Led3Button.Width           = 32;
	MOV	#32, W0
	MOV	W0, _Led3Button+8
;mmbInput_driver.c,312 :: 		Led3Button.Height          = 32;
	MOV	#32, W0
	MOV	W0, _Led3Button+10
;mmbInput_driver.c,313 :: 		Led3Button.Pen_Width       = 1;
	MOV	#lo_addr(_Led3Button+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,314 :: 		Led3Button.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _Led3Button+14
;mmbInput_driver.c,315 :: 		Led3Button.Visible         = 1;
	MOV	#lo_addr(_Led3Button+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,316 :: 		Led3Button.Active          = 1;
	MOV	#lo_addr(_Led3Button+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,317 :: 		Led3Button.Checked          = 0;
	MOV	#lo_addr(_Led3Button+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,318 :: 		Led3Button.Transparent     = 1;
	MOV	#lo_addr(_Led3Button+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,319 :: 		Led3Button.Caption         = Led3Button_Caption;
	MOV	#lo_addr(_Led3Button_Caption), W0
	MOV	W0, _Led3Button+20
;mmbInput_driver.c,320 :: 		Led3Button.TextAlign            = _taLeft;
	MOV	#lo_addr(_Led3Button+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,321 :: 		Led3Button.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _Led3Button+24
	MOV	W1, _Led3Button+26
;mmbInput_driver.c,322 :: 		Led3Button.PressColEnabled = 1;
	MOV	#lo_addr(_Led3Button+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,323 :: 		Led3Button.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _Led3Button+28
;mmbInput_driver.c,324 :: 		Led3Button.Gradient        = 1;
	MOV	#lo_addr(_Led3Button+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,325 :: 		Led3Button.Gradient_Orientation    = 1;
	MOV	#lo_addr(_Led3Button+31), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,326 :: 		Led3Button.Gradient_Start_Color    = 0xF800;
	MOV	#63488, W0
	MOV	W0, _Led3Button+32
;mmbInput_driver.c,327 :: 		Led3Button.Gradient_End_Color      = 0xA800;
	MOV	#43008, W0
	MOV	W0, _Led3Button+34
;mmbInput_driver.c,328 :: 		Led3Button.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _Led3Button+36
;mmbInput_driver.c,329 :: 		Led3Button.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _Led3Button+42
;mmbInput_driver.c,330 :: 		Led3Button.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _Led3Button+38
;mmbInput_driver.c,331 :: 		Led3Button.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _Led3Button+44
;mmbInput_driver.c,332 :: 		Led3Button.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _Led3Button+46
;mmbInput_driver.c,333 :: 		Led3Button.OnClickPtr      = Led3ButtonOnClick;
	MOV	#lo_addr(_Led3ButtonOnClick), W0
	MOV	W0, _Led3Button+48
;mmbInput_driver.c,334 :: 		Led3Button.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _Led3Button+50
;mmbInput_driver.c,336 :: 		Led4Button.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _Led4Button
;mmbInput_driver.c,337 :: 		Led4Button.Order           = 4;
	MOV	#lo_addr(_Led4Button+2), W1
	MOV.B	#4, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,338 :: 		Led4Button.Left            = 198;
	MOV	#198, W0
	MOV	W0, _Led4Button+4
;mmbInput_driver.c,339 :: 		Led4Button.Top             = 63;
	MOV	#63, W0
	MOV	W0, _Led4Button+6
;mmbInput_driver.c,340 :: 		Led4Button.Width           = 32;
	MOV	#32, W0
	MOV	W0, _Led4Button+8
;mmbInput_driver.c,341 :: 		Led4Button.Height          = 32;
	MOV	#32, W0
	MOV	W0, _Led4Button+10
;mmbInput_driver.c,342 :: 		Led4Button.Pen_Width       = 1;
	MOV	#lo_addr(_Led4Button+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,343 :: 		Led4Button.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _Led4Button+14
;mmbInput_driver.c,344 :: 		Led4Button.Visible         = 1;
	MOV	#lo_addr(_Led4Button+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,345 :: 		Led4Button.Active          = 1;
	MOV	#lo_addr(_Led4Button+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,346 :: 		Led4Button.Checked          = 0;
	MOV	#lo_addr(_Led4Button+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,347 :: 		Led4Button.Transparent     = 1;
	MOV	#lo_addr(_Led4Button+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,348 :: 		Led4Button.Caption         = Led4Button_Caption;
	MOV	#lo_addr(_Led4Button_Caption), W0
	MOV	W0, _Led4Button+20
;mmbInput_driver.c,349 :: 		Led4Button.TextAlign            = _taLeft;
	MOV	#lo_addr(_Led4Button+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,350 :: 		Led4Button.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _Led4Button+24
	MOV	W1, _Led4Button+26
;mmbInput_driver.c,351 :: 		Led4Button.PressColEnabled = 1;
	MOV	#lo_addr(_Led4Button+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,352 :: 		Led4Button.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _Led4Button+28
;mmbInput_driver.c,353 :: 		Led4Button.Gradient        = 1;
	MOV	#lo_addr(_Led4Button+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,354 :: 		Led4Button.Gradient_Orientation    = 1;
	MOV	#lo_addr(_Led4Button+31), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,355 :: 		Led4Button.Gradient_Start_Color    = 0xF800;
	MOV	#63488, W0
	MOV	W0, _Led4Button+32
;mmbInput_driver.c,356 :: 		Led4Button.Gradient_End_Color      = 0xA800;
	MOV	#43008, W0
	MOV	W0, _Led4Button+34
;mmbInput_driver.c,357 :: 		Led4Button.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _Led4Button+36
;mmbInput_driver.c,358 :: 		Led4Button.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _Led4Button+42
;mmbInput_driver.c,359 :: 		Led4Button.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _Led4Button+38
;mmbInput_driver.c,360 :: 		Led4Button.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _Led4Button+44
;mmbInput_driver.c,361 :: 		Led4Button.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _Led4Button+46
;mmbInput_driver.c,362 :: 		Led4Button.OnClickPtr      = Led4ButtonOnClick;
	MOV	#lo_addr(_Led4ButtonOnClick), W0
	MOV	W0, _Led4Button+48
;mmbInput_driver.c,363 :: 		Led4Button.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _Led4Button+50
;mmbInput_driver.c,365 :: 		left.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _left
;mmbInput_driver.c,366 :: 		left.Order           = 5;
	MOV	#lo_addr(_left+2), W1
	MOV.B	#5, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,367 :: 		left.Left            = 23;
	MOV	#23, W0
	MOV	W0, _left+4
;mmbInput_driver.c,368 :: 		left.Top             = 141;
	MOV	#141, W0
	MOV	W0, _left+6
;mmbInput_driver.c,369 :: 		left.Width           = 59;
	MOV	#59, W0
	MOV	W0, _left+8
;mmbInput_driver.c,370 :: 		left.Height          = 32;
	MOV	#32, W0
	MOV	W0, _left+10
;mmbInput_driver.c,371 :: 		left.Pen_Width       = 1;
	MOV	#lo_addr(_left+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,372 :: 		left.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _left+14
;mmbInput_driver.c,373 :: 		left.Visible         = 1;
	MOV	#lo_addr(_left+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,374 :: 		left.Active          = 1;
	MOV	#lo_addr(_left+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,375 :: 		left.Checked          = 0;
	MOV	#lo_addr(_left+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,376 :: 		left.Transparent     = 1;
	MOV	#lo_addr(_left+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,377 :: 		left.Caption         = left_Caption;
	MOV	#lo_addr(_left_Caption), W0
	MOV	W0, _left+20
;mmbInput_driver.c,378 :: 		left.TextAlign            = _taLeft;
	MOV	#lo_addr(_left+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,379 :: 		left.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _left+24
	MOV	W1, _left+26
;mmbInput_driver.c,380 :: 		left.PressColEnabled = 1;
	MOV	#lo_addr(_left+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,381 :: 		left.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _left+28
;mmbInput_driver.c,382 :: 		left.Gradient        = 1;
	MOV	#lo_addr(_left+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,383 :: 		left.Gradient_Orientation    = 0;
	MOV	#lo_addr(_left+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,384 :: 		left.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _left+32
;mmbInput_driver.c,385 :: 		left.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _left+34
;mmbInput_driver.c,386 :: 		left.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _left+36
;mmbInput_driver.c,387 :: 		left.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _left+42
;mmbInput_driver.c,388 :: 		left.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _left+38
;mmbInput_driver.c,389 :: 		left.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _left+44
;mmbInput_driver.c,390 :: 		left.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _left+46
;mmbInput_driver.c,391 :: 		left.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _left+48
;mmbInput_driver.c,392 :: 		left.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _left+50
;mmbInput_driver.c,394 :: 		right.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _right
;mmbInput_driver.c,395 :: 		right.Order           = 6;
	MOV	#lo_addr(_right+2), W1
	MOV.B	#6, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,396 :: 		right.Left            = 91;
	MOV	#91, W0
	MOV	W0, _right+4
;mmbInput_driver.c,397 :: 		right.Top             = 141;
	MOV	#141, W0
	MOV	W0, _right+6
;mmbInput_driver.c,398 :: 		right.Width           = 69;
	MOV	#69, W0
	MOV	W0, _right+8
;mmbInput_driver.c,399 :: 		right.Height          = 32;
	MOV	#32, W0
	MOV	W0, _right+10
;mmbInput_driver.c,400 :: 		right.Pen_Width       = 1;
	MOV	#lo_addr(_right+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,401 :: 		right.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _right+14
;mmbInput_driver.c,402 :: 		right.Visible         = 1;
	MOV	#lo_addr(_right+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,403 :: 		right.Active          = 1;
	MOV	#lo_addr(_right+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,404 :: 		right.Checked          = 0;
	MOV	#lo_addr(_right+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,405 :: 		right.Transparent     = 1;
	MOV	#lo_addr(_right+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,406 :: 		right.Caption         = right_Caption;
	MOV	#lo_addr(_right_Caption), W0
	MOV	W0, _right+20
;mmbInput_driver.c,407 :: 		right.TextAlign            = _taLeft;
	MOV	#lo_addr(_right+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,408 :: 		right.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _right+24
	MOV	W1, _right+26
;mmbInput_driver.c,409 :: 		right.PressColEnabled = 1;
	MOV	#lo_addr(_right+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,410 :: 		right.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _right+28
;mmbInput_driver.c,411 :: 		right.Gradient        = 1;
	MOV	#lo_addr(_right+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,412 :: 		right.Gradient_Orientation    = 0;
	MOV	#lo_addr(_right+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,413 :: 		right.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _right+32
;mmbInput_driver.c,414 :: 		right.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _right+34
;mmbInput_driver.c,415 :: 		right.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _right+36
;mmbInput_driver.c,416 :: 		right.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _right+42
;mmbInput_driver.c,417 :: 		right.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _right+38
;mmbInput_driver.c,418 :: 		right.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _right+44
;mmbInput_driver.c,419 :: 		right.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _right+46
;mmbInput_driver.c,420 :: 		right.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _right+48
;mmbInput_driver.c,421 :: 		right.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _right+50
;mmbInput_driver.c,423 :: 		up.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _up
;mmbInput_driver.c,424 :: 		up.Order           = 7;
	MOV	#lo_addr(_up+2), W1
	MOV.B	#7, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,425 :: 		up.Left            = 58;
	MOV	#58, W0
	MOV	W0, _up+4
;mmbInput_driver.c,426 :: 		up.Top             = 109;
	MOV	#109, W0
	MOV	W0, _up+6
;mmbInput_driver.c,427 :: 		up.Width           = 54;
	MOV	#54, W0
	MOV	W0, _up+8
;mmbInput_driver.c,428 :: 		up.Height          = 32;
	MOV	#32, W0
	MOV	W0, _up+10
;mmbInput_driver.c,429 :: 		up.Pen_Width       = 1;
	MOV	#lo_addr(_up+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,430 :: 		up.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _up+14
;mmbInput_driver.c,431 :: 		up.Visible         = 1;
	MOV	#lo_addr(_up+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,432 :: 		up.Active          = 1;
	MOV	#lo_addr(_up+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,433 :: 		up.Checked          = 0;
	MOV	#lo_addr(_up+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,434 :: 		up.Transparent     = 1;
	MOV	#lo_addr(_up+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,435 :: 		up.Caption         = up_Caption;
	MOV	#lo_addr(_up_Caption), W0
	MOV	W0, _up+20
;mmbInput_driver.c,436 :: 		up.TextAlign            = _taLeft;
	MOV	#lo_addr(_up+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,437 :: 		up.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _up+24
	MOV	W1, _up+26
;mmbInput_driver.c,438 :: 		up.PressColEnabled = 1;
	MOV	#lo_addr(_up+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,439 :: 		up.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _up+28
;mmbInput_driver.c,440 :: 		up.Gradient        = 1;
	MOV	#lo_addr(_up+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,441 :: 		up.Gradient_Orientation    = 0;
	MOV	#lo_addr(_up+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,442 :: 		up.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _up+32
;mmbInput_driver.c,443 :: 		up.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _up+34
;mmbInput_driver.c,444 :: 		up.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _up+36
;mmbInput_driver.c,445 :: 		up.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _up+42
;mmbInput_driver.c,446 :: 		up.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _up+38
;mmbInput_driver.c,447 :: 		up.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _up+44
;mmbInput_driver.c,448 :: 		up.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _up+46
;mmbInput_driver.c,449 :: 		up.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _up+48
;mmbInput_driver.c,450 :: 		up.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _up+50
;mmbInput_driver.c,452 :: 		down.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _down
;mmbInput_driver.c,453 :: 		down.Order           = 8;
	MOV	#lo_addr(_down+2), W1
	MOV.B	#8, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,454 :: 		down.Left            = 58;
	MOV	#58, W0
	MOV	W0, _down+4
;mmbInput_driver.c,455 :: 		down.Top             = 173;
	MOV	#173, W0
	MOV	W0, _down+6
;mmbInput_driver.c,456 :: 		down.Width           = 71;
	MOV	#71, W0
	MOV	W0, _down+8
;mmbInput_driver.c,457 :: 		down.Height          = 32;
	MOV	#32, W0
	MOV	W0, _down+10
;mmbInput_driver.c,458 :: 		down.Pen_Width       = 1;
	MOV	#lo_addr(_down+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,459 :: 		down.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _down+14
;mmbInput_driver.c,460 :: 		down.Visible         = 1;
	MOV	#lo_addr(_down+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,461 :: 		down.Active          = 1;
	MOV	#lo_addr(_down+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,462 :: 		down.Checked          = 0;
	MOV	#lo_addr(_down+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,463 :: 		down.Transparent     = 1;
	MOV	#lo_addr(_down+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,464 :: 		down.Caption         = down_Caption;
	MOV	#lo_addr(_down_Caption), W0
	MOV	W0, _down+20
;mmbInput_driver.c,465 :: 		down.TextAlign            = _taLeft;
	MOV	#lo_addr(_down+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,466 :: 		down.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _down+24
	MOV	W1, _down+26
;mmbInput_driver.c,467 :: 		down.PressColEnabled = 1;
	MOV	#lo_addr(_down+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,468 :: 		down.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _down+28
;mmbInput_driver.c,469 :: 		down.Gradient        = 1;
	MOV	#lo_addr(_down+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,470 :: 		down.Gradient_Orientation    = 0;
	MOV	#lo_addr(_down+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,471 :: 		down.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _down+32
;mmbInput_driver.c,472 :: 		down.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _down+34
;mmbInput_driver.c,473 :: 		down.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _down+36
;mmbInput_driver.c,474 :: 		down.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _down+42
;mmbInput_driver.c,475 :: 		down.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _down+38
;mmbInput_driver.c,476 :: 		down.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _down+44
;mmbInput_driver.c,477 :: 		down.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _down+46
;mmbInput_driver.c,478 :: 		down.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _down+48
;mmbInput_driver.c,479 :: 		down.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _down+50
;mmbInput_driver.c,481 :: 		square.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _square
;mmbInput_driver.c,482 :: 		square.Order           = 9;
	MOV	#lo_addr(_square+2), W1
	MOV.B	#9, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,483 :: 		square.Left            = 184;
	MOV	#184, W0
	MOV	W0, _square+4
;mmbInput_driver.c,484 :: 		square.Top             = 140;
	MOV	#140, W0
	MOV	W0, _square+6
;mmbInput_driver.c,485 :: 		square.Width           = 58;
	MOV	#58, W0
	MOV	W0, _square+8
;mmbInput_driver.c,486 :: 		square.Height          = 32;
	MOV	#32, W0
	MOV	W0, _square+10
;mmbInput_driver.c,487 :: 		square.Pen_Width       = 1;
	MOV	#lo_addr(_square+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,488 :: 		square.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _square+14
;mmbInput_driver.c,489 :: 		square.Visible         = 1;
	MOV	#lo_addr(_square+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,490 :: 		square.Active          = 1;
	MOV	#lo_addr(_square+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,491 :: 		square.Checked          = 0;
	MOV	#lo_addr(_square+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,492 :: 		square.Transparent     = 1;
	MOV	#lo_addr(_square+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,493 :: 		square.Caption         = square_Caption;
	MOV	#lo_addr(_square_Caption), W0
	MOV	W0, _square+20
;mmbInput_driver.c,494 :: 		square.TextAlign            = _taLeft;
	MOV	#lo_addr(_square+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,495 :: 		square.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _square+24
	MOV	W1, _square+26
;mmbInput_driver.c,496 :: 		square.PressColEnabled = 1;
	MOV	#lo_addr(_square+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,497 :: 		square.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _square+28
;mmbInput_driver.c,498 :: 		square.Gradient        = 1;
	MOV	#lo_addr(_square+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,499 :: 		square.Gradient_Orientation    = 0;
	MOV	#lo_addr(_square+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,500 :: 		square.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _square+32
;mmbInput_driver.c,501 :: 		square.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _square+34
;mmbInput_driver.c,502 :: 		square.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _square+36
;mmbInput_driver.c,503 :: 		square.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _square+42
;mmbInput_driver.c,504 :: 		square.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _square+38
;mmbInput_driver.c,505 :: 		square.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _square+44
;mmbInput_driver.c,506 :: 		square.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _square+46
;mmbInput_driver.c,507 :: 		square.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _square+48
;mmbInput_driver.c,508 :: 		square.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _square+50
;mmbInput_driver.c,510 :: 		circle.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _circle
;mmbInput_driver.c,511 :: 		circle.Order           = 10;
	MOV	#lo_addr(_circle+2), W1
	MOV.B	#10, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,512 :: 		circle.Left            = 252;
	MOV	#252, W0
	MOV	W0, _circle+4
;mmbInput_driver.c,513 :: 		circle.Top             = 140;
	MOV	#140, W0
	MOV	W0, _circle+6
;mmbInput_driver.c,514 :: 		circle.Width           = 61;
	MOV	#61, W0
	MOV	W0, _circle+8
;mmbInput_driver.c,515 :: 		circle.Height          = 32;
	MOV	#32, W0
	MOV	W0, _circle+10
;mmbInput_driver.c,516 :: 		circle.Pen_Width       = 1;
	MOV	#lo_addr(_circle+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,517 :: 		circle.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _circle+14
;mmbInput_driver.c,518 :: 		circle.Visible         = 1;
	MOV	#lo_addr(_circle+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,519 :: 		circle.Active          = 1;
	MOV	#lo_addr(_circle+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,520 :: 		circle.Checked          = 0;
	MOV	#lo_addr(_circle+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,521 :: 		circle.Transparent     = 1;
	MOV	#lo_addr(_circle+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,522 :: 		circle.Caption         = circle_Caption;
	MOV	#lo_addr(_circle_Caption), W0
	MOV	W0, _circle+20
;mmbInput_driver.c,523 :: 		circle.TextAlign            = _taLeft;
	MOV	#lo_addr(_circle+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,524 :: 		circle.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _circle+24
	MOV	W1, _circle+26
;mmbInput_driver.c,525 :: 		circle.PressColEnabled = 1;
	MOV	#lo_addr(_circle+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,526 :: 		circle.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _circle+28
;mmbInput_driver.c,527 :: 		circle.Gradient        = 1;
	MOV	#lo_addr(_circle+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,528 :: 		circle.Gradient_Orientation    = 0;
	MOV	#lo_addr(_circle+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,529 :: 		circle.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _circle+32
;mmbInput_driver.c,530 :: 		circle.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _circle+34
;mmbInput_driver.c,531 :: 		circle.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _circle+36
;mmbInput_driver.c,532 :: 		circle.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _circle+42
;mmbInput_driver.c,533 :: 		circle.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _circle+38
;mmbInput_driver.c,534 :: 		circle.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _circle+44
;mmbInput_driver.c,535 :: 		circle.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _circle+46
;mmbInput_driver.c,536 :: 		circle.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _circle+48
;mmbInput_driver.c,537 :: 		circle.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _circle+50
;mmbInput_driver.c,539 :: 		triangle.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _triangle
;mmbInput_driver.c,540 :: 		triangle.Order           = 11;
	MOV	#lo_addr(_triangle+2), W1
	MOV.B	#11, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,541 :: 		triangle.Left            = 219;
	MOV	#219, W0
	MOV	W0, _triangle+4
;mmbInput_driver.c,542 :: 		triangle.Top             = 108;
	MOV	#108, W0
	MOV	W0, _triangle+6
;mmbInput_driver.c,543 :: 		triangle.Width           = 52;
	MOV	#52, W0
	MOV	W0, _triangle+8
;mmbInput_driver.c,544 :: 		triangle.Height          = 32;
	MOV	#32, W0
	MOV	W0, _triangle+10
;mmbInput_driver.c,545 :: 		triangle.Pen_Width       = 1;
	MOV	#lo_addr(_triangle+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,546 :: 		triangle.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _triangle+14
;mmbInput_driver.c,547 :: 		triangle.Visible         = 1;
	MOV	#lo_addr(_triangle+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,548 :: 		triangle.Active          = 1;
	MOV	#lo_addr(_triangle+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,549 :: 		triangle.Checked          = 0;
	MOV	#lo_addr(_triangle+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,550 :: 		triangle.Transparent     = 1;
	MOV	#lo_addr(_triangle+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,551 :: 		triangle.Caption         = triangle_Caption;
	MOV	#lo_addr(_triangle_Caption), W0
	MOV	W0, _triangle+20
;mmbInput_driver.c,552 :: 		triangle.TextAlign            = _taLeft;
	MOV	#lo_addr(_triangle+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,553 :: 		triangle.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _triangle+24
	MOV	W1, _triangle+26
;mmbInput_driver.c,554 :: 		triangle.PressColEnabled = 1;
	MOV	#lo_addr(_triangle+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,555 :: 		triangle.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _triangle+28
;mmbInput_driver.c,556 :: 		triangle.Gradient        = 1;
	MOV	#lo_addr(_triangle+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,557 :: 		triangle.Gradient_Orientation    = 0;
	MOV	#lo_addr(_triangle+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,558 :: 		triangle.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _triangle+32
;mmbInput_driver.c,559 :: 		triangle.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _triangle+34
;mmbInput_driver.c,560 :: 		triangle.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _triangle+36
;mmbInput_driver.c,561 :: 		triangle.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _triangle+42
;mmbInput_driver.c,562 :: 		triangle.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _triangle+38
;mmbInput_driver.c,563 :: 		triangle.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _triangle+44
;mmbInput_driver.c,564 :: 		triangle.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _triangle+46
;mmbInput_driver.c,565 :: 		triangle.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _triangle+48
;mmbInput_driver.c,566 :: 		triangle.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _triangle+50
;mmbInput_driver.c,568 :: 		x.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _x
;mmbInput_driver.c,569 :: 		x.Order           = 12;
	MOV	#lo_addr(_x+2), W1
	MOV.B	#12, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,570 :: 		x.Left            = 219;
	MOV	#219, W0
	MOV	W0, _x+4
;mmbInput_driver.c,571 :: 		x.Top             = 172;
	MOV	#172, W0
	MOV	W0, _x+6
;mmbInput_driver.c,572 :: 		x.Width           = 45;
	MOV	#45, W0
	MOV	W0, _x+8
;mmbInput_driver.c,573 :: 		x.Height          = 32;
	MOV	#32, W0
	MOV	W0, _x+10
;mmbInput_driver.c,574 :: 		x.Pen_Width       = 1;
	MOV	#lo_addr(_x+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,575 :: 		x.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _x+14
;mmbInput_driver.c,576 :: 		x.Visible         = 1;
	MOV	#lo_addr(_x+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,577 :: 		x.Active          = 1;
	MOV	#lo_addr(_x+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,578 :: 		x.Checked          = 0;
	MOV	#lo_addr(_x+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,579 :: 		x.Transparent     = 1;
	MOV	#lo_addr(_x+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,580 :: 		x.Caption         = x_Caption;
	MOV	#lo_addr(_x_Caption), W0
	MOV	W0, _x+20
;mmbInput_driver.c,581 :: 		x.TextAlign            = _taLeft;
	MOV	#lo_addr(_x+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,582 :: 		x.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _x+24
	MOV	W1, _x+26
;mmbInput_driver.c,583 :: 		x.PressColEnabled = 1;
	MOV	#lo_addr(_x+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,584 :: 		x.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _x+28
;mmbInput_driver.c,585 :: 		x.Gradient        = 1;
	MOV	#lo_addr(_x+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,586 :: 		x.Gradient_Orientation    = 0;
	MOV	#lo_addr(_x+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,587 :: 		x.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _x+32
;mmbInput_driver.c,588 :: 		x.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _x+34
;mmbInput_driver.c,589 :: 		x.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _x+36
;mmbInput_driver.c,590 :: 		x.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _x+42
;mmbInput_driver.c,591 :: 		x.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _x+38
;mmbInput_driver.c,592 :: 		x.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _x+44
;mmbInput_driver.c,593 :: 		x.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _x+46
;mmbInput_driver.c,594 :: 		x.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _x+48
;mmbInput_driver.c,595 :: 		x.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _x+50
;mmbInput_driver.c,597 :: 		start.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _start
;mmbInput_driver.c,598 :: 		start.Order           = 13;
	MOV	#lo_addr(_start+2), W1
	MOV.B	#13, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,599 :: 		start.Left            = 136;
	MOV	#136, W0
	MOV	W0, _start+4
;mmbInput_driver.c,600 :: 		start.Top             = 204;
	MOV	#204, W0
	MOV	W0, _start+6
;mmbInput_driver.c,601 :: 		start.Width           = 66;
	MOV	#66, W0
	MOV	W0, _start+8
;mmbInput_driver.c,602 :: 		start.Height          = 32;
	MOV	#32, W0
	MOV	W0, _start+10
;mmbInput_driver.c,603 :: 		start.Pen_Width       = 1;
	MOV	#lo_addr(_start+12), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,604 :: 		start.Pen_Color       = 0x0000;
	CLR	W0
	MOV	W0, _start+14
;mmbInput_driver.c,605 :: 		start.Visible         = 1;
	MOV	#lo_addr(_start+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,606 :: 		start.Active          = 1;
	MOV	#lo_addr(_start+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,607 :: 		start.Checked          = 0;
	MOV	#lo_addr(_start+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,608 :: 		start.Transparent     = 1;
	MOV	#lo_addr(_start+19), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,609 :: 		start.Caption         = start_Caption;
	MOV	#lo_addr(_start_Caption), W0
	MOV	W0, _start+20
;mmbInput_driver.c,610 :: 		start.TextAlign            = _taLeft;
	MOV	#lo_addr(_start+22), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,611 :: 		start.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _start+24
	MOV	W1, _start+26
;mmbInput_driver.c,612 :: 		start.PressColEnabled = 1;
	MOV	#lo_addr(_start+40), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,613 :: 		start.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _start+28
;mmbInput_driver.c,614 :: 		start.Gradient        = 1;
	MOV	#lo_addr(_start+30), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,615 :: 		start.Gradient_Orientation    = 0;
	MOV	#lo_addr(_start+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,616 :: 		start.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _start+32
;mmbInput_driver.c,617 :: 		start.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _start+34
;mmbInput_driver.c,618 :: 		start.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _start+36
;mmbInput_driver.c,619 :: 		start.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _start+42
;mmbInput_driver.c,620 :: 		start.Background_Color = 0x8410;
	MOV	#33808, W0
	MOV	W0, _start+38
;mmbInput_driver.c,621 :: 		start.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _start+44
;mmbInput_driver.c,622 :: 		start.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _start+46
;mmbInput_driver.c,623 :: 		start.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _start+48
;mmbInput_driver.c,624 :: 		start.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _start+50
;mmbInput_driver.c,626 :: 		StatusLEDsText.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _StatusLEDsText
;mmbInput_driver.c,627 :: 		StatusLEDsText.Order           = 14;
	MOV	#lo_addr(_StatusLEDsText+2), W1
	MOV.B	#14, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,628 :: 		StatusLEDsText.Left            = 104;
	MOV	#104, W0
	MOV	W0, _StatusLEDsText+4
;mmbInput_driver.c,629 :: 		StatusLEDsText.Top             = 44;
	MOV	#44, W0
	MOV	W0, _StatusLEDsText+6
;mmbInput_driver.c,630 :: 		StatusLEDsText.Width           = 93;
	MOV	#93, W0
	MOV	W0, _StatusLEDsText+8
;mmbInput_driver.c,631 :: 		StatusLEDsText.Height          = 19;
	MOV	#19, W0
	MOV	W0, _StatusLEDsText+10
;mmbInput_driver.c,632 :: 		StatusLEDsText.Pen_Width       = 0;
	MOV	#lo_addr(_StatusLEDsText+12), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,633 :: 		StatusLEDsText.Pen_Color       = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _StatusLEDsText+14
;mmbInput_driver.c,634 :: 		StatusLEDsText.Visible         = 1;
	MOV	#lo_addr(_StatusLEDsText+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,635 :: 		StatusLEDsText.Active          = 1;
	MOV	#lo_addr(_StatusLEDsText+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,636 :: 		StatusLEDsText.Transparent     = 0;
	MOV	#lo_addr(_StatusLEDsText+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,637 :: 		StatusLEDsText.Caption         = StatusLEDsText_Caption;
	MOV	#lo_addr(_StatusLEDsText_Caption), W0
	MOV	W0, _StatusLEDsText+20
;mmbInput_driver.c,638 :: 		StatusLEDsText.TextAlign             = _taCenter;
	MOV	#lo_addr(_StatusLEDsText+22), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,639 :: 		StatusLEDsText.FontName        = DejaVu_Sans_Mono13x16_Bold;
	MOV	#114, W0
	MOV	#0, W1
	MOV	W0, _StatusLEDsText+24
	MOV	W1, _StatusLEDsText+26
;mmbInput_driver.c,640 :: 		StatusLEDsText.PressColEnabled = 1;
	MOV	#lo_addr(_StatusLEDsText+38), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,641 :: 		StatusLEDsText.Font_Color      = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _StatusLEDsText+28
;mmbInput_driver.c,642 :: 		StatusLEDsText.Gradient        = 0;
	MOV	#lo_addr(_StatusLEDsText+30), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,643 :: 		StatusLEDsText.Gradient_Orientation    = 0;
	MOV	#lo_addr(_StatusLEDsText+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,644 :: 		StatusLEDsText.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _StatusLEDsText+32
;mmbInput_driver.c,645 :: 		StatusLEDsText.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _StatusLEDsText+34
;mmbInput_driver.c,646 :: 		StatusLEDsText.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _StatusLEDsText+36
;mmbInput_driver.c,647 :: 		StatusLEDsText.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _StatusLEDsText+40
;mmbInput_driver.c,648 :: 		StatusLEDsText.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _StatusLEDsText+42
;mmbInput_driver.c,649 :: 		StatusLEDsText.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _StatusLEDsText+44
;mmbInput_driver.c,650 :: 		StatusLEDsText.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _StatusLEDsText+46
;mmbInput_driver.c,651 :: 		StatusLEDsText.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _StatusLEDsText+48
;mmbInput_driver.c,653 :: 		ProgramCaption.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _ProgramCaption
;mmbInput_driver.c,654 :: 		ProgramCaption.Order           = 15;
	MOV	#lo_addr(_ProgramCaption+2), W1
	MOV.B	#15, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,655 :: 		ProgramCaption.Left            = 13;
	MOV	#13, W0
	MOV	W0, _ProgramCaption+4
;mmbInput_driver.c,656 :: 		ProgramCaption.Top             = 1;
	MOV	#1, W0
	MOV	W0, _ProgramCaption+6
;mmbInput_driver.c,657 :: 		ProgramCaption.Width           = 292;
	MOV	#292, W0
	MOV	W0, _ProgramCaption+8
;mmbInput_driver.c,658 :: 		ProgramCaption.Height          = 47;
	MOV	#47, W0
	MOV	W0, _ProgramCaption+10
;mmbInput_driver.c,659 :: 		ProgramCaption.Pen_Width       = 0;
	MOV	#lo_addr(_ProgramCaption+12), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,660 :: 		ProgramCaption.Pen_Color       = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _ProgramCaption+14
;mmbInput_driver.c,661 :: 		ProgramCaption.Visible         = 1;
	MOV	#lo_addr(_ProgramCaption+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,662 :: 		ProgramCaption.Active          = 1;
	MOV	#lo_addr(_ProgramCaption+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,663 :: 		ProgramCaption.Transparent     = 0;
	MOV	#lo_addr(_ProgramCaption+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,664 :: 		ProgramCaption.Caption         = ProgramCaption_Caption;
	MOV	#lo_addr(_ProgramCaption_Caption), W0
	MOV	W0, _ProgramCaption+20
;mmbInput_driver.c,665 :: 		ProgramCaption.TextAlign             = _taCenter;
	MOV	#lo_addr(_ProgramCaption+22), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,666 :: 		ProgramCaption.FontName        = DejaVu_Sans_Mono28x34_Bold;
	MOV	#2266, W0
	MOV	#0, W1
	MOV	W0, _ProgramCaption+24
	MOV	W1, _ProgramCaption+26
;mmbInput_driver.c,667 :: 		ProgramCaption.PressColEnabled = 1;
	MOV	#lo_addr(_ProgramCaption+38), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,668 :: 		ProgramCaption.Font_Color      = 0xF800;
	MOV	#63488, W0
	MOV	W0, _ProgramCaption+28
;mmbInput_driver.c,669 :: 		ProgramCaption.Gradient        = 0;
	MOV	#lo_addr(_ProgramCaption+30), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,670 :: 		ProgramCaption.Gradient_Orientation    = 0;
	MOV	#lo_addr(_ProgramCaption+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,671 :: 		ProgramCaption.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _ProgramCaption+32
;mmbInput_driver.c,672 :: 		ProgramCaption.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _ProgramCaption+34
;mmbInput_driver.c,673 :: 		ProgramCaption.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _ProgramCaption+36
;mmbInput_driver.c,674 :: 		ProgramCaption.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _ProgramCaption+40
;mmbInput_driver.c,675 :: 		ProgramCaption.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _ProgramCaption+42
;mmbInput_driver.c,676 :: 		ProgramCaption.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _ProgramCaption+44
;mmbInput_driver.c,677 :: 		ProgramCaption.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _ProgramCaption+46
;mmbInput_driver.c,678 :: 		ProgramCaption.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _ProgramCaption+48
;mmbInput_driver.c,680 :: 		MCU.OwnerScreen     = &Screen1;
	MOV	#lo_addr(_Screen1), W0
	MOV	W0, _MCU
;mmbInput_driver.c,681 :: 		MCU.Order           = 16;
	MOV	#lo_addr(_MCU+2), W1
	MOV.B	#16, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,682 :: 		MCU.Left            = 216;
	MOV	#216, W0
	MOV	W0, _MCU+4
;mmbInput_driver.c,683 :: 		MCU.Top             = 202;
	MOV	#202, W0
	MOV	W0, _MCU+6
;mmbInput_driver.c,684 :: 		MCU.Width           = 104;
	MOV	#104, W0
	MOV	W0, _MCU+8
;mmbInput_driver.c,685 :: 		MCU.Height          = 39;
	MOV	#39, W0
	MOV	W0, _MCU+10
;mmbInput_driver.c,686 :: 		MCU.Pen_Width       = 0;
	MOV	#lo_addr(_MCU+12), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,687 :: 		MCU.Pen_Color       = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _MCU+14
;mmbInput_driver.c,688 :: 		MCU.Visible         = 1;
	MOV	#lo_addr(_MCU+16), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,689 :: 		MCU.Active          = 1;
	MOV	#lo_addr(_MCU+17), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,690 :: 		MCU.Transparent     = 0;
	MOV	#lo_addr(_MCU+18), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,691 :: 		MCU.Caption         = MCU_Caption;
	MOV	#lo_addr(_MCU_Caption), W0
	MOV	W0, _MCU+20
;mmbInput_driver.c,692 :: 		MCU.TextAlign             = _taRight;
	MOV	#lo_addr(_MCU+22), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,693 :: 		MCU.FontName        = DejaVu_Sans_Mono28x34_Bold;
	MOV	#2266, W0
	MOV	#0, W1
	MOV	W0, _MCU+24
	MOV	W1, _MCU+26
;mmbInput_driver.c,694 :: 		MCU.PressColEnabled = 1;
	MOV	#lo_addr(_MCU+38), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,695 :: 		MCU.Font_Color      = 0xF800;
	MOV	#63488, W0
	MOV	W0, _MCU+28
;mmbInput_driver.c,696 :: 		MCU.Gradient        = 0;
	MOV	#lo_addr(_MCU+30), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,697 :: 		MCU.Gradient_Orientation    = 0;
	MOV	#lo_addr(_MCU+31), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,698 :: 		MCU.Gradient_Start_Color    = 0xFFFF;
	MOV	#65535, W0
	MOV	W0, _MCU+32
;mmbInput_driver.c,699 :: 		MCU.Gradient_End_Color      = 0xC618;
	MOV	#50712, W0
	MOV	W0, _MCU+34
;mmbInput_driver.c,700 :: 		MCU.Color           = 0xC618;
	MOV	#50712, W0
	MOV	W0, _MCU+36
;mmbInput_driver.c,701 :: 		MCU.Press_Color     = 0xC618;
	MOV	#50712, W0
	MOV	W0, _MCU+40
;mmbInput_driver.c,702 :: 		MCU.OnUpPtr         = 0;
	CLR	W0
	MOV	W0, _MCU+42
;mmbInput_driver.c,703 :: 		MCU.OnDownPtr       = 0;
	CLR	W0
	MOV	W0, _MCU+44
;mmbInput_driver.c,704 :: 		MCU.OnClickPtr      = 0;
	CLR	W0
	MOV	W0, _MCU+46
;mmbInput_driver.c,705 :: 		MCU.OnPressPtr      = 0;
	CLR	W0
	MOV	W0, _MCU+48
;mmbInput_driver.c,706 :: 		}
L_end_InitializeObjects:
	RETURN
; end of mmbInput_driver_InitializeObjects

mmbInput_driver_IsInsideObject:
	LNK	#0

;mmbInput_driver.c,708 :: 		static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
;mmbInput_driver.c,709 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
; Width start address is: 2 (W1)
	MOV	[W14-8], W1
; Height start address is: 4 (W2)
	MOV	[W14-10], W2
	CP	W12, W10
	BRA LEU	L_mmbInput_driver_IsInsideObject154
	GOTO	L_mmbInput_driver_IsInsideObject130
L_mmbInput_driver_IsInsideObject154:
	ADD	W12, W1, W0
; Width end address is: 2 (W1)
	DEC	W0
	CP	W0, W10
	BRA GEU	L_mmbInput_driver_IsInsideObject155
	GOTO	L_mmbInput_driver_IsInsideObject129
L_mmbInput_driver_IsInsideObject155:
;mmbInput_driver.c,710 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
	CP	W13, W11
	BRA LEU	L_mmbInput_driver_IsInsideObject156
	GOTO	L_mmbInput_driver_IsInsideObject128
L_mmbInput_driver_IsInsideObject156:
	ADD	W13, W2, W0
; Height end address is: 4 (W2)
	DEC	W0
	CP	W0, W11
	BRA GEU	L_mmbInput_driver_IsInsideObject157
	GOTO	L_mmbInput_driver_IsInsideObject127
L_mmbInput_driver_IsInsideObject157:
L_mmbInput_driver_IsInsideObject126:
;mmbInput_driver.c,711 :: 		return 1;
	MOV.B	#1, W0
	GOTO	L_end_IsInsideObject
;mmbInput_driver.c,709 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
L_mmbInput_driver_IsInsideObject130:
L_mmbInput_driver_IsInsideObject129:
;mmbInput_driver.c,710 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
L_mmbInput_driver_IsInsideObject128:
L_mmbInput_driver_IsInsideObject127:
;mmbInput_driver.c,713 :: 		return 0;
	CLR	W0
;mmbInput_driver.c,714 :: 		}
L_end_IsInsideObject:
	ULNK
	RETURN
; end of mmbInput_driver_IsInsideObject

_DeleteTrailingSpaces:

;mmbInput_driver.c,721 :: 		void DeleteTrailingSpaces(char* str){
;mmbInput_driver.c,724 :: 		while(1) {
L_DeleteTrailingSpaces10:
;mmbInput_driver.c,725 :: 		if(str[0] == ' ') {
	MOV.B	[W10], W1
	MOV.B	#32, W0
	CP.B	W1, W0
	BRA Z	L__DeleteTrailingSpaces159
	GOTO	L_DeleteTrailingSpaces12
L__DeleteTrailingSpaces159:
;mmbInput_driver.c,726 :: 		for(i = 0; i < strlen(str); i++) {
; i start address is: 4 (W2)
	CLR	W2
; i end address is: 4 (W2)
L_DeleteTrailingSpaces13:
; i start address is: 4 (W2)
	CALL	_strlen
	ZE	W2, W1
	CP	W1, W0
	BRA LT	L__DeleteTrailingSpaces160
	GOTO	L_DeleteTrailingSpaces14
L__DeleteTrailingSpaces160:
;mmbInput_driver.c,727 :: 		str[i] = str[i+1];
	ZE	W2, W0
	ADD	W10, W0, W1
	ZE	W2, W0
	INC	W0
	ADD	W10, W0, W0
	MOV.B	[W0], [W1]
;mmbInput_driver.c,726 :: 		for(i = 0; i < strlen(str); i++) {
	INC.B	W2
;mmbInput_driver.c,728 :: 		}
; i end address is: 4 (W2)
	GOTO	L_DeleteTrailingSpaces13
L_DeleteTrailingSpaces14:
;mmbInput_driver.c,729 :: 		}
	GOTO	L_DeleteTrailingSpaces16
L_DeleteTrailingSpaces12:
;mmbInput_driver.c,731 :: 		break;
	GOTO	L_DeleteTrailingSpaces11
L_DeleteTrailingSpaces16:
;mmbInput_driver.c,732 :: 		}
	GOTO	L_DeleteTrailingSpaces10
L_DeleteTrailingSpaces11:
;mmbInput_driver.c,733 :: 		}
L_end_DeleteTrailingSpaces:
	RETURN
; end of _DeleteTrailingSpaces

_DrawButton:

;mmbInput_driver.c,735 :: 		void DrawButton(TButton *Abutton) {
;mmbInput_driver.c,736 :: 		if (Abutton->Visible == 1) {
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	ADD	W10, #16, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__DrawButton162
	GOTO	L_DrawButton17
L__DrawButton162:
;mmbInput_driver.c,737 :: 		if (object_pressed == 1) {
	MOV	#lo_addr(_object_pressed), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__DrawButton163
	GOTO	L_DrawButton18
L__DrawButton163:
;mmbInput_driver.c,738 :: 		object_pressed = 0;
	MOV	#lo_addr(_object_pressed), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,739 :: 		TFT_Set_Brush(Abutton->Transparent, Abutton->Press_Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_End_Color, Abutton->Gradient_Start_Color);
	MOV	#32, W0
	ADD	W10, W0, W5
	MOV	#34, W0
	ADD	W10, W0, W4
	ADD	W10, #31, W3
	ADD	W10, #30, W2
	MOV	#40, W0
	ADD	W10, W0, W1
	ADD	W10, #18, W0
	PUSH	W10
	ZE	[W3], W13
	ZE	[W2], W12
	MOV	[W1], W11
	ZE	[W0], W10
	PUSH	[W5]
	PUSH	[W4]
	CALL	_TFT_Set_Brush
	SUB	#4, W15
	POP	W10
;mmbInput_driver.c,740 :: 		}
	GOTO	L_DrawButton19
L_DrawButton18:
;mmbInput_driver.c,742 :: 		TFT_Set_Brush(Abutton->Transparent, Abutton->Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_Start_Color, Abutton->Gradient_End_Color);
	MOV	#34, W0
	ADD	W10, W0, W5
	MOV	#32, W0
	ADD	W10, W0, W4
	ADD	W10, #31, W3
	ADD	W10, #30, W2
	MOV	#36, W0
	ADD	W10, W0, W1
	ADD	W10, #18, W0
	PUSH	W10
	ZE	[W3], W13
	ZE	[W2], W12
	MOV	[W1], W11
	ZE	[W0], W10
	PUSH	[W5]
	PUSH	[W4]
	CALL	_TFT_Set_Brush
	SUB	#4, W15
	POP	W10
;mmbInput_driver.c,743 :: 		}
L_DrawButton19:
;mmbInput_driver.c,744 :: 		TFT_Set_Pen(Abutton->Pen_Color, Abutton->Pen_Width);
	ADD	W10, #12, W1
	ADD	W10, #14, W0
	PUSH	W10
	ZE	[W1], W11
	MOV	[W0], W10
	CALL	_TFT_Set_Pen
	POP	W10
;mmbInput_driver.c,745 :: 		TFT_Rectangle(Abutton->Left, Abutton->Top, Abutton->Left + Abutton->Width - 1, Abutton->Top + Abutton->Height - 1);
	ADD	W10, #6, W3
	ADD	W10, #10, W0
	MOV	[W0], W0
	ADD	W0, [W3], W0
	SUB	W0, #1, W2
	ADD	W10, #4, W1
	ADD	W10, #8, W0
	MOV	[W0], W0
	ADD	W0, [W1], W0
	DEC	W0
	PUSH	W10
	MOV	W2, W13
	MOV	W0, W12
	MOV	[W3], W11
	MOV	[W1], W10
	CALL	_TFT_Rectangle
	POP	W10
;mmbInput_driver.c,746 :: 		TFT_Set_Ext_Font(Abutton->FontName, Abutton->Font_Color, FO_HORIZONTAL);
	ADD	W10, #28, W1
	ADD	W10, #24, W0
	PUSH	W10
	CLR	W13
	MOV	[W1], W12
	MOV.D	[W0], W10
	CALL	_TFT_Set_Ext_Font
	POP	W10
;mmbInput_driver.c,747 :: 		TFT_Write_Text_Return_Pos(Abutton->Caption, Abutton->Left, Abutton->Top);
	ADD	W10, #6, W2
	ADD	W10, #4, W1
	ADD	W10, #20, W0
	PUSH	W10
	MOV	[W2], W12
	MOV	[W1], W11
	MOV	[W0], W10
	CALL	_TFT_Write_Text_Return_Pos
	POP	W10
;mmbInput_driver.c,748 :: 		if (AButton->TextAlign == _taLeft)
	ADD	W10, #22, W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__DrawButton164
	GOTO	L_DrawButton20
L__DrawButton164:
;mmbInput_driver.c,749 :: 		TFT_Write_Text(Abutton->Caption, Abutton->Left + 4, (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
	ADD	W10, #6, W2
	ADD	W10, #10, W0
	MOV	[W0], W1
	MOV	#lo_addr(_caption_height), W0
	SUB	W1, [W0], W0
	LSR	W0, #1, W0
	ADD	W0, [W2], W2
	ADD	W10, #4, W0
	MOV	[W0], W0
	ADD	W0, #4, W1
	ADD	W10, #20, W0
	MOV	W2, W12
	MOV	W1, W11
	MOV	[W0], W10
	CALL	_TFT_Write_Text
	GOTO	L_DrawButton21
L_DrawButton20:
;mmbInput_driver.c,750 :: 		else if (AButton->TextAlign == _taCenter)
	ADD	W10, #22, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__DrawButton165
	GOTO	L_DrawButton22
L__DrawButton165:
;mmbInput_driver.c,751 :: 		TFT_Write_Text(Abutton->Caption, (Abutton->Left + (Abutton->Width - caption_length) / 2), (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
	ADD	W10, #6, W2
	ADD	W10, #10, W0
	MOV	[W0], W1
	MOV	#lo_addr(_caption_height), W0
	SUB	W1, [W0], W0
	LSR	W0, #1, W0
	ADD	W0, [W2], W3
	ADD	W10, #4, W2
	ADD	W10, #8, W0
	MOV	[W0], W1
	MOV	#lo_addr(_caption_length), W0
	SUB	W1, [W0], W0
	LSR	W0, #1, W0
	ADD	W0, [W2], W1
	ADD	W10, #20, W0
	MOV	W3, W12
	MOV	W1, W11
	MOV	[W0], W10
	CALL	_TFT_Write_Text
	GOTO	L_DrawButton23
L_DrawButton22:
;mmbInput_driver.c,752 :: 		else if (AButton->TextAlign == _taRight)
	ADD	W10, #22, W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__DrawButton166
	GOTO	L_DrawButton24
L__DrawButton166:
;mmbInput_driver.c,753 :: 		TFT_Write_Text(Abutton->Caption, Abutton->Left + (Abutton->Width - caption_length - 4), (Abutton->Top + (Abutton->Height - caption_height) / 2));
	ADD	W10, #6, W2
	ADD	W10, #10, W0
	MOV	[W0], W1
	MOV	#lo_addr(_caption_height), W0
	SUB	W1, [W0], W0
	LSR	W0, #1, W0
	ADD	W0, [W2], W3
	ADD	W10, #4, W2
	ADD	W10, #8, W0
	MOV	[W0], W1
	MOV	#lo_addr(_caption_length), W0
	SUB	W1, [W0], W0
	SUB	W0, #4, W0
	ADD	W0, [W2], W1
	ADD	W10, #20, W0
	MOV	W3, W12
	MOV	W1, W11
	MOV	[W0], W10
	CALL	_TFT_Write_Text
L_DrawButton24:
L_DrawButton23:
L_DrawButton21:
;mmbInput_driver.c,754 :: 		}
L_DrawButton17:
;mmbInput_driver.c,755 :: 		}
L_end_DrawButton:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _DrawButton

_DrawImage:

;mmbInput_driver.c,757 :: 		void DrawImage(TImage *AImage) {
;mmbInput_driver.c,758 :: 		if (AImage->Visible) {
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	ADD	W10, #16, W0
	CP0.B	[W0]
	BRA NZ	L__DrawImage168
	GOTO	L_DrawImage25
L__DrawImage168:
;mmbInput_driver.c,759 :: 		TFT_Ext_Image(AImage->Left, AImage->Top, AImage->Picture_Name, AImage->Picture_Ratio);
	ADD	W10, #19, W0
	MOV.B	[W0], W3
	ADD	W10, #12, W2
	ADD	W10, #6, W1
	ADD	W10, #4, W0
	MOV.D	[W2], W12
	MOV	[W1], W11
	MOV	[W0], W10
	ZE	W3, W0
	PUSH	W0
	CALL	_TFT_Ext_Image
	SUB	#2, W15
;mmbInput_driver.c,760 :: 		}
L_DrawImage25:
;mmbInput_driver.c,761 :: 		}
L_end_DrawImage:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _DrawImage

_DrawRadioButton:

;mmbInput_driver.c,763 :: 		void DrawRadioButton(TRadioButton *ARadioButton) {
;mmbInput_driver.c,764 :: 		int circleOffset = 0;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
;mmbInput_driver.c,765 :: 		if (ARadioButton->Visible == 1) {
	ADD	W10, #16, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__DrawRadioButton170
	GOTO	L_DrawRadioButton26
L__DrawRadioButton170:
;mmbInput_driver.c,766 :: 		circleOffset = ARadioButton->Height / 5;
	ADD	W10, #10, W0
	MOV	[W0], W1
	MOV	#5, W2
	REPEAT	#17
	DIV.U	W1, W2
; circleOffset start address is: 12 (W6)
	MOV	W0, W6
;mmbInput_driver.c,767 :: 		TFT_Set_Pen(ARadioButton->Pen_Color, ARadioButton->Pen_Width);
	ADD	W10, #12, W1
	ADD	W10, #14, W0
	PUSH	W10
	ZE	[W1], W11
	MOV	[W0], W10
	CALL	_TFT_Set_Pen
	POP	W10
;mmbInput_driver.c,768 :: 		if (ARadioButton->TextAlign == _taLeft) {
	ADD	W10, #22, W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__DrawRadioButton171
	GOTO	L_DrawRadioButton27
L__DrawRadioButton171:
;mmbInput_driver.c,769 :: 		TFT_Set_Brush(ARadioButton->Transparent,ARadioButton->Background_Color,0,0,0,0);
	MOV	#38, W0
	ADD	W10, W0, W1
	ADD	W10, #19, W0
	PUSH	W10
	CLR	W13
	CLR	W12
	MOV	[W1], W11
	ZE	[W0], W10
	CLR	W0
	PUSH	W0
	CLR	W0
	PUSH	W0
	CALL	_TFT_Set_Brush
	SUB	#4, W15
	POP	W10
;mmbInput_driver.c,770 :: 		TFT_Circle(ARadioButton->Left + ARadioButton->Height / 2, ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2);
	ADD	W10, #10, W0
	MOV	[W0], W0
	LSR	W0, #1, W2
	ADD	W10, #6, W0
	ADD	W2, [W0], W1
	ADD	W10, #4, W0
	ADD	W2, [W0], W0
	PUSH	W6
	PUSH	W10
	MOV	W2, W12
	MOV	W1, W11
	MOV	W0, W10
	CALL	_TFT_Circle
	POP	W10
	POP	W6
;mmbInput_driver.c,771 :: 		if (ARadioButton->Checked == 1) {
	ADD	W10, #18, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__DrawRadioButton172
	GOTO	L_DrawRadioButton28
L__DrawRadioButton172:
;mmbInput_driver.c,772 :: 		if (object_pressed == 1) {
	MOV	#lo_addr(_object_pressed), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__DrawRadioButton173
	GOTO	L_DrawRadioButton29
L__DrawRadioButton173:
;mmbInput_driver.c,773 :: 		object_pressed = 0;
	MOV	#lo_addr(_object_pressed), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,774 :: 		TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Press_Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_End_Color, ARadioButton->Gradient_Start_Color);
	MOV	#32, W0
	ADD	W10, W0, W5
	MOV	#34, W0
	ADD	W10, W0, W4
	ADD	W10, #31, W3
	ADD	W10, #30, W2
	MOV	#42, W0
	ADD	W10, W0, W1
	ADD	W10, #19, W0
	PUSH	W10
	ZE	[W3], W13
	ZE	[W2], W12
	MOV	[W1], W11
	ZE	[W0], W10
	PUSH	[W5]
	PUSH	[W4]
	CALL	_TFT_Set_Brush
	SUB	#4, W15
	POP	W10
;mmbInput_driver.c,775 :: 		}
	GOTO	L_DrawRadioButton30
L_DrawRadioButton29:
;mmbInput_driver.c,777 :: 		TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_Start_Color, ARadioButton->Gradient_End_Color);
	MOV	#34, W0
	ADD	W10, W0, W5
	MOV	#32, W0
	ADD	W10, W0, W4
	ADD	W10, #31, W3
	ADD	W10, #30, W2
	MOV	#36, W0
	ADD	W10, W0, W1
	ADD	W10, #19, W0
	PUSH	W10
	ZE	[W3], W13
	ZE	[W2], W12
	MOV	[W1], W11
	ZE	[W0], W10
	PUSH	[W5]
	PUSH	[W4]
	CALL	_TFT_Set_Brush
	SUB	#4, W15
	POP	W10
L_DrawRadioButton30:
;mmbInput_driver.c,778 :: 		TFT_Circle(ARadioButton->Left + ARadioButton->Height / 2 , ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2 - circleOffset);
	ADD	W10, #10, W0
	MOV	[W0], W0
	LSR	W0, #1, W3
	SUB	W3, W6, W2
; circleOffset end address is: 12 (W6)
	ADD	W10, #6, W0
	ADD	W3, [W0], W1
	ADD	W10, #4, W0
	ADD	W3, [W0], W0
	PUSH	W10
	MOV	W2, W12
	MOV	W1, W11
	MOV	W0, W10
	CALL	_TFT_Circle
	POP	W10
;mmbInput_driver.c,779 :: 		}
L_DrawRadioButton28:
;mmbInput_driver.c,780 :: 		TFT_Set_Ext_Font(ARadioButton->FontName, ARadioButton->Font_Color, FO_HORIZONTAL);
	ADD	W10, #28, W1
	ADD	W10, #24, W0
	PUSH	W10
	CLR	W13
	MOV	[W1], W12
	MOV.D	[W0], W10
	CALL	_TFT_Set_Ext_Font
	POP	W10
;mmbInput_driver.c,781 :: 		TFT_Write_Text_Return_Pos(ARadioButton->Caption, ARadioButton->Left + ARadioButton->Height + 4, ARadioButton->Top);
	ADD	W10, #6, W2
	ADD	W10, #4, W1
	ADD	W10, #10, W0
	MOV	[W0], W0
	ADD	W0, [W1], W0
	ADD	W0, #4, W1
	ADD	W10, #20, W0
	PUSH	W10
	MOV	[W2], W12
	MOV	W1, W11
	MOV	[W0], W10
	CALL	_TFT_Write_Text_Return_Pos
	POP	W10
;mmbInput_driver.c,782 :: 		TFT_Write_Text(ARadioButton->Caption, ARadioButton->Left + ARadioButton->Height + 4, (ARadioButton->Top + ((ARadioButton->Height - caption_height) / 2)));
	ADD	W10, #6, W2
	ADD	W10, #10, W3
	MOV	[W3], W1
	MOV	#lo_addr(_caption_height), W0
	SUB	W1, [W0], W0
	LSR	W0, #1, W0
	ADD	W0, [W2], W2
	ADD	W10, #4, W0
	MOV	[W0], W0
	ADD	W0, [W3], W0
	ADD	W0, #4, W1
	ADD	W10, #20, W0
	MOV	W2, W12
	MOV	W1, W11
	MOV	[W0], W10
	CALL	_TFT_Write_Text
;mmbInput_driver.c,783 :: 		}
	GOTO	L_DrawRadioButton31
L_DrawRadioButton27:
;mmbInput_driver.c,784 :: 		else if (ARadioButton->TextAlign == _taRight) {
; circleOffset start address is: 12 (W6)
	ADD	W10, #22, W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__DrawRadioButton174
	GOTO	L_DrawRadioButton32
L__DrawRadioButton174:
;mmbInput_driver.c,785 :: 		TFT_Set_Brush(ARadioButton->Transparent,ARadioButton->Background_Color,0,0,0,0);
	MOV	#38, W0
	ADD	W10, W0, W1
	ADD	W10, #19, W0
	PUSH	W10
	CLR	W13
	CLR	W12
	MOV	[W1], W11
	ZE	[W0], W10
	CLR	W0
	PUSH	W0
	CLR	W0
	PUSH	W0
	CALL	_TFT_Set_Brush
	SUB	#4, W15
	POP	W10
;mmbInput_driver.c,786 :: 		TFT_Circle(ARadioButton->Left  + ARadioButton->Width - ARadioButton->Height / 2, ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2);
	ADD	W10, #10, W0
	MOV	[W0], W0
	LSR	W0, #1, W3
	ADD	W10, #6, W0
	ADD	W3, [W0], W2
	ADD	W10, #4, W1
	ADD	W10, #8, W0
	MOV	[W0], W0
	ADD	W0, [W1], W0
	SUB	W0, W3, W0
	PUSH	W6
	PUSH	W10
	MOV	W3, W12
	MOV	W2, W11
	MOV	W0, W10
	CALL	_TFT_Circle
	POP	W10
	POP	W6
;mmbInput_driver.c,787 :: 		if (ARadioButton->Checked == 1) {
	ADD	W10, #18, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__DrawRadioButton175
	GOTO	L_DrawRadioButton33
L__DrawRadioButton175:
;mmbInput_driver.c,788 :: 		if (object_pressed == 1) {
	MOV	#lo_addr(_object_pressed), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__DrawRadioButton176
	GOTO	L_DrawRadioButton34
L__DrawRadioButton176:
;mmbInput_driver.c,789 :: 		object_pressed = 0;
	MOV	#lo_addr(_object_pressed), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,790 :: 		TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Press_Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_End_Color, ARadioButton->Gradient_Start_Color);
	MOV	#32, W0
	ADD	W10, W0, W5
	MOV	#34, W0
	ADD	W10, W0, W4
	ADD	W10, #31, W3
	ADD	W10, #30, W2
	MOV	#42, W0
	ADD	W10, W0, W1
	ADD	W10, #19, W0
	PUSH	W10
	ZE	[W3], W13
	ZE	[W2], W12
	MOV	[W1], W11
	ZE	[W0], W10
	PUSH	[W5]
	PUSH	[W4]
	CALL	_TFT_Set_Brush
	SUB	#4, W15
	POP	W10
;mmbInput_driver.c,791 :: 		}
	GOTO	L_DrawRadioButton35
L_DrawRadioButton34:
;mmbInput_driver.c,793 :: 		TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_Start_Color, ARadioButton->Gradient_End_Color);
	MOV	#34, W0
	ADD	W10, W0, W5
	MOV	#32, W0
	ADD	W10, W0, W4
	ADD	W10, #31, W3
	ADD	W10, #30, W2
	MOV	#36, W0
	ADD	W10, W0, W1
	ADD	W10, #19, W0
	PUSH	W10
	ZE	[W3], W13
	ZE	[W2], W12
	MOV	[W1], W11
	ZE	[W0], W10
	PUSH	[W5]
	PUSH	[W4]
	CALL	_TFT_Set_Brush
	SUB	#4, W15
	POP	W10
L_DrawRadioButton35:
;mmbInput_driver.c,794 :: 		TFT_Circle(ARadioButton->Left  + ARadioButton->Width - ARadioButton->Height / 2, ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2 - circleOffset);
	ADD	W10, #10, W0
	MOV	[W0], W0
	LSR	W0, #1, W4
	SUB	W4, W6, W3
; circleOffset end address is: 12 (W6)
	ADD	W10, #6, W0
	ADD	W4, [W0], W2
	ADD	W10, #4, W1
	ADD	W10, #8, W0
	MOV	[W0], W0
	ADD	W0, [W1], W0
	SUB	W0, W4, W0
	PUSH	W10
	MOV	W3, W12
	MOV	W2, W11
	MOV	W0, W10
	CALL	_TFT_Circle
	POP	W10
;mmbInput_driver.c,795 :: 		}
L_DrawRadioButton33:
;mmbInput_driver.c,796 :: 		TFT_Set_Ext_Font(ARadioButton->FontName, ARadioButton->Font_Color, FO_HORIZONTAL);
	ADD	W10, #28, W1
	ADD	W10, #24, W0
	PUSH	W10
	CLR	W13
	MOV	[W1], W12
	MOV.D	[W0], W10
	CALL	_TFT_Set_Ext_Font
	POP	W10
;mmbInput_driver.c,797 :: 		TFT_Write_Text_Return_Pos(ARadioButton->Caption, ARadioButton->Left + 3, ARadioButton->Top);
	ADD	W10, #6, W2
	ADD	W10, #4, W0
	MOV	[W0], W0
	ADD	W0, #3, W1
	ADD	W10, #20, W0
	PUSH	W10
	MOV	[W2], W12
	MOV	W1, W11
	MOV	[W0], W10
	CALL	_TFT_Write_Text_Return_Pos
	POP	W10
;mmbInput_driver.c,798 :: 		TFT_Write_Text(ARadioButton->Caption, ARadioButton->Left + 3, ARadioButton->Top + (ARadioButton->Height - caption_height) / 2);
	ADD	W10, #6, W2
	ADD	W10, #10, W0
	MOV	[W0], W1
	MOV	#lo_addr(_caption_height), W0
	SUB	W1, [W0], W0
	LSR	W0, #1, W0
	ADD	W0, [W2], W2
	ADD	W10, #4, W0
	MOV	[W0], W0
	ADD	W0, #3, W1
	ADD	W10, #20, W0
	MOV	W2, W12
	MOV	W1, W11
	MOV	[W0], W10
	CALL	_TFT_Write_Text
;mmbInput_driver.c,799 :: 		}
L_DrawRadioButton32:
L_DrawRadioButton31:
;mmbInput_driver.c,800 :: 		}
L_DrawRadioButton26:
;mmbInput_driver.c,801 :: 		}
L_end_DrawRadioButton:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _DrawRadioButton

_DrawScreen:
	LNK	#14

;mmbInput_driver.c,803 :: 		void DrawScreen(TScreen *aScreen) {
;mmbInput_driver.c,813 :: 		object_pressed = 0;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	MOV	#lo_addr(_object_pressed), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,814 :: 		order = 0;
	CLR	W0
	MOV	W0, [W14+0]
;mmbInput_driver.c,815 :: 		button_idx = 0;
	CLR	W0
	MOV.B	W0, [W14+2]
;mmbInput_driver.c,816 :: 		image_idx = 0;
	CLR	W0
	MOV.B	W0, [W14+6]
;mmbInput_driver.c,817 :: 		radio_button_idx = 0;
	CLR	W0
	MOV.B	W0, [W14+10]
;mmbInput_driver.c,818 :: 		CurrentScreen = aScreen;
	MOV	W10, _CurrentScreen
;mmbInput_driver.c,820 :: 		if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
	ADD	W10, #2, W0
	MOV	[W0], W1
	MOV	#lo_addr(_display_width), W0
	CP	W1, [W0]
	BRA Z	L__DrawScreen178
	GOTO	L__DrawScreen133
L__DrawScreen178:
	MOV	_CurrentScreen, W0
	ADD	W0, #4, W0
	MOV	[W0], W1
	MOV	#lo_addr(_display_height), W0
	CP	W1, [W0]
	BRA Z	L__DrawScreen179
	GOTO	L__DrawScreen132
L__DrawScreen179:
	GOTO	L_DrawScreen38
L__DrawScreen133:
L__DrawScreen132:
;mmbInput_driver.c,821 :: 		save_bled = TFT_BLED;
; save_bled start address is: 4 (W2)
	CLR.B	W2
	BTSC	LATD7_bit, #7
	INC.B	W2
;mmbInput_driver.c,822 :: 		save_bled_direction = TFT_BLED_Direction;
; save_bled_direction start address is: 6 (W3)
	CLR.B	W3
	BTSC	TRISD7_bit, #7
	INC.B	W3
;mmbInput_driver.c,823 :: 		TFT_BLED_Direction = 0;
	BCLR	TRISD7_bit, #7
;mmbInput_driver.c,824 :: 		TFT_BLED           = 0;
	BCLR	LATD7_bit, #7
;mmbInput_driver.c,825 :: 		TFT_Set_Active(Set_Index, Write_Command, Write_Data);
	PUSH	W10
	MOV	#lo_addr(_Write_Data), W12
	MOV	#lo_addr(_Write_Command), W11
	MOV	#lo_addr(_Set_Index), W10
	CALL	_TFT_Set_Active
	POP	W10
;mmbInput_driver.c,826 :: 		TFT_Init(CurrentScreen->Width, CurrentScreen->Height);
	MOV	_CurrentScreen, W0
	ADD	W0, #4, W1
	MOV	_CurrentScreen, W0
	INC2	W0
	PUSH.D	W2
	PUSH	W10
	MOV	[W1], W11
	MOV	[W0], W10
	CALL	_TFT_Init
	POP	W10
	POP.D	W2
;mmbInput_driver.c,827 :: 		TFT_Set_Ext_Buffer(TFT_Get_Data);
	PUSH	W10
	MOV	#lo_addr(_TFT_Get_Data), W10
	CALL	_TFT_Set_Ext_Buffer
;mmbInput_driver.c,828 :: 		TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 13, 12);                                  // Initialize touch panel
	MOV	_CurrentScreen, W0
	ADD	W0, #4, W1
	MOV	_CurrentScreen, W0
	INC2	W0
	MOV.B	#12, W13
	MOV.B	#13, W12
	MOV	[W1], W11
	MOV	[W0], W10
	CALL	_TP_TFT_Init
;mmbInput_driver.c,829 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
	MOV	#800, W10
	CALL	_TP_TFT_Set_ADC_Threshold
	POP	W10
;mmbInput_driver.c,830 :: 		TFT_Fill_Screen(CurrentScreen->Color);
	MOV	_CurrentScreen, W0
	PUSH.D	W2
	PUSH	W10
	MOV	[W0], W10
	CALL	_TFT_Fill_Screen
	POP	W10
	POP.D	W2
;mmbInput_driver.c,831 :: 		display_width = CurrentScreen->Width;
	MOV	_CurrentScreen, W0
	INC2	W0
	MOV	[W0], W0
	MOV	W0, _display_width
;mmbInput_driver.c,832 :: 		display_height = CurrentScreen->Height;
	MOV	_CurrentScreen, W0
	ADD	W0, #4, W0
	MOV	[W0], W0
	MOV	W0, _display_height
;mmbInput_driver.c,833 :: 		TFT_BLED           = save_bled;
	BTSS	W2, #0
	BCLR	LATD7_bit, #7
	BTSC	W2, #0
	BSET	LATD7_bit, #7
; save_bled end address is: 4 (W2)
;mmbInput_driver.c,834 :: 		TFT_BLED_Direction = save_bled_direction;
	BTSS	W3, #0
	BCLR	TRISD7_bit, #7
	BTSC	W3, #0
	BSET	TRISD7_bit, #7
; save_bled_direction end address is: 6 (W3)
;mmbInput_driver.c,835 :: 		}
	GOTO	L_DrawScreen39
L_DrawScreen38:
;mmbInput_driver.c,837 :: 		TFT_Fill_Screen(CurrentScreen->Color);
	MOV	_CurrentScreen, W0
	MOV	[W0], W10
	CALL	_TFT_Fill_Screen
L_DrawScreen39:
;mmbInput_driver.c,840 :: 		while (order < CurrentScreen->ObjectsCount) {
L_DrawScreen40:
	MOV	_CurrentScreen, W0
	ADD	W0, #6, W0
	MOV.B	[W0], W0
	ZE	W0, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA GT	L__DrawScreen180
	GOTO	L_DrawScreen41
L__DrawScreen180:
;mmbInput_driver.c,841 :: 		if (button_idx < CurrentScreen->ButtonsCount) {
	MOV	_CurrentScreen, W0
	ADD	W0, #8, W0
	MOV	[W0], W1
	ADD	W14, #2, W0
	ZE	[W0], W0
	CP	W0, W1
	BRA LTU	L__DrawScreen181
	GOTO	L_DrawScreen42
L__DrawScreen181:
;mmbInput_driver.c,842 :: 		local_button = GetButton(button_idx);
	MOV	_CurrentScreen, W0
	ADD	W0, #10, W4
	ADD	W14, #2, W0
	ZE	[W0], W0
	CLR	W1
	MOV.D	W0, W2
	SL	W2, W2
	RLC	W3, W3
	ADD	W2, [W4++], W0
	ADDC	W3, [W4--], W1
	MOV	W1, 52
	MOV	[W0], W0
	MOV	W0, [W14+4]
;mmbInput_driver.c,843 :: 		if (order == local_button->Order) {
	INC2	W0
	MOV.B	[W0], W0
	ZE	W0, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA Z	L__DrawScreen182
	GOTO	L_DrawScreen43
L__DrawScreen182:
;mmbInput_driver.c,844 :: 		button_idx++;
	MOV.B	[W14+2], W1
	ADD	W14, #2, W0
	ADD.B	W1, #1, [W0]
;mmbInput_driver.c,845 :: 		order++;
	MOV	[W14+0], W1
	ADD	W14, #0, W0
	ADD	W1, #1, [W0]
;mmbInput_driver.c,846 :: 		DrawButton(local_button);
	PUSH	W10
	MOV	[W14+4], W10
	CALL	_DrawButton
	POP	W10
;mmbInput_driver.c,847 :: 		}
L_DrawScreen43:
;mmbInput_driver.c,848 :: 		}
L_DrawScreen42:
;mmbInput_driver.c,850 :: 		if (image_idx  < CurrentScreen->ImagesCount) {
	MOV	_CurrentScreen, W0
	ADD	W0, #14, W0
	MOV	[W0], W1
	ADD	W14, #6, W0
	ZE	[W0], W0
	CP	W0, W1
	BRA LTU	L__DrawScreen183
	GOTO	L_DrawScreen44
L__DrawScreen183:
;mmbInput_driver.c,851 :: 		local_image = GetImage(image_idx);
	MOV	_CurrentScreen, W0
	ADD	W0, #16, W4
	ADD	W14, #6, W0
	ZE	[W0], W0
	CLR	W1
	MOV.D	W0, W2
	SL	W2, W2
	RLC	W3, W3
	ADD	W2, [W4++], W0
	ADDC	W3, [W4--], W1
	MOV	W1, 52
	MOV	[W0], W0
	MOV	W0, [W14+8]
;mmbInput_driver.c,852 :: 		if (order == local_image->Order) {
	INC2	W0
	MOV.B	[W0], W0
	ZE	W0, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA Z	L__DrawScreen184
	GOTO	L_DrawScreen45
L__DrawScreen184:
;mmbInput_driver.c,853 :: 		image_idx++;
	MOV.B	[W14+6], W1
	ADD	W14, #6, W0
	ADD.B	W1, #1, [W0]
;mmbInput_driver.c,854 :: 		order++;
	MOV	[W14+0], W1
	ADD	W14, #0, W0
	ADD	W1, #1, [W0]
;mmbInput_driver.c,855 :: 		DrawImage(local_image);
	PUSH	W10
	MOV	[W14+8], W10
	CALL	_DrawImage
	POP	W10
;mmbInput_driver.c,856 :: 		}
L_DrawScreen45:
;mmbInput_driver.c,857 :: 		}
L_DrawScreen44:
;mmbInput_driver.c,859 :: 		if (radio_button_idx  < CurrentScreen->RadioButtonsCount) {
	MOV	_CurrentScreen, W0
	ADD	W0, #20, W0
	MOV	[W0], W1
	ADD	W14, #10, W0
	ZE	[W0], W0
	CP	W0, W1
	BRA LTU	L__DrawScreen185
	GOTO	L_DrawScreen46
L__DrawScreen185:
;mmbInput_driver.c,860 :: 		local_radio_button = GetRadioButton(radio_button_idx);
	MOV	_CurrentScreen, W0
	ADD	W0, #22, W4
	ADD	W14, #10, W0
	ZE	[W0], W0
	CLR	W1
	MOV.D	W0, W2
	SL	W2, W2
	RLC	W3, W3
	ADD	W2, [W4++], W0
	ADDC	W3, [W4--], W1
	MOV	W1, 52
	MOV	[W0], W0
	MOV	W0, [W14+12]
;mmbInput_driver.c,861 :: 		if (order == local_radio_button->Order) {
	INC2	W0
	MOV.B	[W0], W0
	ZE	W0, W1
	ADD	W14, #0, W0
	CP	W1, [W0]
	BRA Z	L__DrawScreen186
	GOTO	L_DrawScreen47
L__DrawScreen186:
;mmbInput_driver.c,862 :: 		radio_button_idx++;
	MOV.B	[W14+10], W1
	ADD	W14, #10, W0
	ADD.B	W1, #1, [W0]
;mmbInput_driver.c,863 :: 		order++;
	MOV	[W14+0], W1
	ADD	W14, #0, W0
	ADD	W1, #1, [W0]
;mmbInput_driver.c,864 :: 		DrawRadioButton(local_radio_button);
	PUSH	W10
	MOV	[W14+12], W10
	CALL	_DrawRadioButton
	POP	W10
;mmbInput_driver.c,865 :: 		}
L_DrawScreen47:
;mmbInput_driver.c,866 :: 		}
L_DrawScreen46:
;mmbInput_driver.c,868 :: 		}
	GOTO	L_DrawScreen40
L_DrawScreen41:
;mmbInput_driver.c,869 :: 		}
L_end_DrawScreen:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _DrawScreen

_Get_Object:

;mmbInput_driver.c,871 :: 		void Get_Object(unsigned int X, unsigned int Y) {
;mmbInput_driver.c,872 :: 		button_order        = -1;
	PUSH	W12
	PUSH	W13
	MOV	#65535, W0
	MOV	W0, _button_order
;mmbInput_driver.c,873 :: 		image_order         = -1;
	MOV	#65535, W0
	MOV	W0, _image_order
;mmbInput_driver.c,874 :: 		radio_button_order    = -1;
	MOV	#65535, W0
	MOV	W0, _radio_button_order
;mmbInput_driver.c,876 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
	CLR	W0
	MOV	W0, __object_count
L_Get_Object48:
	MOV	_CurrentScreen, W0
	ADD	W0, #8, W0
	MOV	[W0], W1
	MOV	#lo_addr(__object_count), W0
	CP	W1, [W0]
	BRA GTU	L__Get_Object188
	GOTO	L_Get_Object49
L__Get_Object188:
;mmbInput_driver.c,877 :: 		local_button = GetButton(_object_count);
	MOV	_CurrentScreen, W0
	ADD	W0, #10, W4
	MOV	__object_count, W0
	ASR	W0, #15, W1
	MOV.D	W0, W2
	SL	W2, W2
	RLC	W3, W3
	ADD	W2, [W4++], W0
	ADDC	W3, [W4--], W1
	MOV	W1, 52
	MOV	[W0], W0
	MOV	W0, _local_button
;mmbInput_driver.c,878 :: 		if (local_button->Active == 1) {
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__Get_Object189
	GOTO	L_Get_Object51
L__Get_Object189:
;mmbInput_driver.c,880 :: 		local_button->Width, local_button->Height) == 1) {
	MOV	_local_button, W0
	ADD	W0, #10, W3
	MOV	_local_button, W0
	ADD	W0, #8, W2
;mmbInput_driver.c,879 :: 		if (IsInsideObject(X, Y, local_button->Left, local_button->Top,
	MOV	_local_button, W0
	ADD	W0, #6, W1
	MOV	_local_button, W0
	ADD	W0, #4, W0
	MOV	[W1], W13
	MOV	[W0], W12
;mmbInput_driver.c,880 :: 		local_button->Width, local_button->Height) == 1) {
	PUSH	[W3]
	PUSH	[W2]
	CALL	mmbInput_driver_IsInsideObject
	SUB	#4, W15
	CP.B	W0, #1
	BRA Z	L__Get_Object190
	GOTO	L_Get_Object52
L__Get_Object190:
;mmbInput_driver.c,881 :: 		button_order = local_button->Order;
	MOV	_local_button, W0
	INC2	W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	W0, _button_order
;mmbInput_driver.c,882 :: 		exec_button = local_button;
	MOV	_local_button, W0
	MOV	W0, _exec_button
;mmbInput_driver.c,883 :: 		}
L_Get_Object52:
;mmbInput_driver.c,884 :: 		}
L_Get_Object51:
;mmbInput_driver.c,876 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
	MOV	#1, W1
	MOV	#lo_addr(__object_count), W0
	ADD	W1, [W0], [W0]
;mmbInput_driver.c,885 :: 		}
	GOTO	L_Get_Object48
L_Get_Object49:
;mmbInput_driver.c,888 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ImagesCount ; _object_count++ ) {
	CLR	W0
	MOV	W0, __object_count
L_Get_Object53:
	MOV	_CurrentScreen, W0
	ADD	W0, #14, W0
	MOV	[W0], W1
	MOV	#lo_addr(__object_count), W0
	CP	W1, [W0]
	BRA GTU	L__Get_Object191
	GOTO	L_Get_Object54
L__Get_Object191:
;mmbInput_driver.c,889 :: 		local_image = GetImage(_object_count);
	MOV	_CurrentScreen, W0
	ADD	W0, #16, W4
	MOV	__object_count, W0
	ASR	W0, #15, W1
	MOV.D	W0, W2
	SL	W2, W2
	RLC	W3, W3
	ADD	W2, [W4++], W0
	ADDC	W3, [W4--], W1
	MOV	W1, 52
	MOV	[W0], W0
	MOV	W0, _local_image
;mmbInput_driver.c,890 :: 		if (local_image->Active == 1) {
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__Get_Object192
	GOTO	L_Get_Object56
L__Get_Object192:
;mmbInput_driver.c,892 :: 		local_image->Width, local_image->Height) == 1) {
	MOV	_local_image, W0
	ADD	W0, #10, W3
	MOV	_local_image, W0
	ADD	W0, #8, W2
;mmbInput_driver.c,891 :: 		if (IsInsideObject(X, Y, local_image->Left, local_image->Top,
	MOV	_local_image, W0
	ADD	W0, #6, W1
	MOV	_local_image, W0
	ADD	W0, #4, W0
	MOV	[W1], W13
	MOV	[W0], W12
;mmbInput_driver.c,892 :: 		local_image->Width, local_image->Height) == 1) {
	PUSH	[W3]
	PUSH	[W2]
	CALL	mmbInput_driver_IsInsideObject
	SUB	#4, W15
	CP.B	W0, #1
	BRA Z	L__Get_Object193
	GOTO	L_Get_Object57
L__Get_Object193:
;mmbInput_driver.c,893 :: 		image_order = local_image->Order;
	MOV	_local_image, W0
	INC2	W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	W0, _image_order
;mmbInput_driver.c,894 :: 		exec_image = local_image;
	MOV	_local_image, W0
	MOV	W0, _exec_image
;mmbInput_driver.c,895 :: 		}
L_Get_Object57:
;mmbInput_driver.c,896 :: 		}
L_Get_Object56:
;mmbInput_driver.c,888 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ImagesCount ; _object_count++ ) {
	MOV	#1, W1
	MOV	#lo_addr(__object_count), W0
	ADD	W1, [W0], [W0]
;mmbInput_driver.c,897 :: 		}
	GOTO	L_Get_Object53
L_Get_Object54:
;mmbInput_driver.c,900 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->RadioButtonsCount ; _object_count++ ) {
	CLR	W0
	MOV	W0, __object_count
L_Get_Object58:
	MOV	_CurrentScreen, W0
	ADD	W0, #20, W0
	MOV	[W0], W1
	MOV	#lo_addr(__object_count), W0
	CP	W1, [W0]
	BRA GTU	L__Get_Object194
	GOTO	L_Get_Object59
L__Get_Object194:
;mmbInput_driver.c,901 :: 		local_radio_button = GetRadioButton(_object_count);
	MOV	_CurrentScreen, W0
	ADD	W0, #22, W4
	MOV	__object_count, W0
	ASR	W0, #15, W1
	MOV.D	W0, W2
	SL	W2, W2
	RLC	W3, W3
	ADD	W2, [W4++], W0
	ADDC	W3, [W4--], W1
	MOV	W1, 52
	MOV	[W0], W0
	MOV	W0, _local_radio_button
;mmbInput_driver.c,902 :: 		if (local_radio_button->Active == 1) {
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__Get_Object195
	GOTO	L_Get_Object61
L__Get_Object195:
;mmbInput_driver.c,904 :: 		local_radio_button->Width, local_radio_button->Height) == 1) {
	MOV	_local_radio_button, W0
	ADD	W0, #10, W3
	MOV	_local_radio_button, W0
	ADD	W0, #8, W2
;mmbInput_driver.c,903 :: 		if (IsInsideObject(X, Y, local_radio_button->Left, local_radio_button->Top,
	MOV	_local_radio_button, W0
	ADD	W0, #6, W1
	MOV	_local_radio_button, W0
	ADD	W0, #4, W0
	MOV	[W1], W13
	MOV	[W0], W12
;mmbInput_driver.c,904 :: 		local_radio_button->Width, local_radio_button->Height) == 1) {
	PUSH	[W3]
	PUSH	[W2]
	CALL	mmbInput_driver_IsInsideObject
	SUB	#4, W15
	CP.B	W0, #1
	BRA Z	L__Get_Object196
	GOTO	L_Get_Object62
L__Get_Object196:
;mmbInput_driver.c,905 :: 		radio_button_order = local_radio_button->Order;
	MOV	_local_radio_button, W0
	INC2	W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	W0, _radio_button_order
;mmbInput_driver.c,906 :: 		exec_radio_button = local_radio_button;
	MOV	_local_radio_button, W0
	MOV	W0, _exec_radio_button
;mmbInput_driver.c,907 :: 		}
L_Get_Object62:
;mmbInput_driver.c,908 :: 		}
L_Get_Object61:
;mmbInput_driver.c,900 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->RadioButtonsCount ; _object_count++ ) {
	MOV	#1, W1
	MOV	#lo_addr(__object_count), W0
	ADD	W1, [W0], [W0]
;mmbInput_driver.c,909 :: 		}
	GOTO	L_Get_Object58
L_Get_Object59:
;mmbInput_driver.c,911 :: 		_object_count = -1;
	MOV	#65535, W0
	MOV	W0, __object_count
;mmbInput_driver.c,912 :: 		if (button_order > _object_count)
	MOV	_button_order, W1
	MOV	#65535, W0
	CP	W1, W0
	BRA GT	L__Get_Object197
	GOTO	L_Get_Object63
L__Get_Object197:
;mmbInput_driver.c,913 :: 		_object_count = button_order;
	MOV	_button_order, W0
	MOV	W0, __object_count
L_Get_Object63:
;mmbInput_driver.c,914 :: 		if (image_order >  _object_count )
	MOV	_image_order, W1
	MOV	#lo_addr(__object_count), W0
	CP	W1, [W0]
	BRA GT	L__Get_Object198
	GOTO	L_Get_Object64
L__Get_Object198:
;mmbInput_driver.c,915 :: 		_object_count = image_order;
	MOV	_image_order, W0
	MOV	W0, __object_count
L_Get_Object64:
;mmbInput_driver.c,916 :: 		if (radio_button_order >  _object_count )
	MOV	_radio_button_order, W1
	MOV	#lo_addr(__object_count), W0
	CP	W1, [W0]
	BRA GT	L__Get_Object199
	GOTO	L_Get_Object65
L__Get_Object199:
;mmbInput_driver.c,917 :: 		_object_count = radio_button_order;
	MOV	_radio_button_order, W0
	MOV	W0, __object_count
L_Get_Object65:
;mmbInput_driver.c,918 :: 		}
L_end_Get_Object:
	POP	W13
	POP	W12
	RETURN
; end of _Get_Object

mmbInput_driver_Process_TP_Press:

;mmbInput_driver.c,921 :: 		static void Process_TP_Press(unsigned int X, unsigned int Y) {
;mmbInput_driver.c,922 :: 		exec_button         = 0;
	CLR	W0
	MOV	W0, _exec_button
;mmbInput_driver.c,923 :: 		exec_image          = 0;
	CLR	W0
	MOV	W0, _exec_image
;mmbInput_driver.c,924 :: 		exec_radio_button     = 0;
	CLR	W0
	MOV	W0, _exec_radio_button
;mmbInput_driver.c,926 :: 		Get_Object(X, Y);
	CALL	_Get_Object
;mmbInput_driver.c,929 :: 		if (_object_count != -1) {
	MOV	#65535, W1
	MOV	#lo_addr(__object_count), W0
	CP	W1, [W0]
	BRA NZ	L_mmbInput_driver_Process_TP_Press201
	GOTO	L_mmbInput_driver_Process_TP_Press66
L_mmbInput_driver_Process_TP_Press201:
;mmbInput_driver.c,930 :: 		if (_object_count == button_order) {
	MOV	__object_count, W1
	MOV	#lo_addr(_button_order), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Press202
	GOTO	L_mmbInput_driver_Process_TP_Press67
L_mmbInput_driver_Process_TP_Press202:
;mmbInput_driver.c,931 :: 		if (exec_button->Active == 1) {
	MOV	_exec_button, W0
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Press203
	GOTO	L_mmbInput_driver_Process_TP_Press68
L_mmbInput_driver_Process_TP_Press203:
;mmbInput_driver.c,932 :: 		if (exec_button->OnPressPtr != 0) {
	MOV	#48, W1
	MOV	#lo_addr(_exec_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Press204
	GOTO	L_mmbInput_driver_Process_TP_Press69
L_mmbInput_driver_Process_TP_Press204:
;mmbInput_driver.c,933 :: 		exec_button->OnPressPtr();
	MOV	#48, W1
	MOV	#lo_addr(_exec_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CALL	W0
;mmbInput_driver.c,934 :: 		return;
	GOTO	L_end_Process_TP_Press
;mmbInput_driver.c,935 :: 		}
L_mmbInput_driver_Process_TP_Press69:
;mmbInput_driver.c,936 :: 		}
L_mmbInput_driver_Process_TP_Press68:
;mmbInput_driver.c,937 :: 		}
L_mmbInput_driver_Process_TP_Press67:
;mmbInput_driver.c,939 :: 		if (_object_count == image_order) {
	MOV	__object_count, W1
	MOV	#lo_addr(_image_order), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Press205
	GOTO	L_mmbInput_driver_Process_TP_Press70
L_mmbInput_driver_Process_TP_Press205:
;mmbInput_driver.c,940 :: 		if (exec_image->Active == 1) {
	MOV	_exec_image, W0
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Press206
	GOTO	L_mmbInput_driver_Process_TP_Press71
L_mmbInput_driver_Process_TP_Press206:
;mmbInput_driver.c,941 :: 		if (exec_image->OnPressPtr != 0) {
	MOV	_exec_image, W0
	ADD	W0, #26, W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Press207
	GOTO	L_mmbInput_driver_Process_TP_Press72
L_mmbInput_driver_Process_TP_Press207:
;mmbInput_driver.c,942 :: 		exec_image->OnPressPtr();
	MOV	_exec_image, W0
	ADD	W0, #26, W0
	MOV	[W0], W0
	CALL	W0
;mmbInput_driver.c,943 :: 		return;
	GOTO	L_end_Process_TP_Press
;mmbInput_driver.c,944 :: 		}
L_mmbInput_driver_Process_TP_Press72:
;mmbInput_driver.c,945 :: 		}
L_mmbInput_driver_Process_TP_Press71:
;mmbInput_driver.c,946 :: 		}
L_mmbInput_driver_Process_TP_Press70:
;mmbInput_driver.c,948 :: 		if (_object_count == radio_button_order) {
	MOV	__object_count, W1
	MOV	#lo_addr(_radio_button_order), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Press208
	GOTO	L_mmbInput_driver_Process_TP_Press73
L_mmbInput_driver_Process_TP_Press208:
;mmbInput_driver.c,949 :: 		if (exec_radio_button->Active == 1) {
	MOV	_exec_radio_button, W0
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Press209
	GOTO	L_mmbInput_driver_Process_TP_Press74
L_mmbInput_driver_Process_TP_Press209:
;mmbInput_driver.c,950 :: 		if (exec_radio_button->OnPressPtr != 0) {
	MOV	#50, W1
	MOV	#lo_addr(_exec_radio_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Press210
	GOTO	L_mmbInput_driver_Process_TP_Press75
L_mmbInput_driver_Process_TP_Press210:
;mmbInput_driver.c,951 :: 		exec_radio_button->OnPressPtr();
	MOV	#50, W1
	MOV	#lo_addr(_exec_radio_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CALL	W0
;mmbInput_driver.c,952 :: 		return;
	GOTO	L_end_Process_TP_Press
;mmbInput_driver.c,953 :: 		}
L_mmbInput_driver_Process_TP_Press75:
;mmbInput_driver.c,954 :: 		}
L_mmbInput_driver_Process_TP_Press74:
;mmbInput_driver.c,955 :: 		}
L_mmbInput_driver_Process_TP_Press73:
;mmbInput_driver.c,957 :: 		}
L_mmbInput_driver_Process_TP_Press66:
;mmbInput_driver.c,958 :: 		}
L_end_Process_TP_Press:
	RETURN
; end of mmbInput_driver_Process_TP_Press

mmbInput_driver_Process_TP_Up:

;mmbInput_driver.c,960 :: 		static void Process_TP_Up(unsigned int X, unsigned int Y) {
;mmbInput_driver.c,962 :: 		switch (PressedObjectType) {
	GOTO	L_mmbInput_driver_Process_TP_Up76
;mmbInput_driver.c,964 :: 		case 0: {
L_mmbInput_driver_Process_TP_Up78:
;mmbInput_driver.c,965 :: 		if (PressedObject != 0) {
	MOV	_PressedObject, W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Up212
	GOTO	L_mmbInput_driver_Process_TP_Up79
L_mmbInput_driver_Process_TP_Up212:
;mmbInput_driver.c,966 :: 		exec_button = (TButton*)PressedObject;
	MOV	_PressedObject, W0
	MOV	W0, _exec_button
;mmbInput_driver.c,967 :: 		if ((exec_button->PressColEnabled == 1) && (exec_button->OwnerScreen == CurrentScreen)) {
	MOV	#38, W1
	MOV	#lo_addr(_PressedObject), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Up213
	GOTO	L_mmbInput_driver_Process_TP_Up137
L_mmbInput_driver_Process_TP_Up213:
	MOV	_exec_button, W0
	MOV	[W0], W1
	MOV	#lo_addr(_CurrentScreen), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Up214
	GOTO	L_mmbInput_driver_Process_TP_Up136
L_mmbInput_driver_Process_TP_Up214:
L_mmbInput_driver_Process_TP_Up135:
;mmbInput_driver.c,968 :: 		DrawButton(exec_button);
	PUSH.D	W10
	MOV	_exec_button, W10
	CALL	_DrawButton
	POP.D	W10
;mmbInput_driver.c,967 :: 		if ((exec_button->PressColEnabled == 1) && (exec_button->OwnerScreen == CurrentScreen)) {
L_mmbInput_driver_Process_TP_Up137:
L_mmbInput_driver_Process_TP_Up136:
;mmbInput_driver.c,970 :: 		break;
	GOTO	L_mmbInput_driver_Process_TP_Up77
;mmbInput_driver.c,971 :: 		}
L_mmbInput_driver_Process_TP_Up79:
;mmbInput_driver.c,972 :: 		break;
	GOTO	L_mmbInput_driver_Process_TP_Up77
;mmbInput_driver.c,975 :: 		case 17: {
L_mmbInput_driver_Process_TP_Up83:
;mmbInput_driver.c,976 :: 		if (PressedObject != 0) {
	MOV	_PressedObject, W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Up215
	GOTO	L_mmbInput_driver_Process_TP_Up84
L_mmbInput_driver_Process_TP_Up215:
;mmbInput_driver.c,977 :: 		exec_radio_button = (TRadioButton*)PressedObject;
	MOV	_PressedObject, W0
	MOV	W0, _exec_radio_button
;mmbInput_driver.c,978 :: 		if ((exec_radio_button->PressColEnabled == 1) && (exec_radio_button->OwnerScreen == CurrentScreen)) {
	MOV	#40, W1
	MOV	#lo_addr(_PressedObject), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Up216
	GOTO	L_mmbInput_driver_Process_TP_Up139
L_mmbInput_driver_Process_TP_Up216:
	MOV	_exec_radio_button, W0
	MOV	[W0], W1
	MOV	#lo_addr(_CurrentScreen), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Up217
	GOTO	L_mmbInput_driver_Process_TP_Up138
L_mmbInput_driver_Process_TP_Up217:
L_mmbInput_driver_Process_TP_Up134:
;mmbInput_driver.c,979 :: 		DrawRadioButton(exec_radio_button);
	PUSH.D	W10
	MOV	_exec_radio_button, W10
	CALL	_DrawRadioButton
	POP.D	W10
;mmbInput_driver.c,978 :: 		if ((exec_radio_button->PressColEnabled == 1) && (exec_radio_button->OwnerScreen == CurrentScreen)) {
L_mmbInput_driver_Process_TP_Up139:
L_mmbInput_driver_Process_TP_Up138:
;mmbInput_driver.c,981 :: 		break;
	GOTO	L_mmbInput_driver_Process_TP_Up77
;mmbInput_driver.c,982 :: 		}
L_mmbInput_driver_Process_TP_Up84:
;mmbInput_driver.c,983 :: 		break;
	GOTO	L_mmbInput_driver_Process_TP_Up77
;mmbInput_driver.c,985 :: 		}
L_mmbInput_driver_Process_TP_Up76:
	MOV	_PressedObjectType, W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Up218
	GOTO	L_mmbInput_driver_Process_TP_Up78
L_mmbInput_driver_Process_TP_Up218:
	MOV	_PressedObjectType, W0
	CP	W0, #17
	BRA NZ	L_mmbInput_driver_Process_TP_Up219
	GOTO	L_mmbInput_driver_Process_TP_Up83
L_mmbInput_driver_Process_TP_Up219:
L_mmbInput_driver_Process_TP_Up77:
;mmbInput_driver.c,987 :: 		exec_image          = 0;
	CLR	W0
	MOV	W0, _exec_image
;mmbInput_driver.c,989 :: 		Get_Object(X, Y);
	CALL	_Get_Object
;mmbInput_driver.c,992 :: 		if (_object_count != -1) {
	MOV	#65535, W1
	MOV	#lo_addr(__object_count), W0
	CP	W1, [W0]
	BRA NZ	L_mmbInput_driver_Process_TP_Up220
	GOTO	L_mmbInput_driver_Process_TP_Up88
L_mmbInput_driver_Process_TP_Up220:
;mmbInput_driver.c,994 :: 		if (_object_count == button_order) {
	MOV	__object_count, W1
	MOV	#lo_addr(_button_order), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Up221
	GOTO	L_mmbInput_driver_Process_TP_Up89
L_mmbInput_driver_Process_TP_Up221:
;mmbInput_driver.c,995 :: 		if (exec_button->Active == 1) {
	MOV	_exec_button, W0
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Up222
	GOTO	L_mmbInput_driver_Process_TP_Up90
L_mmbInput_driver_Process_TP_Up222:
;mmbInput_driver.c,996 :: 		if (exec_button->OnUpPtr != 0)
	MOV	#42, W1
	MOV	#lo_addr(_exec_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Up223
	GOTO	L_mmbInput_driver_Process_TP_Up91
L_mmbInput_driver_Process_TP_Up223:
;mmbInput_driver.c,997 :: 		exec_button->OnUpPtr();
	MOV	#42, W1
	MOV	#lo_addr(_exec_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CALL	W0
L_mmbInput_driver_Process_TP_Up91:
;mmbInput_driver.c,998 :: 		if (PressedObject == (void *)exec_button)
	MOV	_PressedObject, W1
	MOV	#lo_addr(_exec_button), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Up224
	GOTO	L_mmbInput_driver_Process_TP_Up92
L_mmbInput_driver_Process_TP_Up224:
;mmbInput_driver.c,999 :: 		if (exec_button->OnClickPtr != 0)
	MOV	#46, W1
	MOV	#lo_addr(_exec_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Up225
	GOTO	L_mmbInput_driver_Process_TP_Up93
L_mmbInput_driver_Process_TP_Up225:
;mmbInput_driver.c,1000 :: 		exec_button->OnClickPtr();
	MOV	#46, W1
	MOV	#lo_addr(_exec_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CALL	W0
L_mmbInput_driver_Process_TP_Up93:
L_mmbInput_driver_Process_TP_Up92:
;mmbInput_driver.c,1001 :: 		PressedObject = 0;
	CLR	W0
	MOV	W0, _PressedObject
;mmbInput_driver.c,1002 :: 		PressedObjectType = -1;
	MOV	#65535, W0
	MOV	W0, _PressedObjectType
;mmbInput_driver.c,1003 :: 		return;
	GOTO	L_end_Process_TP_Up
;mmbInput_driver.c,1004 :: 		}
L_mmbInput_driver_Process_TP_Up90:
;mmbInput_driver.c,1005 :: 		}
L_mmbInput_driver_Process_TP_Up89:
;mmbInput_driver.c,1008 :: 		if (_object_count == image_order) {
	MOV	__object_count, W1
	MOV	#lo_addr(_image_order), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Up226
	GOTO	L_mmbInput_driver_Process_TP_Up94
L_mmbInput_driver_Process_TP_Up226:
;mmbInput_driver.c,1009 :: 		if (exec_image->Active == 1) {
	MOV	_exec_image, W0
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Up227
	GOTO	L_mmbInput_driver_Process_TP_Up95
L_mmbInput_driver_Process_TP_Up227:
;mmbInput_driver.c,1010 :: 		if (exec_image->OnUpPtr != 0)
	MOV	_exec_image, W0
	ADD	W0, #20, W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Up228
	GOTO	L_mmbInput_driver_Process_TP_Up96
L_mmbInput_driver_Process_TP_Up228:
;mmbInput_driver.c,1011 :: 		exec_image->OnUpPtr();
	MOV	_exec_image, W0
	ADD	W0, #20, W0
	MOV	[W0], W0
	CALL	W0
L_mmbInput_driver_Process_TP_Up96:
;mmbInput_driver.c,1012 :: 		if (PressedObject == (void *)exec_image)
	MOV	_PressedObject, W1
	MOV	#lo_addr(_exec_image), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Up229
	GOTO	L_mmbInput_driver_Process_TP_Up97
L_mmbInput_driver_Process_TP_Up229:
;mmbInput_driver.c,1013 :: 		if (exec_image->OnClickPtr != 0)
	MOV	_exec_image, W0
	ADD	W0, #24, W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Up230
	GOTO	L_mmbInput_driver_Process_TP_Up98
L_mmbInput_driver_Process_TP_Up230:
;mmbInput_driver.c,1014 :: 		exec_image->OnClickPtr();
	MOV	_exec_image, W0
	ADD	W0, #24, W0
	MOV	[W0], W0
	CALL	W0
L_mmbInput_driver_Process_TP_Up98:
L_mmbInput_driver_Process_TP_Up97:
;mmbInput_driver.c,1015 :: 		PressedObject = 0;
	CLR	W0
	MOV	W0, _PressedObject
;mmbInput_driver.c,1016 :: 		PressedObjectType = -1;
	MOV	#65535, W0
	MOV	W0, _PressedObjectType
;mmbInput_driver.c,1017 :: 		return;
	GOTO	L_end_Process_TP_Up
;mmbInput_driver.c,1018 :: 		}
L_mmbInput_driver_Process_TP_Up95:
;mmbInput_driver.c,1019 :: 		}
L_mmbInput_driver_Process_TP_Up94:
;mmbInput_driver.c,1022 :: 		if (_object_count == radio_button_order) {
	MOV	__object_count, W1
	MOV	#lo_addr(_radio_button_order), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Up231
	GOTO	L_mmbInput_driver_Process_TP_Up99
L_mmbInput_driver_Process_TP_Up231:
;mmbInput_driver.c,1023 :: 		if (exec_radio_button->Active == 1) {
	MOV	_exec_radio_button, W0
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Up232
	GOTO	L_mmbInput_driver_Process_TP_Up100
L_mmbInput_driver_Process_TP_Up232:
;mmbInput_driver.c,1024 :: 		if (exec_radio_button->OnUpPtr != 0)
	MOV	#44, W1
	MOV	#lo_addr(_exec_radio_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Up233
	GOTO	L_mmbInput_driver_Process_TP_Up101
L_mmbInput_driver_Process_TP_Up233:
;mmbInput_driver.c,1025 :: 		exec_radio_button->OnUpPtr();
	MOV	#44, W1
	MOV	#lo_addr(_exec_radio_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CALL	W0
L_mmbInput_driver_Process_TP_Up101:
;mmbInput_driver.c,1026 :: 		if (PressedObject == (void *)exec_radio_button)
	MOV	_PressedObject, W1
	MOV	#lo_addr(_exec_radio_button), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Up234
	GOTO	L_mmbInput_driver_Process_TP_Up102
L_mmbInput_driver_Process_TP_Up234:
;mmbInput_driver.c,1027 :: 		if (exec_radio_button->OnClickPtr != 0)
	MOV	#48, W1
	MOV	#lo_addr(_exec_radio_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Up235
	GOTO	L_mmbInput_driver_Process_TP_Up103
L_mmbInput_driver_Process_TP_Up235:
;mmbInput_driver.c,1028 :: 		exec_radio_button->OnClickPtr();
	MOV	#48, W1
	MOV	#lo_addr(_exec_radio_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CALL	W0
L_mmbInput_driver_Process_TP_Up103:
L_mmbInput_driver_Process_TP_Up102:
;mmbInput_driver.c,1029 :: 		PressedObject = 0;
	CLR	W0
	MOV	W0, _PressedObject
;mmbInput_driver.c,1030 :: 		PressedObjectType = -1;
	MOV	#65535, W0
	MOV	W0, _PressedObjectType
;mmbInput_driver.c,1031 :: 		return;
	GOTO	L_end_Process_TP_Up
;mmbInput_driver.c,1032 :: 		}
L_mmbInput_driver_Process_TP_Up100:
;mmbInput_driver.c,1033 :: 		}
L_mmbInput_driver_Process_TP_Up99:
;mmbInput_driver.c,1035 :: 		}
L_mmbInput_driver_Process_TP_Up88:
;mmbInput_driver.c,1036 :: 		PressedObject = 0;
	CLR	W0
	MOV	W0, _PressedObject
;mmbInput_driver.c,1037 :: 		PressedObjectType = -1;
	MOV	#65535, W0
	MOV	W0, _PressedObjectType
;mmbInput_driver.c,1038 :: 		}
L_end_Process_TP_Up:
	RETURN
; end of mmbInput_driver_Process_TP_Up

mmbInput_driver_Process_TP_Down:

;mmbInput_driver.c,1040 :: 		static void Process_TP_Down(unsigned int X, unsigned int Y) {
;mmbInput_driver.c,1042 :: 		object_pressed      = 0;
	PUSH	W10
	MOV	#lo_addr(_object_pressed), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,1043 :: 		exec_button         = 0;
	CLR	W0
	MOV	W0, _exec_button
;mmbInput_driver.c,1044 :: 		exec_image          = 0;
	CLR	W0
	MOV	W0, _exec_image
;mmbInput_driver.c,1045 :: 		exec_radio_button     = 0;
	CLR	W0
	MOV	W0, _exec_radio_button
;mmbInput_driver.c,1047 :: 		Get_Object(X, Y);
	CALL	_Get_Object
;mmbInput_driver.c,1049 :: 		if (_object_count != -1) {
	MOV	#65535, W1
	MOV	#lo_addr(__object_count), W0
	CP	W1, [W0]
	BRA NZ	L_mmbInput_driver_Process_TP_Down237
	GOTO	L_mmbInput_driver_Process_TP_Down104
L_mmbInput_driver_Process_TP_Down237:
;mmbInput_driver.c,1050 :: 		if (_object_count == button_order) {
	MOV	__object_count, W1
	MOV	#lo_addr(_button_order), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Down238
	GOTO	L_mmbInput_driver_Process_TP_Down105
L_mmbInput_driver_Process_TP_Down238:
;mmbInput_driver.c,1051 :: 		if (exec_button->Active == 1) {
	MOV	_exec_button, W0
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Down239
	GOTO	L_mmbInput_driver_Process_TP_Down106
L_mmbInput_driver_Process_TP_Down239:
;mmbInput_driver.c,1052 :: 		if (exec_button->PressColEnabled == 1) {
	MOV	#38, W1
	MOV	#lo_addr(_exec_button), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Down240
	GOTO	L_mmbInput_driver_Process_TP_Down107
L_mmbInput_driver_Process_TP_Down240:
;mmbInput_driver.c,1053 :: 		object_pressed = 1;
	MOV	#lo_addr(_object_pressed), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,1054 :: 		DrawButton(exec_button);
	MOV	_exec_button, W10
	CALL	_DrawButton
;mmbInput_driver.c,1055 :: 		}
L_mmbInput_driver_Process_TP_Down107:
;mmbInput_driver.c,1056 :: 		PressedObject = (void *)exec_button;
	MOV	_exec_button, W0
	MOV	W0, _PressedObject
;mmbInput_driver.c,1057 :: 		PressedObjectType = 0;
	CLR	W0
	MOV	W0, _PressedObjectType
;mmbInput_driver.c,1058 :: 		if (exec_button->OnDownPtr != 0) {
	MOV	#44, W1
	MOV	#lo_addr(_exec_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Down241
	GOTO	L_mmbInput_driver_Process_TP_Down108
L_mmbInput_driver_Process_TP_Down241:
;mmbInput_driver.c,1059 :: 		exec_button->OnDownPtr();
	MOV	#44, W1
	MOV	#lo_addr(_exec_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CALL	W0
;mmbInput_driver.c,1060 :: 		return;
	GOTO	L_end_Process_TP_Down
;mmbInput_driver.c,1061 :: 		}
L_mmbInput_driver_Process_TP_Down108:
;mmbInput_driver.c,1062 :: 		}
L_mmbInput_driver_Process_TP_Down106:
;mmbInput_driver.c,1063 :: 		}
L_mmbInput_driver_Process_TP_Down105:
;mmbInput_driver.c,1065 :: 		if (_object_count == image_order) {
	MOV	__object_count, W1
	MOV	#lo_addr(_image_order), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Down242
	GOTO	L_mmbInput_driver_Process_TP_Down109
L_mmbInput_driver_Process_TP_Down242:
;mmbInput_driver.c,1066 :: 		if (exec_image->Active == 1) {
	MOV	_exec_image, W0
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Down243
	GOTO	L_mmbInput_driver_Process_TP_Down110
L_mmbInput_driver_Process_TP_Down243:
;mmbInput_driver.c,1067 :: 		PressedObject = (void *)exec_image;
	MOV	_exec_image, W0
	MOV	W0, _PressedObject
;mmbInput_driver.c,1068 :: 		PressedObjectType = 3;
	MOV	#3, W0
	MOV	W0, _PressedObjectType
;mmbInput_driver.c,1069 :: 		if (exec_image->OnDownPtr != 0) {
	MOV	_exec_image, W0
	ADD	W0, #22, W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Down244
	GOTO	L_mmbInput_driver_Process_TP_Down111
L_mmbInput_driver_Process_TP_Down244:
;mmbInput_driver.c,1070 :: 		exec_image->OnDownPtr();
	MOV	_exec_image, W0
	ADD	W0, #22, W0
	MOV	[W0], W0
	CALL	W0
;mmbInput_driver.c,1071 :: 		return;
	GOTO	L_end_Process_TP_Down
;mmbInput_driver.c,1072 :: 		}
L_mmbInput_driver_Process_TP_Down111:
;mmbInput_driver.c,1073 :: 		}
L_mmbInput_driver_Process_TP_Down110:
;mmbInput_driver.c,1074 :: 		}
L_mmbInput_driver_Process_TP_Down109:
;mmbInput_driver.c,1076 :: 		if (_object_count == radio_button_order) {
	MOV	__object_count, W1
	MOV	#lo_addr(_radio_button_order), W0
	CP	W1, [W0]
	BRA Z	L_mmbInput_driver_Process_TP_Down245
	GOTO	L_mmbInput_driver_Process_TP_Down112
L_mmbInput_driver_Process_TP_Down245:
;mmbInput_driver.c,1077 :: 		if (exec_radio_button->Active == 1) {
	MOV	_exec_radio_button, W0
	ADD	W0, #17, W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Down246
	GOTO	L_mmbInput_driver_Process_TP_Down113
L_mmbInput_driver_Process_TP_Down246:
;mmbInput_driver.c,1078 :: 		if (exec_radio_button->PressColEnabled == 1) {
	MOV	#40, W1
	MOV	#lo_addr(_exec_radio_button), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L_mmbInput_driver_Process_TP_Down247
	GOTO	L_mmbInput_driver_Process_TP_Down114
L_mmbInput_driver_Process_TP_Down247:
;mmbInput_driver.c,1079 :: 		object_pressed = 1;
	MOV	#lo_addr(_object_pressed), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,1080 :: 		DrawRadioButton(exec_radio_button);
	MOV	_exec_radio_button, W10
	CALL	_DrawRadioButton
;mmbInput_driver.c,1081 :: 		}
L_mmbInput_driver_Process_TP_Down114:
;mmbInput_driver.c,1082 :: 		PressedObject = (void *)exec_radio_button;
	MOV	_exec_radio_button, W0
	MOV	W0, _PressedObject
;mmbInput_driver.c,1083 :: 		PressedObjectType = 17;
	MOV	#17, W0
	MOV	W0, _PressedObjectType
;mmbInput_driver.c,1084 :: 		if (exec_radio_button->OnDownPtr != 0) {
	MOV	#46, W1
	MOV	#lo_addr(_exec_radio_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CP	W0, #0
	BRA NZ	L_mmbInput_driver_Process_TP_Down248
	GOTO	L_mmbInput_driver_Process_TP_Down115
L_mmbInput_driver_Process_TP_Down248:
;mmbInput_driver.c,1085 :: 		exec_radio_button->OnDownPtr();
	MOV	#46, W1
	MOV	#lo_addr(_exec_radio_button), W0
	ADD	W1, [W0], W0
	MOV	[W0], W0
	CALL	W0
;mmbInput_driver.c,1086 :: 		return;
	GOTO	L_end_Process_TP_Down
;mmbInput_driver.c,1087 :: 		}
L_mmbInput_driver_Process_TP_Down115:
;mmbInput_driver.c,1088 :: 		}
L_mmbInput_driver_Process_TP_Down113:
;mmbInput_driver.c,1089 :: 		}
L_mmbInput_driver_Process_TP_Down112:
;mmbInput_driver.c,1091 :: 		}
L_mmbInput_driver_Process_TP_Down104:
;mmbInput_driver.c,1092 :: 		}
L_end_Process_TP_Down:
	POP	W10
	RETURN
; end of mmbInput_driver_Process_TP_Down

_Check_TP:

;mmbInput_driver.c,1094 :: 		void Check_TP() {
;mmbInput_driver.c,1095 :: 		if (TP_TFT_Press_Detect()) {
	PUSH	W10
	PUSH	W11
	CALL	_TP_TFT_Press_Detect
	CP0.B	W0
	BRA NZ	L__Check_TP250
	GOTO	L_Check_TP116
L__Check_TP250:
;mmbInput_driver.c,1097 :: 		if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
	MOV	#lo_addr(_Ycoord), W11
	MOV	#lo_addr(_Xcoord), W10
	CALL	_TP_TFT_Get_Coordinates
	CP.B	W0, #0
	BRA Z	L__Check_TP251
	GOTO	L_Check_TP117
L__Check_TP251:
;mmbInput_driver.c,1098 :: 		Process_TP_Press(Xcoord, Ycoord);
	MOV	_Ycoord, W11
	MOV	_Xcoord, W10
	CALL	mmbInput_driver_Process_TP_Press
;mmbInput_driver.c,1099 :: 		if (PenDown == 0) {
	MOV	#lo_addr(_PenDown), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__Check_TP252
	GOTO	L_Check_TP118
L__Check_TP252:
;mmbInput_driver.c,1100 :: 		PenDown = 1;
	MOV	#lo_addr(_PenDown), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,1101 :: 		Process_TP_Down(Xcoord, Ycoord);
	MOV	_Ycoord, W11
	MOV	_Xcoord, W10
	CALL	mmbInput_driver_Process_TP_Down
;mmbInput_driver.c,1102 :: 		}
L_Check_TP118:
;mmbInput_driver.c,1103 :: 		}
L_Check_TP117:
;mmbInput_driver.c,1104 :: 		}
	GOTO	L_Check_TP119
L_Check_TP116:
;mmbInput_driver.c,1105 :: 		else if (PenDown == 1) {
	MOV	#lo_addr(_PenDown), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__Check_TP253
	GOTO	L_Check_TP120
L__Check_TP253:
;mmbInput_driver.c,1106 :: 		PenDown = 0;
	MOV	#lo_addr(_PenDown), W1
	CLR	W0
	MOV.B	W0, [W1]
;mmbInput_driver.c,1107 :: 		Process_TP_Up(Xcoord, Ycoord);
	MOV	_Ycoord, W11
	MOV	_Xcoord, W10
	CALL	mmbInput_driver_Process_TP_Up
;mmbInput_driver.c,1108 :: 		}
L_Check_TP120:
L_Check_TP119:
;mmbInput_driver.c,1109 :: 		}
L_end_Check_TP:
	POP	W11
	POP	W10
	RETURN
; end of _Check_TP

_Init_MCU:

;mmbInput_driver.c,1111 :: 		void Init_MCU() {
;mmbInput_driver.c,1112 :: 		TRISE = 0;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CLR	TRISE
;mmbInput_driver.c,1113 :: 		TFT_DataPort_Direction = 0;
	CLR.B	TRISA
;mmbInput_driver.c,1114 :: 		CLKDIVbits.PLLPRE = 0;      // PLLPRE<4:0> = 0  ->  N1 = 2    8MHz / 2 = 4MHz
	MOV	#lo_addr(CLKDIVbits), W0
	MOV.B	[W0], W1
	MOV.B	#224, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(CLKDIVbits), W0
	MOV.B	W1, [W0]
;mmbInput_driver.c,1116 :: 		PLLFBD =   38;              // PLLDIV<8:0> = 38 ->  M = 40    4MHz * 40 = 160MHz
	MOV	#38, W0
	MOV	WREG, PLLFBD
;mmbInput_driver.c,1118 :: 		CLKDIVbits.PLLPOST = 0;     // PLLPOST<1:0> = 0 ->  N2 = 2    160MHz / 2 = 80MHz
	MOV	#lo_addr(CLKDIVbits), W0
	MOV.B	[W0], W1
	MOV.B	#63, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(CLKDIVbits), W0
	MOV.B	W1, [W0]
;mmbInput_driver.c,1120 :: 		Delay_ms(150);
	MOV	#31, W8
	MOV	#33929, W7
L_Init_MCU121:
	DEC	W7
	BRA NZ	L_Init_MCU121
	DEC	W8
	BRA NZ	L_Init_MCU121
;mmbInput_driver.c,1121 :: 		TP_TFT_Rotate_180(0);
	CLR	W10
	CALL	_TP_TFT_Rotate_180
;mmbInput_driver.c,1122 :: 		TFT_Set_Active(Set_Index,Write_Command,Write_Data);
	MOV	#lo_addr(_Write_Data), W12
	MOV	#lo_addr(_Write_Command), W11
	MOV	#lo_addr(_Set_Index), W10
	CALL	_TFT_Set_Active
;mmbInput_driver.c,1123 :: 		}
L_end_Init_MCU:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _Init_MCU

_Init_Ext_Mem:

;mmbInput_driver.c,1125 :: 		void Init_Ext_Mem() {
;mmbInput_driver.c,1127 :: 		SPI2_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, _SPI_PRESCALE_SEC_1, _SPI_PRESCALE_PRI_64,
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	CLR	W13
	MOV	#28, W12
	CLR	W11
	MOV	#32, W10
;mmbInput_driver.c,1128 :: 		_SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_IDLE_2_ACTIVE);
	MOV	#256, W0
	PUSH	W0
	CLR	W0
	PUSH	W0
	CLR	W0
	PUSH	W0
	CLR	W0
	PUSH	W0
	CALL	_SPI2_Init_Advanced
	SUB	#8, W15
;mmbInput_driver.c,1129 :: 		Delay_ms(10);
	MOV	#3, W8
	MOV	#2261, W7
L_Init_Ext_Mem123:
	DEC	W7
	BRA NZ	L_Init_Ext_Mem123
	DEC	W8
	BRA NZ	L_Init_Ext_Mem123
;mmbInput_driver.c,1132 :: 		if (!Mmc_Fat_Init()) {
	CALL	_Mmc_Fat_Init
	CP0.B	W0
	BRA Z	L__Init_Ext_Mem256
	GOTO	L_Init_Ext_Mem125
L__Init_Ext_Mem256:
;mmbInput_driver.c,1134 :: 		SPI2_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, _SPI_PRESCALE_SEC_1, _SPI_PRESCALE_PRI_4,
	MOV	#2, W13
	MOV	#28, W12
	CLR	W11
	MOV	#32, W10
;mmbInput_driver.c,1135 :: 		_SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_IDLE_2_ACTIVE);
	MOV	#256, W0
	PUSH	W0
	CLR	W0
	PUSH	W0
	CLR	W0
	PUSH	W0
	CLR	W0
	PUSH	W0
	CALL	_SPI2_Init_Advanced
	SUB	#8, W15
;mmbInput_driver.c,1138 :: 		Mmc_Fat_Assign("mmbInput.RES", 0);
	CLR	W11
	MOV	#lo_addr(?lstr1_mmbInput_driver), W10
	CALL	_Mmc_Fat_Assign
;mmbInput_driver.c,1139 :: 		Mmc_Fat_Reset(&res_file_size);
	MOV	#lo_addr(_res_file_size), W10
	CALL	_Mmc_Fat_Reset
;mmbInput_driver.c,1140 :: 		}
L_Init_Ext_Mem125:
;mmbInput_driver.c,1141 :: 		}
L_end_Init_Ext_Mem:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _Init_Ext_Mem

_Start_TP:

;mmbInput_driver.c,1143 :: 		void Start_TP() {
;mmbInput_driver.c,1144 :: 		Init_MCU();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	CALL	_Init_MCU
;mmbInput_driver.c,1146 :: 		Init_Ext_Mem();
	CALL	_Init_Ext_Mem
;mmbInput_driver.c,1148 :: 		InitializeTouchPanel();
	CALL	mmbInput_driver_InitializeTouchPanel
;mmbInput_driver.c,1151 :: 		TP_TFT_Set_Calibration_Consts(149, 776, 68, 765);    // Set calibration constants
	MOV	#765, W13
	MOV	#68, W12
	MOV	#776, W11
	MOV	#149, W10
	CALL	_TP_TFT_Set_Calibration_Consts
;mmbInput_driver.c,1153 :: 		InitializeObjects();
	CALL	mmbInput_driver_InitializeObjects
;mmbInput_driver.c,1154 :: 		display_width = Screen1.Width;
	MOV	_Screen1+2, W0
	MOV	W0, _display_width
;mmbInput_driver.c,1155 :: 		display_height = Screen1.Height;
	MOV	_Screen1+4, W0
	MOV	W0, _display_height
;mmbInput_driver.c,1156 :: 		DrawScreen(&Screen1);
	MOV	#lo_addr(_Screen1), W10
	CALL	_DrawScreen
;mmbInput_driver.c,1157 :: 		}
L_end_Start_TP:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _Start_TP

mmbInput_driver____?ag:

L_end_mmbInput_driver___?ag:
	RETURN
; end of mmbInput_driver____?ag
