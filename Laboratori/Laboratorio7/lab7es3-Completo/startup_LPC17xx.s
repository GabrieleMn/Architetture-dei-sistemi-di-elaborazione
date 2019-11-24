;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00005F00

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF


 				AREA VAR,DATA,READONLY
				DCD 9,6,3,2,1,8,7,0,5,4,0
N				EQU 3
				AREA STACK1,DATA,READWRITE
stack1			SPACE 200					
stack2			SPACE 200					
stack3			SPACE 200	
                AREA    |.text|, CODE, READONLY

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
						
	
				LDR R2,=VAR

				LDR R10,=stack1
				ADD R10,#4
				PUSH {R10,R2}
				BL	fillStack
				POP {R10,R2}		
				LDR R7,=stack2
				ADD R7,#4
				PUSH {R7,R2}		
				BL fillStack
				POP {R7,R2}
				LDR R8,=stack3		
				ADD R8,#4
				PUSH {R8,R2}
				BL fillStack
				POP {R8,R2}		
;-------------------------------------------------------------		
;	scegliere due stack per spostamento tra R10,R7,R8		
				;PUSH{R11}	;ritorno
				;PUSH{R8}	;sorgente
				;PUSH{R7}	;destinazione
				;BL move1
				;POP {R7}
				;POP{R8}
				;POP{R11}
;--------------------------------------------------------------				
sorg			RN 0
dest			RN 1
aux				RN 2
K				RN 3
ritorno			RN 4
M				RN 5

				MOV K,#3
				
				PUSH {R7}	;sorgente
				PUSH{R10}	;destinazione, vuota
				PUSH{R8}	;aux
				PUSH{K}	;K
				BL moveK
				POP{K}
				POP{R8}
				POP{R10}
				POP{R7}
				
			
;--------------------------------------------------------------	
STOP			B STOP
				ENDP
						
				
fillStack		PROC
				PUSH {R3,R4,R5,R6,R7,LR}
				LDR R5,[SP,#28]		; R5 <-- pointer stack
				LDR R6,[SP,#24]		; R6 <-- pointer memoria variabili
				EOR R4,R4

fillLoop		LDR R3,[R6],#4	;prendo  elemento dalla memoria
				CMP R3,#0
				BEQ control
				
				CMP R4,#0		; alla prima iterazione R4 sarà 0 non devo fare confronto
				BEQ over
				CMP R3,R4		; verifico se elemento già nello stack è maggiore di quello che devo mettere, R4 sarà
				BHI	nextStack	; il valore all'iterazione N-1
over			STMIA R5!,{R3}
				
				LDR R4,[R6],#4	; prendo elemento dalla memoria
				CMP R4,#0		; se prendo salto cambio stack
				BEQ nextStack
				CMP R4,R3		; verifico se elemento già nello stack è maggiore di quello che devo mettere
				BHI	nextStack
				STMIA R5!,{R4}
				ADD R7,#1
				B fillLoop
				
control			CMP R7,#0		    ; controllo se sono alla prima iterazione
				BNE nextStackZero	; se NON sono alla prima iterazione e ho preso 0 cambio stack
				ADD R7,#1		    ; altrimenti scarto lo 0 e non lo inserisco
				B fillLoop
								
nextStack		SUB R6,#4
nextStackZero	SUB R5,#4
				STR R5,[SP,#28]
				STR R6,[SP,#24]
				POP {R3,R4,R5,R6,R7,PC}
				ENDP
				


;--------------------------------------------------------------				
											
				
move1			PROC
				PUSH {R0,R3,R4,R5,R6,R7,LR}
				LDR R3,[SP,#32]		;R5--> pointer stack sorgente,casella vuota
				LDR R4,[SP,#28]		;R6--> pointer stack destinazione,casella vuota
			
				
				LDR R6,[R3]			;R6--> copio l'ultimo elemento dalla sorgente
				LDR	R7,[R4]			;R7--> copio l'ultimo elemento della destinazione
				
				CMP R6,#0			;se stack vuoto non posso spostare
				BEQ fail
				
				CMP R7,#0			; se la destinazione è vuota posso mettere qualsiasi elemento
				BEQ ok
				
	
				CMP R6,R7
				BHS	fail
				MOV R7,#0
				
				ADD R4,#4			; aggiorno SP destinazione a cui ho aggiunto un elemento
ok				STR R7,[R3]

				LDR R7,[R3,#-4]		;controllo se sto prendendo l'ultimo elemento
				CMP	R7,#0
				IT NE				;se non è l'utimo posso diminuire indirizzo
				SUBNE R3,#4			; aggiorno SP dello stack a cui ho tolto un elemento
     			
				STR	R6,[R4]			; aggiungo valore alla destinazione
				MOV R0,#1			; salvo valore di ritorno
				STR R0,[SP,#36]		; salvo valore di ritorno
				STR R3,[SP,#32]		; aggiorno SP sorgente
				STR R4,[SP,#28]		; aggiorno SP destinazione
				B	return
					
fail			MOV R0,#0			;imposto valore di ritorno
				STR R0,[SP,#36]
				B return

return			POP {R0,R3,R4,R5,R6,R7,PC}
				ENDP
;--------------------------------------------------------------	

				
moveK			PROC
				PUSH{sorg,dest,aux,K,ritorno,M,R9,LR}				
				LDR sorg,[SP,#44]
				LDR dest,[SP,#40]
				LDR aux,[SP,#36]
				LDR K,[SP,#32]
			
				
				MOV M,#0
				
				CMP K,#1
				BNE	ellse
				PUSH{ritorno}	;------ move1(ritorno,x,y)----
				PUSH{sorg}
				PUSH{dest}
				BL move1
				POP {dest}
				POP {sorg}
				POP {ritorno}	;------ return ---------------
				
				ADD M,M,ritorno
				B fineMove

ellse			SUB R9,K,#1		;------ moveK(x,z,y,N-1) ------
			
				PUSH{sorg}
				PUSH{aux}
				PUSH{dest}
				PUSH{R9}
				
				BL moveK

				POP{R9}		
				POP{dest}
				POP{aux}
				POP{sorg}		;------ return ---------------
			
				ADD M,M,R9

				PUSH{ritorno}	;------ move1(ritorno,x,y)----
				PUSH{sorg}
				PUSH{dest}
				
				BL move1
				
				POP {dest}
				POP {sorg}
				POP {ritorno}	;------ return ---------------
				
				CMP ritorno,#0	
				BNE ellse1
				B fineMove
				
ellse1			ADD M,M,#1
				SUB R9,K,#1		;------ moveK(z,y,x,N-1) ------
				
				PUSH{aux}
				PUSH{dest}
				PUSH{sorg}
				PUSH{R9}		
	
				BL moveK
				
				POP{R9}
				POP{sorg}
				POP{dest}
				POP{aux}		;------ return ---------------
				
				ADD M,M,R9
				
fineMove		STR sorg,[SP,#44]
				STR dest,[SP,#40]
				STR aux,[SP,#36]
				STR M,[SP,#32]			  ;aggiorno K con numero pasi fatti
				
				POP{sorg,dest,aux,K,ritorno,M,R9,PC}
				ENDP


; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                ;IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
