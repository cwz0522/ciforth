dnl  $Id$  M4 file to handle siwtching from to preotected mode
dnl Copyright(2000): Albert van der Horst, HCC FIG Holland by GNU Public License
divert(-1)
_BITS16_1_( {define({IDENTIFY_PROT},{IDENTIFY_16})})
_BITS32_1_( {define({IDENTIFY_PROT},{IDENTIFY_32})})
define({JMPHERE_FROM_PROT},{
        JMPFAR
	DC      $+2+CW-CS_START+SWITCH_START
        DW      GDT_SWITCH
	MOV EAX,CR0
	DEC AL  
	MOV CR0,EAX            ;set real mode
dnl The curly brackets prevent AX to be expanded to EAX
        BITS 16
        MOV     {AX},REALSEGMENT
        MOV     DS,{AX}
        MOV     ES,{AX}
        MOV     SS,{AX}
        STI
        _BITS32_1_({BITS 32})
})dnl
define({JMPHERE_FROM_REAL},{
        CLI
	MOV EAX,CR0
	INC AL  
	MOV CR0,EAX            ;set protected mode
        JMPFAR
	DW      $+4-SWITCH_START+CS_START
        DW      GDT_CS   
        MOV     AX,GDT_DS
        MOV     DS,AX
        MOV     ES,AX                       
        MOV     SS,AX
})dnl     
divert{}dnl

