/*----------------------------------------------------------------------------
 * Name:    sample.c
 * Purpose: to control led through EINT buttons
 * Note(s):
 *----------------------------------------------------------------------------
 *
 * This software is supplied "AS IS" without warranties of any kind.
 *
 * Copyright (c) 2017 Politecnico di Torino. All rights reserved.
 *----------------------------------------------------------------------------*/
                  
#include <stdio.h>
#include "LPC17xx.H"                    /* LPC17xx definitions                */
#include "led/led.h"
#include "button_EXINT/button.h"

/* Led external variables from funct_led */

/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
int main (void) {
  
  SystemInit();  												/* System Initialization (i.e., PLL)  */
  LED_init();                           /* LED Initialization                 */
	led4and11_On();
	led4_Off();
  ledEvenOn_OddOf();
	LED_Off(2);
	LED_On(2);
	
  BUTTON_init();												/* BUTTON Initialization              */
	
	LPC_GPIO2->FIOCLR |= 0x000000FF;
	LED_On(4);
	
  while (1) {                           /* Loop forever                       */	
  }

}
