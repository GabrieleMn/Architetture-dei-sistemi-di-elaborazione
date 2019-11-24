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
#include "timer/timer.h"


//int on;
int state;					/* salva lo stato del programma */
int ciclo;					/* numero di iterazioni */
int sequence[10];
int indice;
int sequenceComplete;
int CurrentBounce;
int PreviousBounce;
int wait05;
/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
int main (void) {
  int i;
	state=1;															/* indica il livello */
	ciclo=0;															/* indica iterazione per ogni livello */
	indice=0;															/* indice per vettore soluzione */
	sequenceComplete=2;										/* flag per vinto/perso */
	wait05=0;

	for(i=0;i<10;i++)
		sequence[i]=0;
	
	SystemInit();  												/* System Initialization (i.e., PLL)  */
  LED_init();                           /* LED Initialization                 */
  BUTTON_init();												/* BUTTON Initialization              */
	
	/*********************************************************
	Decommentare il timer che si vuole usare. 
	**********************************************************/
	
	//		init_timer(0,0x017D7840);				/* TIMER0 Initialization              */	
  //		init_timer(0,0x02FAF080);
	
	init_timer(0,0x0000AAAA);
	
	enable_timer(0);
	enable_timer(1);											/* attivo TIMER1 per generare numero casuale */
	

		
  while (1) {                           /* Loop forever                       */	
			CurrentBounce=LPC_TIM0->TC;
  }

}
