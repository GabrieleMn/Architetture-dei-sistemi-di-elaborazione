/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_timer.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    timer.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "timer.h"
#include "../led/led.h"

/******************************************************************************
** Function name:		Timer0_IRQHandler
**
** Descriptions:		Timer/Counter 0 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
//extern int on;


int end=0;
void TIMER0_IRQHandler (void)
{
	int i=0;
	
	LPC_TIM0->IR = 1;										 		/* clear interrupt flag */
	
	if(wait05==1){
			wait05=0;
			return;}
	
	LPC_GPIO2->FIOCLR |= 0x000000FF;	
	
/***********************************************************************************************************
**	
**	Se ciclo==state vuol dire che la scheda ha mostrato la sequenza completa per il livello corrente e si 
**	mette in attesa di una variazione di sequenceComplete (flag vittoria). Finchè sequenceComplete non cambia
**	l'interruptHandler non esegue niente e ritorna al main  
**
**		sequenceComplete=0  PERSO
**		sequenceComplete=1  VINTO
**			
***********************************************************************************************************/
	
			if(end==1)						// se ho completato la sequenza aspetto di premere un pulsante per nextLevel
			return;
	
	if(end==2){								// pulsante per nextLevel premuto
			sequenceComplete=2;
			wrong=0;
			end=0;
			return;}
		 
			
	if(ciclo==state)													
	{																																											
			if(sequenceComplete==0)								
			{
				LPC_GPIO2->FIOPIN =wrong;
				end=1;
				state=1;													
				indice=0;
				ciclo=0;
				return;
				//while(1);
			}
			else if(sequenceComplete==1)				
			{
				for(i=0;i<indice;i++)
						sequence[i]=0;
				LPC_GPIO2->FIOCLR |= 0x000000FF;
				LPC_GPIO2->FIOPIN |= state;
				ciclo=0;
				state++;													
				indice=0;
			//wrong=0;
			//sequenceComplete=2;
				end=1;
				return;
			}
			else
					return;
	}			
	
/*********************************************************************************************************** 
**	Il timer1 lo uso solo per generare un numero casuale, facendo il modulo 3 ottengo un numero compreso tra
**	0 e 2, così accendo in modo casuale uno dei led 4,5,6   
***********************************************************************************************************/
	
	if(LPC_TIM1->TC %3 == 0){
		LPC_GPIO2->FIOSET |= 0x00000080;	/*led4ON*/
		sequence[indice]=4;
		indice++;
		ciclo++;
		wait05=1;
		return;
	}
	else if (LPC_TIM1->TC % 3 == 1){		
		LPC_GPIO2->FIOSET |= 0x00000040;	/*led5ON*/
		sequence[indice]=5;
		indice++;
		ciclo++;
		wait05=1;
		return;
	}
	else if (LPC_TIM1->TC % 3 == 2){
		LPC_GPIO2->FIOSET |= 0x00000020;	/*led6ON*/
		sequence[indice]=6;
		indice++;
		ciclo++;
		wait05=1;
		return;
		
		
		
	}
	
  return;
}


/******************************************************************************
** Function name:		Timer1_IRQHandler
**
** Descriptions:		Timer/Counter 1 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
void TIMER1_IRQHandler (void)
{
  LPC_TIM1->IR = 1;			/* clear interrupt flag */
  return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
