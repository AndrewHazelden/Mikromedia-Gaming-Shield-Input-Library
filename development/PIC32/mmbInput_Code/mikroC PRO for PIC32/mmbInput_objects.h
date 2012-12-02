typedef enum {_taLeft, _taCenter, _taRight} TTextAlign;

typedef struct Screen TScreen;

typedef struct  Button {
  TScreen*  OwnerScreen;
  char          Order;
  unsigned int  Left;
  unsigned int  Top;
  unsigned int  Width;
  unsigned int  Height;
  char          Pen_Width;
  unsigned int  Pen_Color;
  char          Visible;
  char          Active;
  char          Transparent;
  char          *Caption;
  TTextAlign    TextAlign;
  const char    *FontName;
  unsigned int  Font_Color;
  char          Gradient;
  char          Gradient_Orientation;
  unsigned int  Gradient_Start_Color;
  unsigned int  Gradient_End_Color;
  unsigned int  Color;
  char          PressColEnabled;
  unsigned int  Press_Color;
  void          (*OnUpPtr)();
  void          (*OnDownPtr)();
  void          (*OnClickPtr)();
  void          (*OnPressPtr)();
} TButton;

typedef struct  Image {
  TScreen*  OwnerScreen;
  char          Order;
  unsigned int  Left;
  unsigned int  Top;
  unsigned int  Width;
  unsigned int  Height;
  const char    *Picture_Name;
  char          Visible;
  char          Active;
  char          Picture_Type;
  char          Picture_Ratio;
  void          (*OnUpPtr)();
  void          (*OnDownPtr)();
  void          (*OnClickPtr)();
  void          (*OnPressPtr)();
} TImage;

typedef struct RadioButton {
  TScreen*  OwnerScreen;
  char          Order;
  unsigned int  Left;
  unsigned int  Top;
  unsigned int  Width;
  unsigned int  Height;
  char          Pen_Width;
  unsigned int  Pen_Color;
  char          Visible;
  char          Active;
  char          Checked;
  char          Transparent;
  char          *Caption;
  TTextAlign    TextAlign;
  const char    *FontName;
  unsigned int  Font_Color;
  char          Gradient;
  char          Gradient_Orientation;
  unsigned int  Gradient_Start_Color;
  unsigned int  Gradient_End_Color;
  unsigned int  Color;
  unsigned int  Background_Color;
  char          PressColEnabled;
  unsigned int  Press_Color;
  void          (*OnUpPtr)();
  void          (*OnDownPtr)();
  void          (*OnClickPtr)();
  void          (*OnPressPtr)();
} TRadioButton;

struct Screen {
  unsigned int           Color;
  unsigned int           Width;
  unsigned int           Height;
  unsigned short         ObjectsCount;
  unsigned int           ButtonsCount;
  TButton                * const code *Buttons;
  unsigned int           ImagesCount;
  TImage                 * const code *Images;
  unsigned int           RadioButtonsCount;
  TRadioButton              * const code *RadioButtons;
};

extern   TScreen                Screen1;
extern   TImage               Image1;
extern   TRadioButton                 Led1Button;
extern   TRadioButton                 Led2Button;
extern   TRadioButton                 Led3Button;
extern   TRadioButton                 Led4Button;
extern   TRadioButton                 left;
extern   TRadioButton                 right;
extern   TRadioButton                 up;
extern   TRadioButton                 down;
extern   TRadioButton                 square;
extern   TRadioButton                 circle;
extern   TRadioButton                 triangle;
extern   TRadioButton                 x;
extern   TRadioButton                 start;
extern   TButton               StatusLEDsText;
extern   TButton               ProgramCaption;
extern   TButton               MCU;
extern   TButton                * const code Screen1_Buttons[3];
extern   TImage                 * const code Screen1_Images[1];
extern   TRadioButton               * const code Screen1_RadioButtons[13];



/////////////////////////
// Events Code Declarations
void Led1ButtonOnClick();
void Led2ButtonOnClick();
void Led3ButtonOnClick();
void Led4ButtonOnClick();
/////////////////////////

/////////////////////////////////
// Caption variables Declarations
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
/////////////////////////////////

void DrawScreen(TScreen *aScreen);
void DrawButton(TButton *aButton);
void DrawImage(TImage *AImage);
void DrawRadioButton(TRadioButton *ARadioButton);
void Check_TP();
void Start_TP();
