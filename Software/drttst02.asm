;
;
; Simple Test probgam, loopsback and received characters until "Q" is entered.
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

    GetCharLoop:
        ;Wait for a Char
        DRT_Rx_Char_Polled_mode DRT_CHANNEL_A,CharBuffer
        ;Loop it back
        DRT_Tx_Char_Polled_Mode DRT_CHANNEL_A,CharBuffer

        ;Quit on "Q"
        ld a,(Charbuffer)
        cp a,"Q"
        jp nz, GetCharLoop
    
ret 

    CharBuffer:
    DEFB "X"

save 'drttst02.bin',#8000,1300,DSK,'drttst02.dsk'




