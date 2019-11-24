#include "button.h"
#include "lpc17xx.h"



void EINT0_IRQHandler (void)	  
{
  LPC_SC->EXTINT |= (1 << 0);/* clear pending interrupt         */
	
	LPC_GPIO2->FIOPIN=led_value;
}


void EINT1_IRQHandler (void)	  
{
	unsigned int var;
  LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt         */
	
	var=led_value;
	var=var<<1;
	LPC_GPIO2->FIOPIN=var;

	
	
}

void EINT2_IRQHandler (void)	  
{
	unsigned int var;
  LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */ 

	var=led_value;
	var=var>>1;
	LPC_GPIO2->FIOPIN=var;	
}


