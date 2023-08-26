;
;    DRT_Def_Addr   Define DART Channel Addresses
;    DRT_Def_WR0    Define DART Write Register 0
;    DRT_Def_WR4    Define DART Write Register 4
;    DRT_Init       Initialise a DART Channel
;

DRT_A_DATA_ADDR=#FBE0 ; Channel A Data Address 
DRT_A_CTRL_ADDR=#FBE2 ; Channel A Control Address
DRT_B_DATA_ADDR=#FBE1 ; Channel B Data Address
DRT_B_CTRL_ADDR=#FBE4 ; Channel B Control Address

; Write Registers
DRT_WR0=0 ; Command Register
DRT_WR1=0 ; Interrupt Register
DRT_WR3=0 ; Rx Register
DRT_WR4=0 ; Rx and TX Control
DRT_WR5=0 ; Tx Register

; Read Registers
DRT_RR0=0 ; Status Register

; Channel Selection
DRT_CHANNEL_A=0
DRT_CHANNEL_B=1



; WR0 Command Definitions
DRT_WR0_NULL_COMMAND=0
DRT_WR0_RESET=3

; WR1 Interrupt Definitions
DRT_WR1_DISABLE_ALL_INT=0

; WR3 Rx Enable
DRT_WR3_RX_ENABLE=1
DRT_WR3_RX_DISABLE=0

; WR3 Auto Enable
DRT_WR3_AUTO_ENABLE=1
DRT_WR3_AUTO_ENABLE=0

; WR3 RX Bits Per Char
DRT_WR3_RX_5_BITS=0
DRT_WR3_RX_7_BITS=1
DRT_WR3_RX_6_BITS=1
DRT_WR3_RX_8_BITS=3

; Parity Definitions in WR4
DRT_WR4_NO_PARITY=0
DRT_WR4_EVEN_PARITY=1
DRT_WR4_ODD_PARITY=3

; Stop Bit Definitions in WR4
DRT_WR4_1_STOP_BIT=1
DRT_WR4_1_PLUS_HALF_STOP_BITS=2
DRT_WR4_2_STOP_BITS=3

; Clock Mode Definitions in WR4
DRT_WR4_X1=0
DRT_WR4_X16=1
DRT_WR4_X32=2
DRT_WR4_X64=3

; WR5 Tx Enable
DRT_WR5_TX_ENABLE=1
DRT_WR5_TX_DISABLE=0

; WR5 TX Bits Per Char
DRT_WR5_TX_5_BITS=0
DRT_WR5_TX_7_BITS=1
DRT_WR5_TX_6_BITS=1
DRT_WR5_TX_8_BITS=3


; RR0 Status Bits
DRT_RR0_TX_BUFFER_EMPTY_BIT=2
DRT_RR0_RX_CHAR_AVAIL_BIT=0


; DRT_Def_Addr
;    In : Addr
;
;    Defines the adress of DRT Control and Data Channels
;
macro DRT_Def_Addr Addr

    DRT_A_DATA_ADDR={Addr}   ; Channel A Data Address 
    DRT_A_CTRL_ADDR={Addr}+2 ; Channel A Control Address
    DRT_B_DATA_ADDR={Addr}+1 ; Channel B Data Address
    DRT_B_CTRL_ADDR={Addr}+4 ; Channel B Control Address
    
    print "DRT INF CHANNEL A DATA ADDR", {hex4}DRT_A_DATA_ADDR
    print "DRT INF CHANNEL A CTRL ADDR", {hex4}DRT_A_CTRL_ADDR
    print "DRT INF CHANNEL B DATA ADDR", {hex4}DRT_B_DATA_ADDR
    print "DRT INF CHANNEL B CTRL ADDR", {hex4}DRT_B_CTRL_ADDR
mend

; DRT_Def_WR0
;
;    Description: Defines Write Register 0
;
;    IN:
;       REG 
;       CMD 
;
macro DRT_Def_WR0 REG,CMD

    DRT_WR0 = ({CMD}<<3)+{REG}

    print "DRT INF WR0",{hex2}DRT_WR0
    print "DRT INF WR0 REG",{int}{REG}

    if {CMD}==DRT_WR0_RESET
        print "DRT INF WR0 CHANNEL RESET"
    endif
    
mend

; DRT_Def_WR1
;
;   Description: Defines Write Register 1
;
;   IN:
;       INTER
;
macro DRT_Def_WR1 INTER

    DRT_WR1={INTER}

    print "DRT INF WR1",{hex2}DRT_WR1

    switch {INTER}
        case DRT_WR1_DISABLE_ALL_INT    : print "DRT INF WR1 All Interrupts Disabled" : break
        default                         : print "DRT ERR WR1 Bad Interrupt Definition"
    endswitch
mend

; DRT_Def_WR3
;
;   Description: Define Write Register 3
;
;  IN:
;       RXBITS
;
macro DRT_Def_WR3 RXBITS

    DRT_WR3 = ({RXBITS}<<6)+DRT_WR3_RX_ENABLE

    print "DRT INF WR3",{hex2}DRT_WR3

    switch {RXBITS}
        case DRT_WR3_RX_5_BITS     : print "DRT INF WR3 RX 5 BITS"     : break
        case DRT_WR3_RX_6_BITS     : print "DRT INF WR3 RX 6 BITS"     : break
        case DRT_WR3_RX_7_BITS     : print "DRT INF WR3 RX 7 BITS"     : break
        case DRT_WR3_RX_8_BITS     : print "DRT INF WR3 RX 8 BITS"     : break
        default                    : print "DRT ERR WR3 Bad Rx Bits Definition"
    endswitch

mend

; DRT_Def_WR4
; 
; Description: Defines Write Register 4
;
; IN:
;  PARITY  
;  STOP   
;  CLOCK     
;    
macro DRT_Def_WR4 PARITY,STOP,CLOCK_MODE

    DRT_WR4 = ({CLOCK_MODE}<<6)+({STOP}<<2)+{PARITY}

    print "DRT INF WR4",{hex2}DRT_WR4

    switch {PARITY}
        case DRT_WR4_NO_PARITY     : print "DRT INF WR4 NO PARITY"     : break
        case DRT_WR4_EVEN_PARITY   : print "DRT INF WR4 EVEN PARITY"   : break
        case DRT_WR4_ODD_PARITY    : print "DRT INF WR4 ODD PARITY"    : break
        default                    : print "DRT ERR WR4 Bad Parity Definition"
    endswitch

    switch {STOP}
        case DRT_WR4_1_STOP_BIT             : print "DRT INF WR4 1 STOP BIT"        : break
        case DRT_WR4_1_PLUS_HALF_STOP_BITS  : print "DRT INF WR4 1 1/2 STOP BITS"   : break
        case DRT_WR4_2_STOP_BITS            : print "DRT INF WR4 2 STOP BITS"       : break
        default                             : print "DRT ERR WR4 Bad Stop Bit Definition"
    endswitch
    
    switch {CLOCK_MODE}
        case DRT_WR4_X1     : print "DRT INF WR4 CLOCK MODE X1"     : break
        case DRT_WR4_X16    : print "DRT INF WR4 CLOCK MODE X16"    : break
        case DRT_WR4_X32    : print "DRT INF WR4 CLOCK MODE X32"    : break
        case DRT_WR4_X64    : print "DRT INF WR4 CLOCK MODE X64"    : break
        default             : print "DRT ERR WR4 Bad Clock Mode Definiton"
    endswitch

mend

; DRT_Def_WR5
;
;   Description: Define Write Register 5
;
;  IN:
;       TXBITS
;
macro DRT_Def_WR5 TXBITS

    DRT_WR5 = ({TXBITS}<<5)+(DRT_WR5_TX_ENABLE<<3)

    print "DRT INF WR5",{hex2}DRT_WR5

    switch {TXBITS}
        case DRT_WR5_TX_5_BITS     : print "DRT INF WR5 TX 5 BITS"     : break
        case DRT_WR5_TX_6_BITS     : print "DRT INF WR5 TX 6 BITS"     : break
        case DRT_WR5_TX_7_BITS     : print "DRT INF WR5 TX 7 BITS"     : break
        case DRT_WR5_TX_8_BITS     : print "DRT INF WR5 TX 8 BITS"     : break
        default                    : print "DRT ERR WR5 Bad Tx Bits Definition"
    endswitch

mend


; DRT_Init
;
;    Description: Initialise the DART Channel
;
;    IN:    CHAN
;           PARITY
;           STOP
;           CLOCK_MODE
;           RXBITS
;           TXBITS
;           INTER
;
macro DRT_Init CHAN,PARITY,STOP,CLOCK_MODE,RXBITS,TXBITS,INTER

    switch {CHAN}
        case DRT_CHANNEL_A 
            ld bc,DRT_A_CTRL_ADDR
            print "DRT INF INIT CHANNEL A"
            break
        case DRT_CHANNEL_B
            ld bc,DRT_B_CTRL_ADDR 
            print "DRT INF INIT CHANNEL B"
        default
            print "DRT ERR Bad Channel Selected"
    endswitch
    
    ; Reset Channel
    DRT_Def_WR0 0,DRT_WR0_RESET
    ld a,DRT_WR0
    out (c),a

    ; Select WR4
    DRT_Def_WR0 4,DRT_WR0_NULL_COMMAND
    ld a,DRT_WR0
    out (c),a
    
    ; Write to WR4
    DRT_Def_WR4 {PARITY},{STOP},{CLOCK_MODE}
    ld a,DRT_WR4
    out (c),a

    ; Select WR3
    DRT_Def_WR0 3,DRT_WR0_NULL_COMMAND
    ld a,DRT_WR0
    out (c),a

    ; Write to WR3
    DRT_Def_WR3 {RXBITS}
    ld a,DRT_WR3
    out (c),a

    ; Select WR5
    DRT_Def_WR0 5,DRT_WR0_NULL_COMMAND
    ld a,DRT_WR0
    out (c),a

    ; Write to WR5
    DRT_Def_WR5 {TXBITS}
    ld a,DRT_WR5
    out (c),a

    ; Select WR1
    DRT_Def_WR0 1,DRT_WR0_NULL_COMMAND
    ld a,DRT_WR0
    out (c),a

    ; Write to WR1
    DRT_Def_WR1 {INTER}
    ld a,DRT_WR1
    out (c),a
    
mend


; DRT_Tx_Str_Polled_Mode
; 
;   Description: Writes a string from a channel in polled mode
; 
;   IN:
;       CHAN
;       TXSTRING
;
macro DTR_Tx_Str_Polled_Mode CHAN, TXSTR

    push hl

    ld hl,{TXSTR} ; load the address of the string to transmit

    CheckTxBufferStatus:
    switch {CHAN}
        case DRT_CHANNEL_A 
            ld bc,DRT_A_CTRL_ADDR
            print "DRT INF TX CHANNEL A"
            break
        case DRT_CHANNEL_B
            ld bc,DRT_B_CTRL_ADDR 
            print "DRT INF TX CHANNEL B"
        default
            print "DRT ERR Bad Channel Selected"
    endswitch

    TxBufferStatusLoop:
        in a,(c)
        bit DRT_RR0_TX_BUFFER_EMPTY_BIT,a ; Wait for transmit buffer to be empty
        jp z,TxBufferStatusLoop

    switch {CHAN}
        case DRT_CHANNEL_A 
            ld bc,DRT_A_DATA_ADDR
            print "DRT INF TX CHANNEL A"
            break
        case DRT_CHANNEL_B
            ld bc,DRT_B_DATA_ADDR 
            print "DRT INF TX CHANNEL B"
        default
            print "DRT ERR Bad Channel Selected"
    endswitch

    ld a,(hl) ; load the string to transmit

    or a
    jp z,EndofStr ; is it the end of the string (0)
    
    out (c),a ; Transmit the character

    inc hl ; move to next character
    jp CheckTxBufferStatus

    EndofStr:
    
    pop hl
mend

; DRT_Rx_Char_polled_mode CHAN, RXCHAR
;
;   Description: Reads a chararacter from a channel in polled mode
;
;   IN:
;       CHAN: Channel
;       RXCHAR: Address to put character
;
macro DRT_Rx_Char_Polled_Mode CHAN, RXCHAR

    CheckRxBufferStatus:
    switch {CHAN}
        case DRT_CHANNEL_A 
            ld bc,DRT_A_CTRL_ADDR
            print "DRT INF TX CHANNEL A"
            break
        case DRT_CHANNEL_B
            ld bc,DRT_B_CTRL_ADDR 
            print "DRT INF TX CHANNEL B"
        default
            print "DRT ERR Bad Channel Selected"
    endswitch

    RxBufferStatusLoop:
        in a,(c)
        bit DRT_RR0_RX_CHAR_AVAIL_BIT,a ; Is a character available?
        jp z,RxBufferStatusLoop


   switch {CHAN}
        case DRT_CHANNEL_A 
            ld bc,DRT_A_DATA_ADDR
            print "DRT INF TX CHANNEL A"
            break
        case DRT_CHANNEL_B
            ld bc,DRT_B_DATA_ADDR 
            print "DRT INF TX CHANNEL B"
        default
            print "DRT ERR Bad Channel Selected"
    endswitch

    in a,(C) ;Read a Char

    ld ({RXCHAR}),a
 
mend

; DRT_Tx_Char_polled_mode
; 
;   Description: Writes a chararacter from a channel in polled mode
; 
;   IN:
;       CHAN
;       TXSTRING
;
macro DRT_Tx_Char_Polled_Mode CHAN, TXCHAR

    CheckTxBufferStatus:
    switch {CHAN}
        case DRT_CHANNEL_A 
            ld bc,DRT_A_CTRL_ADDR
            print "DRT INF TX CHANNEL A"
            break
        case DRT_CHANNEL_B
            ld bc,DRT_B_CTRL_ADDR 
            print "DRT INF TX CHANNEL B"
        default
            print "DRT ERR Bad Channel Selected"
    endswitch

    TxBufferStatusLoop:
        in a,(c)
        bit DRT_RR0_TX_BUFFER_EMPTY_BIT,a ; Wait for transmit buffer to be empty
        jp z,TxBufferStatusLoop

    switch {CHAN}
        case DRT_CHANNEL_A 
            ld bc,DRT_A_DATA_ADDR
            print "DRT INF TX CHANNEL A"
            break
        case DRT_CHANNEL_B
            ld bc,DRT_B_DATA_ADDR 
            print "DRT INF TX CHANNEL B"
        default
            print "DRT ERR Bad Channel Selected"
    endswitch

    ld a,({TXCHAR}) ; load the chararacter to transmit

    out (c),a ; Transmit the character

mend
