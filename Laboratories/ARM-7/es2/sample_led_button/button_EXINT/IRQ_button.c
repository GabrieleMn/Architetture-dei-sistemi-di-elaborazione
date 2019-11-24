#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"


void EINT0_IRQHandler (void)	   // abbassano il flag dell'interrupt corrispondente
{
	int mask;
	
	/*if(bounce-previous<10)
		 	return;  */
					
  LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
	
	if((random%2)==0)
		LPC_GPIO2->FIOPIN |= 0x00000008;	/*accendo LED 8 */
	else
		LPC_GPIO2->FIOPIN |= 0x00000004;	/*accendo LED 9 */
	
	mask=LPC_GPIO2->FIOPIN;
	mask&=0x000000FF;
	if(mask==0x000000A8||mask==0x00000054) /* vincita */
		LPC_GPIO2->FIOPIN |= 0x00000001;
	else
		LPC_GPIO2->FIOPIN |= 0x00000002;
	
	//previous=bounce;
}


void EINT1_IRQHandler (void)	  //pulsante KEY1
{
	/*if(bounce-previous<10)
				return;*/
	
	LPC_SC->EXTINT |= (1 << 1);    											 /* clear pending interrupt */
	
	LPC_GPIO2->FIOPIN&=0x11111100;		/* spengo LED */
	
	if((random%2)==0)
		LPC_GPIO2->FIOPIN |= 0x00000080;	/*accendo LED 4 */
	else
		LPC_GPIO2->FIOPIN |= 0x00000040;	/*accendo LED 5 */
	
	
	
	//previous=bounce;

	
	
}

void EINT2_IRQHandler (void)	  
{
	/*if(bounce-previous<10)
				return;*/
	
	LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */ 
	
	if((random%2)==0)
		LPC_GPIO2->FIOPIN |= 0x00000020;	/*accendo LED 6 */
	else
		LPC_GPIO2->FIOPIN |= 0x00000010;	/*accendo LED 7 */
	
	//previous=bounce;
 	
}


