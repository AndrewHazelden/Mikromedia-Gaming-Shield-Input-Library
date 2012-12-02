#line 1 "X:/Mikromedia Board/MMB Input Demo/Release V0.2 - Dec 1, 2012/Mikromedia Gaming Shield Input Libray/Development/dsPIC33 v1.05 boards/mmbInput_Code/mikroC PRO for dsPIC/mmbInput_main.c"
#line 1 "x:/mikromedia board/mmb input demo/release v0.2 - dec 1, 2012/mikromedia gaming shield input libray/development/dspic33 v1.05 boards/mmbinput_code/mikroc pro for dspic/mmbinput_objects.h"
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
 const far char *FontName;
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
 const far char *Picture_Name;
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
 const far char *FontName;
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
 TButton * const code far *Buttons;
 unsigned int ImagesCount;
 TImage * const code far *Images;
 unsigned int RadioButtonsCount;
 TRadioButton * const code far *RadioButtons;
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
extern TButton * const code far Screen1_Buttons[3];
extern TImage * const code far Screen1_Images[1];
extern TRadioButton * const code far Screen1_RadioButtons[13];





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
#line 34 "X:/Mikromedia Board/MMB Input Demo/Release V0.2 - Dec 1, 2012/Mikromedia Gaming Shield Input Libray/Development/dsPIC33 v1.05 boards/mmbInput_Code/mikroC PRO for dsPIC/mmbInput_main.c"
extern void InitGameShield();
extern void Check_GS();

extern long frame_counter;

void main() {

 Start_TP();
 InitGameShield();


 while (1) {
 Check_TP();
 Check_GS();

 frame_counter++;

 }

}
