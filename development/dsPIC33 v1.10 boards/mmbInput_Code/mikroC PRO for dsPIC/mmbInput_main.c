/*
 * Project name:
     mmbInput.vtft
 * Generated by:
     Visual TFT
 * Date of creation
     12/1/2012
 * Time of creation
     7:48:38 AM
     
 * Created By:
 Andrew Hazelden
 
 * Email:
 andrewhazelden@gmail.com
 
 * Blog:
 http://www.andrewhazelden.com
 
 * Test configuration:
     MCU:             P33FJ256GP710A
     Dev.Board:       MikroMMB_for_dsPIC33_hw_rev_1.1
                      http://www.mikroe.com/eng/products/view/586/mikrommb-for-dspic33-board/
     Oscillator:      80000000 Hz
     SW:              mikroC PRO for dsPIC
                      http://www.mikroe.com/eng/products/view/231/mikroc-pro-for-dspic30-33-and-pic24/

     Controller:      Mikromedia GAMING Shield
                      http://www.mikroe.com/eng/products/view/747/mikromedia-gaming-shield/ 
 
 */

#include "mmbInput_objects.h"
extern void InitGameShield();
extern void Check_GS();

extern long frame_counter; //Track the number of frames rendered

void main() {

  Start_TP();
  InitGameShield();    //Setup the gameshield inputs and outputs
  

  while (1) {
    Check_TP(); //Check the Mikromedia Touch Panel
    Check_GS(); //Check for Game Shield input
    
    frame_counter++;  //Increment the frame counter

  }

}
