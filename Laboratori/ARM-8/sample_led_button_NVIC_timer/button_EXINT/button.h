void BUTTON_init(void);

void EINT1_IRQHandler(void);
void EINT2_IRQHandler(void);
void EINT3_IRQHandler(void);

extern int sequenceComplete;									/* 0 perso, 1 vinto */
extern int state;
extern int sequence[10];
extern int ciclo;
extern int CurrentBounce;
extern int end;
extern int PreviousBounce;