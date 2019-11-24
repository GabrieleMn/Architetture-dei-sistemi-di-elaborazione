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

Stack_Size      EQU     0x00000200

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
				
				AREA 	dati, DATA, READONLY

N EQU 40
M EQU 6	



Price_list	DCD 0x2, 29, 0x3, 5, 0x4, 29, 0x7, 11, 0xB, 2 
			DCD 0xC, 12,  0xE, 24, 0x10, 30, 0x11, 28, 0x13, 2 
			DCD 0x17, 17, 0x19, 30, 0x1D, 13, 0x1E, 10, 0x20, 22
			DCD 0x23, 23, 0x24, 5, 0x26, 23, 0x27, 21, 0x2C, 18
			DCD 0x2D, 14, 0x32, 16, 0x35, 2, 0x36, 4, 0x38, 8
			DCD 0x39, 3, 0x3C, 27, 0x3E, 9, 0x41, 6, 0x42, 29
			DCD 0x43, 10, 0x4A, 21, 0x4E, 3, 0x4F, 11, 0x50, 3
			DCD 0x51, 19, 0x52, 28, 0x5F, 22, 0x60, 8, 0x64, 9


Item_list1	DCD 0x27, 1, 0x4E, 5, 0x10, 3, 0x41, 8, 0x3C, 4, 0x23, 2		;TOTALE 148

Item_list2	DCD 0x27, 1, 0x31, 5, 0x10, 3, 0x41, 8, 0x3C, 4, 0x23, 2		;MANCA PRODOTTO
																
				AREA    |.text|, CODE, READONLY	
; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
				
				LDR r0, =Price_list
				LDR r1, =Item_list1
				MOV r2, #0
				
				PUSH {r0, r1, r2}
				;BL sequentialSearch
				BL binarySearch
				;BL robustSequentialSearch
				;BL robustBinarySearch
				POP {r0, r1, r2}
STOP 			B STOP
				ENDP


sequentialSearch	PUSH {R3,R4,R5,R6,R7,R8,R9,LR}
					
					LDR R0,[SP,#32]		
					LDR R1,[SP,#36]
					
whileEXT			CMP R8,#M
					BEQ Fine
				
					LDR R2,[R1],#4		;prendo codProdotto
					LDR R3,[R1],#4		;prendo quantit‡Prodotto
					ADD R8,#1			;contatore esterno
					
whileINT			CMP R9,#N			;ho due condizioni di uscita, R9=M oppure Prodotto trovato R2=R4
					BEQ Fine
					
					ADD R9,#1			;contatore interno
					LDR R4,[R0],#4		;prendo codProdotto in PRICE_LIST
					LDR R5,[R0],#4		;prendo prezzo prodotto
					CMP R2,R4
					BNE	whileINT		;se il prodotto preso da PRICE_LIST non coincide prova con un altro
;productFound					
					UMLAL R6,R7,R3,R5	;R7,R6=(R3*R5)+(R7,R6)
					LDR R0,[SP,#32]		;ripristino indirizo PRICE_LIST
					MOV R9,#0
					B whileEXT
					
Fine				STR	R6,[SP,#40]	
					POP {R3,R4,R5,R6,R7,R8,R9,PC}
					
					
binarySearch		PUSH {R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,LR}
					
					LDR R0,[SP,#44]	;Price		
					LDR R1,[SP,#48]	;Item
					
price				RN 0
item				RN 1
first				RN 2
last				RN 3
index				RN 4
middle				RN 5
key					RN 7 ;elemento ITEM
quantity			RN 8

					
					MOV R6,#2
					

nextItem			CMP R11,#M
					BEQ	fine
					
					LDR key,[item],#4
					LDR quantity,[item],#4
					
					MOV first,#0
					MOV last,#N-2
					MOV index,#0
					
while			
					
					ADD middle,first,last
					AND R9,middle,#0x00000001
					UDIV middle,middle,R6
					CMP R9,#1
					IT	EQ
					SUBEQ middle,#1		
					
					
					LDR R9,[price,middle,LSL #3]	;R9 <- codProdotto
					
					LSL middle,#3
					ADD middle,#4
					LDR R12,[price,middle]				;R12<- prezzo prodotto
					SUB middle,#4
					LSR middle,#3
					
					CMP key,R9
					BEQ equal
					BLO lower
					BHI higher

equal				MOV index,middle
					MUL R9,R8,R12
					ADD R10,R9
					ADD R11,#1		;contatore ciclo
					B nextItem

lower				SUB middle,#1
					MOV last,middle
					ADD middle,#1
					B while

higher				ADD middle,#1
					MOV first,middle
					SUB middle,#1
					B while

fine				STR R10,[SP,#52]
					POP {R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,PC}	
					
	

robustSequentialSearch	
					PUSH {R3,R4,R5,R6,R7,R8,R9,LR}
					
					LDR R0,[SP,#32]		
					LDR R1,[SP,#36]
					
loopEXT				CMP R8,#M
					BEQ Fine1
					
					LDR R2,[R1],#4		;prendo codProdotto
					LDR R3,[R1],#4		;prendo quantit‡Prodotto
					
					ADD R8,#1
					
loopINT				CMP R9,#N
					BEQ notFound		;se sono arrivato ad avere R9=N il prodotto non Ë stato trovato
					
					LDR R4,[R0],#4		;R4 <- codProdotto
					LDR R5,[R0],#4		;R5 <- prezzo
					ADD R9,#1
					CMP R2,R4
					BNE	loopINT			;se il prodotto preso da PRICE_LIST non coincide prova con un altro
					
					UMLAL R6,R7,R3,R5	;(R7,R6)=(R3*R5)+(R7,R6)
					LDR R0,[SP,#32]		;ripristino indirizo PRICE_LIST
					MOV R9,#0
					B loopEXT
					
Fine1				STR	R6,[SP,#40]	
					POP {R3,R4,R5,R6,R7,R8,R9,PC}

notFound			MOV R6,#-1					
					STR	R6,[SP,#40]	
					POP {R3,R4,R5,R6,R7,R8,R9,PC}   
					
robustBinarySearch	PUSH {R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,LR}
					
					LDR R0,[SP,#44]	;Price		
					LDR R1,[SP,#48]	;Item
					
price				RN 0
item				RN 1
first				RN 2
last				RN 3
index				RN 4
middle				RN 5
key					RN 7 ;elemento ITEM
quantity			RN 8

					
					MOV R6,#2
					

nextItem3			CMP R11,#M
					BEQ	fine3
					
					LDR key,[item],#4
					LDR quantity,[item],#4
					
					MOV first,#0
					MOV last,#N-2
					MOV index,#0
					
while3			
					CMP first,last
					BHI	notFound3
					
					ADD middle,first,last
					AND R9,middle,#0x00000001
					UDIV middle,middle,R6
					CMP R9,#1
					IT	EQ
					SUBEQ middle,#1		
					
					
					LDR R9,[price,middle,LSL #3]	;R9 <- codProdotto
					
					LSL middle,#3
					ADD middle,#4
					LDR R12,[price,middle]				;R12<- prezzo prodotto
					SUB middle,#4
					LSR middle,#3
					
					CMP key,R9
					BEQ equal3
					BLO lower3
					BHI higher3

equal3				MOV index,middle
					MUL R9,R8,R12
					ADD R10,R9
					ADD R11,#1		;contatore ciclo
					B nextItem3

lower3				SUB middle,#1
					MOV last,middle
					ADD middle,#1
					B while3

higher3				ADD middle,#1
					MOV first,middle
					SUB middle,#1
					B while3

fine3				STR R10,[SP,#52]
					POP {R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,PC}	

notFound3			MOV R6,#-1					
					STR	R6,[SP,#52]	
					POP {R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,PC}	
	

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
