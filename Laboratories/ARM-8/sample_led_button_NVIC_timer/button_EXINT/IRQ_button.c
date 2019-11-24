#include "button.h"
#include "lpc17xx.h"

#include "../led/led.h"


int	wrong;
int count=0;																	/* indica che led nella sequenza sto accendendo */

	/***********************************************************************************************************
	Il controllo del rimbalzo è disabilitato per il debug
	software.	
	***********************************************************************************************************/

void EINT0_IRQHandler (void)	  
{
	 LPC_SC->EXTINT = (1 << 0);     							/* clear pending interrupt         */
  
	
		/*if(CurrentBounce-PreviousBounce<0.1)
				return;
		PreviousBounce=CurrentBounce;*/
		
		if( end==1){
				end=2;
				return;
		}
		
		wrong++;
		
	LPC_GPIO2->FIOSET |= 0x00000020;				 	 /*led6ON*/
	if (sequence[count]==6&&count+1==ciclo){
			sequenceComplete=1;
			count=0;
			return;}
	else if (sequence[count]!=6){
			sequenceComplete=0;
			count=0;
			return;}
	count++;
  
}

/************************************************************************************************************
Se vinco metto sequenceComplete=1, l'interrupt handler del timer è in attesa di una variazione di
    sequenceComplete, si accorge che ho vinto perchè settata ad 1 e passa al livello successivo             
************************************************************************************************************/


void EINT1_IRQHandler (void)	  
{
	
	LPC_SC->EXTINT = (1 << 1);     							/* clear pending interrupt         */
	/*if(CurrentBounce-PreviousBounce<0.1)
		return;
	PreviousBounce=CurrentBounce;*/
	
	if( end==1){			/* schiacciato pulsante per passare a prossimo livello */
				end=2;
			return;}
	
		wrong++;				/* tiene il conto dei tasti schiacciati per indicare il numero in caso di errore */
		
	LPC_GPIO2->FIOSET |= 0x00000080;						/*led4ON*/
	if (sequence[count]==4&&count+1==ciclo){		/* se ho azzeccato l'ultimo tasto della sequenza ho vinto */
			sequenceComplete=1;
			count=0;
			return;}
	else if (sequence[count]!=4){								/* appena sbaglio game over */
			sequenceComplete=0;											
			count=0;
			return;}
	
	count++;
			
	
}

void EINT2_IRQHandler (void)	  
{
	LPC_SC->EXTINT = (1 << 2);    	 					 /* clear pending interrupt         */    

	
	/*if(CurrentBounce-PreviousBounce<0.1)
				return;
	PreviousBounce=CurrentBounce;*/
		
		if( end==1){
					end=2;
				return;}
		
				wrong++;
	
				LPC_GPIO2->FIOSET |= 0x00000040;						/*led5ON*/
				
	if (sequence[count]==5&&count+1==ciclo){
			sequenceComplete=1;
			count=0;
			return;}
	else if (sequence[count]!=5){
			sequenceComplete=0;
			count=0;
			return;}
	count++;
	
}


