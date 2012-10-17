_PMPWaitBusy:
;mmbInput_driver.c,65 :: 		void PMPWaitBusy() {
;mmbInput_driver.c,66 :: 		while(PMMODEbits.BUSY);
L_PMPWaitBusy0:
LBU	R2, Offset(PMMODEbits+1)(GP)
EXT	R2, R2, 7, 1
BNE	R2, R0, L__PMPWaitBusy142
NOP	
J	L_PMPWaitBusy1
NOP	
L__PMPWaitBusy142:
J	L_PMPWaitBusy0
NOP	
L_PMPWaitBusy1:
;mmbInput_driver.c,67 :: 		}
L_end_PMPWaitBusy:
JR	RA
NOP	
; end of _PMPWaitBusy
_Set_Index:
;mmbInput_driver.c,69 :: 		void Set_Index(unsigned short index) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_driver.c,70 :: 		TFT_RS = 0;
LBU	R2, Offset(LATB15_bit+1)(GP)
INS	R2, R0, 7, 1
SB	R2, Offset(LATB15_bit+1)(GP)
;mmbInput_driver.c,71 :: 		PMDIN = index;
ANDI	R2, R25, 255
SW	R2, Offset(PMDIN+0)(GP)
;mmbInput_driver.c,72 :: 		PMPWaitBusy();
JAL	_PMPWaitBusy+0
NOP	
;mmbInput_driver.c,73 :: 		}
L_end_Set_Index:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Set_Index
_Write_Command:
;mmbInput_driver.c,75 :: 		void Write_Command( unsigned short cmd ) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_driver.c,76 :: 		TFT_RS = 1;
LBU	R2, Offset(LATB15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATB15_bit+1)(GP)
;mmbInput_driver.c,77 :: 		PMDIN = cmd;
ANDI	R2, R25, 255
SW	R2, Offset(PMDIN+0)(GP)
;mmbInput_driver.c,78 :: 		PMPWaitBusy();
JAL	_PMPWaitBusy+0
NOP	
;mmbInput_driver.c,79 :: 		}
L_end_Write_Command:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Write_Command
_Write_Data:
;mmbInput_driver.c,81 :: 		void Write_Data(unsigned int _data) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_driver.c,82 :: 		TFT_RS = 1;
LBU	R2, Offset(LATB15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATB15_bit+1)(GP)
;mmbInput_driver.c,83 :: 		PMDIN = _data;
ANDI	R2, R25, 65535
SW	R2, Offset(PMDIN+0)(GP)
;mmbInput_driver.c,84 :: 		PMPWaitBusy();
JAL	_PMPWaitBusy+0
NOP	
;mmbInput_driver.c,85 :: 		}
L_end_Write_Data:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Write_Data
_Init_ADC:
;mmbInput_driver.c,88 :: 		void Init_ADC() {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_driver.c,89 :: 		AD1PCFG = 0xFFFF;
ORI	R2, R0, 65535
SW	R2, Offset(AD1PCFG+0)(GP)
;mmbInput_driver.c,90 :: 		PCFG12_bit = 0;
LBU	R2, Offset(PCFG12_bit+1)(GP)
INS	R2, R0, 4, 1
SB	R2, Offset(PCFG12_bit+1)(GP)
;mmbInput_driver.c,91 :: 		PCFG13_bit = 0;
LBU	R2, Offset(PCFG13_bit+1)(GP)
INS	R2, R0, 5, 1
SB	R2, Offset(PCFG13_bit+1)(GP)
;mmbInput_driver.c,93 :: 		ADC1_Init();
JAL	_ADC1_Init+0
NOP	
;mmbInput_driver.c,94 :: 		}
L_end_Init_ADC:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Init_ADC
_TFT_Get_Data:
;mmbInput_driver.c,96 :: 		char* TFT_Get_Data(unsigned long offset, unsigned long count, unsigned long *num) {
ADDIU	SP, SP, -24
SW	RA, 0(SP)
;mmbInput_driver.c,100 :: 		start_sector = Mmc_Get_File_Write_Sector() + offset/512;
SW	R25, 4(SP)
JAL	_Mmc_Get_File_Write_Sector+0
NOP	
SRL	R3, R25, 9
ADDU	R3, R2, R3
SW	R3, 16(SP)
;mmbInput_driver.c,101 :: 		pos = (unsigned long)offset%512;
ANDI	R2, R25, 511
SW	R2, 20(SP)
;mmbInput_driver.c,103 :: 		if(start_sector == currentSector+1) {
LW	R2, Offset(_currentSector+0)(GP)
ADDIU	R2, R2, 1
BEQ	R3, R2, L__TFT_Get_Data148
NOP	
J	L_TFT_Get_Data2
NOP	
L__TFT_Get_Data148:
;mmbInput_driver.c,104 :: 		Mmc_Multi_Read_Sector(f16_sector.fSect);
SW	R27, 8(SP)
SW	R26, 12(SP)
LUI	R25, #hi_addr(_f16_sector+0)
ORI	R25, R25, #lo_addr(_f16_sector+0)
JAL	_Mmc_Multi_Read_Sector+0
NOP	
LW	R26, 12(SP)
LW	R27, 8(SP)
;mmbInput_driver.c,105 :: 		currentSector = start_sector;
LW	R2, 16(SP)
SW	R2, Offset(_currentSector+0)(GP)
;mmbInput_driver.c,106 :: 		} else if (start_sector != currentSector) {
J	L_TFT_Get_Data3
NOP	
L_TFT_Get_Data2:
LW	R3, Offset(_currentSector+0)(GP)
LW	R2, 16(SP)
BNE	R2, R3, L__TFT_Get_Data150
NOP	
J	L_TFT_Get_Data4
NOP	
L__TFT_Get_Data150:
;mmbInput_driver.c,107 :: 		if(currentSector != -1)
LW	R3, Offset(_currentSector+0)(GP)
LUI	R2, 65535
ORI	R2, R2, 65535
BNE	R3, R2, L__TFT_Get_Data152
NOP	
J	L_TFT_Get_Data5
NOP	
L__TFT_Get_Data152:
;mmbInput_driver.c,108 :: 		Mmc_Multi_Read_Stop();
SW	R27, 8(SP)
SW	R26, 12(SP)
JAL	_Mmc_Multi_Read_Stop+0
NOP	
LW	R26, 12(SP)
LW	R27, 8(SP)
L_TFT_Get_Data5:
;mmbInput_driver.c,109 :: 		Mmc_Multi_Read_Start(start_sector);
SW	R27, 8(SP)
SW	R26, 12(SP)
LW	R25, 16(SP)
JAL	_Mmc_Multi_Read_Start+0
NOP	
;mmbInput_driver.c,110 :: 		Mmc_Multi_Read_Sector(f16_sector.fSect);
LUI	R25, #hi_addr(_f16_sector+0)
ORI	R25, R25, #lo_addr(_f16_sector+0)
JAL	_Mmc_Multi_Read_Sector+0
NOP	
LW	R26, 12(SP)
LW	R27, 8(SP)
;mmbInput_driver.c,111 :: 		currentSector = start_sector;
LW	R2, 16(SP)
SW	R2, Offset(_currentSector+0)(GP)
;mmbInput_driver.c,112 :: 		}
L_TFT_Get_Data4:
L_TFT_Get_Data3:
;mmbInput_driver.c,114 :: 		if(count>512-pos)
LW	R3, 20(SP)
ORI	R2, R0, 512
SUBU	R2, R2, R3
SLTU	R2, R2, R26
BNE	R2, R0, L__TFT_Get_Data153
NOP	
J	L_TFT_Get_Data6
NOP	
L__TFT_Get_Data153:
;mmbInput_driver.c,115 :: 		*num = 512-pos;
LW	R3, 20(SP)
ORI	R2, R0, 512
SUBU	R2, R2, R3
SW	R2, 0(R27)
J	L_TFT_Get_Data7
NOP	
L_TFT_Get_Data6:
;mmbInput_driver.c,117 :: 		*num = count;
SW	R26, 0(R27)
L_TFT_Get_Data7:
;mmbInput_driver.c,119 :: 		return f16_sector.fSect+pos;
LW	R3, 20(SP)
LUI	R2, #hi_addr(_f16_sector+0)
ORI	R2, R2, #lo_addr(_f16_sector+0)
ADDU	R2, R2, R3
;mmbInput_driver.c,120 :: 		}
;mmbInput_driver.c,119 :: 		return f16_sector.fSect+pos;
;mmbInput_driver.c,120 :: 		}
L_end_TFT_Get_Data:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 24
JR	RA
NOP	
; end of _TFT_Get_Data
mmbInput_driver_InitializeTouchPanel:
;mmbInput_driver.c,121 :: 		static void InitializeTouchPanel() {
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;mmbInput_driver.c,122 :: 		Init_ADC();
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
JAL	_Init_ADC+0
NOP	
;mmbInput_driver.c,123 :: 		TFT_Set_Active(Set_Index, Write_Command, Write_Data);
LUI	R27, #hi_addr(_Write_Data+0)
ORI	R27, R27, #lo_addr(_Write_Data+0)
LUI	R26, #hi_addr(_Write_Command+0)
ORI	R26, R26, #lo_addr(_Write_Command+0)
LUI	R25, #hi_addr(_Set_Index+0)
ORI	R25, R25, #lo_addr(_Set_Index+0)
JAL	_TFT_Set_Active+0
NOP	
;mmbInput_driver.c,124 :: 		TFT_Init(320, 240);
ORI	R26, R0, 240
ORI	R25, R0, 320
JAL	_TFT_Init+0
NOP	
;mmbInput_driver.c,125 :: 		TFT_Set_Ext_Buffer(TFT_Get_Data);
LUI	R25, #hi_addr(_TFT_Get_Data+0)
ORI	R25, R25, #lo_addr(_TFT_Get_Data+0)
JAL	_TFT_Set_Ext_Buffer+0
NOP	
;mmbInput_driver.c,127 :: 		TP_TFT_Init(320, 240, 13, 12);                                  // Initialize touch panel
ORI	R28, R0, 12
ORI	R27, R0, 13
ORI	R26, R0, 240
ORI	R25, R0, 320
JAL	_TP_TFT_Init+0
NOP	
;mmbInput_driver.c,128 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
ORI	R25, R0, 1000
JAL	_TP_TFT_Set_ADC_Threshold+0
NOP	
;mmbInput_driver.c,130 :: 		PenDown = 0;
SB	R0, Offset(_PenDown+0)(GP)
;mmbInput_driver.c,131 :: 		PressedObject = 0;
SW	R0, Offset(_PressedObject+0)(GP)
;mmbInput_driver.c,132 :: 		PressedObjectType = -1;
ORI	R2, R0, 65535
SH	R2, Offset(_PressedObjectType+0)(GP)
;mmbInput_driver.c,133 :: 		}
L_end_InitializeTouchPanel:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of mmbInput_driver_InitializeTouchPanel
mmbInput_driver_InitializeObjects:
;mmbInput_driver.c,219 :: 		static void InitializeObjects() {
;mmbInput_driver.c,220 :: 		Screen1.Color                     = 0x0000;
SH	R0, Offset(_Screen1+0)(GP)
;mmbInput_driver.c,221 :: 		Screen1.Width                     = 320;
ORI	R2, R0, 320
SH	R2, Offset(_Screen1+2)(GP)
;mmbInput_driver.c,222 :: 		Screen1.Height                    = 240;
ORI	R2, R0, 240
SH	R2, Offset(_Screen1+4)(GP)
;mmbInput_driver.c,223 :: 		Screen1.ButtonsCount              = 3;
ORI	R2, R0, 3
SH	R2, Offset(_Screen1+8)(GP)
;mmbInput_driver.c,224 :: 		Screen1.Buttons                   = Screen1_Buttons;
LUI	R2, #hi_addr(_Screen1_Buttons+0)
ORI	R2, R2, #lo_addr(_Screen1_Buttons+0)
SW	R2, Offset(_Screen1+12)(GP)
;mmbInput_driver.c,225 :: 		Screen1.ImagesCount               = 1;
ORI	R2, R0, 1
SH	R2, Offset(_Screen1+16)(GP)
;mmbInput_driver.c,226 :: 		Screen1.Images                    = Screen1_Images;
LUI	R2, #hi_addr(_Screen1_Images+0)
ORI	R2, R2, #lo_addr(_Screen1_Images+0)
SW	R2, Offset(_Screen1+20)(GP)
;mmbInput_driver.c,227 :: 		Screen1.RadioButtonsCount           = 13;
ORI	R2, R0, 13
SH	R2, Offset(_Screen1+24)(GP)
;mmbInput_driver.c,228 :: 		Screen1.RadioButtons                = Screen1_RadioButtons;
LUI	R2, #hi_addr(_Screen1_RadioButtons+0)
ORI	R2, R2, #lo_addr(_Screen1_RadioButtons+0)
SW	R2, Offset(_Screen1+28)(GP)
;mmbInput_driver.c,229 :: 		Screen1.ObjectsCount              = 17;
ORI	R2, R0, 17
SB	R2, Offset(_Screen1+6)(GP)
;mmbInput_driver.c,232 :: 		Image1.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_Image1+0)(GP)
;mmbInput_driver.c,233 :: 		Image1.Order          = 0;
SB	R0, Offset(_Image1+4)(GP)
;mmbInput_driver.c,234 :: 		Image1.Left           = 0;
SH	R0, Offset(_Image1+6)(GP)
;mmbInput_driver.c,235 :: 		Image1.Top            = 0;
SH	R0, Offset(_Image1+8)(GP)
;mmbInput_driver.c,236 :: 		Image1.Width          = 320;
ORI	R2, R0, 320
SH	R2, Offset(_Image1+10)(GP)
;mmbInput_driver.c,237 :: 		Image1.Height         = 240;
ORI	R2, R0, 240
SH	R2, Offset(_Image1+12)(GP)
;mmbInput_driver.c,238 :: 		Image1.Picture_Type   = 0;
SB	R0, Offset(_Image1+22)(GP)
;mmbInput_driver.c,239 :: 		Image1.Picture_Ratio  = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Image1+23)(GP)
;mmbInput_driver.c,240 :: 		Image1.Picture_Name   = carbon_bmp;
ORI	R2, R0, 9511
SW	R2, Offset(_Image1+16)(GP)
;mmbInput_driver.c,241 :: 		Image1.Visible        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Image1+20)(GP)
;mmbInput_driver.c,242 :: 		Image1.Active         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Image1+21)(GP)
;mmbInput_driver.c,243 :: 		Image1.OnUpPtr         = 0;
SW	R0, Offset(_Image1+24)(GP)
;mmbInput_driver.c,244 :: 		Image1.OnDownPtr       = 0;
SW	R0, Offset(_Image1+28)(GP)
;mmbInput_driver.c,245 :: 		Image1.OnClickPtr      = 0;
SW	R0, Offset(_Image1+32)(GP)
;mmbInput_driver.c,246 :: 		Image1.OnPressPtr      = 0;
SW	R0, Offset(_Image1+36)(GP)
;mmbInput_driver.c,248 :: 		Led1Button.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_Led1Button+0)(GP)
;mmbInput_driver.c,249 :: 		Led1Button.Order           = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led1Button+4)(GP)
;mmbInput_driver.c,250 :: 		Led1Button.Left            = 72;
ORI	R2, R0, 72
SH	R2, Offset(_Led1Button+6)(GP)
;mmbInput_driver.c,251 :: 		Led1Button.Top             = 63;
ORI	R2, R0, 63
SH	R2, Offset(_Led1Button+8)(GP)
;mmbInput_driver.c,252 :: 		Led1Button.Width           = 32;
ORI	R2, R0, 32
SH	R2, Offset(_Led1Button+10)(GP)
;mmbInput_driver.c,253 :: 		Led1Button.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_Led1Button+12)(GP)
;mmbInput_driver.c,254 :: 		Led1Button.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led1Button+14)(GP)
;mmbInput_driver.c,255 :: 		Led1Button.Pen_Color       = 0x0000;
SH	R0, Offset(_Led1Button+16)(GP)
;mmbInput_driver.c,256 :: 		Led1Button.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led1Button+18)(GP)
;mmbInput_driver.c,257 :: 		Led1Button.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led1Button+19)(GP)
;mmbInput_driver.c,258 :: 		Led1Button.Checked          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led1Button+20)(GP)
;mmbInput_driver.c,259 :: 		Led1Button.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led1Button+21)(GP)
;mmbInput_driver.c,260 :: 		Led1Button.Caption         = Led1Button_Caption;
LUI	R2, #hi_addr(_Led1Button_Caption+0)
ORI	R2, R2, #lo_addr(_Led1Button_Caption+0)
SW	R2, Offset(_Led1Button+24)(GP)
;mmbInput_driver.c,261 :: 		Led1Button.TextAlign            = _taLeft;
SB	R0, Offset(_Led1Button+28)(GP)
;mmbInput_driver.c,262 :: 		Led1Button.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_Led1Button+32)(GP)
;mmbInput_driver.c,263 :: 		Led1Button.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led1Button+48)(GP)
;mmbInput_driver.c,264 :: 		Led1Button.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_Led1Button+36)(GP)
;mmbInput_driver.c,265 :: 		Led1Button.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led1Button+38)(GP)
;mmbInput_driver.c,266 :: 		Led1Button.Gradient_Orientation    = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led1Button+39)(GP)
;mmbInput_driver.c,267 :: 		Led1Button.Gradient_Start_Color    = 0xF800;
ORI	R2, R0, 63488
SH	R2, Offset(_Led1Button+40)(GP)
;mmbInput_driver.c,268 :: 		Led1Button.Gradient_End_Color      = 0xA800;
ORI	R2, R0, 43008
SH	R2, Offset(_Led1Button+42)(GP)
;mmbInput_driver.c,269 :: 		Led1Button.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_Led1Button+44)(GP)
;mmbInput_driver.c,270 :: 		Led1Button.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_Led1Button+50)(GP)
;mmbInput_driver.c,271 :: 		Led1Button.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_Led1Button+46)(GP)
;mmbInput_driver.c,272 :: 		Led1Button.OnUpPtr         = 0;
SW	R0, Offset(_Led1Button+52)(GP)
;mmbInput_driver.c,273 :: 		Led1Button.OnDownPtr       = 0;
SW	R0, Offset(_Led1Button+56)(GP)
;mmbInput_driver.c,274 :: 		Led1Button.OnClickPtr      = Led1ButtonOnClick;
LUI	R2, #hi_addr(_Led1ButtonOnClick+0)
ORI	R2, R2, #lo_addr(_Led1ButtonOnClick+0)
SW	R2, Offset(_Led1Button+60)(GP)
;mmbInput_driver.c,275 :: 		Led1Button.OnPressPtr      = 0;
SW	R0, Offset(_Led1Button+64)(GP)
;mmbInput_driver.c,277 :: 		Led2Button.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_Led2Button+0)(GP)
;mmbInput_driver.c,278 :: 		Led2Button.Order           = 2;
ORI	R2, R0, 2
SB	R2, Offset(_Led2Button+4)(GP)
;mmbInput_driver.c,279 :: 		Led2Button.Left            = 114;
ORI	R2, R0, 114
SH	R2, Offset(_Led2Button+6)(GP)
;mmbInput_driver.c,280 :: 		Led2Button.Top             = 63;
ORI	R2, R0, 63
SH	R2, Offset(_Led2Button+8)(GP)
;mmbInput_driver.c,281 :: 		Led2Button.Width           = 32;
ORI	R2, R0, 32
SH	R2, Offset(_Led2Button+10)(GP)
;mmbInput_driver.c,282 :: 		Led2Button.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_Led2Button+12)(GP)
;mmbInput_driver.c,283 :: 		Led2Button.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led2Button+14)(GP)
;mmbInput_driver.c,284 :: 		Led2Button.Pen_Color       = 0x0000;
SH	R0, Offset(_Led2Button+16)(GP)
;mmbInput_driver.c,285 :: 		Led2Button.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led2Button+18)(GP)
;mmbInput_driver.c,286 :: 		Led2Button.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led2Button+19)(GP)
;mmbInput_driver.c,287 :: 		Led2Button.Checked          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led2Button+20)(GP)
;mmbInput_driver.c,288 :: 		Led2Button.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led2Button+21)(GP)
;mmbInput_driver.c,289 :: 		Led2Button.Caption         = Led2Button_Caption;
LUI	R2, #hi_addr(_Led2Button_Caption+0)
ORI	R2, R2, #lo_addr(_Led2Button_Caption+0)
SW	R2, Offset(_Led2Button+24)(GP)
;mmbInput_driver.c,290 :: 		Led2Button.TextAlign            = _taLeft;
SB	R0, Offset(_Led2Button+28)(GP)
;mmbInput_driver.c,291 :: 		Led2Button.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_Led2Button+32)(GP)
;mmbInput_driver.c,292 :: 		Led2Button.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led2Button+48)(GP)
;mmbInput_driver.c,293 :: 		Led2Button.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_Led2Button+36)(GP)
;mmbInput_driver.c,294 :: 		Led2Button.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led2Button+38)(GP)
;mmbInput_driver.c,295 :: 		Led2Button.Gradient_Orientation    = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led2Button+39)(GP)
;mmbInput_driver.c,296 :: 		Led2Button.Gradient_Start_Color    = 0xF800;
ORI	R2, R0, 63488
SH	R2, Offset(_Led2Button+40)(GP)
;mmbInput_driver.c,297 :: 		Led2Button.Gradient_End_Color      = 0xA800;
ORI	R2, R0, 43008
SH	R2, Offset(_Led2Button+42)(GP)
;mmbInput_driver.c,298 :: 		Led2Button.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_Led2Button+44)(GP)
;mmbInput_driver.c,299 :: 		Led2Button.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_Led2Button+50)(GP)
;mmbInput_driver.c,300 :: 		Led2Button.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_Led2Button+46)(GP)
;mmbInput_driver.c,301 :: 		Led2Button.OnUpPtr         = 0;
SW	R0, Offset(_Led2Button+52)(GP)
;mmbInput_driver.c,302 :: 		Led2Button.OnDownPtr       = 0;
SW	R0, Offset(_Led2Button+56)(GP)
;mmbInput_driver.c,303 :: 		Led2Button.OnClickPtr      = Led2ButtonOnClick;
LUI	R2, #hi_addr(_Led2ButtonOnClick+0)
ORI	R2, R2, #lo_addr(_Led2ButtonOnClick+0)
SW	R2, Offset(_Led2Button+60)(GP)
;mmbInput_driver.c,304 :: 		Led2Button.OnPressPtr      = 0;
SW	R0, Offset(_Led2Button+64)(GP)
;mmbInput_driver.c,306 :: 		Led3Button.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_Led3Button+0)(GP)
;mmbInput_driver.c,307 :: 		Led3Button.Order           = 3;
ORI	R2, R0, 3
SB	R2, Offset(_Led3Button+4)(GP)
;mmbInput_driver.c,308 :: 		Led3Button.Left            = 156;
ORI	R2, R0, 156
SH	R2, Offset(_Led3Button+6)(GP)
;mmbInput_driver.c,309 :: 		Led3Button.Top             = 63;
ORI	R2, R0, 63
SH	R2, Offset(_Led3Button+8)(GP)
;mmbInput_driver.c,310 :: 		Led3Button.Width           = 32;
ORI	R2, R0, 32
SH	R2, Offset(_Led3Button+10)(GP)
;mmbInput_driver.c,311 :: 		Led3Button.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_Led3Button+12)(GP)
;mmbInput_driver.c,312 :: 		Led3Button.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led3Button+14)(GP)
;mmbInput_driver.c,313 :: 		Led3Button.Pen_Color       = 0x0000;
SH	R0, Offset(_Led3Button+16)(GP)
;mmbInput_driver.c,314 :: 		Led3Button.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led3Button+18)(GP)
;mmbInput_driver.c,315 :: 		Led3Button.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led3Button+19)(GP)
;mmbInput_driver.c,316 :: 		Led3Button.Checked          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led3Button+20)(GP)
;mmbInput_driver.c,317 :: 		Led3Button.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led3Button+21)(GP)
;mmbInput_driver.c,318 :: 		Led3Button.Caption         = Led3Button_Caption;
LUI	R2, #hi_addr(_Led3Button_Caption+0)
ORI	R2, R2, #lo_addr(_Led3Button_Caption+0)
SW	R2, Offset(_Led3Button+24)(GP)
;mmbInput_driver.c,319 :: 		Led3Button.TextAlign            = _taLeft;
SB	R0, Offset(_Led3Button+28)(GP)
;mmbInput_driver.c,320 :: 		Led3Button.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_Led3Button+32)(GP)
;mmbInput_driver.c,321 :: 		Led3Button.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led3Button+48)(GP)
;mmbInput_driver.c,322 :: 		Led3Button.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_Led3Button+36)(GP)
;mmbInput_driver.c,323 :: 		Led3Button.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led3Button+38)(GP)
;mmbInput_driver.c,324 :: 		Led3Button.Gradient_Orientation    = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led3Button+39)(GP)
;mmbInput_driver.c,325 :: 		Led3Button.Gradient_Start_Color    = 0xF800;
ORI	R2, R0, 63488
SH	R2, Offset(_Led3Button+40)(GP)
;mmbInput_driver.c,326 :: 		Led3Button.Gradient_End_Color      = 0xA800;
ORI	R2, R0, 43008
SH	R2, Offset(_Led3Button+42)(GP)
;mmbInput_driver.c,327 :: 		Led3Button.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_Led3Button+44)(GP)
;mmbInput_driver.c,328 :: 		Led3Button.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_Led3Button+50)(GP)
;mmbInput_driver.c,329 :: 		Led3Button.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_Led3Button+46)(GP)
;mmbInput_driver.c,330 :: 		Led3Button.OnUpPtr         = 0;
SW	R0, Offset(_Led3Button+52)(GP)
;mmbInput_driver.c,331 :: 		Led3Button.OnDownPtr       = 0;
SW	R0, Offset(_Led3Button+56)(GP)
;mmbInput_driver.c,332 :: 		Led3Button.OnClickPtr      = Led3ButtonOnClick;
LUI	R2, #hi_addr(_Led3ButtonOnClick+0)
ORI	R2, R2, #lo_addr(_Led3ButtonOnClick+0)
SW	R2, Offset(_Led3Button+60)(GP)
;mmbInput_driver.c,333 :: 		Led3Button.OnPressPtr      = 0;
SW	R0, Offset(_Led3Button+64)(GP)
;mmbInput_driver.c,335 :: 		Led4Button.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_Led4Button+0)(GP)
;mmbInput_driver.c,336 :: 		Led4Button.Order           = 4;
ORI	R2, R0, 4
SB	R2, Offset(_Led4Button+4)(GP)
;mmbInput_driver.c,337 :: 		Led4Button.Left            = 198;
ORI	R2, R0, 198
SH	R2, Offset(_Led4Button+6)(GP)
;mmbInput_driver.c,338 :: 		Led4Button.Top             = 63;
ORI	R2, R0, 63
SH	R2, Offset(_Led4Button+8)(GP)
;mmbInput_driver.c,339 :: 		Led4Button.Width           = 32;
ORI	R2, R0, 32
SH	R2, Offset(_Led4Button+10)(GP)
;mmbInput_driver.c,340 :: 		Led4Button.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_Led4Button+12)(GP)
;mmbInput_driver.c,341 :: 		Led4Button.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led4Button+14)(GP)
;mmbInput_driver.c,342 :: 		Led4Button.Pen_Color       = 0x0000;
SH	R0, Offset(_Led4Button+16)(GP)
;mmbInput_driver.c,343 :: 		Led4Button.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led4Button+18)(GP)
;mmbInput_driver.c,344 :: 		Led4Button.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led4Button+19)(GP)
;mmbInput_driver.c,345 :: 		Led4Button.Checked          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led4Button+20)(GP)
;mmbInput_driver.c,346 :: 		Led4Button.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led4Button+21)(GP)
;mmbInput_driver.c,347 :: 		Led4Button.Caption         = Led4Button_Caption;
LUI	R2, #hi_addr(_Led4Button_Caption+0)
ORI	R2, R2, #lo_addr(_Led4Button_Caption+0)
SW	R2, Offset(_Led4Button+24)(GP)
;mmbInput_driver.c,348 :: 		Led4Button.TextAlign            = _taLeft;
SB	R0, Offset(_Led4Button+28)(GP)
;mmbInput_driver.c,349 :: 		Led4Button.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_Led4Button+32)(GP)
;mmbInput_driver.c,350 :: 		Led4Button.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led4Button+48)(GP)
;mmbInput_driver.c,351 :: 		Led4Button.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_Led4Button+36)(GP)
;mmbInput_driver.c,352 :: 		Led4Button.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led4Button+38)(GP)
;mmbInput_driver.c,353 :: 		Led4Button.Gradient_Orientation    = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Led4Button+39)(GP)
;mmbInput_driver.c,354 :: 		Led4Button.Gradient_Start_Color    = 0xF800;
ORI	R2, R0, 63488
SH	R2, Offset(_Led4Button+40)(GP)
;mmbInput_driver.c,355 :: 		Led4Button.Gradient_End_Color      = 0xA800;
ORI	R2, R0, 43008
SH	R2, Offset(_Led4Button+42)(GP)
;mmbInput_driver.c,356 :: 		Led4Button.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_Led4Button+44)(GP)
;mmbInput_driver.c,357 :: 		Led4Button.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_Led4Button+50)(GP)
;mmbInput_driver.c,358 :: 		Led4Button.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_Led4Button+46)(GP)
;mmbInput_driver.c,359 :: 		Led4Button.OnUpPtr         = 0;
SW	R0, Offset(_Led4Button+52)(GP)
;mmbInput_driver.c,360 :: 		Led4Button.OnDownPtr       = 0;
SW	R0, Offset(_Led4Button+56)(GP)
;mmbInput_driver.c,361 :: 		Led4Button.OnClickPtr      = Led4ButtonOnClick;
LUI	R2, #hi_addr(_Led4ButtonOnClick+0)
ORI	R2, R2, #lo_addr(_Led4ButtonOnClick+0)
SW	R2, Offset(_Led4Button+60)(GP)
;mmbInput_driver.c,362 :: 		Led4Button.OnPressPtr      = 0;
SW	R0, Offset(_Led4Button+64)(GP)
;mmbInput_driver.c,364 :: 		left.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_left+0)(GP)
;mmbInput_driver.c,365 :: 		left.Order           = 5;
ORI	R2, R0, 5
SB	R2, Offset(_left+4)(GP)
;mmbInput_driver.c,366 :: 		left.Left            = 23;
ORI	R2, R0, 23
SH	R2, Offset(_left+6)(GP)
;mmbInput_driver.c,367 :: 		left.Top             = 141;
ORI	R2, R0, 141
SH	R2, Offset(_left+8)(GP)
;mmbInput_driver.c,368 :: 		left.Width           = 68;
ORI	R2, R0, 68
SH	R2, Offset(_left+10)(GP)
;mmbInput_driver.c,369 :: 		left.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_left+12)(GP)
;mmbInput_driver.c,370 :: 		left.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_left+14)(GP)
;mmbInput_driver.c,371 :: 		left.Pen_Color       = 0x0000;
SH	R0, Offset(_left+16)(GP)
;mmbInput_driver.c,372 :: 		left.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_left+18)(GP)
;mmbInput_driver.c,373 :: 		left.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_left+19)(GP)
;mmbInput_driver.c,374 :: 		left.Checked          = 0;
SB	R0, Offset(_left+20)(GP)
;mmbInput_driver.c,375 :: 		left.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_left+21)(GP)
;mmbInput_driver.c,376 :: 		left.Caption         = left_Caption;
LUI	R2, #hi_addr(_left_Caption+0)
ORI	R2, R2, #lo_addr(_left_Caption+0)
SW	R2, Offset(_left+24)(GP)
;mmbInput_driver.c,377 :: 		left.TextAlign            = _taLeft;
SB	R0, Offset(_left+28)(GP)
;mmbInput_driver.c,378 :: 		left.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_left+32)(GP)
;mmbInput_driver.c,379 :: 		left.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_left+48)(GP)
;mmbInput_driver.c,380 :: 		left.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_left+36)(GP)
;mmbInput_driver.c,381 :: 		left.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_left+38)(GP)
;mmbInput_driver.c,382 :: 		left.Gradient_Orientation    = 0;
SB	R0, Offset(_left+39)(GP)
;mmbInput_driver.c,383 :: 		left.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_left+40)(GP)
;mmbInput_driver.c,384 :: 		left.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_left+42)(GP)
;mmbInput_driver.c,385 :: 		left.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_left+44)(GP)
;mmbInput_driver.c,386 :: 		left.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_left+50)(GP)
;mmbInput_driver.c,387 :: 		left.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_left+46)(GP)
;mmbInput_driver.c,388 :: 		left.OnUpPtr         = 0;
SW	R0, Offset(_left+52)(GP)
;mmbInput_driver.c,389 :: 		left.OnDownPtr       = 0;
SW	R0, Offset(_left+56)(GP)
;mmbInput_driver.c,390 :: 		left.OnClickPtr      = 0;
SW	R0, Offset(_left+60)(GP)
;mmbInput_driver.c,391 :: 		left.OnPressPtr      = 0;
SW	R0, Offset(_left+64)(GP)
;mmbInput_driver.c,393 :: 		right.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_right+0)(GP)
;mmbInput_driver.c,394 :: 		right.Order           = 6;
ORI	R2, R0, 6
SB	R2, Offset(_right+4)(GP)
;mmbInput_driver.c,395 :: 		right.Left            = 91;
ORI	R2, R0, 91
SH	R2, Offset(_right+6)(GP)
;mmbInput_driver.c,396 :: 		right.Top             = 141;
ORI	R2, R0, 141
SH	R2, Offset(_right+8)(GP)
;mmbInput_driver.c,397 :: 		right.Width           = 76;
ORI	R2, R0, 76
SH	R2, Offset(_right+10)(GP)
;mmbInput_driver.c,398 :: 		right.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_right+12)(GP)
;mmbInput_driver.c,399 :: 		right.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_right+14)(GP)
;mmbInput_driver.c,400 :: 		right.Pen_Color       = 0x0000;
SH	R0, Offset(_right+16)(GP)
;mmbInput_driver.c,401 :: 		right.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_right+18)(GP)
;mmbInput_driver.c,402 :: 		right.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_right+19)(GP)
;mmbInput_driver.c,403 :: 		right.Checked          = 0;
SB	R0, Offset(_right+20)(GP)
;mmbInput_driver.c,404 :: 		right.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_right+21)(GP)
;mmbInput_driver.c,405 :: 		right.Caption         = right_Caption;
LUI	R2, #hi_addr(_right_Caption+0)
ORI	R2, R2, #lo_addr(_right_Caption+0)
SW	R2, Offset(_right+24)(GP)
;mmbInput_driver.c,406 :: 		right.TextAlign            = _taLeft;
SB	R0, Offset(_right+28)(GP)
;mmbInput_driver.c,407 :: 		right.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_right+32)(GP)
;mmbInput_driver.c,408 :: 		right.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_right+48)(GP)
;mmbInput_driver.c,409 :: 		right.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_right+36)(GP)
;mmbInput_driver.c,410 :: 		right.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_right+38)(GP)
;mmbInput_driver.c,411 :: 		right.Gradient_Orientation    = 0;
SB	R0, Offset(_right+39)(GP)
;mmbInput_driver.c,412 :: 		right.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_right+40)(GP)
;mmbInput_driver.c,413 :: 		right.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_right+42)(GP)
;mmbInput_driver.c,414 :: 		right.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_right+44)(GP)
;mmbInput_driver.c,415 :: 		right.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_right+50)(GP)
;mmbInput_driver.c,416 :: 		right.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_right+46)(GP)
;mmbInput_driver.c,417 :: 		right.OnUpPtr         = 0;
SW	R0, Offset(_right+52)(GP)
;mmbInput_driver.c,418 :: 		right.OnDownPtr       = 0;
SW	R0, Offset(_right+56)(GP)
;mmbInput_driver.c,419 :: 		right.OnClickPtr      = 0;
SW	R0, Offset(_right+60)(GP)
;mmbInput_driver.c,420 :: 		right.OnPressPtr      = 0;
SW	R0, Offset(_right+64)(GP)
;mmbInput_driver.c,422 :: 		up.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_up+0)(GP)
;mmbInput_driver.c,423 :: 		up.Order           = 7;
ORI	R2, R0, 7
SB	R2, Offset(_up+4)(GP)
;mmbInput_driver.c,424 :: 		up.Left            = 58;
ORI	R2, R0, 58
SH	R2, Offset(_up+6)(GP)
;mmbInput_driver.c,425 :: 		up.Top             = 109;
ORI	R2, R0, 109
SH	R2, Offset(_up+8)(GP)
;mmbInput_driver.c,426 :: 		up.Width           = 52;
ORI	R2, R0, 52
SH	R2, Offset(_up+10)(GP)
;mmbInput_driver.c,427 :: 		up.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_up+12)(GP)
;mmbInput_driver.c,428 :: 		up.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_up+14)(GP)
;mmbInput_driver.c,429 :: 		up.Pen_Color       = 0x0000;
SH	R0, Offset(_up+16)(GP)
;mmbInput_driver.c,430 :: 		up.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_up+18)(GP)
;mmbInput_driver.c,431 :: 		up.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_up+19)(GP)
;mmbInput_driver.c,432 :: 		up.Checked          = 0;
SB	R0, Offset(_up+20)(GP)
;mmbInput_driver.c,433 :: 		up.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_up+21)(GP)
;mmbInput_driver.c,434 :: 		up.Caption         = up_Caption;
LUI	R2, #hi_addr(_up_Caption+0)
ORI	R2, R2, #lo_addr(_up_Caption+0)
SW	R2, Offset(_up+24)(GP)
;mmbInput_driver.c,435 :: 		up.TextAlign            = _taLeft;
SB	R0, Offset(_up+28)(GP)
;mmbInput_driver.c,436 :: 		up.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_up+32)(GP)
;mmbInput_driver.c,437 :: 		up.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_up+48)(GP)
;mmbInput_driver.c,438 :: 		up.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_up+36)(GP)
;mmbInput_driver.c,439 :: 		up.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_up+38)(GP)
;mmbInput_driver.c,440 :: 		up.Gradient_Orientation    = 0;
SB	R0, Offset(_up+39)(GP)
;mmbInput_driver.c,441 :: 		up.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_up+40)(GP)
;mmbInput_driver.c,442 :: 		up.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_up+42)(GP)
;mmbInput_driver.c,443 :: 		up.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_up+44)(GP)
;mmbInput_driver.c,444 :: 		up.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_up+50)(GP)
;mmbInput_driver.c,445 :: 		up.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_up+46)(GP)
;mmbInput_driver.c,446 :: 		up.OnUpPtr         = 0;
SW	R0, Offset(_up+52)(GP)
;mmbInput_driver.c,447 :: 		up.OnDownPtr       = 0;
SW	R0, Offset(_up+56)(GP)
;mmbInput_driver.c,448 :: 		up.OnClickPtr      = 0;
SW	R0, Offset(_up+60)(GP)
;mmbInput_driver.c,449 :: 		up.OnPressPtr      = 0;
SW	R0, Offset(_up+64)(GP)
;mmbInput_driver.c,451 :: 		down.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_down+0)(GP)
;mmbInput_driver.c,452 :: 		down.Order           = 8;
ORI	R2, R0, 8
SB	R2, Offset(_down+4)(GP)
;mmbInput_driver.c,453 :: 		down.Left            = 58;
ORI	R2, R0, 58
SH	R2, Offset(_down+6)(GP)
;mmbInput_driver.c,454 :: 		down.Top             = 173;
ORI	R2, R0, 173
SH	R2, Offset(_down+8)(GP)
;mmbInput_driver.c,455 :: 		down.Width           = 68;
ORI	R2, R0, 68
SH	R2, Offset(_down+10)(GP)
;mmbInput_driver.c,456 :: 		down.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_down+12)(GP)
;mmbInput_driver.c,457 :: 		down.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_down+14)(GP)
;mmbInput_driver.c,458 :: 		down.Pen_Color       = 0x0000;
SH	R0, Offset(_down+16)(GP)
;mmbInput_driver.c,459 :: 		down.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_down+18)(GP)
;mmbInput_driver.c,460 :: 		down.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_down+19)(GP)
;mmbInput_driver.c,461 :: 		down.Checked          = 0;
SB	R0, Offset(_down+20)(GP)
;mmbInput_driver.c,462 :: 		down.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_down+21)(GP)
;mmbInput_driver.c,463 :: 		down.Caption         = down_Caption;
LUI	R2, #hi_addr(_down_Caption+0)
ORI	R2, R2, #lo_addr(_down_Caption+0)
SW	R2, Offset(_down+24)(GP)
;mmbInput_driver.c,464 :: 		down.TextAlign            = _taLeft;
SB	R0, Offset(_down+28)(GP)
;mmbInput_driver.c,465 :: 		down.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_down+32)(GP)
;mmbInput_driver.c,466 :: 		down.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_down+48)(GP)
;mmbInput_driver.c,467 :: 		down.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_down+36)(GP)
;mmbInput_driver.c,468 :: 		down.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_down+38)(GP)
;mmbInput_driver.c,469 :: 		down.Gradient_Orientation    = 0;
SB	R0, Offset(_down+39)(GP)
;mmbInput_driver.c,470 :: 		down.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_down+40)(GP)
;mmbInput_driver.c,471 :: 		down.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_down+42)(GP)
;mmbInput_driver.c,472 :: 		down.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_down+44)(GP)
;mmbInput_driver.c,473 :: 		down.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_down+50)(GP)
;mmbInput_driver.c,474 :: 		down.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_down+46)(GP)
;mmbInput_driver.c,475 :: 		down.OnUpPtr         = 0;
SW	R0, Offset(_down+52)(GP)
;mmbInput_driver.c,476 :: 		down.OnDownPtr       = 0;
SW	R0, Offset(_down+56)(GP)
;mmbInput_driver.c,477 :: 		down.OnClickPtr      = 0;
SW	R0, Offset(_down+60)(GP)
;mmbInput_driver.c,478 :: 		down.OnPressPtr      = 0;
SW	R0, Offset(_down+64)(GP)
;mmbInput_driver.c,480 :: 		square.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_square+0)(GP)
;mmbInput_driver.c,481 :: 		square.Order           = 9;
ORI	R2, R0, 9
SB	R2, Offset(_square+4)(GP)
;mmbInput_driver.c,482 :: 		square.Left            = 184;
ORI	R2, R0, 184
SH	R2, Offset(_square+6)(GP)
;mmbInput_driver.c,483 :: 		square.Top             = 140;
ORI	R2, R0, 140
SH	R2, Offset(_square+8)(GP)
;mmbInput_driver.c,484 :: 		square.Width           = 60;
ORI	R2, R0, 60
SH	R2, Offset(_square+10)(GP)
;mmbInput_driver.c,485 :: 		square.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_square+12)(GP)
;mmbInput_driver.c,486 :: 		square.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_square+14)(GP)
;mmbInput_driver.c,487 :: 		square.Pen_Color       = 0x0000;
SH	R0, Offset(_square+16)(GP)
;mmbInput_driver.c,488 :: 		square.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_square+18)(GP)
;mmbInput_driver.c,489 :: 		square.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_square+19)(GP)
;mmbInput_driver.c,490 :: 		square.Checked          = 0;
SB	R0, Offset(_square+20)(GP)
;mmbInput_driver.c,491 :: 		square.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_square+21)(GP)
;mmbInput_driver.c,492 :: 		square.Caption         = square_Caption;
LUI	R2, #hi_addr(_square_Caption+0)
ORI	R2, R2, #lo_addr(_square_Caption+0)
SW	R2, Offset(_square+24)(GP)
;mmbInput_driver.c,493 :: 		square.TextAlign            = _taLeft;
SB	R0, Offset(_square+28)(GP)
;mmbInput_driver.c,494 :: 		square.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_square+32)(GP)
;mmbInput_driver.c,495 :: 		square.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_square+48)(GP)
;mmbInput_driver.c,496 :: 		square.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_square+36)(GP)
;mmbInput_driver.c,497 :: 		square.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_square+38)(GP)
;mmbInput_driver.c,498 :: 		square.Gradient_Orientation    = 0;
SB	R0, Offset(_square+39)(GP)
;mmbInput_driver.c,499 :: 		square.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_square+40)(GP)
;mmbInput_driver.c,500 :: 		square.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_square+42)(GP)
;mmbInput_driver.c,501 :: 		square.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_square+44)(GP)
;mmbInput_driver.c,502 :: 		square.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_square+50)(GP)
;mmbInput_driver.c,503 :: 		square.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_square+46)(GP)
;mmbInput_driver.c,504 :: 		square.OnUpPtr         = 0;
SW	R0, Offset(_square+52)(GP)
;mmbInput_driver.c,505 :: 		square.OnDownPtr       = 0;
SW	R0, Offset(_square+56)(GP)
;mmbInput_driver.c,506 :: 		square.OnClickPtr      = 0;
SW	R0, Offset(_square+60)(GP)
;mmbInput_driver.c,507 :: 		square.OnPressPtr      = 0;
SW	R0, Offset(_square+64)(GP)
;mmbInput_driver.c,509 :: 		circle.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_circle+0)(GP)
;mmbInput_driver.c,510 :: 		circle.Order           = 10;
ORI	R2, R0, 10
SB	R2, Offset(_circle+4)(GP)
;mmbInput_driver.c,511 :: 		circle.Left            = 252;
ORI	R2, R0, 252
SH	R2, Offset(_circle+6)(GP)
;mmbInput_driver.c,512 :: 		circle.Top             = 140;
ORI	R2, R0, 140
SH	R2, Offset(_circle+8)(GP)
;mmbInput_driver.c,513 :: 		circle.Width           = 68;
ORI	R2, R0, 68
SH	R2, Offset(_circle+10)(GP)
;mmbInput_driver.c,514 :: 		circle.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_circle+12)(GP)
;mmbInput_driver.c,515 :: 		circle.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_circle+14)(GP)
;mmbInput_driver.c,516 :: 		circle.Pen_Color       = 0x0000;
SH	R0, Offset(_circle+16)(GP)
;mmbInput_driver.c,517 :: 		circle.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_circle+18)(GP)
;mmbInput_driver.c,518 :: 		circle.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_circle+19)(GP)
;mmbInput_driver.c,519 :: 		circle.Checked          = 0;
SB	R0, Offset(_circle+20)(GP)
;mmbInput_driver.c,520 :: 		circle.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_circle+21)(GP)
;mmbInput_driver.c,521 :: 		circle.Caption         = circle_Caption;
LUI	R2, #hi_addr(_circle_Caption+0)
ORI	R2, R2, #lo_addr(_circle_Caption+0)
SW	R2, Offset(_circle+24)(GP)
;mmbInput_driver.c,522 :: 		circle.TextAlign            = _taLeft;
SB	R0, Offset(_circle+28)(GP)
;mmbInput_driver.c,523 :: 		circle.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_circle+32)(GP)
;mmbInput_driver.c,524 :: 		circle.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_circle+48)(GP)
;mmbInput_driver.c,525 :: 		circle.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_circle+36)(GP)
;mmbInput_driver.c,526 :: 		circle.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_circle+38)(GP)
;mmbInput_driver.c,527 :: 		circle.Gradient_Orientation    = 0;
SB	R0, Offset(_circle+39)(GP)
;mmbInput_driver.c,528 :: 		circle.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_circle+40)(GP)
;mmbInput_driver.c,529 :: 		circle.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_circle+42)(GP)
;mmbInput_driver.c,530 :: 		circle.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_circle+44)(GP)
;mmbInput_driver.c,531 :: 		circle.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_circle+50)(GP)
;mmbInput_driver.c,532 :: 		circle.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_circle+46)(GP)
;mmbInput_driver.c,533 :: 		circle.OnUpPtr         = 0;
SW	R0, Offset(_circle+52)(GP)
;mmbInput_driver.c,534 :: 		circle.OnDownPtr       = 0;
SW	R0, Offset(_circle+56)(GP)
;mmbInput_driver.c,535 :: 		circle.OnClickPtr      = 0;
SW	R0, Offset(_circle+60)(GP)
;mmbInput_driver.c,536 :: 		circle.OnPressPtr      = 0;
SW	R0, Offset(_circle+64)(GP)
;mmbInput_driver.c,538 :: 		triangle.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_triangle+0)(GP)
;mmbInput_driver.c,539 :: 		triangle.Order           = 11;
ORI	R2, R0, 11
SB	R2, Offset(_triangle+4)(GP)
;mmbInput_driver.c,540 :: 		triangle.Left            = 219;
ORI	R2, R0, 219
SH	R2, Offset(_triangle+6)(GP)
;mmbInput_driver.c,541 :: 		triangle.Top             = 108;
ORI	R2, R0, 108
SH	R2, Offset(_triangle+8)(GP)
;mmbInput_driver.c,542 :: 		triangle.Width           = 60;
ORI	R2, R0, 60
SH	R2, Offset(_triangle+10)(GP)
;mmbInput_driver.c,543 :: 		triangle.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_triangle+12)(GP)
;mmbInput_driver.c,544 :: 		triangle.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_triangle+14)(GP)
;mmbInput_driver.c,545 :: 		triangle.Pen_Color       = 0x0000;
SH	R0, Offset(_triangle+16)(GP)
;mmbInput_driver.c,546 :: 		triangle.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_triangle+18)(GP)
;mmbInput_driver.c,547 :: 		triangle.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_triangle+19)(GP)
;mmbInput_driver.c,548 :: 		triangle.Checked          = 0;
SB	R0, Offset(_triangle+20)(GP)
;mmbInput_driver.c,549 :: 		triangle.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_triangle+21)(GP)
;mmbInput_driver.c,550 :: 		triangle.Caption         = triangle_Caption;
LUI	R2, #hi_addr(_triangle_Caption+0)
ORI	R2, R2, #lo_addr(_triangle_Caption+0)
SW	R2, Offset(_triangle+24)(GP)
;mmbInput_driver.c,551 :: 		triangle.TextAlign            = _taLeft;
SB	R0, Offset(_triangle+28)(GP)
;mmbInput_driver.c,552 :: 		triangle.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_triangle+32)(GP)
;mmbInput_driver.c,553 :: 		triangle.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_triangle+48)(GP)
;mmbInput_driver.c,554 :: 		triangle.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_triangle+36)(GP)
;mmbInput_driver.c,555 :: 		triangle.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_triangle+38)(GP)
;mmbInput_driver.c,556 :: 		triangle.Gradient_Orientation    = 0;
SB	R0, Offset(_triangle+39)(GP)
;mmbInput_driver.c,557 :: 		triangle.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_triangle+40)(GP)
;mmbInput_driver.c,558 :: 		triangle.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_triangle+42)(GP)
;mmbInput_driver.c,559 :: 		triangle.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_triangle+44)(GP)
;mmbInput_driver.c,560 :: 		triangle.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_triangle+50)(GP)
;mmbInput_driver.c,561 :: 		triangle.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_triangle+46)(GP)
;mmbInput_driver.c,562 :: 		triangle.OnUpPtr         = 0;
SW	R0, Offset(_triangle+52)(GP)
;mmbInput_driver.c,563 :: 		triangle.OnDownPtr       = 0;
SW	R0, Offset(_triangle+56)(GP)
;mmbInput_driver.c,564 :: 		triangle.OnClickPtr      = 0;
SW	R0, Offset(_triangle+60)(GP)
;mmbInput_driver.c,565 :: 		triangle.OnPressPtr      = 0;
SW	R0, Offset(_triangle+64)(GP)
;mmbInput_driver.c,567 :: 		x.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_x+0)(GP)
;mmbInput_driver.c,568 :: 		x.Order           = 12;
ORI	R2, R0, 12
SB	R2, Offset(_x+4)(GP)
;mmbInput_driver.c,569 :: 		x.Left            = 219;
ORI	R2, R0, 219
SH	R2, Offset(_x+6)(GP)
;mmbInput_driver.c,570 :: 		x.Top             = 172;
ORI	R2, R0, 172
SH	R2, Offset(_x+8)(GP)
;mmbInput_driver.c,571 :: 		x.Width           = 44;
ORI	R2, R0, 44
SH	R2, Offset(_x+10)(GP)
;mmbInput_driver.c,572 :: 		x.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_x+12)(GP)
;mmbInput_driver.c,573 :: 		x.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_x+14)(GP)
;mmbInput_driver.c,574 :: 		x.Pen_Color       = 0x0000;
SH	R0, Offset(_x+16)(GP)
;mmbInput_driver.c,575 :: 		x.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_x+18)(GP)
;mmbInput_driver.c,576 :: 		x.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_x+19)(GP)
;mmbInput_driver.c,577 :: 		x.Checked          = 0;
SB	R0, Offset(_x+20)(GP)
;mmbInput_driver.c,578 :: 		x.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_x+21)(GP)
;mmbInput_driver.c,579 :: 		x.Caption         = x_Caption;
LUI	R2, #hi_addr(_x_Caption+0)
ORI	R2, R2, #lo_addr(_x_Caption+0)
SW	R2, Offset(_x+24)(GP)
;mmbInput_driver.c,580 :: 		x.TextAlign            = _taLeft;
SB	R0, Offset(_x+28)(GP)
;mmbInput_driver.c,581 :: 		x.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_x+32)(GP)
;mmbInput_driver.c,582 :: 		x.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_x+48)(GP)
;mmbInput_driver.c,583 :: 		x.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_x+36)(GP)
;mmbInput_driver.c,584 :: 		x.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_x+38)(GP)
;mmbInput_driver.c,585 :: 		x.Gradient_Orientation    = 0;
SB	R0, Offset(_x+39)(GP)
;mmbInput_driver.c,586 :: 		x.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_x+40)(GP)
;mmbInput_driver.c,587 :: 		x.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_x+42)(GP)
;mmbInput_driver.c,588 :: 		x.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_x+44)(GP)
;mmbInput_driver.c,589 :: 		x.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_x+50)(GP)
;mmbInput_driver.c,590 :: 		x.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_x+46)(GP)
;mmbInput_driver.c,591 :: 		x.OnUpPtr         = 0;
SW	R0, Offset(_x+52)(GP)
;mmbInput_driver.c,592 :: 		x.OnDownPtr       = 0;
SW	R0, Offset(_x+56)(GP)
;mmbInput_driver.c,593 :: 		x.OnClickPtr      = 0;
SW	R0, Offset(_x+60)(GP)
;mmbInput_driver.c,594 :: 		x.OnPressPtr      = 0;
SW	R0, Offset(_x+64)(GP)
;mmbInput_driver.c,596 :: 		start.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_start+0)(GP)
;mmbInput_driver.c,597 :: 		start.Order           = 13;
ORI	R2, R0, 13
SB	R2, Offset(_start+4)(GP)
;mmbInput_driver.c,598 :: 		start.Left            = 136;
ORI	R2, R0, 136
SH	R2, Offset(_start+6)(GP)
;mmbInput_driver.c,599 :: 		start.Top             = 204;
ORI	R2, R0, 204
SH	R2, Offset(_start+8)(GP)
;mmbInput_driver.c,600 :: 		start.Width           = 76;
ORI	R2, R0, 76
SH	R2, Offset(_start+10)(GP)
;mmbInput_driver.c,601 :: 		start.Height          = 32;
ORI	R2, R0, 32
SH	R2, Offset(_start+12)(GP)
;mmbInput_driver.c,602 :: 		start.Pen_Width       = 1;
ORI	R2, R0, 1
SB	R2, Offset(_start+14)(GP)
;mmbInput_driver.c,603 :: 		start.Pen_Color       = 0x0000;
SH	R0, Offset(_start+16)(GP)
;mmbInput_driver.c,604 :: 		start.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_start+18)(GP)
;mmbInput_driver.c,605 :: 		start.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_start+19)(GP)
;mmbInput_driver.c,606 :: 		start.Checked          = 0;
SB	R0, Offset(_start+20)(GP)
;mmbInput_driver.c,607 :: 		start.Transparent     = 1;
ORI	R2, R0, 1
SB	R2, Offset(_start+21)(GP)
;mmbInput_driver.c,608 :: 		start.Caption         = start_Caption;
LUI	R2, #hi_addr(_start_Caption+0)
ORI	R2, R2, #lo_addr(_start_Caption+0)
SW	R2, Offset(_start+24)(GP)
;mmbInput_driver.c,609 :: 		start.TextAlign            = _taLeft;
SB	R0, Offset(_start+28)(GP)
;mmbInput_driver.c,610 :: 		start.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_start+32)(GP)
;mmbInput_driver.c,611 :: 		start.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_start+48)(GP)
;mmbInput_driver.c,612 :: 		start.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_start+36)(GP)
;mmbInput_driver.c,613 :: 		start.Gradient        = 1;
ORI	R2, R0, 1
SB	R2, Offset(_start+38)(GP)
;mmbInput_driver.c,614 :: 		start.Gradient_Orientation    = 0;
SB	R0, Offset(_start+39)(GP)
;mmbInput_driver.c,615 :: 		start.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_start+40)(GP)
;mmbInput_driver.c,616 :: 		start.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_start+42)(GP)
;mmbInput_driver.c,617 :: 		start.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_start+44)(GP)
;mmbInput_driver.c,618 :: 		start.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_start+50)(GP)
;mmbInput_driver.c,619 :: 		start.Background_Color = 0x8410;
ORI	R2, R0, 33808
SH	R2, Offset(_start+46)(GP)
;mmbInput_driver.c,620 :: 		start.OnUpPtr         = 0;
SW	R0, Offset(_start+52)(GP)
;mmbInput_driver.c,621 :: 		start.OnDownPtr       = 0;
SW	R0, Offset(_start+56)(GP)
;mmbInput_driver.c,622 :: 		start.OnClickPtr      = 0;
SW	R0, Offset(_start+60)(GP)
;mmbInput_driver.c,623 :: 		start.OnPressPtr      = 0;
SW	R0, Offset(_start+64)(GP)
;mmbInput_driver.c,625 :: 		StatusLEDsText.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_StatusLEDsText+0)(GP)
;mmbInput_driver.c,626 :: 		StatusLEDsText.Order           = 14;
ORI	R2, R0, 14
SB	R2, Offset(_StatusLEDsText+4)(GP)
;mmbInput_driver.c,627 :: 		StatusLEDsText.Left            = 104;
ORI	R2, R0, 104
SH	R2, Offset(_StatusLEDsText+6)(GP)
;mmbInput_driver.c,628 :: 		StatusLEDsText.Top             = 44;
ORI	R2, R0, 44
SH	R2, Offset(_StatusLEDsText+8)(GP)
;mmbInput_driver.c,629 :: 		StatusLEDsText.Width           = 93;
ORI	R2, R0, 93
SH	R2, Offset(_StatusLEDsText+10)(GP)
;mmbInput_driver.c,630 :: 		StatusLEDsText.Height          = 19;
ORI	R2, R0, 19
SH	R2, Offset(_StatusLEDsText+12)(GP)
;mmbInput_driver.c,631 :: 		StatusLEDsText.Pen_Width       = 0;
SB	R0, Offset(_StatusLEDsText+14)(GP)
;mmbInput_driver.c,632 :: 		StatusLEDsText.Pen_Color       = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_StatusLEDsText+16)(GP)
;mmbInput_driver.c,633 :: 		StatusLEDsText.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_StatusLEDsText+18)(GP)
;mmbInput_driver.c,634 :: 		StatusLEDsText.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_StatusLEDsText+19)(GP)
;mmbInput_driver.c,635 :: 		StatusLEDsText.Transparent     = 0;
SB	R0, Offset(_StatusLEDsText+20)(GP)
;mmbInput_driver.c,636 :: 		StatusLEDsText.Caption         = StatusLEDsText_Caption;
LUI	R2, #hi_addr(_StatusLEDsText_Caption+0)
ORI	R2, R2, #lo_addr(_StatusLEDsText_Caption+0)
SW	R2, Offset(_StatusLEDsText+24)(GP)
;mmbInput_driver.c,637 :: 		StatusLEDsText.TextAlign             = _taCenter;
ORI	R2, R0, 1
SB	R2, Offset(_StatusLEDsText+28)(GP)
;mmbInput_driver.c,638 :: 		StatusLEDsText.FontName        = DejaVu_Sans_Mono8x15_Bold;
ORI	R2, R0, 113
SW	R2, Offset(_StatusLEDsText+32)(GP)
;mmbInput_driver.c,639 :: 		StatusLEDsText.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_StatusLEDsText+46)(GP)
;mmbInput_driver.c,640 :: 		StatusLEDsText.Font_Color      = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_StatusLEDsText+36)(GP)
;mmbInput_driver.c,641 :: 		StatusLEDsText.Gradient        = 0;
SB	R0, Offset(_StatusLEDsText+38)(GP)
;mmbInput_driver.c,642 :: 		StatusLEDsText.Gradient_Orientation    = 0;
SB	R0, Offset(_StatusLEDsText+39)(GP)
;mmbInput_driver.c,643 :: 		StatusLEDsText.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_StatusLEDsText+40)(GP)
;mmbInput_driver.c,644 :: 		StatusLEDsText.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_StatusLEDsText+42)(GP)
;mmbInput_driver.c,645 :: 		StatusLEDsText.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_StatusLEDsText+44)(GP)
;mmbInput_driver.c,646 :: 		StatusLEDsText.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_StatusLEDsText+48)(GP)
;mmbInput_driver.c,647 :: 		StatusLEDsText.OnUpPtr         = 0;
SW	R0, Offset(_StatusLEDsText+52)(GP)
;mmbInput_driver.c,648 :: 		StatusLEDsText.OnDownPtr       = 0;
SW	R0, Offset(_StatusLEDsText+56)(GP)
;mmbInput_driver.c,649 :: 		StatusLEDsText.OnClickPtr      = 0;
SW	R0, Offset(_StatusLEDsText+60)(GP)
;mmbInput_driver.c,650 :: 		StatusLEDsText.OnPressPtr      = 0;
SW	R0, Offset(_StatusLEDsText+64)(GP)
;mmbInput_driver.c,652 :: 		ProgramCaption.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_ProgramCaption+0)(GP)
;mmbInput_driver.c,653 :: 		ProgramCaption.Order           = 15;
ORI	R2, R0, 15
SB	R2, Offset(_ProgramCaption+4)(GP)
;mmbInput_driver.c,654 :: 		ProgramCaption.Left            = 13;
ORI	R2, R0, 13
SH	R2, Offset(_ProgramCaption+6)(GP)
;mmbInput_driver.c,655 :: 		ProgramCaption.Top             = 1;
ORI	R2, R0, 1
SH	R2, Offset(_ProgramCaption+8)(GP)
;mmbInput_driver.c,656 :: 		ProgramCaption.Width           = 292;
ORI	R2, R0, 292
SH	R2, Offset(_ProgramCaption+10)(GP)
;mmbInput_driver.c,657 :: 		ProgramCaption.Height          = 47;
ORI	R2, R0, 47
SH	R2, Offset(_ProgramCaption+12)(GP)
;mmbInput_driver.c,658 :: 		ProgramCaption.Pen_Width       = 0;
SB	R0, Offset(_ProgramCaption+14)(GP)
;mmbInput_driver.c,659 :: 		ProgramCaption.Pen_Color       = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_ProgramCaption+16)(GP)
;mmbInput_driver.c,660 :: 		ProgramCaption.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_ProgramCaption+18)(GP)
;mmbInput_driver.c,661 :: 		ProgramCaption.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_ProgramCaption+19)(GP)
;mmbInput_driver.c,662 :: 		ProgramCaption.Transparent     = 0;
SB	R0, Offset(_ProgramCaption+20)(GP)
;mmbInput_driver.c,663 :: 		ProgramCaption.Caption         = ProgramCaption_Caption;
LUI	R2, #hi_addr(_ProgramCaption_Caption+0)
ORI	R2, R2, #lo_addr(_ProgramCaption_Caption+0)
SW	R2, Offset(_ProgramCaption+24)(GP)
;mmbInput_driver.c,664 :: 		ProgramCaption.TextAlign             = _taCenter;
ORI	R2, R0, 1
SB	R2, Offset(_ProgramCaption+28)(GP)
;mmbInput_driver.c,665 :: 		ProgramCaption.FontName        = DejaVu_Sans_Mono17x34_Bold;
ORI	R2, R0, 1945
SW	R2, Offset(_ProgramCaption+32)(GP)
;mmbInput_driver.c,666 :: 		ProgramCaption.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_ProgramCaption+46)(GP)
;mmbInput_driver.c,667 :: 		ProgramCaption.Font_Color      = 0xF800;
ORI	R2, R0, 63488
SH	R2, Offset(_ProgramCaption+36)(GP)
;mmbInput_driver.c,668 :: 		ProgramCaption.Gradient        = 0;
SB	R0, Offset(_ProgramCaption+38)(GP)
;mmbInput_driver.c,669 :: 		ProgramCaption.Gradient_Orientation    = 0;
SB	R0, Offset(_ProgramCaption+39)(GP)
;mmbInput_driver.c,670 :: 		ProgramCaption.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_ProgramCaption+40)(GP)
;mmbInput_driver.c,671 :: 		ProgramCaption.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_ProgramCaption+42)(GP)
;mmbInput_driver.c,672 :: 		ProgramCaption.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_ProgramCaption+44)(GP)
;mmbInput_driver.c,673 :: 		ProgramCaption.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_ProgramCaption+48)(GP)
;mmbInput_driver.c,674 :: 		ProgramCaption.OnUpPtr         = 0;
SW	R0, Offset(_ProgramCaption+52)(GP)
;mmbInput_driver.c,675 :: 		ProgramCaption.OnDownPtr       = 0;
SW	R0, Offset(_ProgramCaption+56)(GP)
;mmbInput_driver.c,676 :: 		ProgramCaption.OnClickPtr      = 0;
SW	R0, Offset(_ProgramCaption+60)(GP)
;mmbInput_driver.c,677 :: 		ProgramCaption.OnPressPtr      = 0;
SW	R0, Offset(_ProgramCaption+64)(GP)
;mmbInput_driver.c,679 :: 		MCU.OwnerScreen     = &Screen1;
LUI	R2, #hi_addr(_Screen1+0)
ORI	R2, R2, #lo_addr(_Screen1+0)
SW	R2, Offset(_MCU+0)(GP)
;mmbInput_driver.c,680 :: 		MCU.Order           = 16;
ORI	R2, R0, 16
SB	R2, Offset(_MCU+4)(GP)
;mmbInput_driver.c,681 :: 		MCU.Left            = 216;
ORI	R2, R0, 216
SH	R2, Offset(_MCU+6)(GP)
;mmbInput_driver.c,682 :: 		MCU.Top             = 202;
ORI	R2, R0, 202
SH	R2, Offset(_MCU+8)(GP)
;mmbInput_driver.c,683 :: 		MCU.Width           = 104;
ORI	R2, R0, 104
SH	R2, Offset(_MCU+10)(GP)
;mmbInput_driver.c,684 :: 		MCU.Height          = 39;
ORI	R2, R0, 39
SH	R2, Offset(_MCU+12)(GP)
;mmbInput_driver.c,685 :: 		MCU.Pen_Width       = 0;
SB	R0, Offset(_MCU+14)(GP)
;mmbInput_driver.c,686 :: 		MCU.Pen_Color       = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_MCU+16)(GP)
;mmbInput_driver.c,687 :: 		MCU.Visible         = 1;
ORI	R2, R0, 1
SB	R2, Offset(_MCU+18)(GP)
;mmbInput_driver.c,688 :: 		MCU.Active          = 1;
ORI	R2, R0, 1
SB	R2, Offset(_MCU+19)(GP)
;mmbInput_driver.c,689 :: 		MCU.Transparent     = 0;
SB	R0, Offset(_MCU+20)(GP)
;mmbInput_driver.c,690 :: 		MCU.Caption         = MCU_Caption;
LUI	R2, #hi_addr(_MCU_Caption+0)
ORI	R2, R2, #lo_addr(_MCU_Caption+0)
SW	R2, Offset(_MCU+24)(GP)
;mmbInput_driver.c,691 :: 		MCU.TextAlign             = _taRight;
ORI	R2, R0, 2
SB	R2, Offset(_MCU+28)(GP)
;mmbInput_driver.c,692 :: 		MCU.FontName        = DejaVu_Sans_Mono17x34_Bold;
ORI	R2, R0, 1945
SW	R2, Offset(_MCU+32)(GP)
;mmbInput_driver.c,693 :: 		MCU.PressColEnabled = 1;
ORI	R2, R0, 1
SB	R2, Offset(_MCU+46)(GP)
;mmbInput_driver.c,694 :: 		MCU.Font_Color      = 0xF800;
ORI	R2, R0, 63488
SH	R2, Offset(_MCU+36)(GP)
;mmbInput_driver.c,695 :: 		MCU.Gradient        = 0;
SB	R0, Offset(_MCU+38)(GP)
;mmbInput_driver.c,696 :: 		MCU.Gradient_Orientation    = 0;
SB	R0, Offset(_MCU+39)(GP)
;mmbInput_driver.c,697 :: 		MCU.Gradient_Start_Color    = 0xFFFF;
ORI	R2, R0, 65535
SH	R2, Offset(_MCU+40)(GP)
;mmbInput_driver.c,698 :: 		MCU.Gradient_End_Color      = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_MCU+42)(GP)
;mmbInput_driver.c,699 :: 		MCU.Color           = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_MCU+44)(GP)
;mmbInput_driver.c,700 :: 		MCU.Press_Color     = 0xC618;
ORI	R2, R0, 50712
SH	R2, Offset(_MCU+48)(GP)
;mmbInput_driver.c,701 :: 		MCU.OnUpPtr         = 0;
SW	R0, Offset(_MCU+52)(GP)
;mmbInput_driver.c,702 :: 		MCU.OnDownPtr       = 0;
SW	R0, Offset(_MCU+56)(GP)
;mmbInput_driver.c,703 :: 		MCU.OnClickPtr      = 0;
SW	R0, Offset(_MCU+60)(GP)
;mmbInput_driver.c,704 :: 		MCU.OnPressPtr      = 0;
SW	R0, Offset(_MCU+64)(GP)
;mmbInput_driver.c,705 :: 		}
L_end_InitializeObjects:
JR	RA
NOP	
; end of mmbInput_driver_InitializeObjects
mmbInput_driver_IsInsideObject:
;mmbInput_driver.c,707 :: 		static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
;mmbInput_driver.c,708 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
; Width start address is: 16 (R4)
LHU	R4, 0(SP)
; Height start address is: 20 (R5)
LHU	R5, 2(SP)
ANDI	R3, R27, 65535
ANDI	R2, R25, 65535
SLTU	R2, R2, R3
BEQ	R2, R0, L_mmbInput_driver_IsInsideObject157
NOP	
J	L_mmbInput_driver_IsInsideObject130
NOP	
L_mmbInput_driver_IsInsideObject157:
ADDU	R2, R27, R4
; Width end address is: 16 (R4)
ADDIU	R2, R2, -1
ANDI	R3, R2, 65535
ANDI	R2, R25, 65535
SLTU	R2, R3, R2
BEQ	R2, R0, L_mmbInput_driver_IsInsideObject158
NOP	
J	L_mmbInput_driver_IsInsideObject129
NOP	
L_mmbInput_driver_IsInsideObject158:
;mmbInput_driver.c,709 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
ANDI	R3, R28, 65535
ANDI	R2, R26, 65535
SLTU	R2, R2, R3
BEQ	R2, R0, L_mmbInput_driver_IsInsideObject159
NOP	
J	L_mmbInput_driver_IsInsideObject128
NOP	
L_mmbInput_driver_IsInsideObject159:
ADDU	R2, R28, R5
; Height end address is: 20 (R5)
ADDIU	R2, R2, -1
ANDI	R3, R2, 65535
ANDI	R2, R26, 65535
SLTU	R2, R3, R2
BEQ	R2, R0, L_mmbInput_driver_IsInsideObject160
NOP	
J	L_mmbInput_driver_IsInsideObject127
NOP	
L_mmbInput_driver_IsInsideObject160:
L_mmbInput_driver_IsInsideObject126:
;mmbInput_driver.c,710 :: 		return 1;
ORI	R2, R0, 1
J	L_end_IsInsideObject
NOP	
;mmbInput_driver.c,708 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
L_mmbInput_driver_IsInsideObject130:
L_mmbInput_driver_IsInsideObject129:
;mmbInput_driver.c,709 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
L_mmbInput_driver_IsInsideObject128:
L_mmbInput_driver_IsInsideObject127:
;mmbInput_driver.c,712 :: 		return 0;
MOVZ	R2, R0, R0
;mmbInput_driver.c,713 :: 		}
L_end_IsInsideObject:
JR	RA
NOP	
; end of mmbInput_driver_IsInsideObject
_DeleteTrailingSpaces:
;mmbInput_driver.c,720 :: 		void DeleteTrailingSpaces(char* str){
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_driver.c,723 :: 		while(1) {
L_DeleteTrailingSpaces12:
;mmbInput_driver.c,724 :: 		if(str[0] == ' ') {
LBU	R2, 0(R25)
ANDI	R3, R2, 255
ORI	R2, R0, 32
BEQ	R3, R2, L__DeleteTrailingSpaces162
NOP	
J	L_DeleteTrailingSpaces14
NOP	
L__DeleteTrailingSpaces162:
;mmbInput_driver.c,725 :: 		for(i = 0; i < strlen(str); i++) {
; i start address is: 20 (R5)
MOVZ	R5, R0, R0
; i end address is: 20 (R5)
L_DeleteTrailingSpaces15:
; i start address is: 20 (R5)
JAL	_strlen+0
NOP	
ANDI	R3, R5, 255
SEH	R2, R2
SLT	R2, R3, R2
BNE	R2, R0, L__DeleteTrailingSpaces163
NOP	
J	L_DeleteTrailingSpaces16
NOP	
L__DeleteTrailingSpaces163:
;mmbInput_driver.c,726 :: 		str[i] = str[i+1];
ANDI	R2, R5, 255
ADDU	R3, R25, R2
ANDI	R2, R5, 255
ADDIU	R2, R2, 1
SEH	R2, R2
ADDU	R2, R25, R2
LBU	R2, 0(R2)
SB	R2, 0(R3)
;mmbInput_driver.c,725 :: 		for(i = 0; i < strlen(str); i++) {
ADDIU	R2, R5, 1
ANDI	R5, R2, 255
;mmbInput_driver.c,727 :: 		}
; i end address is: 20 (R5)
J	L_DeleteTrailingSpaces15
NOP	
L_DeleteTrailingSpaces16:
;mmbInput_driver.c,728 :: 		}
J	L_DeleteTrailingSpaces18
NOP	
L_DeleteTrailingSpaces14:
;mmbInput_driver.c,730 :: 		break;
J	L_DeleteTrailingSpaces13
NOP	
L_DeleteTrailingSpaces18:
;mmbInput_driver.c,731 :: 		}
J	L_DeleteTrailingSpaces12
NOP	
L_DeleteTrailingSpaces13:
;mmbInput_driver.c,732 :: 		}
L_end_DeleteTrailingSpaces:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _DeleteTrailingSpaces
_DrawButton:
;mmbInput_driver.c,734 :: 		void DrawButton(TButton *Abutton) {
ADDIU	SP, SP, -24
SW	RA, 0(SP)
;mmbInput_driver.c,735 :: 		if (Abutton->Visible == 1) {
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
ADDIU	R2, R25, 18
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__DrawButton165
NOP	
J	L_DrawButton19
NOP	
L__DrawButton165:
;mmbInput_driver.c,736 :: 		if (object_pressed == 1) {
LBU	R3, Offset(_object_pressed+0)(GP)
ORI	R2, R0, 1
BEQ	R3, R2, L__DrawButton166
NOP	
J	L_DrawButton20
NOP	
L__DrawButton166:
;mmbInput_driver.c,737 :: 		object_pressed = 0;
SB	R0, Offset(_object_pressed+0)(GP)
;mmbInput_driver.c,738 :: 		TFT_Set_Brush(Abutton->Transparent, Abutton->Press_Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_End_Color, Abutton->Gradient_Start_Color);
ADDIU	R2, R25, 40
LHU	R7, 0(R2)
ADDIU	R2, R25, 42
LHU	R6, 0(R2)
ADDIU	R2, R25, 39
LBU	R5, 0(R2)
ADDIU	R2, R25, 38
LBU	R4, 0(R2)
ADDIU	R2, R25, 48
LHU	R3, 0(R2)
ADDIU	R2, R25, 20
LBU	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R28, R5, 255
ANDI	R27, R4, 255
ANDI	R26, R3, 65535
ANDI	R25, R2, 255
ADDIU	SP, SP, -4
SH	R7, 2(SP)
SH	R6, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
LW	R25, 20(SP)
;mmbInput_driver.c,739 :: 		}
J	L_DrawButton21
NOP	
L_DrawButton20:
;mmbInput_driver.c,741 :: 		TFT_Set_Brush(Abutton->Transparent, Abutton->Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_Start_Color, Abutton->Gradient_End_Color);
ADDIU	R2, R25, 42
LHU	R7, 0(R2)
ADDIU	R2, R25, 40
LHU	R6, 0(R2)
ADDIU	R2, R25, 39
LBU	R5, 0(R2)
ADDIU	R2, R25, 38
LBU	R4, 0(R2)
ADDIU	R2, R25, 44
LHU	R3, 0(R2)
ADDIU	R2, R25, 20
LBU	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R28, R5, 255
ANDI	R27, R4, 255
ANDI	R26, R3, 65535
ANDI	R25, R2, 255
ADDIU	SP, SP, -4
SH	R7, 2(SP)
SH	R6, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
LW	R25, 20(SP)
;mmbInput_driver.c,742 :: 		}
L_DrawButton21:
;mmbInput_driver.c,743 :: 		TFT_Set_Pen(Abutton->Pen_Color, Abutton->Pen_Width);
ADDIU	R2, R25, 14
LBU	R3, 0(R2)
ADDIU	R2, R25, 16
LHU	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R26, R3, 255
ANDI	R25, R2, 65535
JAL	_TFT_Set_Pen+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,744 :: 		TFT_Rectangle(Abutton->Left, Abutton->Top, Abutton->Left + Abutton->Width - 1, Abutton->Top + Abutton->Height - 1);
ADDIU	R2, R25, 8
LHU	R5, 0(R2)
ADDIU	R2, R25, 12
LHU	R2, 0(R2)
ADDU	R2, R5, R2
ADDIU	R4, R2, -1
ADDIU	R2, R25, 6
LHU	R3, 0(R2)
ADDIU	R2, R25, 10
LHU	R2, 0(R2)
ADDU	R2, R3, R2
ADDIU	R2, R2, -1
SW	R25, 20(SP)
ANDI	R28, R4, 65535
ANDI	R27, R2, 65535
ANDI	R26, R5, 65535
ANDI	R25, R3, 65535
JAL	_TFT_Rectangle+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,745 :: 		TFT_Set_Ext_Font(Abutton->FontName, Abutton->Font_Color, FO_HORIZONTAL);
ADDIU	R2, R25, 36
LHU	R3, 0(R2)
ADDIU	R2, R25, 32
LW	R2, 0(R2)
SW	R25, 20(SP)
MOVZ	R27, R0, R0
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Set_Ext_Font+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,746 :: 		TFT_Write_Text_Return_Pos(Abutton->Caption, Abutton->Left, Abutton->Top);
ADDIU	R2, R25, 8
LHU	R4, 0(R2)
ADDIU	R2, R25, 6
LHU	R3, 0(R2)
ADDIU	R2, R25, 24
LW	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R27, R4, 65535
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Write_Text_Return_Pos+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,747 :: 		if (AButton->TextAlign == _taLeft)
ADDIU	R2, R25, 28
LBU	R2, 0(R2)
ANDI	R2, R2, 255
BEQ	R2, R0, L__DrawButton167
NOP	
J	L_DrawButton22
NOP	
L__DrawButton167:
;mmbInput_driver.c,748 :: 		TFT_Write_Text(Abutton->Caption, Abutton->Left + 4, (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
ADDIU	R2, R25, 8
LHU	R4, 0(R2)
ADDIU	R2, R25, 12
LHU	R3, 0(R2)
LHU	R2, Offset(_caption_height+0)(GP)
SUBU	R2, R3, R2
ANDI	R2, R2, 65535
SRL	R2, R2, 1
ADDU	R4, R4, R2
ADDIU	R2, R25, 6
LHU	R2, 0(R2)
ADDIU	R3, R2, 4
ADDIU	R2, R25, 24
LW	R2, 0(R2)
ANDI	R27, R4, 65535
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Write_Text+0
NOP	
J	L_DrawButton23
NOP	
L_DrawButton22:
;mmbInput_driver.c,749 :: 		else if (AButton->TextAlign == _taCenter)
ADDIU	R2, R25, 28
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__DrawButton168
NOP	
J	L_DrawButton24
NOP	
L__DrawButton168:
;mmbInput_driver.c,750 :: 		TFT_Write_Text(Abutton->Caption, (Abutton->Left + (Abutton->Width - caption_length) / 2), (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
ADDIU	R2, R25, 8
LHU	R4, 0(R2)
ADDIU	R2, R25, 12
LHU	R3, 0(R2)
LHU	R2, Offset(_caption_height+0)(GP)
SUBU	R2, R3, R2
ANDI	R2, R2, 65535
SRL	R2, R2, 1
ADDU	R5, R4, R2
ADDIU	R2, R25, 6
LHU	R4, 0(R2)
ADDIU	R2, R25, 10
LHU	R3, 0(R2)
LHU	R2, Offset(_caption_length+0)(GP)
SUBU	R2, R3, R2
ANDI	R2, R2, 65535
SRL	R2, R2, 1
ADDU	R3, R4, R2
ADDIU	R2, R25, 24
LW	R2, 0(R2)
ANDI	R27, R5, 65535
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Write_Text+0
NOP	
J	L_DrawButton25
NOP	
L_DrawButton24:
;mmbInput_driver.c,751 :: 		else if (AButton->TextAlign == _taRight)
ADDIU	R2, R25, 28
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 2
BEQ	R3, R2, L__DrawButton169
NOP	
J	L_DrawButton26
NOP	
L__DrawButton169:
;mmbInput_driver.c,752 :: 		TFT_Write_Text(Abutton->Caption, Abutton->Left + (Abutton->Width - caption_length - 4), (Abutton->Top + (Abutton->Height - caption_height) / 2));
ADDIU	R2, R25, 8
LHU	R4, 0(R2)
ADDIU	R2, R25, 12
LHU	R3, 0(R2)
LHU	R2, Offset(_caption_height+0)(GP)
SUBU	R2, R3, R2
ANDI	R2, R2, 65535
SRL	R2, R2, 1
ADDU	R5, R4, R2
ADDIU	R2, R25, 6
LHU	R4, 0(R2)
ADDIU	R2, R25, 10
LHU	R3, 0(R2)
LHU	R2, Offset(_caption_length+0)(GP)
SUBU	R2, R3, R2
ADDIU	R2, R2, -4
ADDU	R3, R4, R2
ADDIU	R2, R25, 24
LW	R2, 0(R2)
ANDI	R27, R5, 65535
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Write_Text+0
NOP	
L_DrawButton26:
L_DrawButton25:
L_DrawButton23:
;mmbInput_driver.c,753 :: 		}
L_DrawButton19:
;mmbInput_driver.c,754 :: 		}
L_end_DrawButton:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 24
JR	RA
NOP	
; end of _DrawButton
_DrawImage:
;mmbInput_driver.c,756 :: 		void DrawImage(TImage *AImage) {
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;mmbInput_driver.c,757 :: 		if (AImage->Visible) {
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
ADDIU	R2, R25, 20
LBU	R2, 0(R2)
BNE	R2, R0, L__DrawImage172
NOP	
J	L_DrawImage27
NOP	
L__DrawImage172:
;mmbInput_driver.c,758 :: 		TFT_Ext_Image(AImage->Left, AImage->Top, AImage->Picture_Name, AImage->Picture_Ratio);
ADDIU	R2, R25, 23
LBU	R5, 0(R2)
ADDIU	R2, R25, 16
LW	R4, 0(R2)
ADDIU	R2, R25, 8
LHU	R3, 0(R2)
ADDIU	R2, R25, 6
LHU	R2, 0(R2)
ANDI	R28, R5, 255
MOVZ	R27, R4, R0
ANDI	R26, R3, 65535
ANDI	R25, R2, 65535
JAL	_TFT_Ext_Image+0
NOP	
;mmbInput_driver.c,759 :: 		}
L_DrawImage27:
;mmbInput_driver.c,760 :: 		}
L_end_DrawImage:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _DrawImage
_DrawRadioButton:
;mmbInput_driver.c,762 :: 		void DrawRadioButton(TRadioButton *ARadioButton) {
ADDIU	SP, SP, -28
SW	RA, 0(SP)
;mmbInput_driver.c,763 :: 		int circleOffset = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
;mmbInput_driver.c,764 :: 		if (ARadioButton->Visible == 1) {
ADDIU	R2, R25, 18
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__DrawRadioButton174
NOP	
J	L_DrawRadioButton28
NOP	
L__DrawRadioButton174:
;mmbInput_driver.c,765 :: 		circleOffset = ARadioButton->Height / 5;
ADDIU	R2, R25, 12
LHU	R3, 0(R2)
ORI	R2, R0, 5
DIVU	R3, R2
MFLO	R2
; circleOffset start address is: 32 (R8)
ANDI	R8, R2, 65535
;mmbInput_driver.c,766 :: 		TFT_Set_Pen(ARadioButton->Pen_Color, ARadioButton->Pen_Width);
ADDIU	R2, R25, 14
LBU	R3, 0(R2)
ADDIU	R2, R25, 16
LHU	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R26, R3, 255
ANDI	R25, R2, 65535
JAL	_TFT_Set_Pen+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,767 :: 		if (ARadioButton->TextAlign == _taLeft) {
ADDIU	R2, R25, 28
LBU	R2, 0(R2)
ANDI	R2, R2, 255
BEQ	R2, R0, L__DrawRadioButton175
NOP	
J	L_DrawRadioButton29
NOP	
L__DrawRadioButton175:
;mmbInput_driver.c,768 :: 		TFT_Set_Brush(ARadioButton->Transparent,ARadioButton->Background_Color,0,0,0,0);
ADDIU	R2, R25, 46
LHU	R3, 0(R2)
ADDIU	R2, R25, 21
LBU	R2, 0(R2)
SW	R25, 20(SP)
MOVZ	R28, R0, R0
MOVZ	R27, R0, R0
ANDI	R26, R3, 65535
ANDI	R25, R2, 255
ADDIU	SP, SP, -4
SH	R0, 2(SP)
SH	R0, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
LW	R25, 20(SP)
;mmbInput_driver.c,769 :: 		TFT_Circle(ARadioButton->Left + ARadioButton->Height / 2, ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2);
ADDIU	R2, R25, 12
LHU	R2, 0(R2)
ANDI	R2, R2, 65535
SRL	R4, R2, 1
ADDIU	R2, R25, 8
LHU	R2, 0(R2)
ADDU	R3, R2, R4
ADDIU	R2, R25, 6
LHU	R2, 0(R2)
ADDU	R2, R2, R4
SH	R8, 20(SP)
SW	R25, 24(SP)
ANDI	R27, R4, 65535
ANDI	R26, R3, 65535
ANDI	R25, R2, 65535
JAL	_TFT_Circle+0
NOP	
LW	R25, 24(SP)
LH	R8, 20(SP)
;mmbInput_driver.c,770 :: 		if (ARadioButton->Checked == 1) {
ADDIU	R2, R25, 20
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__DrawRadioButton176
NOP	
J	L_DrawRadioButton30
NOP	
L__DrawRadioButton176:
;mmbInput_driver.c,771 :: 		if (object_pressed == 1) {
LBU	R3, Offset(_object_pressed+0)(GP)
ORI	R2, R0, 1
BEQ	R3, R2, L__DrawRadioButton177
NOP	
J	L_DrawRadioButton31
NOP	
L__DrawRadioButton177:
;mmbInput_driver.c,772 :: 		object_pressed = 0;
SB	R0, Offset(_object_pressed+0)(GP)
;mmbInput_driver.c,773 :: 		TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Press_Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_End_Color, ARadioButton->Gradient_Start_Color);
ADDIU	R2, R25, 40
LHU	R7, 0(R2)
ADDIU	R2, R25, 42
LHU	R6, 0(R2)
ADDIU	R2, R25, 39
LBU	R5, 0(R2)
ADDIU	R2, R25, 38
LBU	R4, 0(R2)
ADDIU	R2, R25, 50
LHU	R3, 0(R2)
ADDIU	R2, R25, 21
LBU	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R28, R5, 255
ANDI	R27, R4, 255
ANDI	R26, R3, 65535
ANDI	R25, R2, 255
ADDIU	SP, SP, -4
SH	R7, 2(SP)
SH	R6, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
LW	R25, 20(SP)
;mmbInput_driver.c,774 :: 		}
J	L_DrawRadioButton32
NOP	
L_DrawRadioButton31:
;mmbInput_driver.c,776 :: 		TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_Start_Color, ARadioButton->Gradient_End_Color);
ADDIU	R2, R25, 42
LHU	R7, 0(R2)
ADDIU	R2, R25, 40
LHU	R6, 0(R2)
ADDIU	R2, R25, 39
LBU	R5, 0(R2)
ADDIU	R2, R25, 38
LBU	R4, 0(R2)
ADDIU	R2, R25, 44
LHU	R3, 0(R2)
ADDIU	R2, R25, 21
LBU	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R28, R5, 255
ANDI	R27, R4, 255
ANDI	R26, R3, 65535
ANDI	R25, R2, 255
ADDIU	SP, SP, -4
SH	R7, 2(SP)
SH	R6, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
LW	R25, 20(SP)
L_DrawRadioButton32:
;mmbInput_driver.c,777 :: 		TFT_Circle(ARadioButton->Left + ARadioButton->Height / 2 , ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2 - circleOffset);
ADDIU	R2, R25, 12
LHU	R2, 0(R2)
ANDI	R2, R2, 65535
SRL	R5, R2, 1
SUBU	R4, R5, R8
; circleOffset end address is: 32 (R8)
ADDIU	R2, R25, 8
LHU	R2, 0(R2)
ADDU	R3, R2, R5
ADDIU	R2, R25, 6
LHU	R2, 0(R2)
ADDU	R2, R2, R5
SW	R25, 20(SP)
ANDI	R27, R4, 65535
ANDI	R26, R3, 65535
ANDI	R25, R2, 65535
JAL	_TFT_Circle+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,778 :: 		}
L_DrawRadioButton30:
;mmbInput_driver.c,779 :: 		TFT_Set_Ext_Font(ARadioButton->FontName, ARadioButton->Font_Color, FO_HORIZONTAL);
ADDIU	R2, R25, 36
LHU	R3, 0(R2)
ADDIU	R2, R25, 32
LW	R2, 0(R2)
SW	R25, 20(SP)
MOVZ	R27, R0, R0
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Set_Ext_Font+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,780 :: 		TFT_Write_Text_Return_Pos(ARadioButton->Caption, ARadioButton->Left + ARadioButton->Height + 4, ARadioButton->Top);
ADDIU	R2, R25, 8
LHU	R4, 0(R2)
ADDIU	R2, R25, 6
LHU	R3, 0(R2)
ADDIU	R2, R25, 12
LHU	R2, 0(R2)
ADDU	R2, R3, R2
ADDIU	R3, R2, 4
ADDIU	R2, R25, 24
LW	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R27, R4, 65535
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Write_Text_Return_Pos+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,781 :: 		TFT_Write_Text(ARadioButton->Caption, ARadioButton->Left + ARadioButton->Height + 4, (ARadioButton->Top + ((ARadioButton->Height - caption_height) / 2)));
ADDIU	R2, R25, 8
LHU	R4, 0(R2)
ADDIU	R2, R25, 12
LHU	R3, 0(R2)
LHU	R2, Offset(_caption_height+0)(GP)
SUBU	R2, R3, R2
ANDI	R2, R2, 65535
SRL	R2, R2, 1
ADDU	R4, R4, R2
ADDIU	R2, R25, 6
LHU	R2, 0(R2)
ADDU	R2, R2, R3
ADDIU	R3, R2, 4
ADDIU	R2, R25, 24
LW	R2, 0(R2)
ANDI	R27, R4, 65535
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Write_Text+0
NOP	
;mmbInput_driver.c,782 :: 		}
J	L_DrawRadioButton33
NOP	
L_DrawRadioButton29:
;mmbInput_driver.c,783 :: 		else if (ARadioButton->TextAlign == _taRight) {
; circleOffset start address is: 32 (R8)
ADDIU	R2, R25, 28
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 2
BEQ	R3, R2, L__DrawRadioButton178
NOP	
J	L_DrawRadioButton34
NOP	
L__DrawRadioButton178:
;mmbInput_driver.c,784 :: 		TFT_Set_Brush(ARadioButton->Transparent,ARadioButton->Background_Color,0,0,0,0);
ADDIU	R2, R25, 46
LHU	R3, 0(R2)
ADDIU	R2, R25, 21
LBU	R2, 0(R2)
SW	R25, 20(SP)
MOVZ	R28, R0, R0
MOVZ	R27, R0, R0
ANDI	R26, R3, 65535
ANDI	R25, R2, 255
ADDIU	SP, SP, -4
SH	R0, 2(SP)
SH	R0, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
LW	R25, 20(SP)
;mmbInput_driver.c,785 :: 		TFT_Circle(ARadioButton->Left  + ARadioButton->Width - ARadioButton->Height / 2, ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2);
ADDIU	R2, R25, 12
LHU	R2, 0(R2)
ANDI	R2, R2, 65535
SRL	R5, R2, 1
ADDIU	R2, R25, 8
LHU	R2, 0(R2)
ADDU	R4, R2, R5
ADDIU	R2, R25, 6
LHU	R3, 0(R2)
ADDIU	R2, R25, 10
LHU	R2, 0(R2)
ADDU	R2, R3, R2
SUBU	R2, R2, R5
SH	R8, 20(SP)
SW	R25, 24(SP)
ANDI	R27, R5, 65535
ANDI	R26, R4, 65535
ANDI	R25, R2, 65535
JAL	_TFT_Circle+0
NOP	
LW	R25, 24(SP)
LH	R8, 20(SP)
;mmbInput_driver.c,786 :: 		if (ARadioButton->Checked == 1) {
ADDIU	R2, R25, 20
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__DrawRadioButton179
NOP	
J	L_DrawRadioButton35
NOP	
L__DrawRadioButton179:
;mmbInput_driver.c,787 :: 		if (object_pressed == 1) {
LBU	R3, Offset(_object_pressed+0)(GP)
ORI	R2, R0, 1
BEQ	R3, R2, L__DrawRadioButton180
NOP	
J	L_DrawRadioButton36
NOP	
L__DrawRadioButton180:
;mmbInput_driver.c,788 :: 		object_pressed = 0;
SB	R0, Offset(_object_pressed+0)(GP)
;mmbInput_driver.c,789 :: 		TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Press_Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_End_Color, ARadioButton->Gradient_Start_Color);
ADDIU	R2, R25, 40
LHU	R7, 0(R2)
ADDIU	R2, R25, 42
LHU	R6, 0(R2)
ADDIU	R2, R25, 39
LBU	R5, 0(R2)
ADDIU	R2, R25, 38
LBU	R4, 0(R2)
ADDIU	R2, R25, 50
LHU	R3, 0(R2)
ADDIU	R2, R25, 21
LBU	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R28, R5, 255
ANDI	R27, R4, 255
ANDI	R26, R3, 65535
ANDI	R25, R2, 255
ADDIU	SP, SP, -4
SH	R7, 2(SP)
SH	R6, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
LW	R25, 20(SP)
;mmbInput_driver.c,790 :: 		}
J	L_DrawRadioButton37
NOP	
L_DrawRadioButton36:
;mmbInput_driver.c,792 :: 		TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_Start_Color, ARadioButton->Gradient_End_Color);
ADDIU	R2, R25, 42
LHU	R7, 0(R2)
ADDIU	R2, R25, 40
LHU	R6, 0(R2)
ADDIU	R2, R25, 39
LBU	R5, 0(R2)
ADDIU	R2, R25, 38
LBU	R4, 0(R2)
ADDIU	R2, R25, 44
LHU	R3, 0(R2)
ADDIU	R2, R25, 21
LBU	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R28, R5, 255
ANDI	R27, R4, 255
ANDI	R26, R3, 65535
ANDI	R25, R2, 255
ADDIU	SP, SP, -4
SH	R7, 2(SP)
SH	R6, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
LW	R25, 20(SP)
L_DrawRadioButton37:
;mmbInput_driver.c,793 :: 		TFT_Circle(ARadioButton->Left  + ARadioButton->Width - ARadioButton->Height / 2, ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2 - circleOffset);
ADDIU	R2, R25, 12
LHU	R2, 0(R2)
ANDI	R2, R2, 65535
SRL	R6, R2, 1
SUBU	R5, R6, R8
; circleOffset end address is: 32 (R8)
ADDIU	R2, R25, 8
LHU	R2, 0(R2)
ADDU	R4, R2, R6
ADDIU	R2, R25, 6
LHU	R3, 0(R2)
ADDIU	R2, R25, 10
LHU	R2, 0(R2)
ADDU	R2, R3, R2
SUBU	R2, R2, R6
SW	R25, 20(SP)
ANDI	R27, R5, 65535
ANDI	R26, R4, 65535
ANDI	R25, R2, 65535
JAL	_TFT_Circle+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,794 :: 		}
L_DrawRadioButton35:
;mmbInput_driver.c,795 :: 		TFT_Set_Ext_Font(ARadioButton->FontName, ARadioButton->Font_Color, FO_HORIZONTAL);
ADDIU	R2, R25, 36
LHU	R3, 0(R2)
ADDIU	R2, R25, 32
LW	R2, 0(R2)
SW	R25, 20(SP)
MOVZ	R27, R0, R0
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Set_Ext_Font+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,796 :: 		TFT_Write_Text_Return_Pos(ARadioButton->Caption, ARadioButton->Left + 3, ARadioButton->Top);
ADDIU	R2, R25, 8
LHU	R4, 0(R2)
ADDIU	R2, R25, 6
LHU	R2, 0(R2)
ADDIU	R3, R2, 3
ADDIU	R2, R25, 24
LW	R2, 0(R2)
SW	R25, 20(SP)
ANDI	R27, R4, 65535
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Write_Text_Return_Pos+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,797 :: 		TFT_Write_Text(ARadioButton->Caption, ARadioButton->Left + 3, ARadioButton->Top + (ARadioButton->Height - caption_height) / 2);
ADDIU	R2, R25, 8
LHU	R4, 0(R2)
ADDIU	R2, R25, 12
LHU	R3, 0(R2)
LHU	R2, Offset(_caption_height+0)(GP)
SUBU	R2, R3, R2
ANDI	R2, R2, 65535
SRL	R2, R2, 1
ADDU	R4, R4, R2
ADDIU	R2, R25, 6
LHU	R2, 0(R2)
ADDIU	R3, R2, 3
ADDIU	R2, R25, 24
LW	R2, 0(R2)
ANDI	R27, R4, 65535
ANDI	R26, R3, 65535
MOVZ	R25, R2, R0
JAL	_TFT_Write_Text+0
NOP	
;mmbInput_driver.c,798 :: 		}
L_DrawRadioButton34:
L_DrawRadioButton33:
;mmbInput_driver.c,799 :: 		}
L_DrawRadioButton28:
;mmbInput_driver.c,800 :: 		}
L_end_DrawRadioButton:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 28
JR	RA
NOP	
; end of _DrawRadioButton
_DrawScreen:
;mmbInput_driver.c,802 :: 		void DrawScreen(TScreen *aScreen) {
ADDIU	SP, SP, -52
SW	RA, 0(SP)
;mmbInput_driver.c,812 :: 		object_pressed = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
SB	R0, Offset(_object_pressed+0)(GP)
;mmbInput_driver.c,813 :: 		order = 0;
SH	R0, 28(SP)
;mmbInput_driver.c,814 :: 		button_idx = 0;
SB	R0, 30(SP)
;mmbInput_driver.c,815 :: 		image_idx = 0;
SB	R0, 36(SP)
;mmbInput_driver.c,816 :: 		radio_button_idx = 0;
SB	R0, 44(SP)
;mmbInput_driver.c,817 :: 		CurrentScreen = aScreen;
SW	R25, Offset(_CurrentScreen+0)(GP)
;mmbInput_driver.c,819 :: 		if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
ADDIU	R2, R25, 2
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LHU	R2, Offset(_display_width+0)(GP)
BEQ	R2, R3, L__DrawScreen182
NOP	
J	L__DrawScreen133
NOP	
L__DrawScreen182:
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 4
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LHU	R2, Offset(_display_height+0)(GP)
BEQ	R2, R3, L__DrawScreen183
NOP	
J	L__DrawScreen132
NOP	
L__DrawScreen183:
J	L_DrawScreen40
NOP	
L__DrawScreen133:
L__DrawScreen132:
;mmbInput_driver.c,820 :: 		save_bled = TFT_BLED;
LBU	R2, Offset(LATA9_bit+1)(GP)
EXT	R2, R2, 1, 1
; save_bled start address is: 16 (R4)
ANDI	R4, R2, 255
;mmbInput_driver.c,821 :: 		save_bled_direction = TFT_BLED_Direction;
LBU	R2, Offset(TRISA9_bit+1)(GP)
EXT	R2, R2, 1, 1
; save_bled_direction start address is: 20 (R5)
ANDI	R5, R2, 255
;mmbInput_driver.c,822 :: 		TFT_BLED_Direction = 0;
LBU	R2, Offset(TRISA9_bit+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(TRISA9_bit+1)(GP)
;mmbInput_driver.c,823 :: 		TFT_BLED           = 0;
LBU	R2, Offset(LATA9_bit+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(LATA9_bit+1)(GP)
;mmbInput_driver.c,824 :: 		TFT_Set_Active(Set_Index, Write_Command, Write_Data);
SW	R25, 20(SP)
LUI	R27, #hi_addr(_Write_Data+0)
ORI	R27, R27, #lo_addr(_Write_Data+0)
LUI	R26, #hi_addr(_Write_Command+0)
ORI	R26, R26, #lo_addr(_Write_Command+0)
LUI	R25, #hi_addr(_Set_Index+0)
ORI	R25, R25, #lo_addr(_Set_Index+0)
JAL	_TFT_Set_Active+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,825 :: 		TFT_Init(CurrentScreen->Width, CurrentScreen->Height);
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 4
LHU	R3, 0(R2)
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 2
LHU	R2, 0(R2)
SB	R5, 20(SP)
SB	R4, 21(SP)
SW	R25, 24(SP)
ANDI	R26, R3, 65535
ANDI	R25, R2, 65535
JAL	_TFT_Init+0
NOP	
LW	R25, 24(SP)
LBU	R4, 21(SP)
LBU	R5, 20(SP)
;mmbInput_driver.c,826 :: 		TFT_Set_Ext_Buffer(TFT_Get_Data);
SW	R25, 20(SP)
LUI	R25, #hi_addr(_TFT_Get_Data+0)
ORI	R25, R25, #lo_addr(_TFT_Get_Data+0)
JAL	_TFT_Set_Ext_Buffer+0
NOP	
;mmbInput_driver.c,827 :: 		TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 13, 12);                                  // Initialize touch panel
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 4
LHU	R3, 0(R2)
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 2
LHU	R2, 0(R2)
ORI	R28, R0, 12
ORI	R27, R0, 13
ANDI	R26, R3, 65535
ANDI	R25, R2, 65535
JAL	_TP_TFT_Init+0
NOP	
;mmbInput_driver.c,828 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
ORI	R25, R0, 1000
JAL	_TP_TFT_Set_ADC_Threshold+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,829 :: 		TFT_Fill_Screen(CurrentScreen->Color);
LW	R2, Offset(_CurrentScreen+0)(GP)
SB	R5, 20(SP)
SB	R4, 21(SP)
SW	R25, 24(SP)
LHU	R25, 0(R2)
JAL	_TFT_Fill_Screen+0
NOP	
LW	R25, 24(SP)
LBU	R4, 21(SP)
LBU	R5, 20(SP)
;mmbInput_driver.c,830 :: 		display_width = CurrentScreen->Width;
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 2
LHU	R2, 0(R2)
SH	R2, Offset(_display_width+0)(GP)
;mmbInput_driver.c,831 :: 		display_height = CurrentScreen->Height;
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 4
LHU	R2, 0(R2)
SH	R2, Offset(_display_height+0)(GP)
;mmbInput_driver.c,832 :: 		TFT_BLED           = save_bled;
LBU	R2, Offset(LATA9_bit+1)(GP)
INS	R2, R4, 1, 1
; save_bled end address is: 16 (R4)
SB	R2, Offset(LATA9_bit+1)(GP)
;mmbInput_driver.c,833 :: 		TFT_BLED_Direction = save_bled_direction;
LBU	R2, Offset(TRISA9_bit+1)(GP)
INS	R2, R5, 1, 1
; save_bled_direction end address is: 20 (R5)
SB	R2, Offset(TRISA9_bit+1)(GP)
;mmbInput_driver.c,834 :: 		}
J	L_DrawScreen41
NOP	
L_DrawScreen40:
;mmbInput_driver.c,836 :: 		TFT_Fill_Screen(CurrentScreen->Color);
LW	R2, Offset(_CurrentScreen+0)(GP)
LHU	R25, 0(R2)
JAL	_TFT_Fill_Screen+0
NOP	
L_DrawScreen41:
;mmbInput_driver.c,839 :: 		while (order < CurrentScreen->ObjectsCount) {
L_DrawScreen42:
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 6
LBU	R2, 0(R2)
ANDI	R3, R2, 255
LH	R2, 28(SP)
SLT	R2, R2, R3
BNE	R2, R0, L__DrawScreen184
NOP	
J	L_DrawScreen43
NOP	
L__DrawScreen184:
;mmbInput_driver.c,840 :: 		if (button_idx < CurrentScreen->ButtonsCount) {
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 8
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LBU	R2, 30(SP)
SLTU	R2, R2, R3
BNE	R2, R0, L__DrawScreen185
NOP	
J	L_DrawScreen44
NOP	
L__DrawScreen185:
;mmbInput_driver.c,841 :: 		local_button = GetButton(button_idx);
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 12
LW	R3, 0(R2)
LBU	R2, 30(SP)
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R2, 0(R2)
SW	R2, 32(SP)
;mmbInput_driver.c,842 :: 		if (order == local_button->Order) {
ADDIU	R2, R2, 4
LBU	R2, 0(R2)
ANDI	R3, R2, 255
LH	R2, 28(SP)
BEQ	R2, R3, L__DrawScreen186
NOP	
J	L_DrawScreen45
NOP	
L__DrawScreen186:
;mmbInput_driver.c,843 :: 		button_idx++;
LBU	R2, 30(SP)
ADDIU	R2, R2, 1
SB	R2, 30(SP)
;mmbInput_driver.c,844 :: 		order++;
LH	R2, 28(SP)
ADDIU	R2, R2, 1
SH	R2, 28(SP)
;mmbInput_driver.c,845 :: 		DrawButton(local_button);
SW	R25, 20(SP)
LW	R25, 32(SP)
JAL	_DrawButton+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,846 :: 		}
L_DrawScreen45:
;mmbInput_driver.c,847 :: 		}
L_DrawScreen44:
;mmbInput_driver.c,849 :: 		if (image_idx  < CurrentScreen->ImagesCount) {
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 16
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LBU	R2, 36(SP)
SLTU	R2, R2, R3
BNE	R2, R0, L__DrawScreen187
NOP	
J	L_DrawScreen46
NOP	
L__DrawScreen187:
;mmbInput_driver.c,850 :: 		local_image = GetImage(image_idx);
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 20
LW	R3, 0(R2)
LBU	R2, 36(SP)
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R2, 0(R2)
SW	R2, 40(SP)
;mmbInput_driver.c,851 :: 		if (order == local_image->Order) {
ADDIU	R2, R2, 4
LBU	R2, 0(R2)
ANDI	R3, R2, 255
LH	R2, 28(SP)
BEQ	R2, R3, L__DrawScreen188
NOP	
J	L_DrawScreen47
NOP	
L__DrawScreen188:
;mmbInput_driver.c,852 :: 		image_idx++;
LBU	R2, 36(SP)
ADDIU	R2, R2, 1
SB	R2, 36(SP)
;mmbInput_driver.c,853 :: 		order++;
LH	R2, 28(SP)
ADDIU	R2, R2, 1
SH	R2, 28(SP)
;mmbInput_driver.c,854 :: 		DrawImage(local_image);
SW	R25, 20(SP)
LW	R25, 40(SP)
JAL	_DrawImage+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,855 :: 		}
L_DrawScreen47:
;mmbInput_driver.c,856 :: 		}
L_DrawScreen46:
;mmbInput_driver.c,858 :: 		if (radio_button_idx  < CurrentScreen->RadioButtonsCount) {
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 24
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LBU	R2, 44(SP)
SLTU	R2, R2, R3
BNE	R2, R0, L__DrawScreen189
NOP	
J	L_DrawScreen48
NOP	
L__DrawScreen189:
;mmbInput_driver.c,859 :: 		local_radio_button = GetRadioButton(radio_button_idx);
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 28
LW	R3, 0(R2)
LBU	R2, 44(SP)
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R2, 0(R2)
SW	R2, 48(SP)
;mmbInput_driver.c,860 :: 		if (order == local_radio_button->Order) {
ADDIU	R2, R2, 4
LBU	R2, 0(R2)
ANDI	R3, R2, 255
LH	R2, 28(SP)
BEQ	R2, R3, L__DrawScreen190
NOP	
J	L_DrawScreen49
NOP	
L__DrawScreen190:
;mmbInput_driver.c,861 :: 		radio_button_idx++;
LBU	R2, 44(SP)
ADDIU	R2, R2, 1
SB	R2, 44(SP)
;mmbInput_driver.c,862 :: 		order++;
LH	R2, 28(SP)
ADDIU	R2, R2, 1
SH	R2, 28(SP)
;mmbInput_driver.c,863 :: 		DrawRadioButton(local_radio_button);
SW	R25, 20(SP)
LW	R25, 48(SP)
JAL	_DrawRadioButton+0
NOP	
LW	R25, 20(SP)
;mmbInput_driver.c,864 :: 		}
L_DrawScreen49:
;mmbInput_driver.c,865 :: 		}
L_DrawScreen48:
;mmbInput_driver.c,867 :: 		}
J	L_DrawScreen42
NOP	
L_DrawScreen43:
;mmbInput_driver.c,868 :: 		}
L_end_DrawScreen:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 52
JR	RA
NOP	
; end of _DrawScreen
_Get_Object:
;mmbInput_driver.c,870 :: 		void Get_Object(unsigned int X, unsigned int Y) {
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mmbInput_driver.c,871 :: 		button_order        = -1;
SW	R27, 4(SP)
SW	R28, 8(SP)
ORI	R2, R0, 65535
SH	R2, Offset(_button_order+0)(GP)
;mmbInput_driver.c,872 :: 		image_order         = -1;
ORI	R2, R0, 65535
SH	R2, Offset(_image_order+0)(GP)
;mmbInput_driver.c,873 :: 		radio_button_order    = -1;
ORI	R2, R0, 65535
SH	R2, Offset(_radio_button_order+0)(GP)
;mmbInput_driver.c,875 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
SH	R0, Offset(__object_count+0)(GP)
L_Get_Object50:
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 8
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LH	R2, Offset(__object_count+0)(GP)
SLTU	R2, R2, R3
BNE	R2, R0, L__Get_Object192
NOP	
J	L_Get_Object51
NOP	
L__Get_Object192:
;mmbInput_driver.c,876 :: 		local_button = GetButton(_object_count);
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 12
LW	R3, 0(R2)
LH	R2, Offset(__object_count+0)(GP)
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R2, 0(R2)
SW	R2, Offset(_local_button+0)(GP)
;mmbInput_driver.c,877 :: 		if (local_button->Active == 1) {
ADDIU	R2, R2, 19
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__Get_Object193
NOP	
J	L_Get_Object53
NOP	
L__Get_Object193:
;mmbInput_driver.c,879 :: 		local_button->Width, local_button->Height) == 1) {
LW	R2, Offset(_local_button+0)(GP)
ADDIU	R2, R2, 12
LHU	R5, 0(R2)
LW	R2, Offset(_local_button+0)(GP)
ADDIU	R2, R2, 10
LHU	R4, 0(R2)
;mmbInput_driver.c,878 :: 		if (IsInsideObject(X, Y, local_button->Left, local_button->Top,
LW	R2, Offset(_local_button+0)(GP)
ADDIU	R2, R2, 8
LHU	R3, 0(R2)
LW	R2, Offset(_local_button+0)(GP)
ADDIU	R2, R2, 6
LHU	R2, 0(R2)
ANDI	R28, R3, 65535
ANDI	R27, R2, 65535
;mmbInput_driver.c,879 :: 		local_button->Width, local_button->Height) == 1) {
ADDIU	SP, SP, -4
SH	R5, 2(SP)
SH	R4, 0(SP)
JAL	mmbInput_driver_IsInsideObject+0
NOP	
ADDIU	SP, SP, 4
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__Get_Object194
NOP	
J	L_Get_Object54
NOP	
L__Get_Object194:
;mmbInput_driver.c,880 :: 		button_order = local_button->Order;
LW	R2, Offset(_local_button+0)(GP)
ADDIU	R2, R2, 4
LBU	R2, 0(R2)
ANDI	R2, R2, 255
SH	R2, Offset(_button_order+0)(GP)
;mmbInput_driver.c,881 :: 		exec_button = local_button;
LW	R2, Offset(_local_button+0)(GP)
SW	R2, Offset(_exec_button+0)(GP)
;mmbInput_driver.c,882 :: 		}
L_Get_Object54:
;mmbInput_driver.c,883 :: 		}
L_Get_Object53:
;mmbInput_driver.c,875 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
LH	R2, Offset(__object_count+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(__object_count+0)(GP)
;mmbInput_driver.c,884 :: 		}
J	L_Get_Object50
NOP	
L_Get_Object51:
;mmbInput_driver.c,887 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ImagesCount ; _object_count++ ) {
SH	R0, Offset(__object_count+0)(GP)
L_Get_Object55:
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 16
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LH	R2, Offset(__object_count+0)(GP)
SLTU	R2, R2, R3
BNE	R2, R0, L__Get_Object195
NOP	
J	L_Get_Object56
NOP	
L__Get_Object195:
;mmbInput_driver.c,888 :: 		local_image = GetImage(_object_count);
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 20
LW	R3, 0(R2)
LH	R2, Offset(__object_count+0)(GP)
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R2, 0(R2)
SW	R2, Offset(_local_image+0)(GP)
;mmbInput_driver.c,889 :: 		if (local_image->Active == 1) {
ADDIU	R2, R2, 21
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__Get_Object196
NOP	
J	L_Get_Object58
NOP	
L__Get_Object196:
;mmbInput_driver.c,891 :: 		local_image->Width, local_image->Height) == 1) {
LW	R2, Offset(_local_image+0)(GP)
ADDIU	R2, R2, 12
LHU	R5, 0(R2)
LW	R2, Offset(_local_image+0)(GP)
ADDIU	R2, R2, 10
LHU	R4, 0(R2)
;mmbInput_driver.c,890 :: 		if (IsInsideObject(X, Y, local_image->Left, local_image->Top,
LW	R2, Offset(_local_image+0)(GP)
ADDIU	R2, R2, 8
LHU	R3, 0(R2)
LW	R2, Offset(_local_image+0)(GP)
ADDIU	R2, R2, 6
LHU	R2, 0(R2)
ANDI	R28, R3, 65535
ANDI	R27, R2, 65535
;mmbInput_driver.c,891 :: 		local_image->Width, local_image->Height) == 1) {
ADDIU	SP, SP, -4
SH	R5, 2(SP)
SH	R4, 0(SP)
JAL	mmbInput_driver_IsInsideObject+0
NOP	
ADDIU	SP, SP, 4
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__Get_Object197
NOP	
J	L_Get_Object59
NOP	
L__Get_Object197:
;mmbInput_driver.c,892 :: 		image_order = local_image->Order;
LW	R2, Offset(_local_image+0)(GP)
ADDIU	R2, R2, 4
LBU	R2, 0(R2)
ANDI	R2, R2, 255
SH	R2, Offset(_image_order+0)(GP)
;mmbInput_driver.c,893 :: 		exec_image = local_image;
LW	R2, Offset(_local_image+0)(GP)
SW	R2, Offset(_exec_image+0)(GP)
;mmbInput_driver.c,894 :: 		}
L_Get_Object59:
;mmbInput_driver.c,895 :: 		}
L_Get_Object58:
;mmbInput_driver.c,887 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ImagesCount ; _object_count++ ) {
LH	R2, Offset(__object_count+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(__object_count+0)(GP)
;mmbInput_driver.c,896 :: 		}
J	L_Get_Object55
NOP	
L_Get_Object56:
;mmbInput_driver.c,899 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->RadioButtonsCount ; _object_count++ ) {
SH	R0, Offset(__object_count+0)(GP)
L_Get_Object60:
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 24
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LH	R2, Offset(__object_count+0)(GP)
SLTU	R2, R2, R3
BNE	R2, R0, L__Get_Object198
NOP	
J	L_Get_Object61
NOP	
L__Get_Object198:
;mmbInput_driver.c,900 :: 		local_radio_button = GetRadioButton(_object_count);
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 28
LW	R3, 0(R2)
LH	R2, Offset(__object_count+0)(GP)
SLL	R2, R2, 2
ADDU	R2, R3, R2
LW	R2, 0(R2)
SW	R2, Offset(_local_radio_button+0)(GP)
;mmbInput_driver.c,901 :: 		if (local_radio_button->Active == 1) {
ADDIU	R2, R2, 19
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__Get_Object199
NOP	
J	L_Get_Object63
NOP	
L__Get_Object199:
;mmbInput_driver.c,903 :: 		local_radio_button->Width, local_radio_button->Height) == 1) {
LW	R2, Offset(_local_radio_button+0)(GP)
ADDIU	R2, R2, 12
LHU	R5, 0(R2)
LW	R2, Offset(_local_radio_button+0)(GP)
ADDIU	R2, R2, 10
LHU	R4, 0(R2)
;mmbInput_driver.c,902 :: 		if (IsInsideObject(X, Y, local_radio_button->Left, local_radio_button->Top,
LW	R2, Offset(_local_radio_button+0)(GP)
ADDIU	R2, R2, 8
LHU	R3, 0(R2)
LW	R2, Offset(_local_radio_button+0)(GP)
ADDIU	R2, R2, 6
LHU	R2, 0(R2)
ANDI	R28, R3, 65535
ANDI	R27, R2, 65535
;mmbInput_driver.c,903 :: 		local_radio_button->Width, local_radio_button->Height) == 1) {
ADDIU	SP, SP, -4
SH	R5, 2(SP)
SH	R4, 0(SP)
JAL	mmbInput_driver_IsInsideObject+0
NOP	
ADDIU	SP, SP, 4
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L__Get_Object200
NOP	
J	L_Get_Object64
NOP	
L__Get_Object200:
;mmbInput_driver.c,904 :: 		radio_button_order = local_radio_button->Order;
LW	R2, Offset(_local_radio_button+0)(GP)
ADDIU	R2, R2, 4
LBU	R2, 0(R2)
ANDI	R2, R2, 255
SH	R2, Offset(_radio_button_order+0)(GP)
;mmbInput_driver.c,905 :: 		exec_radio_button = local_radio_button;
LW	R2, Offset(_local_radio_button+0)(GP)
SW	R2, Offset(_exec_radio_button+0)(GP)
;mmbInput_driver.c,906 :: 		}
L_Get_Object64:
;mmbInput_driver.c,907 :: 		}
L_Get_Object63:
;mmbInput_driver.c,899 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->RadioButtonsCount ; _object_count++ ) {
LH	R2, Offset(__object_count+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(__object_count+0)(GP)
;mmbInput_driver.c,908 :: 		}
J	L_Get_Object60
NOP	
L_Get_Object61:
;mmbInput_driver.c,910 :: 		_object_count = -1;
ORI	R2, R0, 65535
SH	R2, Offset(__object_count+0)(GP)
;mmbInput_driver.c,911 :: 		if (button_order > _object_count)
LH	R2, Offset(_button_order+0)(GP)
SLTI	R2, R2, 0
BEQ	R2, R0, L__Get_Object201
NOP	
J	L_Get_Object65
NOP	
L__Get_Object201:
;mmbInput_driver.c,912 :: 		_object_count = button_order;
LH	R2, Offset(_button_order+0)(GP)
SH	R2, Offset(__object_count+0)(GP)
L_Get_Object65:
;mmbInput_driver.c,913 :: 		if (image_order >  _object_count )
LH	R3, Offset(__object_count+0)(GP)
LH	R2, Offset(_image_order+0)(GP)
SLT	R2, R3, R2
BNE	R2, R0, L__Get_Object202
NOP	
J	L_Get_Object66
NOP	
L__Get_Object202:
;mmbInput_driver.c,914 :: 		_object_count = image_order;
LH	R2, Offset(_image_order+0)(GP)
SH	R2, Offset(__object_count+0)(GP)
L_Get_Object66:
;mmbInput_driver.c,915 :: 		if (radio_button_order >  _object_count )
LH	R3, Offset(__object_count+0)(GP)
LH	R2, Offset(_radio_button_order+0)(GP)
SLT	R2, R3, R2
BNE	R2, R0, L__Get_Object203
NOP	
J	L_Get_Object67
NOP	
L__Get_Object203:
;mmbInput_driver.c,916 :: 		_object_count = radio_button_order;
LH	R2, Offset(_radio_button_order+0)(GP)
SH	R2, Offset(__object_count+0)(GP)
L_Get_Object67:
;mmbInput_driver.c,917 :: 		}
L_end_Get_Object:
LW	R28, 8(SP)
LW	R27, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _Get_Object
mmbInput_driver_Process_TP_Press:
;mmbInput_driver.c,920 :: 		static void Process_TP_Press(unsigned int X, unsigned int Y) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;mmbInput_driver.c,921 :: 		exec_button         = 0;
SW	R0, Offset(_exec_button+0)(GP)
;mmbInput_driver.c,922 :: 		exec_image          = 0;
SW	R0, Offset(_exec_image+0)(GP)
;mmbInput_driver.c,923 :: 		exec_radio_button     = 0;
SW	R0, Offset(_exec_radio_button+0)(GP)
;mmbInput_driver.c,925 :: 		Get_Object(X, Y);
JAL	_Get_Object+0
NOP	
;mmbInput_driver.c,928 :: 		if (_object_count != -1) {
LH	R3, Offset(__object_count+0)(GP)
LUI	R2, 65535
ORI	R2, R2, 65535
BNE	R3, R2, L_mmbInput_driver_Process_TP_Press206
NOP	
J	L_mmbInput_driver_Process_TP_Press68
NOP	
L_mmbInput_driver_Process_TP_Press206:
;mmbInput_driver.c,929 :: 		if (_object_count == button_order) {
LH	R3, Offset(_button_order+0)(GP)
LH	R2, Offset(__object_count+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Press207
NOP	
J	L_mmbInput_driver_Process_TP_Press69
NOP	
L_mmbInput_driver_Process_TP_Press207:
;mmbInput_driver.c,930 :: 		if (exec_button->Active == 1) {
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 19
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Press208
NOP	
J	L_mmbInput_driver_Process_TP_Press70
NOP	
L_mmbInput_driver_Process_TP_Press208:
;mmbInput_driver.c,931 :: 		if (exec_button->OnPressPtr != 0) {
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 64
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Press210
NOP	
J	L_mmbInput_driver_Process_TP_Press71
NOP	
L_mmbInput_driver_Process_TP_Press210:
;mmbInput_driver.c,932 :: 		exec_button->OnPressPtr();
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 64
LW	R2, 0(R2)
JALR	RA, R2
NOP	
;mmbInput_driver.c,933 :: 		return;
J	L_end_Process_TP_Press
NOP	
;mmbInput_driver.c,934 :: 		}
L_mmbInput_driver_Process_TP_Press71:
;mmbInput_driver.c,935 :: 		}
L_mmbInput_driver_Process_TP_Press70:
;mmbInput_driver.c,936 :: 		}
L_mmbInput_driver_Process_TP_Press69:
;mmbInput_driver.c,938 :: 		if (_object_count == image_order) {
LH	R3, Offset(_image_order+0)(GP)
LH	R2, Offset(__object_count+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Press211
NOP	
J	L_mmbInput_driver_Process_TP_Press72
NOP	
L_mmbInput_driver_Process_TP_Press211:
;mmbInput_driver.c,939 :: 		if (exec_image->Active == 1) {
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 21
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Press212
NOP	
J	L_mmbInput_driver_Process_TP_Press73
NOP	
L_mmbInput_driver_Process_TP_Press212:
;mmbInput_driver.c,940 :: 		if (exec_image->OnPressPtr != 0) {
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 36
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Press214
NOP	
J	L_mmbInput_driver_Process_TP_Press74
NOP	
L_mmbInput_driver_Process_TP_Press214:
;mmbInput_driver.c,941 :: 		exec_image->OnPressPtr();
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 36
LW	R2, 0(R2)
JALR	RA, R2
NOP	
;mmbInput_driver.c,942 :: 		return;
J	L_end_Process_TP_Press
NOP	
;mmbInput_driver.c,943 :: 		}
L_mmbInput_driver_Process_TP_Press74:
;mmbInput_driver.c,944 :: 		}
L_mmbInput_driver_Process_TP_Press73:
;mmbInput_driver.c,945 :: 		}
L_mmbInput_driver_Process_TP_Press72:
;mmbInput_driver.c,947 :: 		if (_object_count == radio_button_order) {
LH	R3, Offset(_radio_button_order+0)(GP)
LH	R2, Offset(__object_count+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Press215
NOP	
J	L_mmbInput_driver_Process_TP_Press75
NOP	
L_mmbInput_driver_Process_TP_Press215:
;mmbInput_driver.c,948 :: 		if (exec_radio_button->Active == 1) {
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 19
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Press216
NOP	
J	L_mmbInput_driver_Process_TP_Press76
NOP	
L_mmbInput_driver_Process_TP_Press216:
;mmbInput_driver.c,949 :: 		if (exec_radio_button->OnPressPtr != 0) {
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 64
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Press218
NOP	
J	L_mmbInput_driver_Process_TP_Press77
NOP	
L_mmbInput_driver_Process_TP_Press218:
;mmbInput_driver.c,950 :: 		exec_radio_button->OnPressPtr();
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 64
LW	R2, 0(R2)
JALR	RA, R2
NOP	
;mmbInput_driver.c,951 :: 		return;
J	L_end_Process_TP_Press
NOP	
;mmbInput_driver.c,952 :: 		}
L_mmbInput_driver_Process_TP_Press77:
;mmbInput_driver.c,953 :: 		}
L_mmbInput_driver_Process_TP_Press76:
;mmbInput_driver.c,954 :: 		}
L_mmbInput_driver_Process_TP_Press75:
;mmbInput_driver.c,956 :: 		}
L_mmbInput_driver_Process_TP_Press68:
;mmbInput_driver.c,957 :: 		}
L_end_Process_TP_Press:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of mmbInput_driver_Process_TP_Press
mmbInput_driver_Process_TP_Up:
;mmbInput_driver.c,959 :: 		static void Process_TP_Up(unsigned int X, unsigned int Y) {
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;mmbInput_driver.c,961 :: 		switch (PressedObjectType) {
J	L_mmbInput_driver_Process_TP_Up78
NOP	
;mmbInput_driver.c,963 :: 		case 0: {
L_mmbInput_driver_Process_TP_Up80:
;mmbInput_driver.c,964 :: 		if (PressedObject != 0) {
LW	R2, Offset(_PressedObject+0)(GP)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Up221
NOP	
J	L_mmbInput_driver_Process_TP_Up81
NOP	
L_mmbInput_driver_Process_TP_Up221:
;mmbInput_driver.c,965 :: 		exec_button = (TButton*)PressedObject;
LW	R2, Offset(_PressedObject+0)(GP)
SW	R2, Offset(_exec_button+0)(GP)
;mmbInput_driver.c,966 :: 		if ((exec_button->PressColEnabled == 1) && (exec_button->OwnerScreen == CurrentScreen)) {
LW	R2, Offset(_PressedObject+0)(GP)
ADDIU	R2, R2, 46
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Up222
NOP	
J	L_mmbInput_driver_Process_TP_Up137
NOP	
L_mmbInput_driver_Process_TP_Up222:
LW	R2, Offset(_exec_button+0)(GP)
LW	R3, 0(R2)
LW	R2, Offset(_CurrentScreen+0)(GP)
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Up223
NOP	
J	L_mmbInput_driver_Process_TP_Up136
NOP	
L_mmbInput_driver_Process_TP_Up223:
L_mmbInput_driver_Process_TP_Up135:
;mmbInput_driver.c,967 :: 		DrawButton(exec_button);
SH	R26, 4(SP)
SH	R25, 6(SP)
LW	R25, Offset(_exec_button+0)(GP)
JAL	_DrawButton+0
NOP	
LHU	R25, 6(SP)
LHU	R26, 4(SP)
;mmbInput_driver.c,966 :: 		if ((exec_button->PressColEnabled == 1) && (exec_button->OwnerScreen == CurrentScreen)) {
L_mmbInput_driver_Process_TP_Up137:
L_mmbInput_driver_Process_TP_Up136:
;mmbInput_driver.c,969 :: 		break;
J	L_mmbInput_driver_Process_TP_Up79
NOP	
;mmbInput_driver.c,970 :: 		}
L_mmbInput_driver_Process_TP_Up81:
;mmbInput_driver.c,971 :: 		break;
J	L_mmbInput_driver_Process_TP_Up79
NOP	
;mmbInput_driver.c,974 :: 		case 17: {
L_mmbInput_driver_Process_TP_Up85:
;mmbInput_driver.c,975 :: 		if (PressedObject != 0) {
LW	R2, Offset(_PressedObject+0)(GP)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Up225
NOP	
J	L_mmbInput_driver_Process_TP_Up86
NOP	
L_mmbInput_driver_Process_TP_Up225:
;mmbInput_driver.c,976 :: 		exec_radio_button = (TRadioButton*)PressedObject;
LW	R2, Offset(_PressedObject+0)(GP)
SW	R2, Offset(_exec_radio_button+0)(GP)
;mmbInput_driver.c,977 :: 		if ((exec_radio_button->PressColEnabled == 1) && (exec_radio_button->OwnerScreen == CurrentScreen)) {
LW	R2, Offset(_PressedObject+0)(GP)
ADDIU	R2, R2, 48
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Up226
NOP	
J	L_mmbInput_driver_Process_TP_Up139
NOP	
L_mmbInput_driver_Process_TP_Up226:
LW	R2, Offset(_exec_radio_button+0)(GP)
LW	R3, 0(R2)
LW	R2, Offset(_CurrentScreen+0)(GP)
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Up227
NOP	
J	L_mmbInput_driver_Process_TP_Up138
NOP	
L_mmbInput_driver_Process_TP_Up227:
L_mmbInput_driver_Process_TP_Up134:
;mmbInput_driver.c,978 :: 		DrawRadioButton(exec_radio_button);
SH	R26, 4(SP)
SH	R25, 6(SP)
LW	R25, Offset(_exec_radio_button+0)(GP)
JAL	_DrawRadioButton+0
NOP	
LHU	R25, 6(SP)
LHU	R26, 4(SP)
;mmbInput_driver.c,977 :: 		if ((exec_radio_button->PressColEnabled == 1) && (exec_radio_button->OwnerScreen == CurrentScreen)) {
L_mmbInput_driver_Process_TP_Up139:
L_mmbInput_driver_Process_TP_Up138:
;mmbInput_driver.c,980 :: 		break;
J	L_mmbInput_driver_Process_TP_Up79
NOP	
;mmbInput_driver.c,981 :: 		}
L_mmbInput_driver_Process_TP_Up86:
;mmbInput_driver.c,982 :: 		break;
J	L_mmbInput_driver_Process_TP_Up79
NOP	
;mmbInput_driver.c,984 :: 		}
L_mmbInput_driver_Process_TP_Up78:
LH	R2, Offset(_PressedObjectType+0)(GP)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Up229
NOP	
J	L_mmbInput_driver_Process_TP_Up80
NOP	
L_mmbInput_driver_Process_TP_Up229:
LH	R3, Offset(_PressedObjectType+0)(GP)
ORI	R2, R0, 17
BNE	R3, R2, L_mmbInput_driver_Process_TP_Up231
NOP	
J	L_mmbInput_driver_Process_TP_Up85
NOP	
L_mmbInput_driver_Process_TP_Up231:
L_mmbInput_driver_Process_TP_Up79:
;mmbInput_driver.c,986 :: 		exec_image          = 0;
SW	R0, Offset(_exec_image+0)(GP)
;mmbInput_driver.c,988 :: 		Get_Object(X, Y);
JAL	_Get_Object+0
NOP	
;mmbInput_driver.c,991 :: 		if (_object_count != -1) {
LH	R3, Offset(__object_count+0)(GP)
LUI	R2, 65535
ORI	R2, R2, 65535
BNE	R3, R2, L_mmbInput_driver_Process_TP_Up233
NOP	
J	L_mmbInput_driver_Process_TP_Up90
NOP	
L_mmbInput_driver_Process_TP_Up233:
;mmbInput_driver.c,993 :: 		if (_object_count == button_order) {
LH	R3, Offset(_button_order+0)(GP)
LH	R2, Offset(__object_count+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Up234
NOP	
J	L_mmbInput_driver_Process_TP_Up91
NOP	
L_mmbInput_driver_Process_TP_Up234:
;mmbInput_driver.c,994 :: 		if (exec_button->Active == 1) {
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 19
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Up235
NOP	
J	L_mmbInput_driver_Process_TP_Up92
NOP	
L_mmbInput_driver_Process_TP_Up235:
;mmbInput_driver.c,995 :: 		if (exec_button->OnUpPtr != 0)
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 52
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Up237
NOP	
J	L_mmbInput_driver_Process_TP_Up93
NOP	
L_mmbInput_driver_Process_TP_Up237:
;mmbInput_driver.c,996 :: 		exec_button->OnUpPtr();
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 52
LW	R2, 0(R2)
JALR	RA, R2
NOP	
L_mmbInput_driver_Process_TP_Up93:
;mmbInput_driver.c,997 :: 		if (PressedObject == (void *)exec_button)
LW	R3, Offset(_exec_button+0)(GP)
LW	R2, Offset(_PressedObject+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Up238
NOP	
J	L_mmbInput_driver_Process_TP_Up94
NOP	
L_mmbInput_driver_Process_TP_Up238:
;mmbInput_driver.c,998 :: 		if (exec_button->OnClickPtr != 0)
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 60
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Up240
NOP	
J	L_mmbInput_driver_Process_TP_Up95
NOP	
L_mmbInput_driver_Process_TP_Up240:
;mmbInput_driver.c,999 :: 		exec_button->OnClickPtr();
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 60
LW	R2, 0(R2)
JALR	RA, R2
NOP	
L_mmbInput_driver_Process_TP_Up95:
L_mmbInput_driver_Process_TP_Up94:
;mmbInput_driver.c,1000 :: 		PressedObject = 0;
SW	R0, Offset(_PressedObject+0)(GP)
;mmbInput_driver.c,1001 :: 		PressedObjectType = -1;
ORI	R2, R0, 65535
SH	R2, Offset(_PressedObjectType+0)(GP)
;mmbInput_driver.c,1002 :: 		return;
J	L_end_Process_TP_Up
NOP	
;mmbInput_driver.c,1003 :: 		}
L_mmbInput_driver_Process_TP_Up92:
;mmbInput_driver.c,1004 :: 		}
L_mmbInput_driver_Process_TP_Up91:
;mmbInput_driver.c,1007 :: 		if (_object_count == image_order) {
LH	R3, Offset(_image_order+0)(GP)
LH	R2, Offset(__object_count+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Up241
NOP	
J	L_mmbInput_driver_Process_TP_Up96
NOP	
L_mmbInput_driver_Process_TP_Up241:
;mmbInput_driver.c,1008 :: 		if (exec_image->Active == 1) {
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 21
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Up242
NOP	
J	L_mmbInput_driver_Process_TP_Up97
NOP	
L_mmbInput_driver_Process_TP_Up242:
;mmbInput_driver.c,1009 :: 		if (exec_image->OnUpPtr != 0)
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 24
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Up244
NOP	
J	L_mmbInput_driver_Process_TP_Up98
NOP	
L_mmbInput_driver_Process_TP_Up244:
;mmbInput_driver.c,1010 :: 		exec_image->OnUpPtr();
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 24
LW	R2, 0(R2)
JALR	RA, R2
NOP	
L_mmbInput_driver_Process_TP_Up98:
;mmbInput_driver.c,1011 :: 		if (PressedObject == (void *)exec_image)
LW	R3, Offset(_exec_image+0)(GP)
LW	R2, Offset(_PressedObject+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Up245
NOP	
J	L_mmbInput_driver_Process_TP_Up99
NOP	
L_mmbInput_driver_Process_TP_Up245:
;mmbInput_driver.c,1012 :: 		if (exec_image->OnClickPtr != 0)
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 32
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Up247
NOP	
J	L_mmbInput_driver_Process_TP_Up100
NOP	
L_mmbInput_driver_Process_TP_Up247:
;mmbInput_driver.c,1013 :: 		exec_image->OnClickPtr();
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 32
LW	R2, 0(R2)
JALR	RA, R2
NOP	
L_mmbInput_driver_Process_TP_Up100:
L_mmbInput_driver_Process_TP_Up99:
;mmbInput_driver.c,1014 :: 		PressedObject = 0;
SW	R0, Offset(_PressedObject+0)(GP)
;mmbInput_driver.c,1015 :: 		PressedObjectType = -1;
ORI	R2, R0, 65535
SH	R2, Offset(_PressedObjectType+0)(GP)
;mmbInput_driver.c,1016 :: 		return;
J	L_end_Process_TP_Up
NOP	
;mmbInput_driver.c,1017 :: 		}
L_mmbInput_driver_Process_TP_Up97:
;mmbInput_driver.c,1018 :: 		}
L_mmbInput_driver_Process_TP_Up96:
;mmbInput_driver.c,1021 :: 		if (_object_count == radio_button_order) {
LH	R3, Offset(_radio_button_order+0)(GP)
LH	R2, Offset(__object_count+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Up248
NOP	
J	L_mmbInput_driver_Process_TP_Up101
NOP	
L_mmbInput_driver_Process_TP_Up248:
;mmbInput_driver.c,1022 :: 		if (exec_radio_button->Active == 1) {
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 19
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Up249
NOP	
J	L_mmbInput_driver_Process_TP_Up102
NOP	
L_mmbInput_driver_Process_TP_Up249:
;mmbInput_driver.c,1023 :: 		if (exec_radio_button->OnUpPtr != 0)
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 52
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Up251
NOP	
J	L_mmbInput_driver_Process_TP_Up103
NOP	
L_mmbInput_driver_Process_TP_Up251:
;mmbInput_driver.c,1024 :: 		exec_radio_button->OnUpPtr();
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 52
LW	R2, 0(R2)
JALR	RA, R2
NOP	
L_mmbInput_driver_Process_TP_Up103:
;mmbInput_driver.c,1025 :: 		if (PressedObject == (void *)exec_radio_button)
LW	R3, Offset(_exec_radio_button+0)(GP)
LW	R2, Offset(_PressedObject+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Up252
NOP	
J	L_mmbInput_driver_Process_TP_Up104
NOP	
L_mmbInput_driver_Process_TP_Up252:
;mmbInput_driver.c,1026 :: 		if (exec_radio_button->OnClickPtr != 0)
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 60
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Up254
NOP	
J	L_mmbInput_driver_Process_TP_Up105
NOP	
L_mmbInput_driver_Process_TP_Up254:
;mmbInput_driver.c,1027 :: 		exec_radio_button->OnClickPtr();
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 60
LW	R2, 0(R2)
JALR	RA, R2
NOP	
L_mmbInput_driver_Process_TP_Up105:
L_mmbInput_driver_Process_TP_Up104:
;mmbInput_driver.c,1028 :: 		PressedObject = 0;
SW	R0, Offset(_PressedObject+0)(GP)
;mmbInput_driver.c,1029 :: 		PressedObjectType = -1;
ORI	R2, R0, 65535
SH	R2, Offset(_PressedObjectType+0)(GP)
;mmbInput_driver.c,1030 :: 		return;
J	L_end_Process_TP_Up
NOP	
;mmbInput_driver.c,1031 :: 		}
L_mmbInput_driver_Process_TP_Up102:
;mmbInput_driver.c,1032 :: 		}
L_mmbInput_driver_Process_TP_Up101:
;mmbInput_driver.c,1034 :: 		}
L_mmbInput_driver_Process_TP_Up90:
;mmbInput_driver.c,1035 :: 		PressedObject = 0;
SW	R0, Offset(_PressedObject+0)(GP)
;mmbInput_driver.c,1036 :: 		PressedObjectType = -1;
ORI	R2, R0, 65535
SH	R2, Offset(_PressedObjectType+0)(GP)
;mmbInput_driver.c,1037 :: 		}
L_end_Process_TP_Up:
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of mmbInput_driver_Process_TP_Up
mmbInput_driver_Process_TP_Down:
;mmbInput_driver.c,1039 :: 		static void Process_TP_Down(unsigned int X, unsigned int Y) {
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;mmbInput_driver.c,1041 :: 		object_pressed      = 0;
SW	R25, 4(SP)
SB	R0, Offset(_object_pressed+0)(GP)
;mmbInput_driver.c,1042 :: 		exec_button         = 0;
SW	R0, Offset(_exec_button+0)(GP)
;mmbInput_driver.c,1043 :: 		exec_image          = 0;
SW	R0, Offset(_exec_image+0)(GP)
;mmbInput_driver.c,1044 :: 		exec_radio_button     = 0;
SW	R0, Offset(_exec_radio_button+0)(GP)
;mmbInput_driver.c,1046 :: 		Get_Object(X, Y);
JAL	_Get_Object+0
NOP	
;mmbInput_driver.c,1048 :: 		if (_object_count != -1) {
LH	R3, Offset(__object_count+0)(GP)
LUI	R2, 65535
ORI	R2, R2, 65535
BNE	R3, R2, L_mmbInput_driver_Process_TP_Down257
NOP	
J	L_mmbInput_driver_Process_TP_Down106
NOP	
L_mmbInput_driver_Process_TP_Down257:
;mmbInput_driver.c,1049 :: 		if (_object_count == button_order) {
LH	R3, Offset(_button_order+0)(GP)
LH	R2, Offset(__object_count+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Down258
NOP	
J	L_mmbInput_driver_Process_TP_Down107
NOP	
L_mmbInput_driver_Process_TP_Down258:
;mmbInput_driver.c,1050 :: 		if (exec_button->Active == 1) {
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 19
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Down259
NOP	
J	L_mmbInput_driver_Process_TP_Down108
NOP	
L_mmbInput_driver_Process_TP_Down259:
;mmbInput_driver.c,1051 :: 		if (exec_button->PressColEnabled == 1) {
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 46
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Down260
NOP	
J	L_mmbInput_driver_Process_TP_Down109
NOP	
L_mmbInput_driver_Process_TP_Down260:
;mmbInput_driver.c,1052 :: 		object_pressed = 1;
ORI	R2, R0, 1
SB	R2, Offset(_object_pressed+0)(GP)
;mmbInput_driver.c,1053 :: 		DrawButton(exec_button);
LW	R25, Offset(_exec_button+0)(GP)
JAL	_DrawButton+0
NOP	
;mmbInput_driver.c,1054 :: 		}
L_mmbInput_driver_Process_TP_Down109:
;mmbInput_driver.c,1055 :: 		PressedObject = (void *)exec_button;
LW	R2, Offset(_exec_button+0)(GP)
SW	R2, Offset(_PressedObject+0)(GP)
;mmbInput_driver.c,1056 :: 		PressedObjectType = 0;
SH	R0, Offset(_PressedObjectType+0)(GP)
;mmbInput_driver.c,1057 :: 		if (exec_button->OnDownPtr != 0) {
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 56
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Down262
NOP	
J	L_mmbInput_driver_Process_TP_Down110
NOP	
L_mmbInput_driver_Process_TP_Down262:
;mmbInput_driver.c,1058 :: 		exec_button->OnDownPtr();
LW	R2, Offset(_exec_button+0)(GP)
ADDIU	R2, R2, 56
LW	R2, 0(R2)
JALR	RA, R2
NOP	
;mmbInput_driver.c,1059 :: 		return;
J	L_end_Process_TP_Down
NOP	
;mmbInput_driver.c,1060 :: 		}
L_mmbInput_driver_Process_TP_Down110:
;mmbInput_driver.c,1061 :: 		}
L_mmbInput_driver_Process_TP_Down108:
;mmbInput_driver.c,1062 :: 		}
L_mmbInput_driver_Process_TP_Down107:
;mmbInput_driver.c,1064 :: 		if (_object_count == image_order) {
LH	R3, Offset(_image_order+0)(GP)
LH	R2, Offset(__object_count+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Down263
NOP	
J	L_mmbInput_driver_Process_TP_Down111
NOP	
L_mmbInput_driver_Process_TP_Down263:
;mmbInput_driver.c,1065 :: 		if (exec_image->Active == 1) {
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 21
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Down264
NOP	
J	L_mmbInput_driver_Process_TP_Down112
NOP	
L_mmbInput_driver_Process_TP_Down264:
;mmbInput_driver.c,1066 :: 		PressedObject = (void *)exec_image;
LW	R2, Offset(_exec_image+0)(GP)
SW	R2, Offset(_PressedObject+0)(GP)
;mmbInput_driver.c,1067 :: 		PressedObjectType = 3;
ORI	R2, R0, 3
SH	R2, Offset(_PressedObjectType+0)(GP)
;mmbInput_driver.c,1068 :: 		if (exec_image->OnDownPtr != 0) {
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 28
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Down266
NOP	
J	L_mmbInput_driver_Process_TP_Down113
NOP	
L_mmbInput_driver_Process_TP_Down266:
;mmbInput_driver.c,1069 :: 		exec_image->OnDownPtr();
LW	R2, Offset(_exec_image+0)(GP)
ADDIU	R2, R2, 28
LW	R2, 0(R2)
JALR	RA, R2
NOP	
;mmbInput_driver.c,1070 :: 		return;
J	L_end_Process_TP_Down
NOP	
;mmbInput_driver.c,1071 :: 		}
L_mmbInput_driver_Process_TP_Down113:
;mmbInput_driver.c,1072 :: 		}
L_mmbInput_driver_Process_TP_Down112:
;mmbInput_driver.c,1073 :: 		}
L_mmbInput_driver_Process_TP_Down111:
;mmbInput_driver.c,1075 :: 		if (_object_count == radio_button_order) {
LH	R3, Offset(_radio_button_order+0)(GP)
LH	R2, Offset(__object_count+0)(GP)
BEQ	R2, R3, L_mmbInput_driver_Process_TP_Down267
NOP	
J	L_mmbInput_driver_Process_TP_Down114
NOP	
L_mmbInput_driver_Process_TP_Down267:
;mmbInput_driver.c,1076 :: 		if (exec_radio_button->Active == 1) {
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 19
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Down268
NOP	
J	L_mmbInput_driver_Process_TP_Down115
NOP	
L_mmbInput_driver_Process_TP_Down268:
;mmbInput_driver.c,1077 :: 		if (exec_radio_button->PressColEnabled == 1) {
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 48
LBU	R2, 0(R2)
ANDI	R3, R2, 255
ORI	R2, R0, 1
BEQ	R3, R2, L_mmbInput_driver_Process_TP_Down269
NOP	
J	L_mmbInput_driver_Process_TP_Down116
NOP	
L_mmbInput_driver_Process_TP_Down269:
;mmbInput_driver.c,1078 :: 		object_pressed = 1;
ORI	R2, R0, 1
SB	R2, Offset(_object_pressed+0)(GP)
;mmbInput_driver.c,1079 :: 		DrawRadioButton(exec_radio_button);
LW	R25, Offset(_exec_radio_button+0)(GP)
JAL	_DrawRadioButton+0
NOP	
;mmbInput_driver.c,1080 :: 		}
L_mmbInput_driver_Process_TP_Down116:
;mmbInput_driver.c,1081 :: 		PressedObject = (void *)exec_radio_button;
LW	R2, Offset(_exec_radio_button+0)(GP)
SW	R2, Offset(_PressedObject+0)(GP)
;mmbInput_driver.c,1082 :: 		PressedObjectType = 17;
ORI	R2, R0, 17
SH	R2, Offset(_PressedObjectType+0)(GP)
;mmbInput_driver.c,1083 :: 		if (exec_radio_button->OnDownPtr != 0) {
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 56
LW	R2, 0(R2)
BNE	R2, R0, L_mmbInput_driver_Process_TP_Down271
NOP	
J	L_mmbInput_driver_Process_TP_Down117
NOP	
L_mmbInput_driver_Process_TP_Down271:
;mmbInput_driver.c,1084 :: 		exec_radio_button->OnDownPtr();
LW	R2, Offset(_exec_radio_button+0)(GP)
ADDIU	R2, R2, 56
LW	R2, 0(R2)
JALR	RA, R2
NOP	
;mmbInput_driver.c,1085 :: 		return;
J	L_end_Process_TP_Down
NOP	
;mmbInput_driver.c,1086 :: 		}
L_mmbInput_driver_Process_TP_Down117:
;mmbInput_driver.c,1087 :: 		}
L_mmbInput_driver_Process_TP_Down115:
;mmbInput_driver.c,1088 :: 		}
L_mmbInput_driver_Process_TP_Down114:
;mmbInput_driver.c,1090 :: 		}
L_mmbInput_driver_Process_TP_Down106:
;mmbInput_driver.c,1091 :: 		}
L_end_Process_TP_Down:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of mmbInput_driver_Process_TP_Down
_Check_TP:
;mmbInput_driver.c,1093 :: 		void Check_TP() {
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mmbInput_driver.c,1094 :: 		if (TP_TFT_Press_Detect()) {
SW	R25, 4(SP)
SW	R26, 8(SP)
JAL	_TP_TFT_Press_Detect+0
NOP	
BNE	R2, R0, L__Check_TP274
NOP	
J	L_Check_TP118
NOP	
L__Check_TP274:
;mmbInput_driver.c,1096 :: 		if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
LUI	R26, #hi_addr(_Ycoord+0)
ORI	R26, R26, #lo_addr(_Ycoord+0)
LUI	R25, #hi_addr(_Xcoord+0)
ORI	R25, R25, #lo_addr(_Xcoord+0)
JAL	_TP_TFT_Get_Coordinates+0
NOP	
ANDI	R2, R2, 255
BEQ	R2, R0, L__Check_TP275
NOP	
J	L_Check_TP119
NOP	
L__Check_TP275:
;mmbInput_driver.c,1097 :: 		Process_TP_Press(Xcoord, Ycoord);
LHU	R26, Offset(_Ycoord+0)(GP)
LHU	R25, Offset(_Xcoord+0)(GP)
JAL	mmbInput_driver_Process_TP_Press+0
NOP	
;mmbInput_driver.c,1098 :: 		if (PenDown == 0) {
LBU	R2, Offset(_PenDown+0)(GP)
BEQ	R2, R0, L__Check_TP276
NOP	
J	L_Check_TP120
NOP	
L__Check_TP276:
;mmbInput_driver.c,1099 :: 		PenDown = 1;
ORI	R2, R0, 1
SB	R2, Offset(_PenDown+0)(GP)
;mmbInput_driver.c,1100 :: 		Process_TP_Down(Xcoord, Ycoord);
LHU	R26, Offset(_Ycoord+0)(GP)
LHU	R25, Offset(_Xcoord+0)(GP)
JAL	mmbInput_driver_Process_TP_Down+0
NOP	
;mmbInput_driver.c,1101 :: 		}
L_Check_TP120:
;mmbInput_driver.c,1102 :: 		}
L_Check_TP119:
;mmbInput_driver.c,1103 :: 		}
J	L_Check_TP121
NOP	
L_Check_TP118:
;mmbInput_driver.c,1104 :: 		else if (PenDown == 1) {
LBU	R3, Offset(_PenDown+0)(GP)
ORI	R2, R0, 1
BEQ	R3, R2, L__Check_TP277
NOP	
J	L_Check_TP122
NOP	
L__Check_TP277:
;mmbInput_driver.c,1105 :: 		PenDown = 0;
SB	R0, Offset(_PenDown+0)(GP)
;mmbInput_driver.c,1106 :: 		Process_TP_Up(Xcoord, Ycoord);
LHU	R26, Offset(_Ycoord+0)(GP)
LHU	R25, Offset(_Xcoord+0)(GP)
JAL	mmbInput_driver_Process_TP_Up+0
NOP	
;mmbInput_driver.c,1107 :: 		}
L_Check_TP122:
L_Check_TP121:
;mmbInput_driver.c,1108 :: 		}
L_end_Check_TP:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _Check_TP
_Init_MCU:
;mmbInput_driver.c,1110 :: 		void Init_MCU() {
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;mmbInput_driver.c,1111 :: 		PMMODE = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R0, Offset(PMMODE+0)(GP)
;mmbInput_driver.c,1112 :: 		PMAEN  = 0;
SW	R0, Offset(PMAEN+0)(GP)
;mmbInput_driver.c,1113 :: 		PMCON  = 0;  // WRSP: Write Strobe Polarity bit
SW	R0, Offset(PMCON+0)(GP)
;mmbInput_driver.c,1114 :: 		PMMODEbits.MODE = 2;     // Master 2
ORI	R3, R0, 2
LHU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R3, 8, 2
SH	R2, Offset(PMMODEbits+0)(GP)
;mmbInput_driver.c,1115 :: 		PMMODEbits.WAITB = 0;
LBU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R0, 6, 2
SB	R2, Offset(PMMODEbits+0)(GP)
;mmbInput_driver.c,1116 :: 		PMMODEbits.WAITM = 1;
ORI	R3, R0, 1
LBU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R3, 2, 4
SB	R2, Offset(PMMODEbits+0)(GP)
;mmbInput_driver.c,1117 :: 		PMMODEbits.WAITE = 0;
LBU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R0, 0, 2
SB	R2, Offset(PMMODEbits+0)(GP)
;mmbInput_driver.c,1118 :: 		PMMODEbits.MODE16 = 1;   // 16 bit mode
LBU	R2, Offset(PMMODEbits+1)(GP)
ORI	R2, R2, 4
SB	R2, Offset(PMMODEbits+1)(GP)
;mmbInput_driver.c,1119 :: 		PMCONbits.CSF = 0;
LBU	R2, Offset(PMCONbits+0)(GP)
INS	R2, R0, 6, 2
SB	R2, Offset(PMCONbits+0)(GP)
;mmbInput_driver.c,1120 :: 		PMCONbits.PTRDEN = 1;
LBU	R2, Offset(PMCONbits+1)(GP)
ORI	R2, R2, 1
SB	R2, Offset(PMCONbits+1)(GP)
;mmbInput_driver.c,1121 :: 		PMCONbits.PTWREN = 1;
LBU	R2, Offset(PMCONbits+1)(GP)
ORI	R2, R2, 2
SB	R2, Offset(PMCONbits+1)(GP)
;mmbInput_driver.c,1122 :: 		PMCONbits.PMPEN = 1;
LBU	R2, Offset(PMCONbits+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(PMCONbits+1)(GP)
;mmbInput_driver.c,1123 :: 		TP_TFT_Rotate_180(0);
MOVZ	R25, R0, R0
JAL	_TP_TFT_Rotate_180+0
NOP	
;mmbInput_driver.c,1124 :: 		TFT_Set_Active(Set_Index,Write_Command,Write_Data);
LUI	R27, #hi_addr(_Write_Data+0)
ORI	R27, R27, #lo_addr(_Write_Data+0)
LUI	R26, #hi_addr(_Write_Command+0)
ORI	R26, R26, #lo_addr(_Write_Command+0)
LUI	R25, #hi_addr(_Set_Index+0)
ORI	R25, R25, #lo_addr(_Set_Index+0)
JAL	_TFT_Set_Active+0
NOP	
;mmbInput_driver.c,1125 :: 		}
L_end_Init_MCU:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _Init_MCU
_Init_Ext_Mem:
;mmbInput_driver.c,1127 :: 		void Init_Ext_Mem() {
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;mmbInput_driver.c,1129 :: 		SPI2_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, 64, _SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_HIGH, _SPI_ACTIVE_2_IDLE);
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
MOVZ	R28, R0, R0
ORI	R27, R0, 64
MOVZ	R26, R0, R0
ORI	R25, R0, 32
ADDIU	SP, SP, -8
SH	R0, 4(SP)
ORI	R2, R0, 64
SH	R2, 2(SP)
SH	R0, 0(SP)
JAL	_SPI2_Init_Advanced+0
NOP	
ADDIU	SP, SP, 8
;mmbInput_driver.c,1130 :: 		Delay_ms(10);
LUI	R24, 4
ORI	R24, R24, 4522
L_Init_Ext_Mem123:
ADDIU	R24, R24, -1
BNE	R24, R0, L_Init_Ext_Mem123
NOP	
;mmbInput_driver.c,1133 :: 		if (!Mmc_Fat_Init()) {
JAL	_Mmc_Fat_Init+0
NOP	
BEQ	R2, R0, L__Init_Ext_Mem280
NOP	
J	L_Init_Ext_Mem125
NOP	
L__Init_Ext_Mem280:
;mmbInput_driver.c,1135 :: 		SPI2_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, 4, _SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_HIGH, _SPI_ACTIVE_2_IDLE);
MOVZ	R28, R0, R0
ORI	R27, R0, 4
MOVZ	R26, R0, R0
ORI	R25, R0, 32
ADDIU	SP, SP, -8
SH	R0, 4(SP)
ORI	R2, R0, 64
SH	R2, 2(SP)
SH	R0, 0(SP)
JAL	_SPI2_Init_Advanced+0
NOP	
ADDIU	SP, SP, 8
;mmbInput_driver.c,1138 :: 		Mmc_Fat_Assign("mmbInput.RES", 0);
MOVZ	R26, R0, R0
LUI	R25, #hi_addr(?lstr1_mmbInput_driver+0)
ORI	R25, R25, #lo_addr(?lstr1_mmbInput_driver+0)
JAL	_Mmc_Fat_Assign+0
NOP	
;mmbInput_driver.c,1139 :: 		Mmc_Fat_Reset(&res_file_size);
LUI	R25, #hi_addr(_res_file_size+0)
ORI	R25, R25, #lo_addr(_res_file_size+0)
JAL	_Mmc_Fat_Reset+0
NOP	
;mmbInput_driver.c,1140 :: 		}
L_Init_Ext_Mem125:
;mmbInput_driver.c,1141 :: 		}
L_end_Init_Ext_Mem:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _Init_Ext_Mem
_Start_TP:
;mmbInput_driver.c,1143 :: 		void Start_TP() {
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;mmbInput_driver.c,1144 :: 		Init_MCU();
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
JAL	_Init_MCU+0
NOP	
;mmbInput_driver.c,1146 :: 		Init_Ext_Mem();
JAL	_Init_Ext_Mem+0
NOP	
;mmbInput_driver.c,1148 :: 		InitializeTouchPanel();
JAL	mmbInput_driver_InitializeTouchPanel+0
NOP	
;mmbInput_driver.c,1151 :: 		TP_TFT_Set_Calibration_Consts(76, 907, 77, 915);    // Set calibration constants
ORI	R28, R0, 915
ORI	R27, R0, 77
ORI	R26, R0, 907
ORI	R25, R0, 76
JAL	_TP_TFT_Set_Calibration_Consts+0
NOP	
;mmbInput_driver.c,1153 :: 		InitializeObjects();
JAL	mmbInput_driver_InitializeObjects+0
NOP	
;mmbInput_driver.c,1154 :: 		display_width = Screen1.Width;
LHU	R2, Offset(_Screen1+2)(GP)
SH	R2, Offset(_display_width+0)(GP)
;mmbInput_driver.c,1155 :: 		display_height = Screen1.Height;
LHU	R2, Offset(_Screen1+4)(GP)
SH	R2, Offset(_display_height+0)(GP)
;mmbInput_driver.c,1156 :: 		DrawScreen(&Screen1);
LUI	R25, #hi_addr(_Screen1+0)
ORI	R25, R25, #lo_addr(_Screen1+0)
JAL	_DrawScreen+0
NOP	
;mmbInput_driver.c,1157 :: 		}
L_end_Start_TP:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _Start_TP
mmbInput_driver____?ag:
L_end_mmbInput_driver___?ag:
JR	RA
NOP	
; end of mmbInput_driver____?ag
