#include "lpc17xx.h"
#include "led.h"


unsigned int startLed;

void LED_On(unsigned int num){
	
switch (num){

		case 0: LPC_GPIO2->FIOSET   |= 0x00000080; 
						startLed=0x00000080;
						break;
		case 1: LPC_GPIO2->FIOSET   |= 0x00000040; 
						startLed=0x00000040;
						break;
		case 2: LPC_GPIO2->FIOSET   |= 0x00000020;
						startLed=0x00000020;
						break;
		case 3: LPC_GPIO2->FIOSET   |= 0x00000010; 
						startLed=0x00000010;
						break;
		case 4: LPC_GPIO2->FIOSET   |= 0x00000008; 
						startLed=0x00000008;
						break;
		case 5: LPC_GPIO2->FIOSET   |= 0x00000004; 
						startLed=0x00000004;
						break;
		case 6: LPC_GPIO2->FIOSET   |= 0x00000002; 
						startLed=0x00000002;
						break;
		case 7: LPC_GPIO2->FIOSET   |= 0x00000001; 
						startLed=0x00000001;
						break;
};
}