;                           LABORATORIO 2
;   1)  per comodità la prima matrice è stata salvata per righe mentre
;       la seconda per colonne.

;   2)  Non viene richiesta gestione INPUT/OUTPUT

;   3)  OVERFLOW si può verificare solo durante somma, durante la moltiplicazione
;       no perchè 8x8, sicuramente esprimibile su 16 bit.

;   4)  Sono presenti due inizializzazioni, una genera overflow l'altra no.
;       1: prima inizializzaione
;       2: seconda inizializzazione
;       Modificare prima N,M,P e la dimensione delle matrici.
;       N,M,P settate di default per configurazione 2.


.MODEL small                 
.STACK                        
.DATA
    N EQU 4         ;righe matrice1         ;valori per matrice OVERFLOW
    M EQU 7         ;colonne matrice1
    P EQU 5         ;colonne matrice 2
    MATRICE1 DB 28 DUP (?)
    MATRICE2 DB 35 DUP (?)
    RISULTATO DW 20 DUP (?)
    

  


.CODE
.STARTUP


;JE  NO_OF
JMP OF
;-------------------------------------------
;          NO OVERFLOW
NO_OF:  
    MOV MATRICE1,4
    MOV MATRICE1+1,-3
    MOV MATRICE1+2,5
    MOV MATRICE1+3,1
    MOV MATRICE1+4,3
    MOV MATRICE1+5,-5
    MOV MATRICE1+6,0
    MOV MATRICE1+7,11
    MOV MATRICE1+8,-5
    MOV MATRICE1+9,12
    MOV MATRICE1+10,4
    MOV MATRICE1+11,-5
    
    MOV MATRICE2,-2
    MOV MATRICE2+1,5
    MOV MATRICE2+2,4
    MOV MATRICE2+3,9
    MOV MATRICE2+4,3
    MOV MATRICE2+5,-1
    MOV MATRICE2+6,3
    MOV MATRICE2+7,-7
    
    MOV RISULTATO,0
    MOV RISULTATO+2,0
    MOV RISULTATO+4,0
    MOV RISULTATO+6,0
    MOV RISULTATO+8,0
    MOV RISULTATO+10,0
    JMP READY
;---------------------------------------------
;                   OVERFLOW

OF:
    MOV MATRICE1+0,3
    MOV MATRICE1+1,14
    MOV MATRICE1+2,-15
    MOV MATRICE1+3,9
    MOV MATRICE1+4,26
    MOV MATRICE1+5,-53
    MOV MATRICE1+6,5
    MOV MATRICE1+7,89
    MOV MATRICE1+8,79
    MOV MATRICE1+9,3
    MOV MATRICE1+10,23
    MOV MATRICE1+11,84
    MOV MATRICE1+12,-6
    MOV MATRICE1+13,26
    MOV MATRICE1+14,43
    MOV MATRICE1+15,-3
    MOV MATRICE1+16,83
    MOV MATRICE1+17,27
    MOV MATRICE1+18,-9
    MOV MATRICE1+19,50
    MOV MATRICE1+20,28
    MOV MATRICE1+21,-88
    MOV MATRICE1+22,41
    MOV MATRICE1+23,97
    MOV MATRICE1+24,-103
    MOV MATRICE1+25,69
    MOV MATRICE1+26,39
    MOV MATRICE1+27,-9
    
    
    MOV MATRICE2,37
    MOV MATRICE2+1,9
    MOV MATRICE2+2,-23
    MOV MATRICE2+3,0
    MOV MATRICE2+4,9
    MOV MATRICE2+5,82
    MOV MATRICE2+6,70
    MOV MATRICE2+7,-101
    MOV MATRICE2+8,74
    MOV MATRICE2+9,90
    MOV MATRICE2+10,-62
    MOV MATRICE2+11,86
    MOV MATRICE2+12,5
    MOV MATRICE2+13,-67
    MOV MATRICE2+14,0
    MOV MATRICE2+15,94
    MOV MATRICE2+16,-78
    MOV MATRICE2+17,86
    MOV MATRICE2+18,28
    MOV MATRICE2+19,34
    MOV MATRICE2+20,9
    MOV MATRICE2+21,58
    MOV MATRICE2+22,-4
    MOV MATRICE2+23,16
    MOV MATRICE2+24,20
    MOV MATRICE2+25,0
    MOV MATRICE2+26,-21
    MOV MATRICE2+27,82
    MOV MATRICE2+28,-20
    MOV MATRICE2+29,59
    MOV MATRICE2+30,-4
    MOV MATRICE2+31,89
    MOV MATRICE2+32,-34
    MOV MATRICE2+33,1
    MOV MATRICE2+34,14
   
    MOV RISULTATO,0
    MOV RISULTATO+2,0
    MOV RISULTATO+4,0
    MOV RISULTATO+6,0
    MOV RISULTATO+8,0
    MOV RISULTATO+10,0
    MOV RISULTATO+11,0
    MOV RISULTATO+12,0
    MOV RISULTATO+13,0
    MOV RISULTATO+14,0
    MOV RISULTATO+15,0
    MOV RISULTATO+16,0
    MOV RISULTATO+17,0
    MOV RISULTATO+18,0
    MOV RISULTATO+19,0
    MOV RISULTATO+20,0
  

;---------------------------------------------
   
READY:
XOR SI,SI
XOR DI,DI
XOR AX,AX
XOR BX,BX
XOR DX,DX

MOV DI,OFFSET MATRICE1
MOV BX,OFFSET MATRICE2

MOV CX,N 

loop3: ;itera su tutte le righe della prima matrice
    PUSH CX
    MOV CX,P
    loop2:;itera su tutte le colonne della seconda matrice  
        PUSH CX                     
        MOV CX,M   
         loop1:;esaurisce moltiplicazioni/somme
            MOV AL,[DI]     ;elemento riga matrice1
            IMUL [BX]       ;elemento riga x elemento colonna                
            ADD DX,AX       ;somma a risultato parziale in DX
            JO OVERFLOW
       back:XOR AX,AX
            ADD BX,1        ;elemento successivo della riga
            ADD DI,1        ;elemento succcessivo della colonna
            LOOP loop1
            POP CX
            
            
        SUB DI,M            ;ritorno inizio riga 
        ;BX GIA SU COLONNA SUCCESSIVA,MATRICE2 salvata per colonne
        MOV RISULTATO+SI,DX
        XOR DX,DX           ;azzera somma parziale
        INC SI
        INC SI
        LOOP loop2
        POP CX
        
        
     
     ADD DI,M                ;passo a riga successiva
     MOV BX,OFFSET MATRICE2  ;ritorno a prima colonna
     LOOP loop3
     HLT
            
     OVERFLOW: CMP DX,0
               JL NEGATIVO
               MOV DX,-32768
               JMP back
      negativo:MOV DX,32767
               JMP back
               
           



.EXIT
END