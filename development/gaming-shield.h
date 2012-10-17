/*
 * Project name:
     Mikromedia Gaming Shield Input Library

 * Library Version: 
   0.1 Alpha

 * Date of creation
     7/16/2012
 * Time of creation
     8:51:10 AM
     
 * Created By:
 Andrew Hazelden
 
 * Email:
 andrewhazelden@gmail.com
 
 * Blog:
 http://www.andrewhazelden.com 

 * Software License:  BSD 
     
 * Compatible SW:     mikroC PRO for PIC32
                      http://www.mikroe.com/eng/products/view/623/mikroc-pro-for-pic32/
                       
                      mikroC PRO for dsPIC
                      http://www.mikroe.com/eng/products/view/231/mikroc-pro-for-dspic30-33-and-pic24/

                      VisualTFT
                      http://www.mikroe.com/eng/products/view/627/visual-tft/
  
 * Compatible Boards:
 
                      MikroMMB_for_PIC32_hw_rev_1.10
                      http://www.mikroe.com/eng/products/view/595/mikrommb-for-pic32-board/

                      or
                      
                      MikroMMB_for_dsPIC33_hw_rev_1.05                     http://www.mikroe.com/eng/products/view/586/mikrommb-for-dspic33-board/ 
                      
                
 * Controller:        Mikromedia GAMING Shield
                      http://www.mikroe.com/eng/products/view/747/mikromedia-gaming-shield/
 */
 
 
//----------------------------------
// Mikromedia Gaming Shield Buttons
//----------------------------------

//-----------------------
// DSPIC33 Controls  
//-----------------------
 #ifdef P33FJ256GP710A
 
//The button controls are defined here for the dsPIC33 version

//Button Address Bits
sbit upButton at PORTD.B14;       //Up
sbit downButton at PORTD.B15;     //Down
sbit rightButton at PORTD.B6;     //Right
sbit leftButton at PORTD.B9;      //Left
sbit triangleButton at PORTA.B9;  //Triangle Up
sbit xButton at PORTA.B10;        //X Down
sbit circleButton at PORTF.B0;    //Circle Right
sbit squareButton at PORTD.B7;    //Square Left
sbit startButton at PORTF.B1;     //Start

//Tris Direction Bits
sbit upButtonDirection at TRISD.B14;       //Up Tris Direction
sbit downButtonDirection at TRISD.B15;     //Down Tris Direction
sbit rightButtonDirection at TRISD.B6;     //Right Tris Direction
sbit leftButtonDirection at TRISD.B9;      //Left Tris Direction
sbit triangleButtonDirection at TRISA.B9;  //Triangle Up Tris Direction
sbit xButtonDirection at TRISA.B10;        //X Down Tris Direction
sbit circleButtonDirection at TRISF.B0;    //Circle Right Tris Direction
sbit squareButtonDirection at TRISD.B7;    //Square Left Tris Direction
sbit startButtonDirection at TRISF.B1;     //Start Tris Direction


//Save value from previous cycle
bit upButtonOld;
bit downButtonOld;
bit rightButtonOld;
bit leftButtonOld;
bit triangleButtonOld;
bit xButtonOld;
bit circleButtonOld;
bit squareButtonOld;
bit startButtonOld;


sbit LED1 at LATA.B12; //Led 1
sbit LED2 at LATA.B13; //Led 2
sbit LED3 at LATA.B14; //Led 3
sbit LED4 at LATA.B15; //Led 4

sbit LED1_Direction at TRISA.B12; //Led 1
sbit LED2_Direction at TRISA.B13; //Led 2
sbit LED3_Direction at TRISA.B14; //Led 3
sbit LED4_Direction at TRISA.B15; //Led 4


// END DSPIC33 Controls   
#endif


//-----------------------
// PIC32 Controls 
//-----------------------
#ifdef P32MX460F512L   
        
//The button controls are defined here for the PIC32 version

//Button Address Bits
sbit upButton at PORTA.B6;     //up
sbit downButton at PORTA.B7;   //down
sbit rightButton at PORTD.B10; //right
sbit leftButton at PORTA.B5;   //left
sbit triangleButton at PORTD.B14; //triangle up
sbit xButton at PORTD.B15;        //x down
sbit circleButton at PORTF.B4;    //circle right
sbit squareButton at PORTD.B11;   //square left
sbit startButton at PORTF.B5;     //start

//Tris Direction Bits
sbit upButtonDirection at TRISA.B6;     //up
sbit downButtonDirection at TRISA.B7;   //down
sbit rightButtonDirection at TRISD.B10; //right
sbit leftButtonDirection at TRISA.B5;   //left
sbit triangleButtonDirection at TRISD.B14; //triangle up
sbit xButtonDirection at TRISD.B15;        //x down
sbit circleButtonDirection at TRISF.B4;    //circle right
sbit squareButtonDirection at TRISD.B11;   //square left
sbit startButtonDirection at TRISF.B5;     //start


//Save value from previous cycle
bit upButtonOld;
bit downButtonOld;
bit rightButtonOld;
bit leftButtonOld;
bit triangleButtonOld;
bit xButtonOld;
bit circleButtonOld;
bit squareButtonOld;
bit startButtonOld;

//This defines the status LEDs
sbit LED1 at LATE.B8; //Led 1
sbit LED2 at LATE.B9; //Led 2
sbit LED3 at LATA.B14; //Led 3
sbit LED4 at LATA.B15; //Led 4

sbit LED1_Direction at TRISE.B8; //Led 1
sbit LED2_Direction at TRISE.B9; //Led 2
sbit LED3_Direction at TRISA.B14; //Led 3
sbit LED4_Direction at TRISA.B15; //Led 4


// END PIC32 Controls

#endif




//------------------------------------
// Init Functon for the Gaming Shield
//------------------------------------


void InitGameShield(){


  //Init the Buttons - Set the button direction to inputs
  //TRIS inputs = 1

  upButtonDirection = 1;       //up
  downButtonDirection = 1;     //down
  rightButtonDirection = 1;    //right
  leftButtonDirection = 1;     //left
  triangleButtonDirection = 1; //triangle up
  xButtonDirection = 1;        //x down
  circleButtonDirection = 1;   //circle right
  squareButtonDirection = 1;   //square left
  startButtonDirection = 1;    //start

  //Init the LEDs - Set the LEDs direction to outputs
  //TRIS outputs = 0

  LED1_Direction = 0; //led 1
  LED2_Direction = 0; //led 2
  LED3_Direction = 0; //led 3
  LED4_Direction = 0; //led 4

  Delay_ms(100);

  LED1 = 0;
  LED2 = 0;
  LED3 = 0;
  LED4 = 0;
}