; 
;
;
; Simple Test probgam, transmites "Hello World"
;
;

org #8000

include "drtlib01.asm"
include "ctclib01.asm"

    ;Setup the CTC
    CTC_Def_Addr #F9E0
    CTC_Def_CW 1,1,1,0,1,0,1,0
    CTC_init 0,12

    ;Setup the DART
    DRT_Def_Addr #FBE0
    DRT_init DRT_CHANNEL_A, DRT_WR4_NO_PARITY, DRT_WR4_1_STOP_BIT, DRT_WR4_X16, DRT_WR3_RX_8_BITS, DRT_WR5_TX_8_BITS, DRT_WR1_DISABLE_ALL_INT

    ;Transmit String
    DTR_Tx_Str_Polled_mode DRT_CHANNEL_A, TxStr

ret 

    TxStr:
    DEFB "HELLO WORLD",0

save 'drttst01.bin',#8000,1300,DSK,'drttst01.dsk'




