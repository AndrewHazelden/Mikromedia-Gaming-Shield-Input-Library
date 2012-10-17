#line 1 "C:/Documents and Settings/PC/Desktop/Mikromedia Gaming Shield Input Libray/Development/PIC32/mmbInput_Code/mikroC PRO for PIC32/mmbInput_driver.c"
#line 1 "c:/documents and settings/pc/desktop/mikromedia gaming shield input libray/development/pic32/mmbinput_code/mikroc pro for pic32/mmbinput_objects.h"
typedef enum {_taLeft, _taCenter, _taRight} TTextAlign;

typedef struct Screen TScreen;

typedef struct Button {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 char Pen_Width;
 unsigned int Pen_Color;
 char Visible;
 char Active;
 char Transparent;
 char *Caption;
 TTextAlign TextAlign;
 const char *FontName;
 unsigned int Font_Color;
 char Gradient;
 char Gradient_Orientation;
 unsigned int Gradient_Start_Color;
 unsigned int Gradient_End_Color;
 unsigned int Color;
 char PressColEnabled;
 unsigned int Press_Color;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TButton;

typedef struct Image {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 const char *Picture_Name;
 char Visible;
 char Active;
 char Picture_Type;
 char Picture_Ratio;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TImage;

typedef struct RadioButton {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 char Pen_Width;
 unsigned int Pen_Color;
 char Visible;
 char Active;
 char Checked;
 char Transparent;
 char *Caption;
 TTextAlign TextAlign;
 const char *FontName;
 unsigned int Font_Color;
 char Gradient;
 char Gradient_Orientation;
 unsigned int Gradient_Start_Color;
 unsigned int Gradient_End_Color;
 unsigned int Color;
 unsigned int Background_Color;
 char PressColEnabled;
 unsigned int Press_Color;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TRadioButton;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned short ObjectsCount;
 unsigned int ButtonsCount;
 TButton * const code *Buttons;
 unsigned int ImagesCount;
 TImage * const code *Images;
 unsigned int RadioButtonsCount;
 TRadioButton * const code *RadioButtons;
};

extern TScreen Screen1;
extern TImage Image1;
extern TRadioButton Led1Button;
extern TRadioButton Led2Button;
extern TRadioButton Led3Button;
extern TRadioButton Led4Button;
extern TRadioButton left;
extern TRadioButton right;
extern TRadioButton up;
extern TRadioButton down;
extern TRadioButton square;
extern TRadioButton circle;
extern TRadioButton triangle;
extern TRadioButton x;
extern TRadioButton start;
extern TButton StatusLEDsText;
extern TButton ProgramCaption;
extern TButton MCU;
extern TButton * const code Screen1_Buttons[3];
extern TImage * const code Screen1_Images[1];
extern TRadioButton * const code Screen1_RadioButtons[13];





void Led1ButtonOnClick();
void Led2ButtonOnClick();
void Led3ButtonOnClick();
void Led4ButtonOnClick();




extern char Image1_Caption[];
extern char Led1Button_Caption[];
extern char Led2Button_Caption[];
extern char Led3Button_Caption[];
extern char Led4Button_Caption[];
extern char left_Caption[];
extern char right_Caption[];
extern char up_Caption[];
extern char down_Caption[];
extern char square_Caption[];
extern char circle_Caption[];
extern char triangle_Caption[];
extern char x_Caption[];
extern char start_Caption[];
extern char StatusLEDsText_Caption[];
extern char ProgramCaption_Caption[];
extern char MCU_Caption[];


void DrawScreen(TScreen *aScreen);
void DrawButton(TButton *aButton);
void DrawImage(TImage *AImage);
void DrawRadioButton(TRadioButton *ARadioButton);
void Check_TP();
void Start_TP();
#line 1 "c:/documents and settings/pc/desktop/mikromedia gaming shield input libray/development/pic32/mmbinput_code/mikroc pro for pic32/mmbinput_resources.h"
#line 1 "c:/program files/mikroelektronika/mikroc pro for pic32/include/built_in.h"
#line 7 "C:/Documents and Settings/PC/Desktop/Mikromedia Gaming Shield Input Libray/Development/PIC32/mmbInput_Code/mikroC PRO for PIC32/mmbInput_driver.c"
sbit Mmc_Chip_Select at LATG9_bit;
sbit Mmc_Chip_Select_Direction at TRISG9_bit;


unsigned long currentSector = -1, res_file_size;





char TFT_DataPort at LATE;
sbit TFT_RST at LATC1_bit;
sbit TFT_BLED at LATA9_bit;
sbit TFT_RS at LATB15_bit;
sbit TFT_CS at LATF12_bit;
sbit TFT_RD at LATD5_bit;
sbit TFT_WR at LATD4_bit;
char TFT_DataPort_Direction at TRISE;
sbit TFT_RST_Direction at TRISC1_bit;
sbit TFT_BLED_Direction at TRISA9_bit;
sbit TFT_RS_Direction at TRISB15_bit;
sbit TFT_CS_Direction at TRISF12_bit;
sbit TFT_RD_Direction at TRISD5_bit;
sbit TFT_WR_Direction at TRISD4_bit;



sbit DRIVEX_LEFT at LATB13_bit;
sbit DRIVEX_RIGHT at LATB11_bit;
sbit DRIVEY_UP at LATB12_bit;
sbit DRIVEY_DOWN at LATB10_bit;
sbit DRIVEX_LEFT_DIRECTION at TRISB13_bit;
sbit DRIVEX_RIGHT_DIRECTION at TRISB11_bit;
sbit DRIVEY_UP_DIRECTION at TRISB12_bit;
sbit DRIVEY_DOWN_DIRECTION at TRISB10_bit;



unsigned int Xcoord, Ycoord;
const ADC_THRESHOLD = 1000;
char PenDown;
void *PressedObject;
int PressedObjectType;
unsigned int caption_length, caption_height;
unsigned int display_width, display_height;

int _object_count;
unsigned short object_pressed;
TButton *local_button;
TButton *exec_button;
int button_order;
TImage *local_image;
TImage *exec_image;
int image_order;
TRadioButton *local_radio_button;
TRadioButton *exec_radio_button;
int radio_button_order;

void PMPWaitBusy() {
 while(PMMODEbits.BUSY);
}

void Set_Index(unsigned short index) {
 TFT_RS = 0;
 PMDIN = index;
 PMPWaitBusy();
}

void Write_Command( unsigned short cmd ) {
 TFT_RS = 1;
 PMDIN = cmd;
 PMPWaitBusy();
}

void Write_Data(unsigned int _data) {
 TFT_RS = 1;
 PMDIN = _data;
 PMPWaitBusy();
}


void Init_ADC() {
 AD1PCFG = 0xFFFF;
 PCFG12_bit = 0;
 PCFG13_bit = 0;

 ADC1_Init();
}

char* TFT_Get_Data(unsigned long offset, unsigned long count, unsigned long *num) {
unsigned long start_sector;
unsigned long pos;

 start_sector = Mmc_Get_File_Write_Sector() + offset/512;
 pos = (unsigned long)offset%512;

 if(start_sector == currentSector+1) {
 Mmc_Multi_Read_Sector(f16_sector.fSect);
 currentSector = start_sector;
 } else if (start_sector != currentSector) {
 if(currentSector != -1)
 Mmc_Multi_Read_Stop();
 Mmc_Multi_Read_Start(start_sector);
 Mmc_Multi_Read_Sector(f16_sector.fSect);
 currentSector = start_sector;
 }

 if(count>512-pos)
 *num = 512-pos;
 else
 *num = count;

 return f16_sector.fSect+pos;
}
static void InitializeTouchPanel() {
 Init_ADC();
 TFT_Set_Active(Set_Index, Write_Command, Write_Data);
 TFT_Init(320, 240);
 TFT_Set_Ext_Buffer(TFT_Get_Data);

 TP_TFT_Init(320, 240, 13, 12);
 TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);

 PenDown = 0;
 PressedObject = 0;
 PressedObjectType = -1;
}



 TScreen* CurrentScreen;

 TScreen Screen1;
 TImage Image1;
 TRadioButton Led1Button;
char Led1Button_Caption[1] = "";

 TRadioButton Led2Button;
char Led2Button_Caption[1] = "";

 TRadioButton Led3Button;
char Led3Button_Caption[1] = "";

 TRadioButton Led4Button;
char Led4Button_Caption[1] = "";

 TRadioButton left;
char left_Caption[5] = "Left";

 TRadioButton right;
char right_Caption[6] = "Right";

 TRadioButton up;
char up_Caption[3] = "Up";

 TRadioButton down;
char down_Caption[5] = "Down";

 TRadioButton square;
char square_Caption[4] = "Sqr";

 TRadioButton circle;
char circle_Caption[5] = "Circ";

 TRadioButton triangle;
char triangle_Caption[4] = "Tri";

 TRadioButton x;
char x_Caption[2] = "X";

 TRadioButton start;
char start_Caption[6] = "Start";

 TButton StatusLEDsText;
char StatusLEDsText_Caption[12] = "Status LEDs";

 TButton ProgramCaption;
char ProgramCaption_Caption[17] = "MMB  Input  Demo";

 TButton MCU;
char MCU_Caption[9] = "     ";

 TButton * const code Screen1_Buttons[3]=
 {
 &StatusLEDsText,
 &ProgramCaption,
 &MCU
 };
 TImage * const code Screen1_Images[1]=
 {
 &Image1
 };
 TRadioButton * const code Screen1_RadioButtons[13]=
 {
 &Led1Button,
 &Led2Button,
 &Led3Button,
 &Led4Button,
 &left,
 &right,
 &up,
 &down,
 &square,
 &circle,
 &triangle,
 &x,
 &start
 };




static void InitializeObjects() {
 Screen1.Color = 0x0000;
 Screen1.Width = 320;
 Screen1.Height = 240;
 Screen1.ButtonsCount = 3;
 Screen1.Buttons = Screen1_Buttons;
 Screen1.ImagesCount = 1;
 Screen1.Images = Screen1_Images;
 Screen1.RadioButtonsCount = 13;
 Screen1.RadioButtons = Screen1_RadioButtons;
 Screen1.ObjectsCount = 17;


 Image1.OwnerScreen = &Screen1;
 Image1.Order = 0;
 Image1.Left = 0;
 Image1.Top = 0;
 Image1.Width = 320;
 Image1.Height = 240;
 Image1.Picture_Type = 0;
 Image1.Picture_Ratio = 1;
 Image1.Picture_Name =  0x00002527 ;
 Image1.Visible = 1;
 Image1.Active = 1;
 Image1.OnUpPtr = 0;
 Image1.OnDownPtr = 0;
 Image1.OnClickPtr = 0;
 Image1.OnPressPtr = 0;

 Led1Button.OwnerScreen = &Screen1;
 Led1Button.Order = 1;
 Led1Button.Left = 72;
 Led1Button.Top = 63;
 Led1Button.Width = 32;
 Led1Button.Height = 32;
 Led1Button.Pen_Width = 1;
 Led1Button.Pen_Color = 0x0000;
 Led1Button.Visible = 1;
 Led1Button.Active = 1;
 Led1Button.Checked = 1;
 Led1Button.Transparent = 1;
 Led1Button.Caption = Led1Button_Caption;
 Led1Button.TextAlign = _taLeft;
 Led1Button.FontName =  0x00000071 ;
 Led1Button.PressColEnabled = 1;
 Led1Button.Font_Color = 0xFFFF;
 Led1Button.Gradient = 1;
 Led1Button.Gradient_Orientation = 1;
 Led1Button.Gradient_Start_Color = 0xF800;
 Led1Button.Gradient_End_Color = 0xA800;
 Led1Button.Color = 0xC618;
 Led1Button.Press_Color = 0xC618;
 Led1Button.Background_Color = 0x8410;
 Led1Button.OnUpPtr = 0;
 Led1Button.OnDownPtr = 0;
 Led1Button.OnClickPtr = Led1ButtonOnClick;
 Led1Button.OnPressPtr = 0;

 Led2Button.OwnerScreen = &Screen1;
 Led2Button.Order = 2;
 Led2Button.Left = 114;
 Led2Button.Top = 63;
 Led2Button.Width = 32;
 Led2Button.Height = 32;
 Led2Button.Pen_Width = 1;
 Led2Button.Pen_Color = 0x0000;
 Led2Button.Visible = 1;
 Led2Button.Active = 1;
 Led2Button.Checked = 1;
 Led2Button.Transparent = 1;
 Led2Button.Caption = Led2Button_Caption;
 Led2Button.TextAlign = _taLeft;
 Led2Button.FontName =  0x00000071 ;
 Led2Button.PressColEnabled = 1;
 Led2Button.Font_Color = 0xFFFF;
 Led2Button.Gradient = 1;
 Led2Button.Gradient_Orientation = 1;
 Led2Button.Gradient_Start_Color = 0xF800;
 Led2Button.Gradient_End_Color = 0xA800;
 Led2Button.Color = 0xC618;
 Led2Button.Press_Color = 0xC618;
 Led2Button.Background_Color = 0x8410;
 Led2Button.OnUpPtr = 0;
 Led2Button.OnDownPtr = 0;
 Led2Button.OnClickPtr = Led2ButtonOnClick;
 Led2Button.OnPressPtr = 0;

 Led3Button.OwnerScreen = &Screen1;
 Led3Button.Order = 3;
 Led3Button.Left = 156;
 Led3Button.Top = 63;
 Led3Button.Width = 32;
 Led3Button.Height = 32;
 Led3Button.Pen_Width = 1;
 Led3Button.Pen_Color = 0x0000;
 Led3Button.Visible = 1;
 Led3Button.Active = 1;
 Led3Button.Checked = 1;
 Led3Button.Transparent = 1;
 Led3Button.Caption = Led3Button_Caption;
 Led3Button.TextAlign = _taLeft;
 Led3Button.FontName =  0x00000071 ;
 Led3Button.PressColEnabled = 1;
 Led3Button.Font_Color = 0xFFFF;
 Led3Button.Gradient = 1;
 Led3Button.Gradient_Orientation = 1;
 Led3Button.Gradient_Start_Color = 0xF800;
 Led3Button.Gradient_End_Color = 0xA800;
 Led3Button.Color = 0xC618;
 Led3Button.Press_Color = 0xC618;
 Led3Button.Background_Color = 0x8410;
 Led3Button.OnUpPtr = 0;
 Led3Button.OnDownPtr = 0;
 Led3Button.OnClickPtr = Led3ButtonOnClick;
 Led3Button.OnPressPtr = 0;

 Led4Button.OwnerScreen = &Screen1;
 Led4Button.Order = 4;
 Led4Button.Left = 198;
 Led4Button.Top = 63;
 Led4Button.Width = 32;
 Led4Button.Height = 32;
 Led4Button.Pen_Width = 1;
 Led4Button.Pen_Color = 0x0000;
 Led4Button.Visible = 1;
 Led4Button.Active = 1;
 Led4Button.Checked = 1;
 Led4Button.Transparent = 1;
 Led4Button.Caption = Led4Button_Caption;
 Led4Button.TextAlign = _taLeft;
 Led4Button.FontName =  0x00000071 ;
 Led4Button.PressColEnabled = 1;
 Led4Button.Font_Color = 0xFFFF;
 Led4Button.Gradient = 1;
 Led4Button.Gradient_Orientation = 1;
 Led4Button.Gradient_Start_Color = 0xF800;
 Led4Button.Gradient_End_Color = 0xA800;
 Led4Button.Color = 0xC618;
 Led4Button.Press_Color = 0xC618;
 Led4Button.Background_Color = 0x8410;
 Led4Button.OnUpPtr = 0;
 Led4Button.OnDownPtr = 0;
 Led4Button.OnClickPtr = Led4ButtonOnClick;
 Led4Button.OnPressPtr = 0;

 left.OwnerScreen = &Screen1;
 left.Order = 5;
 left.Left = 23;
 left.Top = 141;
 left.Width = 68;
 left.Height = 32;
 left.Pen_Width = 1;
 left.Pen_Color = 0x0000;
 left.Visible = 1;
 left.Active = 1;
 left.Checked = 0;
 left.Transparent = 1;
 left.Caption = left_Caption;
 left.TextAlign = _taLeft;
 left.FontName =  0x00000071 ;
 left.PressColEnabled = 1;
 left.Font_Color = 0xFFFF;
 left.Gradient = 1;
 left.Gradient_Orientation = 0;
 left.Gradient_Start_Color = 0xFFFF;
 left.Gradient_End_Color = 0xC618;
 left.Color = 0xC618;
 left.Press_Color = 0xC618;
 left.Background_Color = 0x8410;
 left.OnUpPtr = 0;
 left.OnDownPtr = 0;
 left.OnClickPtr = 0;
 left.OnPressPtr = 0;

 right.OwnerScreen = &Screen1;
 right.Order = 6;
 right.Left = 91;
 right.Top = 141;
 right.Width = 76;
 right.Height = 32;
 right.Pen_Width = 1;
 right.Pen_Color = 0x0000;
 right.Visible = 1;
 right.Active = 1;
 right.Checked = 0;
 right.Transparent = 1;
 right.Caption = right_Caption;
 right.TextAlign = _taLeft;
 right.FontName =  0x00000071 ;
 right.PressColEnabled = 1;
 right.Font_Color = 0xFFFF;
 right.Gradient = 1;
 right.Gradient_Orientation = 0;
 right.Gradient_Start_Color = 0xFFFF;
 right.Gradient_End_Color = 0xC618;
 right.Color = 0xC618;
 right.Press_Color = 0xC618;
 right.Background_Color = 0x8410;
 right.OnUpPtr = 0;
 right.OnDownPtr = 0;
 right.OnClickPtr = 0;
 right.OnPressPtr = 0;

 up.OwnerScreen = &Screen1;
 up.Order = 7;
 up.Left = 58;
 up.Top = 109;
 up.Width = 52;
 up.Height = 32;
 up.Pen_Width = 1;
 up.Pen_Color = 0x0000;
 up.Visible = 1;
 up.Active = 1;
 up.Checked = 0;
 up.Transparent = 1;
 up.Caption = up_Caption;
 up.TextAlign = _taLeft;
 up.FontName =  0x00000071 ;
 up.PressColEnabled = 1;
 up.Font_Color = 0xFFFF;
 up.Gradient = 1;
 up.Gradient_Orientation = 0;
 up.Gradient_Start_Color = 0xFFFF;
 up.Gradient_End_Color = 0xC618;
 up.Color = 0xC618;
 up.Press_Color = 0xC618;
 up.Background_Color = 0x8410;
 up.OnUpPtr = 0;
 up.OnDownPtr = 0;
 up.OnClickPtr = 0;
 up.OnPressPtr = 0;

 down.OwnerScreen = &Screen1;
 down.Order = 8;
 down.Left = 58;
 down.Top = 173;
 down.Width = 68;
 down.Height = 32;
 down.Pen_Width = 1;
 down.Pen_Color = 0x0000;
 down.Visible = 1;
 down.Active = 1;
 down.Checked = 0;
 down.Transparent = 1;
 down.Caption = down_Caption;
 down.TextAlign = _taLeft;
 down.FontName =  0x00000071 ;
 down.PressColEnabled = 1;
 down.Font_Color = 0xFFFF;
 down.Gradient = 1;
 down.Gradient_Orientation = 0;
 down.Gradient_Start_Color = 0xFFFF;
 down.Gradient_End_Color = 0xC618;
 down.Color = 0xC618;
 down.Press_Color = 0xC618;
 down.Background_Color = 0x8410;
 down.OnUpPtr = 0;
 down.OnDownPtr = 0;
 down.OnClickPtr = 0;
 down.OnPressPtr = 0;

 square.OwnerScreen = &Screen1;
 square.Order = 9;
 square.Left = 184;
 square.Top = 140;
 square.Width = 60;
 square.Height = 32;
 square.Pen_Width = 1;
 square.Pen_Color = 0x0000;
 square.Visible = 1;
 square.Active = 1;
 square.Checked = 0;
 square.Transparent = 1;
 square.Caption = square_Caption;
 square.TextAlign = _taLeft;
 square.FontName =  0x00000071 ;
 square.PressColEnabled = 1;
 square.Font_Color = 0xFFFF;
 square.Gradient = 1;
 square.Gradient_Orientation = 0;
 square.Gradient_Start_Color = 0xFFFF;
 square.Gradient_End_Color = 0xC618;
 square.Color = 0xC618;
 square.Press_Color = 0xC618;
 square.Background_Color = 0x8410;
 square.OnUpPtr = 0;
 square.OnDownPtr = 0;
 square.OnClickPtr = 0;
 square.OnPressPtr = 0;

 circle.OwnerScreen = &Screen1;
 circle.Order = 10;
 circle.Left = 252;
 circle.Top = 140;
 circle.Width = 68;
 circle.Height = 32;
 circle.Pen_Width = 1;
 circle.Pen_Color = 0x0000;
 circle.Visible = 1;
 circle.Active = 1;
 circle.Checked = 0;
 circle.Transparent = 1;
 circle.Caption = circle_Caption;
 circle.TextAlign = _taLeft;
 circle.FontName =  0x00000071 ;
 circle.PressColEnabled = 1;
 circle.Font_Color = 0xFFFF;
 circle.Gradient = 1;
 circle.Gradient_Orientation = 0;
 circle.Gradient_Start_Color = 0xFFFF;
 circle.Gradient_End_Color = 0xC618;
 circle.Color = 0xC618;
 circle.Press_Color = 0xC618;
 circle.Background_Color = 0x8410;
 circle.OnUpPtr = 0;
 circle.OnDownPtr = 0;
 circle.OnClickPtr = 0;
 circle.OnPressPtr = 0;

 triangle.OwnerScreen = &Screen1;
 triangle.Order = 11;
 triangle.Left = 219;
 triangle.Top = 108;
 triangle.Width = 60;
 triangle.Height = 32;
 triangle.Pen_Width = 1;
 triangle.Pen_Color = 0x0000;
 triangle.Visible = 1;
 triangle.Active = 1;
 triangle.Checked = 0;
 triangle.Transparent = 1;
 triangle.Caption = triangle_Caption;
 triangle.TextAlign = _taLeft;
 triangle.FontName =  0x00000071 ;
 triangle.PressColEnabled = 1;
 triangle.Font_Color = 0xFFFF;
 triangle.Gradient = 1;
 triangle.Gradient_Orientation = 0;
 triangle.Gradient_Start_Color = 0xFFFF;
 triangle.Gradient_End_Color = 0xC618;
 triangle.Color = 0xC618;
 triangle.Press_Color = 0xC618;
 triangle.Background_Color = 0x8410;
 triangle.OnUpPtr = 0;
 triangle.OnDownPtr = 0;
 triangle.OnClickPtr = 0;
 triangle.OnPressPtr = 0;

 x.OwnerScreen = &Screen1;
 x.Order = 12;
 x.Left = 219;
 x.Top = 172;
 x.Width = 44;
 x.Height = 32;
 x.Pen_Width = 1;
 x.Pen_Color = 0x0000;
 x.Visible = 1;
 x.Active = 1;
 x.Checked = 0;
 x.Transparent = 1;
 x.Caption = x_Caption;
 x.TextAlign = _taLeft;
 x.FontName =  0x00000071 ;
 x.PressColEnabled = 1;
 x.Font_Color = 0xFFFF;
 x.Gradient = 1;
 x.Gradient_Orientation = 0;
 x.Gradient_Start_Color = 0xFFFF;
 x.Gradient_End_Color = 0xC618;
 x.Color = 0xC618;
 x.Press_Color = 0xC618;
 x.Background_Color = 0x8410;
 x.OnUpPtr = 0;
 x.OnDownPtr = 0;
 x.OnClickPtr = 0;
 x.OnPressPtr = 0;

 start.OwnerScreen = &Screen1;
 start.Order = 13;
 start.Left = 136;
 start.Top = 204;
 start.Width = 76;
 start.Height = 32;
 start.Pen_Width = 1;
 start.Pen_Color = 0x0000;
 start.Visible = 1;
 start.Active = 1;
 start.Checked = 0;
 start.Transparent = 1;
 start.Caption = start_Caption;
 start.TextAlign = _taLeft;
 start.FontName =  0x00000071 ;
 start.PressColEnabled = 1;
 start.Font_Color = 0xFFFF;
 start.Gradient = 1;
 start.Gradient_Orientation = 0;
 start.Gradient_Start_Color = 0xFFFF;
 start.Gradient_End_Color = 0xC618;
 start.Color = 0xC618;
 start.Press_Color = 0xC618;
 start.Background_Color = 0x8410;
 start.OnUpPtr = 0;
 start.OnDownPtr = 0;
 start.OnClickPtr = 0;
 start.OnPressPtr = 0;

 StatusLEDsText.OwnerScreen = &Screen1;
 StatusLEDsText.Order = 14;
 StatusLEDsText.Left = 104;
 StatusLEDsText.Top = 44;
 StatusLEDsText.Width = 93;
 StatusLEDsText.Height = 19;
 StatusLEDsText.Pen_Width = 0;
 StatusLEDsText.Pen_Color = 0xFFFF;
 StatusLEDsText.Visible = 1;
 StatusLEDsText.Active = 1;
 StatusLEDsText.Transparent = 0;
 StatusLEDsText.Caption = StatusLEDsText_Caption;
 StatusLEDsText.TextAlign = _taCenter;
 StatusLEDsText.FontName =  0x00000071 ;
 StatusLEDsText.PressColEnabled = 1;
 StatusLEDsText.Font_Color = 0xFFFF;
 StatusLEDsText.Gradient = 0;
 StatusLEDsText.Gradient_Orientation = 0;
 StatusLEDsText.Gradient_Start_Color = 0xFFFF;
 StatusLEDsText.Gradient_End_Color = 0xC618;
 StatusLEDsText.Color = 0xC618;
 StatusLEDsText.Press_Color = 0xC618;
 StatusLEDsText.OnUpPtr = 0;
 StatusLEDsText.OnDownPtr = 0;
 StatusLEDsText.OnClickPtr = 0;
 StatusLEDsText.OnPressPtr = 0;

 ProgramCaption.OwnerScreen = &Screen1;
 ProgramCaption.Order = 15;
 ProgramCaption.Left = 13;
 ProgramCaption.Top = 1;
 ProgramCaption.Width = 292;
 ProgramCaption.Height = 47;
 ProgramCaption.Pen_Width = 0;
 ProgramCaption.Pen_Color = 0xFFFF;
 ProgramCaption.Visible = 1;
 ProgramCaption.Active = 1;
 ProgramCaption.Transparent = 0;
 ProgramCaption.Caption = ProgramCaption_Caption;
 ProgramCaption.TextAlign = _taCenter;
 ProgramCaption.FontName =  0x00000799 ;
 ProgramCaption.PressColEnabled = 1;
 ProgramCaption.Font_Color = 0xF800;
 ProgramCaption.Gradient = 0;
 ProgramCaption.Gradient_Orientation = 0;
 ProgramCaption.Gradient_Start_Color = 0xFFFF;
 ProgramCaption.Gradient_End_Color = 0xC618;
 ProgramCaption.Color = 0xC618;
 ProgramCaption.Press_Color = 0xC618;
 ProgramCaption.OnUpPtr = 0;
 ProgramCaption.OnDownPtr = 0;
 ProgramCaption.OnClickPtr = 0;
 ProgramCaption.OnPressPtr = 0;

 MCU.OwnerScreen = &Screen1;
 MCU.Order = 16;
 MCU.Left = 216;
 MCU.Top = 202;
 MCU.Width = 104;
 MCU.Height = 39;
 MCU.Pen_Width = 0;
 MCU.Pen_Color = 0xFFFF;
 MCU.Visible = 1;
 MCU.Active = 1;
 MCU.Transparent = 0;
 MCU.Caption = MCU_Caption;
 MCU.TextAlign = _taRight;
 MCU.FontName =  0x00000799 ;
 MCU.PressColEnabled = 1;
 MCU.Font_Color = 0xF800;
 MCU.Gradient = 0;
 MCU.Gradient_Orientation = 0;
 MCU.Gradient_Start_Color = 0xFFFF;
 MCU.Gradient_End_Color = 0xC618;
 MCU.Color = 0xC618;
 MCU.Press_Color = 0xC618;
 MCU.OnUpPtr = 0;
 MCU.OnDownPtr = 0;
 MCU.OnClickPtr = 0;
 MCU.OnPressPtr = 0;
}

static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) {
 if ( (Left<= X) && (Left+ Width - 1 >= X) &&
 (Top <= Y) && (Top + Height - 1 >= Y) )
 return 1;
 else
 return 0;
}






 void DeleteTrailingSpaces(char* str){
 char i;
 i = 0;
 while(1) {
 if(str[0] == ' ') {
 for(i = 0; i < strlen(str); i++) {
 str[i] = str[i+1];
 }
 }
 else
 break;
 }
 }

void DrawButton(TButton *Abutton) {
 if (Abutton->Visible == 1) {
 if (object_pressed == 1) {
 object_pressed = 0;
 TFT_Set_Brush(Abutton->Transparent, Abutton->Press_Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_End_Color, Abutton->Gradient_Start_Color);
 }
 else {
 TFT_Set_Brush(Abutton->Transparent, Abutton->Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_Start_Color, Abutton->Gradient_End_Color);
 }
 TFT_Set_Pen(Abutton->Pen_Color, Abutton->Pen_Width);
 TFT_Rectangle(Abutton->Left, Abutton->Top, Abutton->Left + Abutton->Width - 1, Abutton->Top + Abutton->Height - 1);
 TFT_Set_Ext_Font(Abutton->FontName, Abutton->Font_Color, FO_HORIZONTAL);
 TFT_Write_Text_Return_Pos(Abutton->Caption, Abutton->Left, Abutton->Top);
 if (AButton->TextAlign == _taLeft)
 TFT_Write_Text(Abutton->Caption, Abutton->Left + 4, (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
 else if (AButton->TextAlign == _taCenter)
 TFT_Write_Text(Abutton->Caption, (Abutton->Left + (Abutton->Width - caption_length) / 2), (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
 else if (AButton->TextAlign == _taRight)
 TFT_Write_Text(Abutton->Caption, Abutton->Left + (Abutton->Width - caption_length - 4), (Abutton->Top + (Abutton->Height - caption_height) / 2));
 }
}

void DrawImage(TImage *AImage) {
 if (AImage->Visible) {
 TFT_Ext_Image(AImage->Left, AImage->Top, AImage->Picture_Name, AImage->Picture_Ratio);
 }
}

void DrawRadioButton(TRadioButton *ARadioButton) {
 int circleOffset = 0;
 if (ARadioButton->Visible == 1) {
 circleOffset = ARadioButton->Height / 5;
 TFT_Set_Pen(ARadioButton->Pen_Color, ARadioButton->Pen_Width);
 if (ARadioButton->TextAlign == _taLeft) {
 TFT_Set_Brush(ARadioButton->Transparent,ARadioButton->Background_Color,0,0,0,0);
 TFT_Circle(ARadioButton->Left + ARadioButton->Height / 2, ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2);
 if (ARadioButton->Checked == 1) {
 if (object_pressed == 1) {
 object_pressed = 0;
 TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Press_Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_End_Color, ARadioButton->Gradient_Start_Color);
 }
 else
 TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_Start_Color, ARadioButton->Gradient_End_Color);
 TFT_Circle(ARadioButton->Left + ARadioButton->Height / 2 , ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2 - circleOffset);
 }
 TFT_Set_Ext_Font(ARadioButton->FontName, ARadioButton->Font_Color, FO_HORIZONTAL);
 TFT_Write_Text_Return_Pos(ARadioButton->Caption, ARadioButton->Left + ARadioButton->Height + 4, ARadioButton->Top);
 TFT_Write_Text(ARadioButton->Caption, ARadioButton->Left + ARadioButton->Height + 4, (ARadioButton->Top + ((ARadioButton->Height - caption_height) / 2)));
 }
 else if (ARadioButton->TextAlign == _taRight) {
 TFT_Set_Brush(ARadioButton->Transparent,ARadioButton->Background_Color,0,0,0,0);
 TFT_Circle(ARadioButton->Left + ARadioButton->Width - ARadioButton->Height / 2, ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2);
 if (ARadioButton->Checked == 1) {
 if (object_pressed == 1) {
 object_pressed = 0;
 TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Press_Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_End_Color, ARadioButton->Gradient_Start_Color);
 }
 else
 TFT_Set_Brush(ARadioButton->Transparent, ARadioButton->Color, ARadioButton->Gradient, ARadioButton->Gradient_Orientation, ARadioButton->Gradient_Start_Color, ARadioButton->Gradient_End_Color);
 TFT_Circle(ARadioButton->Left + ARadioButton->Width - ARadioButton->Height / 2, ARadioButton->Top + ARadioButton->Height / 2, ARadioButton->Height / 2 - circleOffset);
 }
 TFT_Set_Ext_Font(ARadioButton->FontName, ARadioButton->Font_Color, FO_HORIZONTAL);
 TFT_Write_Text_Return_Pos(ARadioButton->Caption, ARadioButton->Left + 3, ARadioButton->Top);
 TFT_Write_Text(ARadioButton->Caption, ARadioButton->Left + 3, ARadioButton->Top + (ARadioButton->Height - caption_height) / 2);
 }
 }
}

void DrawScreen(TScreen *aScreen) {
 int order;
 unsigned short button_idx;
 TButton *local_button;
 unsigned short image_idx;
 TImage *local_image;
 unsigned short radio_button_idx;
 TRadioButton *local_radio_button;
 char save_bled, save_bled_direction;

 object_pressed = 0;
 order = 0;
 button_idx = 0;
 image_idx = 0;
 radio_button_idx = 0;
 CurrentScreen = aScreen;

 if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
 save_bled = TFT_BLED;
 save_bled_direction = TFT_BLED_Direction;
 TFT_BLED_Direction = 0;
 TFT_BLED = 0;
 TFT_Set_Active(Set_Index, Write_Command, Write_Data);
 TFT_Init(CurrentScreen->Width, CurrentScreen->Height);
 TFT_Set_Ext_Buffer(TFT_Get_Data);
 TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 13, 12);
 TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);
 TFT_Fill_Screen(CurrentScreen->Color);
 display_width = CurrentScreen->Width;
 display_height = CurrentScreen->Height;
 TFT_BLED = save_bled;
 TFT_BLED_Direction = save_bled_direction;
 }
 else
 TFT_Fill_Screen(CurrentScreen->Color);


 while (order < CurrentScreen->ObjectsCount) {
 if (button_idx < CurrentScreen->ButtonsCount) {
 local_button =  CurrentScreen->Buttons[button_idx] ;
 if (order == local_button->Order) {
 button_idx++;
 order++;
 DrawButton(local_button);
 }
 }

 if (image_idx < CurrentScreen->ImagesCount) {
 local_image =  CurrentScreen->Images[image_idx] ;
 if (order == local_image->Order) {
 image_idx++;
 order++;
 DrawImage(local_image);
 }
 }

 if (radio_button_idx < CurrentScreen->RadioButtonsCount) {
 local_radio_button =  CurrentScreen->RadioButtons[radio_button_idx] ;
 if (order == local_radio_button->Order) {
 radio_button_idx++;
 order++;
 DrawRadioButton(local_radio_button);
 }
 }

 }
}

void Get_Object(unsigned int X, unsigned int Y) {
 button_order = -1;
 image_order = -1;
 radio_button_order = -1;

 for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
 local_button =  CurrentScreen->Buttons[_object_count] ;
 if (local_button->Active == 1) {
 if (IsInsideObject(X, Y, local_button->Left, local_button->Top,
 local_button->Width, local_button->Height) == 1) {
 button_order = local_button->Order;
 exec_button = local_button;
 }
 }
 }


 for ( _object_count = 0 ; _object_count < CurrentScreen->ImagesCount ; _object_count++ ) {
 local_image =  CurrentScreen->Images[_object_count] ;
 if (local_image->Active == 1) {
 if (IsInsideObject(X, Y, local_image->Left, local_image->Top,
 local_image->Width, local_image->Height) == 1) {
 image_order = local_image->Order;
 exec_image = local_image;
 }
 }
 }


 for ( _object_count = 0 ; _object_count < CurrentScreen->RadioButtonsCount ; _object_count++ ) {
 local_radio_button =  CurrentScreen->RadioButtons[_object_count] ;
 if (local_radio_button->Active == 1) {
 if (IsInsideObject(X, Y, local_radio_button->Left, local_radio_button->Top,
 local_radio_button->Width, local_radio_button->Height) == 1) {
 radio_button_order = local_radio_button->Order;
 exec_radio_button = local_radio_button;
 }
 }
 }

 _object_count = -1;
 if (button_order > _object_count)
 _object_count = button_order;
 if (image_order > _object_count )
 _object_count = image_order;
 if (radio_button_order > _object_count )
 _object_count = radio_button_order;
}


static void Process_TP_Press(unsigned int X, unsigned int Y) {
 exec_button = 0;
 exec_image = 0;
 exec_radio_button = 0;

 Get_Object(X, Y);


 if (_object_count != -1) {
 if (_object_count == button_order) {
 if (exec_button->Active == 1) {
 if (exec_button->OnPressPtr != 0) {
 exec_button->OnPressPtr();
 return;
 }
 }
 }

 if (_object_count == image_order) {
 if (exec_image->Active == 1) {
 if (exec_image->OnPressPtr != 0) {
 exec_image->OnPressPtr();
 return;
 }
 }
 }

 if (_object_count == radio_button_order) {
 if (exec_radio_button->Active == 1) {
 if (exec_radio_button->OnPressPtr != 0) {
 exec_radio_button->OnPressPtr();
 return;
 }
 }
 }

 }
}

static void Process_TP_Up(unsigned int X, unsigned int Y) {

 switch (PressedObjectType) {

 case 0: {
 if (PressedObject != 0) {
 exec_button = (TButton*)PressedObject;
 if ((exec_button->PressColEnabled == 1) && (exec_button->OwnerScreen == CurrentScreen)) {
 DrawButton(exec_button);
 }
 break;
 }
 break;
 }

 case 17: {
 if (PressedObject != 0) {
 exec_radio_button = (TRadioButton*)PressedObject;
 if ((exec_radio_button->PressColEnabled == 1) && (exec_radio_button->OwnerScreen == CurrentScreen)) {
 DrawRadioButton(exec_radio_button);
 }
 break;
 }
 break;
 }
 }

 exec_image = 0;

 Get_Object(X, Y);


 if (_object_count != -1) {

 if (_object_count == button_order) {
 if (exec_button->Active == 1) {
 if (exec_button->OnUpPtr != 0)
 exec_button->OnUpPtr();
 if (PressedObject == (void *)exec_button)
 if (exec_button->OnClickPtr != 0)
 exec_button->OnClickPtr();
 PressedObject = 0;
 PressedObjectType = -1;
 return;
 }
 }


 if (_object_count == image_order) {
 if (exec_image->Active == 1) {
 if (exec_image->OnUpPtr != 0)
 exec_image->OnUpPtr();
 if (PressedObject == (void *)exec_image)
 if (exec_image->OnClickPtr != 0)
 exec_image->OnClickPtr();
 PressedObject = 0;
 PressedObjectType = -1;
 return;
 }
 }


 if (_object_count == radio_button_order) {
 if (exec_radio_button->Active == 1) {
 if (exec_radio_button->OnUpPtr != 0)
 exec_radio_button->OnUpPtr();
 if (PressedObject == (void *)exec_radio_button)
 if (exec_radio_button->OnClickPtr != 0)
 exec_radio_button->OnClickPtr();
 PressedObject = 0;
 PressedObjectType = -1;
 return;
 }
 }

 }
 PressedObject = 0;
 PressedObjectType = -1;
}

static void Process_TP_Down(unsigned int X, unsigned int Y) {

 object_pressed = 0;
 exec_button = 0;
 exec_image = 0;
 exec_radio_button = 0;

 Get_Object(X, Y);

 if (_object_count != -1) {
 if (_object_count == button_order) {
 if (exec_button->Active == 1) {
 if (exec_button->PressColEnabled == 1) {
 object_pressed = 1;
 DrawButton(exec_button);
 }
 PressedObject = (void *)exec_button;
 PressedObjectType = 0;
 if (exec_button->OnDownPtr != 0) {
 exec_button->OnDownPtr();
 return;
 }
 }
 }

 if (_object_count == image_order) {
 if (exec_image->Active == 1) {
 PressedObject = (void *)exec_image;
 PressedObjectType = 3;
 if (exec_image->OnDownPtr != 0) {
 exec_image->OnDownPtr();
 return;
 }
 }
 }

 if (_object_count == radio_button_order) {
 if (exec_radio_button->Active == 1) {
 if (exec_radio_button->PressColEnabled == 1) {
 object_pressed = 1;
 DrawRadioButton(exec_radio_button);
 }
 PressedObject = (void *)exec_radio_button;
 PressedObjectType = 17;
 if (exec_radio_button->OnDownPtr != 0) {
 exec_radio_button->OnDownPtr();
 return;
 }
 }
 }

 }
}

void Check_TP() {
 if (TP_TFT_Press_Detect()) {

 if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
 Process_TP_Press(Xcoord, Ycoord);
 if (PenDown == 0) {
 PenDown = 1;
 Process_TP_Down(Xcoord, Ycoord);
 }
 }
 }
 else if (PenDown == 1) {
 PenDown = 0;
 Process_TP_Up(Xcoord, Ycoord);
 }
}

void Init_MCU() {
 PMMODE = 0;
 PMAEN = 0;
 PMCON = 0;
 PMMODEbits.MODE = 2;
 PMMODEbits.WAITB = 0;
 PMMODEbits.WAITM = 1;
 PMMODEbits.WAITE = 0;
 PMMODEbits.MODE16 = 1;
 PMCONbits.CSF = 0;
 PMCONbits.PTRDEN = 1;
 PMCONbits.PTWREN = 1;
 PMCONbits.PMPEN = 1;
 TP_TFT_Rotate_180(0);
 TFT_Set_Active(Set_Index,Write_Command,Write_Data);
}

void Init_Ext_Mem() {

 SPI2_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, 64, _SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_HIGH, _SPI_ACTIVE_2_IDLE);
 Delay_ms(10);


 if (!Mmc_Fat_Init()) {

 SPI2_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, 4, _SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_HIGH, _SPI_ACTIVE_2_IDLE);


 Mmc_Fat_Assign("mmbInput.RES", 0);
 Mmc_Fat_Reset(&res_file_size);
 }
}

void Start_TP() {
 Init_MCU();

 Init_Ext_Mem();

 InitializeTouchPanel();


 TP_TFT_Set_Calibration_Consts(76, 907, 77, 915);

 InitializeObjects();
 display_width = Screen1.Width;
 display_height = Screen1.Height;
 DrawScreen(&Screen1);
}
