#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"


void EINT0_IRQHandler (void)	   // abbassano il flag dell'interrupt corrispondente
{
	//	if(bounce-previous<2)																	/*gestione rimbalzo*/
  //		return;
  
	LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
	LPC_GPIO2->FIOPIN=startLed;
	
	//bounce=previous;
}


void EINT1_IRQHandler (void)	  //pulsante KEY1
{
	unsigned int limit= LPC_GPIO2->FIOPIN & 0x00000080;
  unsigned int mask=LPC_GPIO2->FIOPIN & 0x000000FF;			
		
//	if(bounce-previous<2)																	/*gestione rimbalzo*/
//		return;
	
	LPC_SC->EXTINT |= (1 << 1);    											 /* clear pending interrupt */
	
	if( limit == 0x00000080){
		LPC_GPIO2->FIOPIN = LPC_GPIO2->FIOPIN & 0xFFFFFF00;
		LPC_GPIO2->FIOPIN =LPC_GPIO2->FIOPIN | 0x00000001 ;}
	else{
		mask=mask<<1;
		mask &= 0x000000FF;																	/*  azzero 8-32 maschera  */
		LPC_GPIO2->FIOPIN = LPC_GPIO2->FIOPIN & 0xFFFFFF00; /*  Spengo tutti i led  */
		mask= mask | LPC_GPIO2->FIOPIN;											/*  salvo 8-32 FIOPIN nella maschera  */
		LPC_GPIO2->FIOPIN = mask;}			
		
//		previous=bounce;
}

void EINT2_IRQHandler (void)	  
{
	unsigned int limit= LPC_GPIO2->FIOPIN & 0x00000001; /* prendo limite destro FIOPIN */
	unsigned int mask=LPC_GPIO2->FIOPIN & 0x000000FF;		
	
//	if(bounce-previous<2)																	/*gestione rimbalzo*/
//		return;
	
	LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */ 
	
 	if( limit == 0x00000001){
		LPC_GPIO2->FIOPIN = LPC_GPIO2->FIOPIN & 0xFFFFFF00;
		LPC_GPIO2->FIOPIN =LPC_GPIO2->FIOPIN | 0x00000080 ;}
	else{
		mask=mask >>1;
		mask &= 0x000000FF;
		LPC_GPIO2->FIOPIN = LPC_GPIO2->FIOPIN & 0xFFFFFF00;
		mask= mask | LPC_GPIO2->FIOPIN;
		LPC_GPIO2->FIOPIN = mask;}
	
		previous=bounce;
}


