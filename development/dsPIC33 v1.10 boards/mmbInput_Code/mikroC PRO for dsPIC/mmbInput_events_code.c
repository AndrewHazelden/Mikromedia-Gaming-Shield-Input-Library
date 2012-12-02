#include "mmbInput_objects.h"
#include "mmbInput_resources.h"

//--------------------- User code ---------------------//

#include "gaming-shield.h"

void Check_GS();
void UpdateStatusLEDButtons();

long int frame_counter = 0;



void Check_GS(){


  //draw the screen for the first time
  if(frame_counter==0){

  LED1 = 0;
  LED2 = 0;
  LED3 = 0;
  LED4 = 0;


  //Display the microcontroller type in text area of the "MCU" 
  //The MCU "button" text element is on the lower right of the screen
  #ifdef P33FJ256GP710A
    strcpy(MCU_Caption, "dsPIC");
    DrawButton(&MCU);
  #endif

  #ifdef P32MX460F512L
    strcpy(MCU_Caption, "PIC32");
    DrawButton(&MCU);
  #endif

  UpdateStatusLEDButtons();
  //DrawScreen(&Screen1);
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



  //Refresh the radio buttons

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



  //Save the old button values for the next check
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


//Redraw the status LED buttons on the LCD display
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



//----------------- End of User code ------------------//

// Event Handlers

void Led1ButtonOnClick() {
  LED1 = ~LED1;               //Toggle the LED
  UpdateStatusLEDButtons();
}

void Led2ButtonOnClick() {
  LED2 = ~LED2;               //Toggle the LED
  UpdateStatusLEDButtons();
}

void Led3ButtonOnClick() {
  LED3 = ~LED3;               //Toggle the LED
  UpdateStatusLEDButtons();
}

void Led4ButtonOnClick() {
  LED4 = ~LED4;              //Toggle the LED
  UpdateStatusLEDButtons();
}
