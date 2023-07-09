;
;    CTC_Def_Addr   Define CTC Addr
;    CTC_Def_CW     Define CTC Control Word
;    CTC_Init       Load Time Constant and Inititialise Channel
;

CTC_C0=#F9E0
CTC_C1=CTC_C0+1
CTC_C2=CTC_C1+1
CTC_C3=CTC_C2+1

CTC_CW=#00

; CTC_Def_Addr
;    In : Addr
;
;    Defines the adress of CTC Channels
;
macro CTC_Def_Addr Addr

    CTC_C0={Addr}         // Channel 0 Address
    CTC_C1=CTC_C0 + 1     // Channel 1 Address
    CTC_C2=CTC_C1 + 1     // Channel 2 Address
    CTC_C3=CTC_C2 + 1     // Channel 3 Address
    
    print 'CTC C0', {hex4}CTC_C0
    print 'CTC C1', {hex4}CTC_C1
    print 'CTC C2', {hex4}CTC_C2
    print 'CTC C3', {hex4}CTC_C3
mend

; CTC_Def_CW
;
;    Description: Defines the CTC Control Register
;
;    IN:
;       INTEN    = bit  7 Interrupt             1 = Enabled                                         0 = Disabled
;       MODE     = bit  6 Mode                  1 = Counter                                         0 = Timer
;       PS*      = bit  5 PreScaler             1 = Divide by 256                                   0 = Divide by 16
;       TRIGE    = bit  4 Positive Edge         1 = Postive Edge Starts Timer or Counter            0 = Negative Edge
;       TRIG     = bit  3 Trigger               1 = Start on External Trigger                       0 = Start when Time Constant is loaded
;       TCF      = bit  2 Time Constant Follows 1 = Next Byte is a Time constant
;       CHANRES  = bit  1 Channel Reset         1 = Reset
;       CR       = bit  0 Control Register      1 = this is a Control Register Byte
;
macro CTC_Def_CW CR,CHANRES,TCF,TRIG,TRIGE,PS,MODE,INTEN

    CTC_CW = ({INTEN} << 7) + ({MODE} << 6) + ({PS} << 5) + ({TRIGE} << 4) + ({TRIG} << 3) + ({TCF} << 2) + ({CHANRES}  << 1) + {CR}

    print 'CTC CW',{hex2}CTC_CW

    if {CR}==1
        print 'Bit 0 = 1 Control Register Byte'
    endif
    
    if {CHANRES}==1 
        print 'Bit 1 = 1 Channel Reset, Stop Counting and Resume when time Constant is loaded' 
    endif

    if {TCF}==1
        print 'Bit 2 = 1 Time Constant to follow'
    endif
       
    if {TRIG}==1
        print 'Bit 3 = 1 External Trigger'
    else
        print 'Bit 3 = 0 Start as soon as Time Constant is loaded'
    endif
    
    if {TRIGE}==1
        print 'Bit 4 = 1 Use Positive Edge'
    else
        print 'Bit 4 = 0 Use Negative Edge'
    endif

    if {PS}==1
        print 'Bit 5 = 1 Divide by 256'
    else
        print 'Bit 5 = 0 Devide by 16'
    endif

    if {MODE}==1
        print 'Bit 6 = 1 Channel is Counter'
    else
        print 'Bit 6 = 0 Channel is Timer'
    endif
    
    if {INTEN}==1
        print 'Bit 7 = 1 Interrupt Enabled'
    else
        print 'Bit 7 = 0 Interrupt Disabled'
    endif

mend

; CTC_Init
;
;    Description: Initialise the CTC Channel
;
;    IN: None
;
macro CTC_Init CHAN,TC

    defb {TC}

    if {CHAN}==0 
        ld bc,CTC_C0
    endif
    if {CHAN}==1
        ld bc,CTC_C1
    endif
    if {CHAN}==2
        ld bc,CTC_C2
    endif
    if {CHAN}==3
        ld bc,CTC_C3
    endif
    
    ld a,CTC_CW
    out (c),a
    
    if {TC}!=0
        ld a,{TC}
        out (c),a
    endif

    print 'Time Constant = ',{hex2}{TC}

mend

