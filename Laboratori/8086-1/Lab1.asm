;       LABORATORIO 1
;       inerire testo di 4 righe, per ogni riga, dopo l'inserimento viene stampato il carattere che occorre più volte con il 
;       relativo numero di occorrenze. Subito di seguito vengono stampati i caratterri che occorrono almeno MAX/2 volte 
;       nella stessa riga.
;       Alla fine della 4 riga, viene stampato il cifrario di Cesare.

;       ACQUISIZIONE TESTO
;           soluzione 1) acquisire stringhe intere per ogni riga tramite buffer
;           soluzione 2) acquisizione carattere per carattere, SOLUZIONE SCELTA --> evito di scorrere di nuovo il vettore per
;                                                                                   il calolo delle occorrenze



.MODEL small                 
.STACK                        
.DATA
                prima_riga DB 50 dup (?)     
                seconda_riga DB 50 dup (?) 
                terza_riga DB 50 dup (?) 
                quarta_riga DB 50 dup (?) 
                tabella DB 52 dup (?) 
                MAX DW ?   
                MAX_IND DW ?
                K DW ? 
                CONT DW ?
                
.CODE
.STARTUP
                MOV K,1  
                MOV CONT,0
                XOR DI,DI 
                MOV MAX,0  
                MOV MAX_IND,0
                MOV SI,OFFSET prima_riga  
          RIGA:   
                MOV AH,1 
                INT 21H 
                MOV [SI],AL 
                INC SI                  ;per spostarmi nella riga
                INC DI                  ;per contare caratteri
                CALL CALCOLA          
         invio: CMP DI,20               ;se invio prima dei 20 caratteri non saltare riga, se dopo 20 caratteri salta riga
                JL  RIGA
                CMP AL,0DH
                JE NEXT
                CMP DI,50
                JE  NEXT
                JMP RIGA
         
                
          NEXT: INC CONT                ;aumento numero righe processate
                CALL NEW
                MOV BX,MAX_IND          ;preparo BX per STAMPA_CHAR 
                CALL STAMPA_CHAR   
                MOV AX,MAX     ;;;;
                CALL STAMPA_CIFRE      
                MOV CX,52               ;preparo CX per STAMPA_MAX2
                MOV BX,OFFSET tabella   ;preparo BX per stampa_MAX2
                CALL STAMPA_MAX2        
                CALL DOUBLE_NEW
                MOV MAX,0               
                CALL AZZERA             
                MOV CX,50               
                SUB CX,DI               ;calcolo offset mancante per nuova riga next_line=(50-offsetCorrente)
                ADD SI,CX               ;salto a nuova riga sommando offset mancante next_line+offset corrente
                XOR DI,DI               ;azzero numero caratteri per nuova riga
                CMP CONT,4
                JE FINE 
                JMP RIGA 
;--------------------------------------------------------------------        
;                   CALCOLA OCCORRENZE PER OGNI DATO           
        CALCOLA:
                PUSH AX                 ;preservo AH=1 per acquisizione carattere successivo
                MOV DX,OFFSET tabella
                CMP AL,0DH              ;se premuto invio, gestisci
                JE invio
                CMP AL,65               ;se non alfabetico non caloclare
                JL RIGA
                CMP AL,122              ;se non alfabetico non calcolare
                JA RIGA
                MOV AH,0 
           CALL CALCOLA_OFFSET       
                MOV BX,DX              ;non sporco registro ingresso
                ADD BX,AX              ;usa ascii lettera come offset
                ADD [BX],1             ;incremeta occorrenza lettera all'indirizzo tabella+asciiLettera
                POP AX  
                CALL VER_MAX   
                RET 
 ;per ogni dato inserito viene calcolato il suo offset per inserirlo
 ;in TABELLA, calcolato l'occorrenza e verificato il massimo
;--------------------------------------------------------------------               
 ;             CALCOLA OFFSET 0-52 PER AGGIORNAMENTO TABELLA OCCORRENZE     
       
CALCOLA_OFFSET:
                CMP AL,91
                JA minusc
                SUB AL,65
                RET 
         minusc:SUB AL,71               ;offset minuscole 71 perchè devo togliere 65(MAIUSC)+6(non alfabetici)
                RET                      
                 
                
 ;--------------------------------------------------------------------               
 ;             VERIFICA MASSIMO ,INPUT BX=INDIRIZZO MASSIMO     
      
      
       VER_MAX: 
                MOV DX,[BX]
                MOV DH,0
                CMP DX,MAX
                JA AGGIORNA_MAX
                RET
 ;verifica se il valore contenuto nella cella puntata da BX sia il massimo.
 ;--------------------------------------------------------------------               
 ;               AGGIORNA VALORE E INDIRIZZO DEL MASSIMO
  AGGIORNA_MAX:
                MOV MAX,DX
                MOV MAX_IND,BX
                MOV CX,BX
                JMP RIGA 
                   
 ;--------------------------------------------------------------------            
 ;          STAMPA UN CARATTERE DI TABELLA, INTPUT BX=INDIRIZZO CARATTERE
    STAMPA_CHAR:
                MOV DX,BX                  ;non sporco registro in ingresso
                SUB DX,OFFSET tabella
                CALL RIPRISTINA_OFF
                MOV AH,2 
                INT 21H 
                RET   
 ;non posso stampre direttamente il valore legato a MAX_IND perchè
 ;stamperebbe il valore ascii corrispondente all'indirizzo
;---------------------------------------------------------------------                 
;          RIPSRITINA VALORE ASCII DA VALORE OFFSET TABELLA                      
                 
RIPRISTINA_OFF:
                CMP DX,26
                JAE recover_minusc
                ADD DX,65
                RET
 recover_minusc:ADD DL,71
                RET
;TABELLA ha come indice il suo offset sommato al codice ascii della lettera
;opportunemete traslato
;--------------------------------------------------------------------  
;                   STAMPA CIFRE - INPUT AX=numero 
  STAMPA_CIFRE: 
               
                
                MOV BX,10    
                XOR DX,DX    
                XOR CX,CX   
          loop1:XOR DX,DX   
                DIV BX                      ;divido AX/BX
                PUSH DX     
                INC CX                      ;numero di cifre
                CMP AX, 0                   ;resto
                JNE loop1   
    
          loop2:POP DX      
                ADD DX, 30H     
                MOV AH, 02H     
                INT 21H      
                LOOP loop2  
                
                                          
                RET
;gestisce la stampa dei numeri, anche a più cifre tramite successive
;divisioni per 10.
;--------------------------------------------------------------------                
;       STAMPA TUTTI I VALORI DI TABELLA CON OCCORRENZE >= MAX/2 
;       INPUT BX=OFFSET TABELLA               
   STAMPA_MAX2: 
                MOV AX,MAX
                MOV DL,2
                DIV DL
                CMP AL,0
                JE miss
                CMP AH,0
                JE pari
                ADD AL,1
           pari:CMP [BX],AL
                JL  miss 
                CMP BX,MAX_IND
                JE miss
                
                CALL STAMPA_CHAR 
             
                
                PUSH BX
                PUSH CX
                MOV AX,[BX]
                MOV AH,0
                CALL STAMPA_CIFRE
                POP CX
                POP BX
                
                
                
           miss:INC BX
                LOOP STAMPA_MAX2 
                SUB BX,52 
                MOV CX,52
                RET
;--------------------------------------------------------------------                                   
;               AZZERA TABELLA, INPUT BX=OFFSET TABELLA 
       AZZERA:  
                MOV [BX],0
                INC BX
                LOOP AZZERA
                RET 
;--------------------------------------------------------------------                   
STAMPA_CIFRARIO:
                XOR AX,AX
                XOR BX,BX
                MOV CX,50
                MOV BX,OFFSET prima_riga 
                PUSH BX
                SUB K,1         ;faccio partire K da 0 per calcolo offset,k era inizializzato ad 1.
                XOR BX,BX
                MOV BX,K 
                ADD K,1   
                MOV AL,BL
                MUL CX          ;calcolo successivi offset come [(OFFSET prima_riga) + (50*k)].
                POP BX
                ADD BX,AX       ;sommo all'offset prima riga il nuovo offset come descrito nel commento precedente.
          loop3:CMP [BX],00h    ;se carattere è NULL sicuramente la linea è finita, salto a quella dopo
                JE next_line
                CMP [BX],65     ;se carattere minore di 65 non è alafabetico
                JL  NO_CHAR
                CMP [BX],91     ;se carattere maggiore di 91 controllo ulteriore,altrimenti è maiuscolo
                JAE control
                JMP CHAR_MAIUSC 
        control:CMP [BX],96     ;se carattere maggiore di 96 alfabetico minuscolo altrimenti no alfabetico
                JA CHAR_MINUSC
                JMP NO_CHAR     
         return:inc BX 
                LOOP loop3 
      next_line:
                CALL NEW
                ADD K,1 
                CMP K,5
                JL STAMPA_CIFRARIO
                RET
                
                
                
                
           
        NO_CHAR:
                MOV AH,2
                MOV DL,[BX]
                INT 21H 
                JMP return
    
    CHAR_MAIUSC:
                XOR DX,DX
                MOV DX,[BX]         ;preservo riga in input
                ADD DX,K            
                MOV DH,0
                CMP DX,91           ;verifico se eccedo range minuscole
                JAE JMPTO_MINUSC    ;se eccedo,gestici.
                MOV AH,2
                INT 21H 
                JMP return
    CHAR_MINUSC:
                XOR DX,DX
                MOV DX,[BX]         ;preservo riga in input
                ADD DX,K
                MOV DH,0
                CMP DX,123          ;verifico se eccedo range maiuscola
                JAE JMPTO_MAIUSC    ;se eccedo, gestisci.
                MOV AH,2
                INT 21H
                JMP return     
                
 
     JMPTO_MINUSC:                  ;GESTISCE IL CASO IN CUI SOMMANDO K SFORO IL RANGE DELLE LETTERE MAIUSCOLE
                    SUB DX,91       ;calcolo di quanto eccedo dal range
                    ADD DX,97       ;sommo l'eccedenza alla prima lettera minuscola
                    MOV AH,2   
                    INT 21H
                    JMP return
                   
         
                   
     JMPTO_MAIUSC:                  ;GESTISCE IL CASO IN CUI SOMMANDO K SFORO IL RANGE DELLE LETTERE MINUSCOLE
                    SUB DX,123      ;calcolo di quanto eccedo dal range
                    ADD DX,65       ;sommo l'eccedenza alla prima lettere maiscola
                    MOV AH,2   
                    INT 21H
                    JMP return
                 
     DOUBLE_NEW:                    ;VA A CAPO DI DUE RIGHE
              XOR AX,AX
              XOR DX,DX
              MOV AH,2
              MOV DL,10
              INT 21H
              INT 21H
              MOV DL,13
              INT 21H
              RET  
              
              
        NEW:                        ;VA A CAPO DI UNA RIGA
              XOR AX,AX
              XOR DX,DX
              MOV AH,2
              MOV DL,10
              INT 21H
              MOV DL,13
              INT 21H
              RET  
                  
          
          FINE:   CALL STAMPA_CIFRARIO  
                  HLT
.EXIT
END