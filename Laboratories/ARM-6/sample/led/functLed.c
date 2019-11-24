
#include "led.h"
#include "lpc17xx.h"  //contiene costanti

unsigned int led_value;

void led4and11_On(void){

	LPC_GPIO2->FIOSET   |= 0x00000081;
																		
}	
void led4_Off(void){
	LPC_GPIO2->FIOCLR   |= 0x00000080;
	
}

void ledEvenOn_OddOf(void){
	LPC_GPIO2->FIOPIN |=0x000000AA;	
	LPC_GPIO2->FIOPIN &=	~0x0000055;

	
}

 void LED_On(unsigned int num){
	
	
	switch (num){
		case 0: LPC_GPIO2->FIOSET   |= 0x00000080; 	//LED4
						led_value=LPC_GPIO2->FIOSET;
						led_value &= 0x00000011;
						break;
		case 1: LPC_GPIO2->FIOSET   |= 0x00000040; 	//LED5
						led_value=LPC_GPIO2->FIOSET & 0x000000FF;
						break;
		case 2: LPC_GPIO2->FIOSET   |= 0x00000020; //LED6
							led_value=LPC_GPIO2->FIOSET & 0x000000FF;
						break;	
		case 3: LPC_GPIO2->FIOSET   |= 0x00000010; //LED7
							led_value=LPC_GPIO2->FIOSET & 0x000000FF;
						break;
		case 4: LPC_GPIO2->FIOSET   |= 0x00000008; //LED8
							led_value=LPC_GPIO2->FIOSET & 0x000000FF;
						break;
		case 5: LPC_GPIO2->FIOSET   |= 0x00000084; //LED9
							led_value=LPC_GPIO2->FIOSET & 0x000000FF;
						break;
		case 6: LPC_GPIO2->FIOSET   |= 0x00000002; //LED10
							led_value=LPC_GPIO2->FIOSET & 0x000000FF;
						break;
		case 7: LPC_GPIO2->FIOSET   |= 0x00000001; //LED11
							led_value=LPC_GPIO2->FIOSET & 0x000000FF;
						break;
		
	}}
	
void LED_Off(unsigned int num){
	
	
	switch (num){
		case 0: LPC_GPIO2->FIOCLR   |= 0x00000080; 	//LED4
						break;
		case 1: LPC_GPIO2->FIOCLR   |= 0x00000040; 	//LED5
						break;
		case 2: LPC_GPIO2->FIOCLR   |= 0x00000020; //LED6
						break;	
		case 3: LPC_GPIO2->FIOCLR   |= 0x00000010; //LED7
						break;
		case 4: LPC_GPIO2->FIOCLR   |= 0x00000008; //LED8
						break;
		case 5: LPC_GPIO2->FIOCLR   |= 0x00000084; //LED9
						break;
		case 6: LPC_GPIO2->FIOCLR   |= 0x00000002; //LED10
						break;
		case 7: LPC_GPIO2->FIOCLR   |= 0x00000001; //LED11
						break;
		
	}
}
	
