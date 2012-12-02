#line 1 "X:/Mikromedia Board/MMB Input Demo/Release V0.2 - Dec 1, 2012/Mikromedia Gaming Shield Input Libray/Development/PIC32/mmbInput_Code/mikroC PRO for PIC32/mmbInput_events_code.c"
#line 1 "x:/mikromedia board/mmb input demo/release v0.2 - dec 1, 2012/mikromedia gaming shield input libray/development/pic32/mmbinput_code/mikroc pro for pic32/mmbinput_objects.h"
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
#line 1 "x:/mikromedia board/mmb input demo/release v0.2 - dec 1, 2012/mikromedia gaming shield input libray/development/pic32/mmbinput_code/mikroc pro for pic32/mmbinput_resources.h"
#line 1 "x:/mikromedia board/mmb input demo/release v0.2 - dec 1, 2012/mikromedia gaming shield input libray/development/pic32/mmbinput_code/mikroc pro for pic32/gaming-shield.h"
#line 189 "x:/mikromedia board/mmb input demo/release v0.2 - dec 1, 2012/mikromedia gaming shield input libray/development/pic32/mmbinput_code/mikroc pro for pic32/gaming-shield.h"
sbit upButton at PORTA.B6;
sbit downButton at PORTA.B7;
sbit rightButton at PORTD.B10;
sbit leftButton at PORTA.B5;
sbit triangleButton at PORTD.B14;
sbit xButton at PORTD.B15;
sbit circleButton at PORTF.B4;
sbit squareButton at PORTD.B11;
sbit startButton at PORTF.B5;


sbit upButtonDirection at TRISA.B6;
sbit downButtonDirection at TRISA.B7;
sbit rightButtonDirection at TRISD.B10;
sbit leftButtonDirection at TRISA.B5;
sbit triangleButtonDirection at TRISD.B14;
sbit xButtonDirection at TRISD.B15;
sbit circleButtonDirection at TRISF.B4;
sbit squareButtonDirection at TRISD.B11;
sbit startButtonDirection at TRISF.B5;



bit upButtonOld;
bit downButtonOld;
bit rightButtonOld;
bit leftButtonOld;
bit triangleButtonOld;
bit xButtonOld;
bit circleButtonOld;
bit squareButtonOld;
bit startButtonOld;


sbit LED1 at LATE.B8;
sbit LED2 at LATE.B9;
sbit LED3 at LATA.B14;
sbit LED4 at LATA.B15;

sbit LED1_Direction at TRISE.B8;
sbit LED2_Direction at TRISE.B9;
sbit LED3_Direction at TRISA.B14;
sbit LED4_Direction at TRISA.B15;
#line 246 "x:/mikromedia board/mmb input demo/release v0.2 - dec 1, 2012/mikromedia gaming shield input libray/development/pic32/mmbinput_code/mikroc pro for pic32/gaming-shield.h"
void InitGameShield(){





 upButtonDirection = 1;
 downButtonDirection = 1;
 rightButtonDirection = 1;
 leftButtonDirection = 1;
 triangleButtonDirection = 1;
 xButtonDirection = 1;
 circleButtonDirection = 1;
 squareButtonDirection = 1;
 startButtonDirection = 1;




 LED1_Direction = 0;
 LED2_Direction = 0;
 LED3_Direction = 0;
 LED4_Direction = 0;

 Delay_ms(100);

 LED1 = 0;
 LED2 = 0;
 LED3 = 0;
 LED4 = 0;
}
#line 8 "X:/Mikromedia Board/MMB Input Demo/Release V0.2 - Dec 1, 2012/Mikromedia Gaming Shield Input Libray/Development/PIC32/mmbInput_Code/mikroC PRO for PIC32/mmbInput_events_code.c"
void Check_GS();
void UpdateStatusLEDButtons();

long int frame_counter = 0;



void Check_GS(){



 if(frame_counter==0){

 LED1 = 0;
 LED2 = 0;
 LED3 = 0;
 LED4 = 0;
#line 35 "X:/Mikromedia Board/MMB Input Demo/Release V0.2 - Dec 1, 2012/Mikromedia Gaming Shield Input Libray/Development/PIC32/mmbInput_Code/mikroC PRO for PIC32/mmbInput_events_code.c"
 strcpy(MCU_Caption, "PIC32");
 DrawButton(&MCU);


 UpdateStatusLEDButtons();

 }


 if(leftButton)
 {
 left.Checked = 1;
 }
 else
 {
 left.Checked = 0;
 }


 if(rightButton)
 {
 right.Checked = 1;
 }
 else
 {
 right.Checked = 0;
 }


 if(upButton)
 {
 up.Checked = 1;
 }
 else
 {
 up.Checked = 0;
 }


 if(downButton)
 {
 down.Checked = 1;
 }
 else
 {
 down.Checked = 0;
 }


 if(squareButton)
 {
 square.Checked = 1;
 }
 else
 {
 square.Checked = 0;
 }

 if(circleButton)
 {
 circle.Checked = 1;
 }
 else
 {
 circle.Checked = 0;
 }



 if(triangleButton)
 {
 triangle.Checked = 1;
 }
 else
 {
 triangle.Checked = 0;
 }



 if(xButton)
 {
 x.Checked = 1;

 }
 else
 {
 x.Checked = 0;
 }


 if(startButton)
 {
 start.Checked = 1;

 }
 else
 {
 start.Checked = 0;
 }





 if( upButtonOld != upButton){
 DrawRadioButton(&up);
 }

 if( downButtonOld != downButton){
 DrawRadioButton(&down);
 }

 if( rightButtonOld != rightButton){
 DrawRadioButton(&right);
 }

 if( leftButtonOld != leftButton){
 DrawRadioButton(&left);
 }

 if( triangleButtonOld != triangleButton){
 DrawRadioButton(&triangle);
 }

 if( xButtonOld != xButton){
 DrawRadioButton(&x);
 }

 if( circleButtonOld != circleButton){
 DrawRadioButton(&circle);
 }

 if( squareButtonOld != squareButton){
 DrawRadioButton(&square);
 }

 if( startButtonOld != startButton){
 DrawRadioButton(&start);
 }




 upButtonOld = upButton;
 downButtonOld = downButton;
 rightButtonOld = rightButton;
 leftButtonOld = leftButton;

 triangleButtonOld = triangleButton;
 xButtonOld = xButton;
 circleButtonOld = circleButton;
 squareButtonOld = squareButton;

 startButtonOld = startButton;


}



void UpdateStatusLEDButtons(){

 Led1Button.Checked = !LED1;
 DrawRadioButton(&Led1Button);

 Led2Button.Checked = !LED2;
 DrawRadioButton(&Led2Button);

 Led3Button.Checked = !LED3;
 DrawRadioButton(&Led3Button);

 Led4Button.Checked = !LED4;
 DrawRadioButton(&Led4Button);

}







void Led1ButtonOnClick() {
 LED1 = ~LED1;
 UpdateStatusLEDButtons();
}

void Led2ButtonOnClick() {
 LED2 = ~LED2;
 UpdateStatusLEDButtons();
}

void Led3ButtonOnClick() {
 LED3 = ~LED3;
 UpdateStatusLEDButtons();
}

void Led4ButtonOnClick() {
 LED4 = ~LED4;
 UpdateStatusLEDButtons();
}
