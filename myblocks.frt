         9 1 DO I J ! 5 SPACES ( eerst wat spaties)                             9 1 DO 9 J @ - I BORD @ EMIT SPACE LOOP CR                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       <HEX ( DEBUG SCR#7 )                                           :  DUMP2   ( SEG ADDRESS AMOUNT - ..)                               OVER + SWAP FFF0 AND                                            DO                                                                  CR DUP H. I H. ." : "                                           I                                                               10 0 DO                                                             2DUP I + L@ B.                                                  I 2 MOD IF SPACE THEN                                       LOOP  &| EMIT                                                   10 0 DO 2DUP I + L@ FF AND TO-PRINT EMIT LOOP                   &| EMIT DROP                                                10 +LOOP CR DROP                                            ;    HEX>                                                                                                                                                                                        ( : GET-S   10 0 DO I A-L F000 I 80 * + SWAP CMOVE LOOP ;       : PUT-S   10 0 DO F000 I 80 * + I A-L UPDATE CMOVE LOOP ;       : CLEAN   F800 F000 DO I C@ 7F AND I C! LOOP ;                  : E-S     0 I-STATE !  HOME GET-S XX CLEAN PUT-S HOME ;         : EDIT SCR ! E-S ; ) : L-S SCR @ LIST ; : LO-S SCR @ LOAD ;     : INIT-STAR 1B 5 BDOS . 43 5 BDOS . 42 5 BDOS .                             1B 5 BDOS . 4E 5 BDOS . 4 5 BDOS . ;                : LAST-SEC ( 0/1 LEAVES ONE MORE THAN THE LAST BLOCK NR)            0 BEGIN 1+ F000 OVER 1 R/W DISK-ERROR @ UNTIL               ;                                                               : EXTEND   ( 1/0 EXTENDS # BLOCKS WITH NUMBER-1 )                 8 * LAST-SEC HOME ( GET AMOUNT OF BLOCKS)                       SWAP OVER + SWAP DO F000 I 0 R/W LOOP                           FCB 10 BDOS DROP    ( CLOSE THE FILE,I.E. UPDATE DIRECTORY)     FCB 0F BDOS DROP    ( OPEN AGAIN  )                           ;   DECIMAL                                                    ( Elementary string: $@ $! $=          A0jul16-AH)               : $@ COUNT ;     : $. TYPE ;  : C+! >R R @ + R> ! ;             : $! ( address, count,string -.)                                  OVER OVER C! 1+ SWAP CMOVE     ;                              : $C+ ( C,$-. append the character to the string $ )               SWAP OVER $@ + C!  1 SWAP C+! ;                              : $+!  ( $T,$C,$-. Append $C char's from $T to $)                  DUP C@ >R ( Keep old length )  2DUP C+! ( Adjust length)        1 + R> + SWAP CMOVE  ;                                      ( HANDY & Preparation for ANSI-fication)                        : PARSE WORD HERE $@ ;                                          : S" &" PARSE 2DUP ( fig: already HERE) 1+ ALLOT DROP ;         : STRING <BUILDS S" DROP DROP DOES> $@ ;                        : TEST ." WE GAAN NAR ROME" ; OK                                                                                                                                                                 ( ERROR MESSAGES   )                                            MSG # 1 : EMPTY STACK                                           MSG # 2 : DICTIONARY FULL                                       MSG # 3 : HAS INCORRECT ADDRESS MODE                            MSG # 4 : ISN'T UNIQUE                                                                                                          MSG # 6 : DISK RANGE ?                                          MSG # 7 : FULL STACK                                            MSG # 8 : DISC ERROR !                                                                                                                                                                                                                                                                                                                                                                          MSG # 14 : SAVE/RESTORE MUST RUN FROM FLOPPY                    ( FIG FORTH FOR CP/M 2.0 ADAPTED BY A. VD HORST HCCH )          ( ERROR MESSAGES   )                                            MSG # 17 : COMPILATION ONLY, USE IN DEFINITION                  MSG # 18 : EXECUTION ONLY                                       MSG # 19 : CONDITIONALS NOT PAIRED                              MSG # 20 : DEFINITION NOT FINISHED                              MSG # 21 : IN PROTECTED DICTIONARY                              MSG # 22 : USE ONLY WHEN LOADING                                MSG # 23 : OFF CURRENT EDITING SCREEN                           MSG # 24 : DECLARE VOCABULARY                                   MSG # 25 : LIST EXPECTS DECIMAL                                                                                                                                                                                                                                                                                                                                                                                                                                  (  DEBUG   SCR#6)    0 VARIABLE BASE'                          : <HEX   BASE @ BASE' ! HEX ;       ( 0/1  SWITCH TO HEX)       : HEX>   BASE' @ BASE !     ;       ( 1/0  AND BACK)            (        1/0  PRINT IN HEX REGARDLESS OF BASE)                  : H.     <HEX 0 <# # # # # #> TYPE SPACE HEX> ;                 (        1/0  IDEM FOR A SINGLE BYTE)                           : B.     <HEX 0 <# # # #> TYPE HEX> ;                           : BASE?  BASE @ H. ;                ( 0/0 TRUE VALUE OF BASE)   : ^      ( 0/0 NON DESTRUCTIVE STACK PRINT)                              CR ." S: " SP@ S0 @ ( FIND LIMITS)                              BEGIN OVER OVER = 0=                                            WHILE 2 - DUP @ H.                                              REPEAT                                                          DROP DROP                                              ;                                                                                                                               <HEX ( DEBUG SCR#7 )                                            : TO-PRINT DUP DUP BL < SWAP 7F > OR IF DROP &. THEN ;          : CHARS  &| EMIT 0 DO DUP I + C@ TO-PRINT EMIT LOOP                   &| EMIT ;                                                 : BYTES 0 DO                                                               DUP I + C@ B.                                                   I 2 MOD IF SPACE THEN                                       LOOP ;                                                  :  DUMP   ( 2/0  DUMPS FROM ADDRESS-2 AMOUNT-1 BYTES)               OVER + SWAP                                                     DO                                                                  CR I H. ." : "                                                  I 0F AND DUP 5 2 */ SPACES 10 SWAP -                            I   OVER BYTES   OVER CHARS   DROP DROP                     10 I 0F AND - +LOOP         CR                              ;    HEX>                                                        ." SYSTEM ELECTIVE CP/M FIGFORTH EXTENSIONS 84AUG12 AH"         ( MAINTENANCE )  100 LOAD 32 LOAD                               ( HEX CHAR DUMP)  6 LOAD 30 LOAD 7 LOAD 1 LOAD ( i.a. editor)   ( STRING         36 LOAD 37 LOAD )                              ( EDITOR )       101 105 THRU 107 LOAD 106 LOAD                 ( CP/M READ WRITE LOAD    15 LOAD 18 LOAD 21 LOAD 21: BUGS)     ( KRAKER )        10 LOAD                                       ( NEW SYSTEM      23 LOAD   )                                   ( CRC             71 LOAD   )                                   ( ASSEMBLER 8080  74 LOAD ) ( 8086) 96 LOAD                     ( STAR PRINTER    31 LOAD   )                                   ( CP/M CONVERT    80 LOAD   )                                   WARNING 1 TOGGLE                                                                                                                                                                                                                                                ." QUADRUPLE ARITHMETIC 08-02-84 "                              : ADC ( n1,n2-n,c  add, leave sum and carry)                       0 SWAP 0 D+ ;                                                : 2M+ ( d1,d2-d,c  add double )                                   >R SWAP >R    ADC R> ADC   R> SWAP >R                           ADC R> + ;                                                    : 3M+ ROT >R 2M+ R> ADC ;                                       : 4M+ ROT >R 3M+ R> ADC ;                                       : 2U*  ( d1,d2-q unsigned product)                              ROT ( l1,l2,h2,h1)    OVER OVER U* >R >R ^                      ROT ( l1,h2,h1,l2)    OVER OVER U* >R >R ^                      SWAP DROP ROT ROT ( l2,l1,h2) OVER OVER U* >R >R ^              DROP ( l1,l2)    U* ^ R> ADC ^ R> ADC ^                          IF ( carry) R> R> 2M+ 1+ ." C" ELSE                                         R> R> 2M+    ." NC" THEN  ^                         R> R> 2M+ DROP ^ ;                                             CR ." 84NOV22  FORTH KRAKER >1<  ALBERT VAN DER HORST "         0 VARIABLE SELTAB 120 ALLOT   SELTAB VARIABLE SELTOP            : T,  ( N--. Put N in select table)                                 SELTOP @ !  2 SELTOP +!  ;                                  : CFOF ( --N Get cfa of word following )                           [COMPILE] ' CFA ;                                            : C->P 2 + ; ( N--N Converteer cfa naar pfa )                   : ID.. C->P NFA ID. ; ( cfa--. Print a words name )             : SEL@    ( N--M,F F="value N present in table" )                  ( if F then M is vector address else M=N)                          0 SWAP ( initialise flag)                                       SELTOP @ SELTAB DO                                                  DUP I @ = IF ( FOUND!) DROP DROP 1 I 2+ @ THEN              4 +LOOP        SWAP   ( get flag up)  ;                   : <> - 0= 0= ;  : CR 13 EMIT 10 EMIT ;                          30 LOAD 33 LOAD -->                                              CR ." 84NOV24  FORTH KRAKER >2<  ALBERT VAN DER HORST "          HERE VARIABLE LIM                                             : (KRAAK) ( CFA--. Decompile a word from its CFA )                 DUP NEXTN LIM ! ( Get an absolute limit)                        DUP @ SEL@ IF ( Is content of CFA known?)                          EXECUTE ( Assuming CFA also on stack)                        ELSE                                                               CR DROP DUP DUP @ 2 - = IF                                          ." Code definition : " ELSE ." Can't handle : "             ENDIF ID.. CR                                                ENDIF ;                                                      : KRAAK  ( Use KRAAK SOMETHING to decompile the word SOMETHING)     CFOF (KRAAK) ;                                              : ?IM  ( CFA--f tests whether word IMMEDIATE )                       C->P NFA C@ $40 AND ;                                      : ?Q ?TERMINAL IF QUIT THEN ; ( NOODREM) -->                    CR ." 84NOV24  FORTH KRAKER >3<  ALBERT VAN DER HORST "         : BY ( CFA--. the CFA word is decompiled using : )                T, CFOF T, ; ( a word from the input stream )                 ( Example of a defining word decompilation)                     ( It is done by examples of the defined words )                 : -co DUP C->P @ CR H. ." CONSTANT " ID.. CR ;                         CFOF 0 @ BY -co                                          : -va DUP C->P @ CR H. ." VARIABLE " ID.. CR ;                         CFOF SELTAB @ BY -va                                     : -us DUP C->P C@ CR B. ."  USER " ID.. CR ;                           CFOF FENCE @ BY -us                                      : ITEM ( 1/1 Desinterpret next item, increments pointer)            DUP @ SEL@ ( Something special ?)                               IF EXECUTE ( The special) ELSE                                     DUP ?IM IF ." [COMPILE] " THEN ID.. 2+                       THEN ; -->                                                  CR ." 84NOV24  FORTH KRAKER >4<  ALBERT VAN DER HORST "         CFOF TASK @ CONSTANT DOCOL ( Get the  DOCOLON address )         ( Decompilation of special high level words)                     : -hi CR ." : " DUP DUP ID.. 2 +  CR                             BEGIN ?Q DUP @  LIT ;S <> >R DUP LIM @ < R> AND WHILE                ITEM REPEAT                                                CR DROP ." ;" ?IM IF ."  IMMEDIATE " THEN CR ;                      CFOF TASK @  BY -hi                                       ( for all -words: 1/1 pointer before afd after execution)       : -lit 2+ DUP @ H. 2+ ;                                             CFOF LIT BY -lit                                            : -0br CR ." 0BRANCH [ " -lit ." , ] " ;                            CFOF 0BRANCH BY -0br                                        : -br  CR ." BRANCH  [ " -lit ." , ] " ;                            CFOF BRANCH BY -br                                           -->                                                            CR ." A0MAR05  FORTH KRAKER >5<  ALBERT VAN DER HORST "          : -dq 2+ DUP COUNT CR &. EMIT &" EMIT BL EMIT                      TYPE &" EMIT BL EMIT  COUNT + ;                                                         CFOF (.") BY -dq                                                                                     : -do CR ." DO " 2 + ;     CFOF (DO) BY -do                     : -lo CR ." LOOP " 2 + ;   CFOF (LOOP) BY -lo                   : -pl CR ." +LOOP " 2 + ;  CFOF (+LOOP) BY -pl                  : -cm ." COMPILE " -lit ;  CFOF COMPILE BY -cm                  ( DIRTY TRICK FOLLOWING :)                                      : -pc CR ." ;CODE plus code (suppressed)"                         DROP ' TASK ; ( Destroy deecompile pointer !)                     CFOF (;CODE) BY -pc                                                                                                                                                                                                                                        ( DISK IO SCREEN 15 SCHRIJVEN >1< VERSIE #1)                    <HEX  0 VARIABLE FCB2   21 ALLOT  ( BUG: 2nd goes wrong)        : CLEAN-FCB DUP 21 0 FILL  1+ 0B 20 FILL ;                      : FILL-FCB 22 WORD                                                 1+ HERE  COUNT ROT SWAP CMOVE  ;                             : SET-DMA  1A BDOS DROP ;                                       : ?PRES   FCB2 0F BDOS 0FF - IF ." ALREADY PRESENT" QUIT THEN      FCB2 10 BDOS DROP ;                                            -->                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ( SCR # 16 SCHRIJVEN >2<   )                                    0 VARIABLE DISK-BUFFER-W 100 ALLOT                              DISK-BUFFER-W VARIABLE POINTER-W                                : .OPENW FCB2 CLEAN-FCB FCB2 FILL-FCB ?PRES                       FCB2 16 BDOS 0FF = IF ." DISK FULL " QUIT THEN                  DISK-BUFFER-W POINTER-W ! ;                                   : .CLOSEW                                                            DISK-BUFFER-W SET-DMA FCB2 15 BDOS . ." LAST RECORD" CR               FCB2 10 BDOS . ." CLOSE STATUS" CR ;                 0A0D VARIABLE CRLF    1A VARIABLE CTRLZ                         : MOVE-DOWN   -80 POINTER-W +!                                                DISK-BUFFER-W 80 OVER + SWAP 80 CMOVE ;           : TO-DISK DUP >R POINTER-W @ SWAP CMOVE                                   R> POINTER-W +!                                                 POINTER-W @ DISK-BUFFER-W -                                     80 >  IF   -->                                         ( SCREEN #17 SCHRIJVEN  >3<)                                                DISK-BUFFER-W SET-DMA FCB2 15 BDOS .                            MOVE-DOWN                                                   THEN ;                                                                                                                 : .WRITE  ( 2/0 WRITE SCREEN-1 .. SCREEN-2 TO DISK)                  1+ B/SCR * SWAP B/SCR * ( GET START BUFFER #'S)                   DO I BLOCK DUP                                                  40 -TRAILING TO-DISK  CRLF 2 TO-DISK                            40 + 40 -TRAILING TO-DISK CRLF 2 TO-DISK                      LOOP CTRLZ 1 TO-DISK                                       ;   HEX>                                                                                                                                                                                                                                                                                                                        ( DISK IO, LEZEN )                                              <HEX  ( BUG: 64 char lines go wrong)                            0 VARIABLE DISK-BUFFER-R  80 ALLOT 0 VARIABLE POINTER-R          0A CONSTANT "LF"  0D CONSTANT "CR"                              1A CONSTANT ^Z    DISK-BUFFER-R 80 + CONSTANT END-BUF           0 VARIABLE EOF                                                 : .OPENR   FCB2 DUP CLEAN-FCB FILL-FCB                                END-BUF POINTER-R !                                             FCB2 0F BDOS 0FF = IF ." NOT PRESENT" QUIT THEN                 0 EOF ! ;                                                 : .CLOSER   FCB2 10 BDOS . ." CLOSE STATUS" CR ;                                                                                                                                                              -->                                                                                                                                                                               ( SCR # 19,  TWEEDE SCREEN VAN CP/M READ)                       : ?EMPTY ( POINTER -- CORRECTED PNR, READ SECTOR IF AT END)         DUP END-BUF = IF DISK-BUFFER-R SET-DMA  FCB2 14 BDOS .                         DROP DISK-BUFFER-R THEN  ;                   : GET-CHAR                                                         POINTER-R @                                                       ?EMPTY                   ( GET NEW BUFFER IF NEEDED)            DUP C@ "LF" = IF 1+ ?EMPTY THEN ( SKIP OVER LF)                 DUP C@ SWAP              ( GET CHAR, POINTER ON TOP)            OVER ^Z =                                                        IF 1 EOF ! ELSE 1+ THEN ( INCREMENT POINTER UNLESS AT ^Z)    POINTER-R !  ;                                                                                                               -->                                                                                                                                                                                             CR ." READ CP/M files >3< AH   84/06/13"                        : GET-LINE ( ADR -- . reads a line to ADR )                          DUP 40 20 FILL ( preset spaces )                                41 OVER + SWAP ( max $41 char to a line, CR!)                   DO  GET-CHAR                                                        DUP "CR" = IF DROP 20 LEAVE THEN                                DUP ^Z   = IF DROP 20 LEAVE THEN                                I C! ( may leave spurious 81th space)                       LOOP  ;                                                    : .READ ( 2/0 READ SCREEN-2 TO SCREEN -1)                            1+ B/SCR * SWAP B/SCR * ( get start buffer #'s)                 DO  I BLOCK DUP GET-LINE                                            DUP 40 + GET-LINE  81 + 0 SWAP C! UPDATE                        I #BUFF MOD 0= IF ( full load of buffers) FLUSH THEN        LOOP                                                      ; HEX>                                                           ( 01-APR-83 LADEN VAN CP/M FILE  #1 )                           ( EXAMPLE: .OPENR TEMP" 25 26 .LOAD .CLOSER )                   <HEX  0 VARIABLE LBUF 3E ALLOT 0 C,                             : I-F-A ( ADRES -- . ,INTERPRET FROM ADDRESS )                      TIB @ >R  IN @ >R  ( SAVE CURRENT INTERPRET POSITION)           TIB !     0 IN !   ( NEW POSITION)                              0 INTERPRET                                                     >R IN !   >R TIB ! ( RESTORE)  ;                                                                                            : .LOAD ( LOAD THE CPM FILE SPECIFIED IN FCB2 )                         BEGIN   LBUF DUP GET-LINE I-F-A                                 EOF @ UNTIL ;                                                                                                                                                                              HEX>                                                                                                                         CR ." TAARTEN AUTOMATISERING DOOR DRS HENK" CR                  ." EEN VOORBEELD UIT BRODIE"     CR                             ." TYPE HELP VOOR DE GLOSSARY"  CR                              0 VARIABLE TAARTEN     0 VARIABLE DIEP-VRIES                    : HELP CR ." GLOSSARY:" CR ." BAK-TAART"                               CR ." EET-TAART" CR ." VRIES-IN" CR ." ONTDOOI"                 CR ." START" CR ." STATUS" CR ;                          : START 0 TAARTEN ! 0 DIEP-VRIES ! ;                            : BAK-TAART 1 TAARTEN +! ;                                      : EET-TAART TAARTEN @ DUP                                             IF -1 TAARTEN +! CR ." DANKJEWEL !" CR ELSE                       CR ." WELKE TAART ?" CR DROP THEN ;                     : VRIES-IN TAARTEN @ DIEP-VRIES +! 0 TAARTEN ! ;                : ONTDOOI DIEP-VRIES @ TAARTEN +! 0 DIEP-VRIES ! ;              : STATUS CR ." AANTAL AANWEZIGE TAARTEN: " TAARTEN ?              CR ." EN NOG " DIEP-VRIES ? ." IN DE DIEP VRIES " ;            ( EXTENDING THE FORTH SYSTEM #1 84/4/12 A.H.)                  <HEX                                                            : NEW-SYSTEM   ( Generates a new FORTH system, )                               ( using the CP/M SAVE command)                        LATEST PFA NFA 10C ! ( Define new topmost word)                 ( Initial value for VOC-LINK and FENCE:)                        HERE DUP 11C ! 11E !                                            HERE 100 / DECIMAL CR                                           CR ." TYPE: SAVE" . ." NEWFORTH.COM"                            BYE                                                        ;     HEX>                                                                                                                                                                                                                                                                                                                                                                                      ." GILBREATH's benchmark - BYTE jan 83 "  ( VERSIE #1)          8190 CONSTANT SIZE                                              0 VARIABLE FLAGS      SIZE ALLOT                                                                                                : DO-PRIME                                                          FLAGS SIZE 1 FILL                                               0 ( 0 COUNT ) SIZE 0                                            DO FLAGS I + C@                                                    IF I DUP + 3 +  ( DUP . )                                          DUP I +                                                         BEGIN DUP SIZE <                                                WHILE 0 OVER FLAGS +  C!  OVER + REPEAT                         DROP DROP 1+                                                 THEN                                                         LOOP                                                            . ." PRIMES" ;                                              ." ERATOSTHENES >1< Variables - A. van der Horst"  CR           ( User specified variables:)                                    52 VARIABLE CH/L  ( Characters per line)                        22 VARIABLE LN/P  ( Lines per page)                              1 VARIABLE PAUSE ( Boolean: pause between pages)                                                                               ( Other:)                                                       6250 CONSTANT SIZE ( 16 numbers pro byte)                       0 VARIABLE FLAGS      SIZE ALLOT                                FLAGS SIZE + CONSTANT END-FLAGS                                 0 VARIABLE LIM     ( part of FLAGS considered)                  0 VARIABLE C#      0 VARIABLE L#  ( char and line counter)      0 VARIABLE THOUSANDS ( #  thousand to be sieved)                0 VARIABLE MILS      ( Contains current thousand)               0 VARIABLE MANTISSA  ( The current thousands is to be printed)  -->                                                             ." ERATOSTHENES >2< Pretty printing - A. van der Horst"  CR     : FFEED  PAUSE @ IF CR ." KEY FOR NEXT SCREEN" KEY DROP THEN        12 EMIT CR ." ERATOSTHENES SIEVE -- PRIMES LESS THAN"           THOUSANDS @ 5 .R ."  000" CR 2 L# ! 1 MANTISSA ! ;          : ?P ( LENGTH -- . , give FF if LENGTH lines don't fat)              DUP L# +! L# @ LN/P @ > IF FFEED L# +! ELSE DROP THEN ;    : NEWLINE  ( Start at a new line, maybe with a mantissa)            1 ?P CR ( Checks first)                                         MANTISSA @ IF MILS @ 6 .R ELSE 6 SPACES THEN                    6 C# !   0 MANTISSA ! ;                                     : ?L ( LENGTH -- . , give LF if LENGTH char's don't fit)             DUP C# +! C# @ CH/L @ >                                         IF NEWLINE C# +! ELSE DROP THEN ;                          : .P   4 ?L SPACE 0 <# # # # #> TYPE ;                          : INIT-P  FFEED NEWLINE  ;   -->                                                                                                ." ERATOSTHENES >3< Bit manipulation - A. van der Horst " CR      HEX                                                           : NOT   0FF XOR ( N -- N  FLIP ALL BITS OF N) ;                 0 VARIABLE S-MASK -2 ALLOT 01 C, 02 C, 04 C, 08 C,                                         10 C, 20 C, 40 C, 80 C,              0 VARIABLE C-MASK -2 ALLOT                                                  01 NOT C, 02 NOT C, 04 NOT C, 08 NOT C,                         10 NOT C, 20 NOT C, 40 NOT C, 80 NOT C,             : INIT-T   FLAGS SIZE 0FF FILL ; ( Preset to 'prime')           DECIMAL                                                         : 8/MOD   0 8 U/ ; ( May be redefined in assembler )            : CLEAR-B ( BIT# --  clears the specified bit)                            8/MOD FLAGS + SWAP  ( Address in flags table)                   C-MASK + C@         ( Get mask)                                 OVER C@ AND SWAP C! ( Clear the bit)  ;               -->                                                             ." ERATOSTHENES >4< Bit manipulation - A. van der Horst " CR    : SET-B ( BIT# --  sets the specified bit)                                8/MOD FLAGS + SWAP  ( Address in flags table)                   S-MASK + C@         ( Get mask)                                 OVER C@ OR SWAP C!  ( Store with bit set)  ;          : TEST-B ( BIT# -- FLAG  Gets a FLAG testable by IF)                      8/MOD FLAGS + C@ SWAP  ( Get flag)                              S-MASK + C@ AND        ( Result: =0 or #0)     ;      : FLIP ( PRIME,START -- .  , marks multiples of PRIME as               (  non prime starting with START)                                  BEGIN  DUP LIM @ U<  WHILE                                             DUP CLEAR-B  OVER +                                      REPEAT   DROP DROP ;                                  : CHECK SIZE 16 U* 1000 U/  THOUSANDS @ U< IF                         ." INCREASE SIZE " ABORT THEN ;                           -->                                                             ." ERATOSTHENES >5< Main program - A. van der Horst " CR        : BATCH1 ( First batch of 500 numbers)                               500 1 ( Only odd numbers)                                      DO I TEST-B                                                        IF I DUP + 1 + DUP .P ( get prime number)                          I FLIP THEN ( Mark multiple as non-prime)                 LOOP ;                                                      : BATCH ( OFFSET --  every  following batch )                        500 0                                                           DO DUP I + TEST-B IF I DUP + 1 + .P THEN                        LOOP DROP ;                                                : SIEVE  ( N --  Makes list of primes <N*1000 )                     DUP THOUSANDS !   DUP CHECK   500 * LIM !  0 MILS !             INIT-T INIT-P 2 .P BATCH1                                       THOUSANDS @ 1                                                   DO I MILS !  1 MANTISSA !  NEWLINE I 500 * BATCH LOOP ;     ." DEFINIEER ^. EN  ''.  85JAN06 ALBERT VAN DER HORST"          <HEX                                                             : TOH 30 - DUP 9 > IF 7 - THEN ;                                   1 WIDTH !                                                    : &. ( 0/1 Leaves ASCII character at .  f.i. &A leaves 41H)       HERE 2 + C@ [COMPILE] LITERAL ; IMMEDIATE                     : ^. ( 0/1 leaves control character at . f.i. ^A leaves 01H)      HERE 2 + C@ 1F AND [COMPILE] LITERAL ; IMMEDIATE              : $.. ( 0/1 leaves hex number f.i. $0A leaves 0AH)                HERE 2 + C@ TOH 10 * HERE 3 + C@ TOH + [COMPILE] LITERAL ;    IMMEDIATE                                                       : $.... ( 0/1 leaves hex number 16 bits)                           0 HERE 6 + HERE 2 + DO 10 * I C@ TOH + LOOP                     [COMPILE] LITERAL ; IMMEDIATE                                   1F WIDTH ! HEX>                                              $1B CONSTANT ESC    $0F CONSTANT SI   $0E CONSTANT SO          ." 84NOV25 Initialize STAR-printer AH "  <HEX                   : PEMIT 7F AND 5 BDOS DROP ;                                    : PCR   0D PEMIT   0A PEMIT ;                                   : INIT-STAR ( N--. N is lines per pages)                           ESC PEMIT "@ PEMIT ESC PEMIT "C PEMIT ( TOS) PEMIT ;         : CONDENSED  ESC PEMIT "P PEMIT "3 PEMIT ;                      : EMPHASIZED ESC PEMIT  "E PEMIT ;                              : DOUBLE ESC PEMIT "G PEMIT ;                                   : BOLD EMPHASIZED DOUBLE ;                                      ( 137 CH/L !    60 LN/P !     0 PAUSE ! )                        : PSPACES  ( 1/0 print N-1 spaces)                                0 DO 20 PEMIT LOOP ;                                          : PTYPE  ( ADDRESS,LENGTH -- . PRINT LENGTH CHAR AT ADDRESS)            -DUP IF                                                         OVER + SWAP DO I C@ PEMIT LOOP THEN ;                   : P."  "" WORD HERE COUNT PTYPE ;       -->                    ( SUPER-QUAD)                                                     0 VARIABLE L                                                  : CONDENSED 34 MODE ;                                           :  HEADER  CR DUP 2 + SWAP                                         DO 3  SPACES ." SCR #" I 4 .R 54  SPACES LOOP ;              : 1LINE  L @ OVER (LINE)  TYPE                                    L @ 2 .R SPACE  L @ 16 + SWAP (LINE)  TYPE CR ;                : SUPER-DUPE                                                      2 /MOD SWAP DROP 2 *                                            DUP HEADER CR                                                   16 0 DO  I L ! DUP 1LINE                                        LOOP  ;                                                      : SQ CONDENSED SUPER-DUPE 2+ SUPER-DUPE DROP ;                                                                                                                                                                                                                  CR ." KRAAKER"                                                  : NEXTN ( CFA--NFA Get the NFA of the word defined)               C->P NFA LATEST             ( after the CFA one)                2DUP = IF                                                         DROP DROP HERE  ( No following word)                          ELSE                                                              BEGIN                                                              2DUP PFA LFA @ <> WHILE                                         PFA LFA @                                                    REPEAT                                                          SWAP DROP ( The CFA)                                          ENDIF                                                         ;                                                               : NEXTC ( CFA--CFA Like previous definition, giving CFA)          NEXTN PFA CFA ;                                                                                                               CR ." KRAAKER"                                                  : KRAAK-FROM ( .--. Kraak, starting with following word)          CFOF                                                            BEGIN                                                              DUP NEXTN HERE < WHILE                                          NEXTC DUP (KRAAK)                                            REPEAT                                                          DROP                                                          ;                                                               0 VARIABLE aux                                                  : PEMIT $7F AND 5 BDOS DROP ;                                   : TO-LP-KRAAK-FROM                                                ' EMIT @ aux !                                                  ' PEMIT CFA ' EMIT !                                            KRAAK-FROM                                                      aux @ ' EMIT ! ;                                              : A0 ;                                                          : A1 A0 A0 ;   : A2 A1 A1 ;    : A3 A2 A2 ;                     : A4 A3 A3 ;   : A5 A4 A4 ;    : A6 A5 A5 ;                     : A7 A6 A6 ;   : A8 A7 A7 ;    : A9 A8 A8 ;                     : AA A9 A9 ;                                                                                                                   : TEST 0 DO AA LOOP ;                                           : Q 0 DO 10000 TEST LOOP ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ( Elementary string: $@ $! $=          89jul16-AH)               : $@ COUNT ;     : $. TYPE ;  : C+! >R R @ + R> ! ;             : $! ( address, count,string -.)                                  OVER OVER C! 1+ SWAP CMOVE     ;                              : $C+ ( C,$-. append the character to the string $ )               SWAP OVER $@ + C!  1 SWAP C+! ;                              : $+!  ( $T,$C,$-. Append $C char's from $T to $)                  DUP C@ >R ( Keep old length )  2DUP C+! ( Adjust length)        1 + R> + SWAP CMOVE  ;                                      ( HANDY & Preparation for ANSI-fication)                        : PARSE WORD HERE $@ ;                                          : S" &" PARSE 2DUP ( fig: already HERE) 1+ ALLOT DROP ;         : STRING <BUILDS S" DROP DROP DOES> $@ ;                                                                                                                                                                                                                         ( STRING MANIPULATIONS : $I $S A0MAR06-AH)                      : $I ( String,c - Index   Index is the first place                      ( is to be found in the string else 0 )                   OVER C@ 0= IF DROP DROP 0 ELSE                                  0 ROT ROT SWAP $@ OVER + SWAP DO                                  DUP I C@ = IF SWAP  DROP I SWAP LEAVE THEN                    LOOP DROP THEN ;                                              : $S ( STRING, DEL- TEXT1, L1, TEXT2, L2 )                        ( Splits the text at the delimiter in two)                      (  if not present, L2 is made zero )                           OVER SWAP $I  DUP IF                                               >R $@ OVER R SWAP - ( Length before delimiter )                 SWAP OVER - 1 - ( Length after delimiter)                       R> 1+ SWAP                                                   ELSE DROP $@ 0 0                                                THEN ;                                                        (  -HEADING                   89jul16-AH )                       : -HEADING ( $T,$C -$T,$C   Like -TRAILING, removes)               BEGIN                        ( heading blanks )                   OVER C@ BL = OVER 0= 0=  AND                                  WHILE                                                             1 - SWAP 1 + SWAP                                             REPEAT  ;                                                    : $=  ( S1 S2 --F string at address S1 equal to other one)        1 ROT ROT  ( Start with a zero flag)                            DUP C@ 1+ ( Compare also count ) 0 DO                              OVER I + C@ OVER I + C@ <> IF                                      ROT DROP 0 ROT ROT ( Replace flag with 0 )                      LEAVE                                                        THEN                                                         LOOP DROP DROP  ;                                                                                                            (  -HEADING                   89jul16-AH )                       : -HEADING ( $T,$C -$T,$C   Like -TRAILING, removes)               BEGIN                        ( heading blanks )                   OVER C@ BL = OVER 0= NOT AND                                  WHILE                                                             1 - SWAP 1 + SWAP                                             REPEAT  ;                                                    : $=  ( S1 S2 --F string at address S1 equal to other one)        1 ROT ROT  ( Start with a zero flag)                            DUP C@ 1+ ( Compare also count ) 0 DO                              OVER I + C@ OVER I + C@ <> IF                                      ROT DROP 0 ROT ROT ( Replace flag with 0 )                      LEAVE                                                        THEN                                                         LOOP DROP DROP  ;                                                                                                            ( WRITE THE CURRENT SYSTEM TO HARD DISK ) HEX                   B/BUF SEC/BLK / CONSTANT SEC-LEN                                0 VARIABLE RW-BUFFER B/BUF ALLOT                                0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      HERE 1 - SEC-LEN / , SEC-LEN , 7C0 ,                            ( We use the two l.s. bytes of 64 bit number)                                 1 , 0 , 0 , 0 ,                                    CODE WRITE-SYSTEM                                                PUSHX, SI|                                                      MOVXI, AX| 4300 W,                                              MOVXI, DX| 0080 W,                                              MOVXI, SI| PARAM-BLOCK W,                                       INT, 13  B,                                                     POPX, SI|                                                       PUSHF,                                                          NEXT C;            DECIMAL                                    ( Experiment with GDT etc.) HEX                                 ( 32 K GDT AT 0001.8000 ) 2800 CONSTANT GDT-SEGMENT             7FFF VARIABLE GDT 2.8000 SWAP , ,                               7C0 CONSTANT CODE-SEGMENT ( The same for real and prot)         CODE-SEGMENT  10 * CONSTANT CODE-START                          : GDT! GDT-SEGMENT SWAP L! ;   1800 CONSTANT DATA-SEGMENT       : CODE! CODE-SEGMENT + GDT! ;   : DATA! DATA-SEGMENT + GDT! ;   : PREPARE-CS                                                      FFFF 0 CODE!   CODE-START 2 CODE!                               9A00 4 CODE!   008F 6 CODE! ;                                 : PREPARE-DS                                                      FFFF 0 DATA! CODE-START 2 DATA!                                 9200 4 DATA! 008F 6 DATA! ;                                    CODE LOAD-GDT CLI, 0F C, 01 C, 10 C, MEM| GDT MEM,             NEXT C; DECIMAL                                                                                                                 ( Experiment with GDT etc.) HEX                                 7C8 CONSTANT CS-32 ( 32 BITS CODE SEGMENT)                      10  CONSTANT DS-32 ( 32 BITS DATA SEGMENT)                      : CS32! CS-32 + GDT! ;   : DS32! DS-32 + GDT! ;                 : PREPARE-CS32                                                    FFFF 0 CS32!   CODE-START 2 CS32!                               9A00 4 CS32!   00CF 6 CS32! ;                                 : PREPARE-DS32                                                    FFFF 0 DS32!   CODE-START 2 DS32!                               9200 4 DS32!   00CF 6 DS32! ;                                 PREPARE-DS PREPARE-CS PREPARE-CS32 PREPARE-DS32                                                                                 DECIMAL                                                                                                                                                                                                                                                         ( Experimenting with drive parameters ) HEX                     B/BUF SEC/BLK / CONSTANT SEC-LEN                                0 VARIABLE RW-BUFFER B/BUF ALLOT                                0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      HERE 1 - SEC-LEN / , SEC-LEN , 7C0 ,                            ( We use the two l.s. bytes of 64 bit number)                                 1 , 0 , 0 , 0 ,                                    CODE WRITE-SYSTEM                                                PUSHX, SI|                                                      MOVXI, AX| 4300 W,                                              MOVXI, DX| 0080 W,                                              MOVXI, SI| PARAM-BLOCK W,                                       INT, 13  B,                                                     POPX, SI|                                                       PUSHF,                                                          NEXT C;            DECIMAL                                    ( EXPERIMENT: SWITCH TO PROTECTED MODE AND BACK )                 90 LOAD 41 42 THRU HEX     LOAD-GDT                           CODE TO-PROT1                                                     CLI, PUSHS, DS|  TO-PROT,                                         JMPFAR, HERE 4 + MEM, CS-32 SEG,                                MOVI, W| R| AX| DS-32 , 0 ,                                     MOVSW, T| DS| R| AX|                                            MOVI, W| R| AX| &a , 0 ,                                        XCHGX, AX| XCHGX, AX| XCHGX, AX| XCHGX, AX|                     MOVFA, B| B.0400 SWAP , ,                                       JMPFAR, HERE 6 + MEM, 0 , CODE-SEGMENT SEG,                  TO-REAL, STI, POPS, DS|  OS, PUSHX, AX|                         NEXT C; DECIMAL                                                                                                                                                                                                                                                ( SWITCH TO PROTECTED MODE AND BACK TIMING TEST )               CODE TO-PROT2                                                     CLI, TO-PROT,                                                     JMPFAR, HERE 4 + MEM, CS-32 SEG,                                JMPFAR, HERE 6 + MEM, 0 , CODE-SEGMENT SEG,                  TO-REAL, STI,                                                   NEXT C; DECIMAL                                                CODE TO-PROT3                                                     CLI, TO-PROT,   TO-REAL, STI,                                  NEXT C; DECIMAL                                                                                                                : TEST2 0 DO TO-PROT2 LOOP ;                                    : TEST3 0 DO TO-PROT3 LOOP ;                                    : Q2 0 DO 10000 TEST2 LOOP ;                                    : Q3 0 DO 10000 TEST3 LOOP ;                                                                                                    ( SWITCH TO PROTECTED MODE AND BACK REPLACEMENT FOR DOCOL )       90 LOAD 41 42 THRU HEX     LOAD-GDT                           CODE NEW-DOCOL                                                   (  JMPFAR, HERE 6 + MEM, 0 , CODE-SEGMENT SEG, )                (  TO-REAL,) STI,   CLI,   ( TO-PROT,)                         (  JMPFAR, HERE 4 + MEM, CS-32 SEG, )                             LEA, BP1| DB| [BP] -2 B,                                        MOV, W| F| SI1| DB| [BP] 0 B,                                   LEA, SI1| DB| [DI] 2 B,                                        NEXT C; DECIMAL                                                 : A0 ; ' A0 2 - @ CONSTANT 'DOCOL                              CODE X JMP,  ' NEW-DOCOL 'DOCOL 3 + - , C;                       CODE SWITCH  ' X 'DOCOL  CP, CP, CP, DROP DROP                 CLI,  ( TO-PROT, MOVXI, AX| DATA-SEGMENT MEM,                    MOVSW, T| DS| R| AX|  MOVSW, T| ES| R| AX|  MOVSW, T|          SS| R| AX| ) NEXT C;  DECIMAL                                   ( SWITCH TO PROTECTED MODE AND BACK REPLACEMENT FOR DOCOL )     CODE NEW-BIOS                                                     POPX, AX|   MOVFA, B| HERE 0 ,    ( PATCH THE INTERRUPT #)      POPX, DX|  POPX, CX|  POPX, BX|  POPX, DI|                    PUSHX, SI|   PUSHX, BP| ( TO-REAL,) STI, XCHGX, DI|               INT, HERE SWAP ! 0 C, ( PATCH THE ADDRESS WHERE TO PATCH )      PUSHF, POPX, DI|   ( SAVE FLAGS BEFORE THEY ARE DESTROYED)      XCHGX, SI| ( FREE AX)  CLI,  ( TO-PROT,)                        ( NOW ALL REGISTERS ARE TIED UP EXCEPT ax| [!])               POPX, BP|  POPX, AX|  XCHGX, SI|  ( RESTORE FORTH REGISTERS)    PUSHX, AX|    PUSHX, BX|    PUSHX, CX|    PUSHX, DX|  PUSHX, DI| NEXT C;                                                        CODE HLT HLT, C;                                                : PATCH-BIOS ' NEW-BIOS ' BIOS CFA ! ;                          : PATCH PATCH-BIOS SWITCH ;                                     KRAAKER                                                                                                                         ' NEW-BIOS 30 DUMP ' NEW-DOCOL 30 DUMP 48 EDIT                  40BB :                            58A2 CF40 5A|X..@Z|           40C0 : 595B 5F56 550F 20C0 480F 22C0 FB97 CD00 |Y[_VU. .H.".....40D0 : 9C5F 96FA 0F20 C040 0F22 C05D 5896 5053 |._... .@.".]X.PS                                                                4043 :        0F20 C048 0F22 C0FB FA0F 20C0 40|. .H.".... .@|   4050 : 0F22 C08D 6EFE 8976 008D 7502 AD89 C789 |."..n..v..u.....4060 : FBFF 2582 41B0 3540 5A06 A804 8627 444F |..%.A.5@Z....'DO                                                                ' NEW-BIOS 30 DUMP                                              44E1 :   58A2 EE44 5A59 5B5F 5655 FB97 CD10 9C|X..DZY[_VU.....| 44F0 : 5F96 FA5D 5896 5053 5152 57AD 89C7 89FB |_..]X.PSQRW.....4500 : FF25 8348 4CD4 D444 0A45 F481 D802 4511 |.%.HL..D.E....E.4510 : 45E9 A730 8A50 4154 4348 2D42 494F D30B |E..0.PATCH-BIO..                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ." CRC CHECK FOR FIG  85JAN06 ALBERT VAN DER HORST"             ( Adapted from FORTH DIMENSIONS IV-3 )                           : ACCUMULATE ( oldcrc/char -- newcrc )                            $0100 * XOR                                                     8 0 DO                                                             DUP 0< IF $4002 XOR DUP + 1+ ELSE DUP + THEN                 LOOP ;                                                        : DISPOSE ( crcvalue/adres/len -- newcrcvalue)                     OVER DUP C@ "( = SWAP 1+ C@ BL = AND OVER 1 = AND IF               ( comment; skip it) DROP DROP ") WORD                        ELSE                                                               1+ OVER + SWAP DO I C@ ACCUMULATE LOOP                       THEN ;                                                       : MORE ( -- adr f  Leaves flag if there is more in the block)      BL WORD HERE DUP C@ 2 < OVER 1+ C@ "! < AND 0=               ;                                                               ." CRC 2 "                                                      : VERIFY-BLOCK ( oldcrc/blnr -- newcrc)                           BLK @ >R IN @ >R   BLK !  0 IN !                                BEGIN MORE WHILE                                                    BL OVER COUNT + C! COUNT DISPOSE                            REPEAT DROP ( drop the address left by MORE)                    R> IN ! R> BLK ! ;                                            : VERIFY ( scrnr/crc)                                             0 SWAP B/SCR * DUP B/SCR + SWAP DO                                 I VERIFY-BLOCK                                               LOOP                                                          ;                                                               : VER   SCR @ VERIFY U. ;                                                                                                                                                                                                                                      ( Test screen)                                                       For program exchange, the medium of hard copy is cheap,    convenient, and machine-independent. Its primary disadvantages  are the time required for hand-typing the source code and the   possibility of human error in the process. Even if the screens  LOAD without error messages, some errors may pass undetected    until run-time, when the system crashes mysteriously.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >1<"                    HEX VOCABULARY ASSEMBLER IMMEDIATE : 8* DUP + DUP + DUP + ;     ' ASSEMBLER CFA ' ;CODE 8 + !        ( PATCH ;CODE IN NUCLEUS ) : CODE ?EXEC CREATE [COMPILE] ASSEMBLER !CSP ; IMMEDIATE        : C; CURRENT @ CONTEXT ! ?EXEC ?CSP SMUDGE ; IMMEDIATE          : LABEL ?EXEC 0 VARIABLE SMUDGE -2 ALLOT [COMPILE] ASSEMBLER        !CSP ; IMMEDIATE     ASSEMBLER DEFINITIONS                  4 CONSTANT H    5 CONSTANT L     7 CONSTANT A    6 CONSTANT PSW 2 CONSTANT D    3 CONSTANT E     0 CONSTANT B    1 CONSTANT C   6 CONSTANT M    6 CONSTANT SP     ' ;S 0B + @ CONSTANT (NEXT)   : 1MI <BUILDS C, DOES> C@ C, ;  : 2MI <BUILDS C, DOES> C@ + C, ; : 3MI <BUILDS C, DOES> C@ SWAP 8* +  C, ;                      : 4MI <BUILDS C, DOES> C@ C, C, ;                               : 5MI <BUILDS C, DOES> C@ C, , ;  : PSH1 C3 C, (NEXT) 1 - , ;   : PSH2 C3 C, (NEXT) 2 - , ;       : NEXT C3 C, (NEXT) , ;        -->                                                            CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >2<"                    00 1MI NOP     76 1MI HLT     F3 1MI DI     FB 1MI EI           07 1MI RLC     0F 1MI RRC     17 1MI RAL    1F 1MI RAR          E9 1MI PCHL    F9 1MI SPHL    E3 1MI XTHL   EB 1MI XCHG         27 1MI DAA     2F 1MI CMA     37 1MI STC    3F 1MI CMC          80 2MI ADD     88 2MI ADC     90 2MI SUB    98 2MI SBB          A0 2MI ANA     A8 2MI XRA     B0 2MI ORA    B8 2MI CMP          09 3MI DAD     C1 3MI POP     C5 3MI PUSH   02 3MI STAX         0A 3MI LDAX    04 3MI INR     05 3MI DCR    03 3MI INX          0B 3MI DCX     C7 3MI RST     D3 4MI OUT    DB 4MI IN           C6 4MI ADI     CE 4MI ACI     D6 4MI SUI    DE 4MI SBI          E6 4MI ANI     EE 4MI XRI     F6 4MI ORI    FE 4MI CPI          22 5MI SHLD    2A 5MI LHLD    32 5MI STA    3A 5MI LDA          CD 5MI CALL    C3 5MI JMP                                                      ( CZ,CNZ,CCY,CNC)  -->                                                                                           CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >3<"                    C9 1MI RET                   C2 CONSTANT 0=  D2 CONSTANT CS     E2 CONSTANT PE  F2 CONSTANT 0<   : NOT 8 + ;                    : MOV 8* 40 + + C, ;   : MVI 8* 6 + C, C, ;   : LXI 8* 1+ C, , ;: THEN HERE SWAP ! ;               : IF C, HERE 0 , ;           : ELSE C3 IF SWAP THEN ;           : BEGIN HERE ;               : UNTIL C, , ;                     : WHILE IF ;                 : REPEAT SWAP C3 C, , THEN ;                                    ;S                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              CR ." SIMPLE PROFILER AH   85FEB15"                             LABEL NEXT2      ( REPLACES NEXT!)                                 B LDAX   B INX   A L MOV                                        B LDAX   B INX   A H MOV   (NEXT) 6 + JMP C;                    (NEXT) 3 + JMP C;                                             ODE PROFILE  ( PATCHES THE CODE AT NEXT FOR PROFILING)            $C3 A MVI  (NEXT) STA                                           NEXT2 H LXI    (NEXT) 1+ SHLD     NEXT C;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ( STREAM READ ROUTINES CP/M 85/012/08  AH )                     : F_READ ( B,N-N2 Tries to read N char's to buffer B)                    ( N2 is number actually read, 0 for EOF)                    ( NOT  YET: NOW IT IS FILLED WITH ^Z, NOTHING RETURNED )    BEGIN                                                              SWAP GET-CHAR                                                   OVER C! 1+ SWAP 1 -                                             DUP 0=                                                       UNTIL                                                          ;                                                               : F_WRITE ( B,N-N2 Tries to write N char's from buffer B)            ( N2 is the number actually written to disk )                   ( NOT  YET: NOW IT IS UNCLEAR, NOTHING RETURNED )            TO-DISK                                                       ;                                                                                                                               ( DISC IO SCREEN 15 GENERAL  >1<   85/12/08 AH )                <HEX                                                            0A0D VARIABLE CRLF    1A VARIABLE CTRLZ                         : CLEAN-FCB DUP 21 0 FILL  1+ 0B 20 FILL ;                                                                                      : FILL-FCB 22 WORD                                                 1+ HERE  COUNT ROT SWAP CMOVE  ;                                                                                             : SET-DMA  1A BDOS DROP ;                                                                                                         -->                                                                                                                                                                                                                                                                                                                                                                                           ( DISC IO SCREEN 16 WRITE    >1<   85/12/08 AH )                0 VARIABLE DISK-BUFFER-W 100 ALLOT                              DISK-BUFFER-W VARIABLE POINTER-W                               0 VARIABLE FCB2   21 ALLOT  ( BUG: 2nd goes wrong)               : ?PRES ( .-. Aborts whether the entry is already present )        FCB2 0F BDOS 0FF - IF ." ALREADY PRESENT" QUIT THEN             FCB2 10 BDOS DROP ;                                          : .OPENW FCB2 CLEAN-FCB FCB2 FILL-FCB ?PRES                       FCB2 16 BDOS 0FF = IF ." DISK FULL " QUIT THEN                  DISK-BUFFER-W POINTER-W ! ;                                   : .CLOSEW                                                            DISK-BUFFER-W SET-DMA FCB2 15 BDOS . ." LAST RECORD" CR               FCB2 10 BDOS . ." CLOSE STATUS" CR ;                 : MOVE-DOWN   -80 POINTER-W +!                                                DISK-BUFFER-W 80 OVER + SWAP 80 CMOVE ;               -->                                                         ( DISC IO SCREEN 17 WRITE    >2<   85/12/08 AH )3<)             : TO-DISK DUP >R POINTER-W @ SWAP CMOVE                                   R> POINTER-W +!                                                 POINTER-W @ DISK-BUFFER-W -                                     80 >  IF   -->                                                     DISK-BUFFER-W SET-DMA FCB2 15 BDOS .                            MOVE-DOWN                                                   THEN ;                                                                                                                 : .WRITE  ( 2/0 WRITE SCREEN-1 .. SCREEN-2 TO DISK)                  1+ B/SCR * SWAP B/SCR * ( GET START BUFFER #'S)                   DO I BLOCK DUP                                                  40 -TRAILING TO-DISK  CRLF 2 TO-DISK                            40 + 40 -TRAILING TO-DISK CRLF 2 TO-DISK                      LOOP CTRLZ 1 TO-DISK                                       ;   HEX>                                                        ( DISC IO SCREEN 18 READ     >1<   85/12/08 AH )                <HEX  ( BUG: 64 char lines go wrong)                            0 VARIABLE DISK-BUFFER-R  80 ALLOT 0 VARIABLE POINTER-R          0A CONSTANT "LF"  0D CONSTANT "CR"                              1A CONSTANT ^Z    DISK-BUFFER-R 80 + CONSTANT END-BUF           0 VARIABLE EOF                                                 : .OPENR   FCB2 DUP CLEAN-FCB FILL-FCB                                END-BUF POINTER-R !                                             FCB2 0F BDOS 0FF = IF ." NOT PRESENT" QUIT THEN                 0 EOF ! ;                                                 : .CLOSER   FCB2 10 BDOS . ." CLOSE STATUS" CR ;                                                                                                                                                              -->                                                                                                                                                                               ( DISC IO SCREEN 19 READ     >2<   85/12/08 AH )                : ?EMPTY ( POINTER -- CORRECTED PNR, READ SECTOR IF AT END)         DUP END-BUF = IF DISK-BUFFER-R SET-DMA  FCB2 14 BDOS .                         DROP DISK-BUFFER-R THEN  ;                   : GET-CHAR                                                         POINTER-R @                                                       ?EMPTY                   ( GET NEW BUFFER IF NEEDED)            DUP C@ "LF" = IF 1+ ?EMPTY THEN ( SKIP OVER LF)                 DUP C@ SWAP              ( GET CHAR, POINTER ON TOP)            OVER ^Z =                                                        IF 1 EOF ! ELSE 1+ THEN ( INCREMENT POINTER UNLESS AT ^Z)    POINTER-R !  ;                                                                                                               -->                                                                                                                                                                                             ( DISC IO SCREEN 20 READ     >3<   85/12/08 AH )                : GET-LINE ( ADR -- . reads a line to ADR )                          DUP 40 20 FILL ( preset spaces )                                41 OVER + SWAP ( max $41 char to a line, CR!)                   DO  GET-CHAR                                                        DUP "CR" = IF DROP 20 LEAVE THEN                                DUP ^Z   = IF DROP 20 LEAVE THEN                                I C! ( may leave spurious 81th space)                       LOOP  ;                                                    : .READ ( 2/0 READ SCREEN-2 TO SCREEN -1)                            1+ B/SCR * SWAP B/SCR * ( get start buffer #'s)                 DO  I BLOCK DUP GET-LINE                                            DUP 40 + GET-LINE  81 + 0 SWAP C! UPDATE                        I #BUFF MOD 0= IF ( full load of buffers) FLUSH THEN        LOOP                                                      ; HEX>                                                           ( DISC IO SCREEN 21  LOAD    >1<   85/12/08 AH )                ( EXAMPLE: .OPENR TEMP" 25 26 .LOAD .CLOSER )                   <HEX  0 VARIABLE LBUF 3E ALLOT 0 C,                             : I-F-A ( ADRES -- . ,INTERPRET FROM ADDRESS )                      TIB @ >R  IN @ >R  ( SAVE CURRENT INTERPRET POSITION)           TIB !     0 IN !   ( NEW POSITION)                              0 INTERPRET                                                     >R IN !   >R TIB ! ( RESTORE)  ;                                                                                            : .LOAD ( LOAD THE CPM FILE SPECIFIED IN FCB2 )                         BEGIN   LBUF DUP GET-LINE I-F-A                                 EOF @ UNTIL ;                                                                                                                                                                              HEX>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ( POSTIT/FIXUP 8086 ASSEMBLER LOAD SCREEN AvdH HCC HOLLAND)     ASSEMBLER DEFINITIONS HEX                                       : 3PI <BUILDS C, C, C, DOES> POST, POST, POST, DROP ;           : 3FI <BUILDS C, C, C, DOES> <FIX 3 + FIX| FIX| FIX| DROP ;     8 0 8 1FAMILY| DR0| DR1| DR2| DR3| ILL| ILL| DR6| DR7|          8 0 4 1FAMILY| CR0| ILL| CR1| CR2|  00 20 0F 3PI MOVCD,         : GET-CR0   MOVCD, F| CR0| R| AX| ;                             : PUT-CR0   MOVCD, T| CR0| R| AX| ;                             : TO-PROT,  GET-CR0  INCX, AX|  PUT-CR0 ;                       : TO-REAL,  GET-CR0  DECX, AX|  PUT-CR0 ;                       66 1PI OS,   67 1PI AS, ( OPERAND AND ADDRESS SIZE OVERWRITE)   : NOP, XCHGX, AX| ;                                             : CP, MOVTA, B| SWAP DUP , 1 + MOVFA, SWAP DUP , 1 + ;          FORTH DEFINITIONS DECIMAL                                       : 2DROP DROP DROP ;                                             : ALIGN HERE 1 AND IF 0 C, THEN ;                               ( POSTIT/FIXUP 8086 ASSEMBLER SYSDEPENDANT AvdH HCC HOLLAND)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ( AUXILIARY DEFINITIONS ) DECIMAL                               0 VARIABLE IDP   : <FIX HERE IDP ! ; : IHERE IDP @ ;            : C|, -1 IDP +! IHERE C@ OR IHERE C! ;  ( c.f. C, )             : C@+ COUNT ;  : C@- 1 - DUP C@ ; ( : C!+ >R R ! R> 1+ ;)       : MEM, , ; : R, HERE - 2 + , ; : B, C, ;  : W, , ; : SEG, , ;   : POST, C@+ C, ;       : FIX| C@- C|, ;                         : 1PI <BUILDS C, DOES> POST, DROP ;                             : 2PI <BUILDS C, C, DOES> POST, POST, DROP ;                    : 1FI <BUILDS C, DOES> <FIX 1+ FIX| DROP ;                      : 2FI <BUILDS C, C, DOES> <FIX 2+ FIX| FIX| DROP ;              : 1FAMILY,  ( INCREMENT, OPCODE , COUNT -- )                       0 DO DUP 1PI OVER + LOOP DROP DROP ;                         : 1FAMILY| 0 DO DUP 1FI OVER + LOOP DROP DROP ;                 : SPLIT 256 /MOD SWAP ; ( To handle two bytes at once )         : 2FAMILY, 0 DO DUP SPLIT 2PI OVER + LOOP DROP DROP ;           : 2FAMILY| 0 DO DUP SPLIT 2FI OVER + LOOP DROP DROP ;           ( POST-IT/FIX-UP 8086 ASSEMBLER , OPCODES AvdH HCCFIG HOLLAND)   8 0 4 1FAMILY| ES| CS| SS| DS|    1 6 2 1FAMILY, PUSHS, POPS,   HEX 8 26 4 1FAMILY, ES:, CS:, SS:, DS:,                         8 27 4 1FAMILY, DAA, DAS, AAA, AAS,                             1 0 2 1FAMILY| B1| W1|   08 04 8 1FAMILY, ADDAI, ORAI, ADCAI,  SBBAI, ANDAI, SUBAI, XORAI, CMPAI, 2 A0 2 1FAMILY, MOVTA, MOVFA, 1 0 2 1FAMILY| Y| N|   2 0 8 1FAMILY| O| C| Z| CZ| S| P| L| LE| 70 1PI J,  ( As in J, L| Y| <CALC> S, )                         1 0 8 1FAMILY| AX| CX| DX| BX| SP| BP| SI| DI|                  08 40 4 1FAMILY, INCX, DECX, PUSHX, POPX,    90 1PI XCHGX,      ( C7) 6 1FI MEM|   ( C0) 40 00 4 1FAMILY| D0| DB| DW| R|        ( 38) 08 00 8 1FAMILY| AX1| CX1| DX1| BX1| SP1| BP1| SI1| DI1|  ( 07) 1 0 8 1FAMILY| [BX+SI] [BX+DI] [BP+SI] [BP+DI]           [SI] [DI] [BP] [BX]                                              1 0 8 1FAMILY| AL| CL| DL| BL| AH| CH| DH| BH|                                                                                 ( POST-IT/FIX-UP 8086 ASSEMBLER , OPCODES AvdH HCCFIG HOLLAND)  1 0 2 2FAMILY| B| W|   2 0 2 2FAMILY| F| T|                     8 0 8 2FAMILY, ADD, OR, ADC, SBB, AND, SUB, XOR, CMP,           2 84 2 2FAMILY, TEST, XCHG,   0 88 2PI MOV,                     ( 00FD) 0 8C 2PI MOVSW,   ( 00FE) 0 8D 2PI LEA,                 ( IRR,egular)  ( FF) 9A 1PI CALLFAR,  ( FE) A8 1PI TESTAI, ( FF)1 98 8 1FAMILY, CBW, CWD, IR2, WAIT, PUSHF, POPF, SAHF, LAHF,   ( FE) 2 A4 6 1FAMILY, MOVS, CMPS, IR3, STOS, LODS, SCAS,        08 B0 2 1FAMILY, MOVRI, MOVXI,                                  8 C2 2 1FAMILY, RET+, RETFAR+,  8 C3 2 1FAMILY, RET,  RETFAR,   1 C4 2 1FAMILY, LES, LDS,  0 C6 2PI MOVI,  0 CD 1PI INT,        1 CC 4 1FAMILY, INT3, IRR, INTO, IRET,                          1 D4 4 1FAMILY, AAM, AAD, IL1, XLAT,                            1 E0 4 1FAMILY, LOOPNZ, LOOPZ, LOOP, JCXZ,                      2 E4 2 1FAMILY, INAP, OUTAP,  2 EC 2 1FAMILY, INAD, OUTAD,      1 E8 2 1FAMILY, CALL, JMP,  EA 1PI JMPFAR,  EB 1PI JMPS,        ( POST-IT/FIX-UP 8086 ASSEMBLER , OPCODES AvdH HCCFIG HOLLAND)  1 F0 6 1FAMILY, LOCK, ILL, REP, REPZ, HLT, CMC,                 1 F8 6 1FAMILY, CLC, STC, CLI, STI, CLD, STD, ( 38FE)           800 80 8 2FAMILY, ADDI, ORI, ADCI, SBBI, ANDI, SUBI, XORI, CMPI,800 83 8 2FAMILY, ADDSI, IL3, ADCSI, SBBSI, IL4, SUBSI, IL5,    CMPSI,   2 0 2 2FAMILY| 1| V|                                   800 D0 8 2FAMILY, ROL, ROR, RCL, RCR, SHL, SHR, IL6, RAR,       800 10F6 6 2FAMILY, NOT, NEG, MUL, IMUL, DIV, IDIV,             00 F6 2PI TESTI, 800 FE 2 2FAMILY, INC, DEC,                    ( 38FF) 00 8F 2PI POP,  30 FE 2PI PUSH,                         800 10FF 4 2FAMILY, CALLO, CALLFARO, JMPO, JMPFARO,                                                                                                                                                                                                                                                                                                                                             ( POST-IT/FIX-UP 8086 ASSEMBLER , POSTLUDE AvdH HCCFIG HOLLAND) VOCABULARY ASSEMBLER IMMEDIATE                                  ' ASSEMBLER CFA ' ;CODE 8 + !        ( PATCH ;CODE IN NUCLEUS ) ASSEMBLER DEFINITIONS 92 95 HEX THRU DECIMAL                    : C; CURRENT @ CONTEXT ! ?EXEC ?CSP SMUDGE ; IMMEDIATE          : NEXT                                                               LODS, W1|                                                       MOV, W| F| R| DI| AX1|                                          MOV, W| F| R| BX| DI1|                                          JMPO, D0| [DI]                                              ;                                                              FORTH DEFINITIONS                                               : CODE ?EXEC CREATE [COMPILE] ASSEMBLER !CSP ; IMMEDIATE         CODE TEST NEXT  C;                                                                                                                                                                             ( Basic block manipulapions ) HEX                               ALIGN 0 VARIABLE RW-BUFFER B/BUF ALLOT                          0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      2 , ( 2 sectors/block) RW-BUFFER , 7C0 ,                        ( We use the two l.s. bytes of 64 bit number)                   HERE 2 ALLOT  0 , 0 , 0 , CONSTANT BL#                           : R/W-BLOCK  ASSEMBLER                                           POPX, AX|            ADD, W| R| AX1| AX|                        MOVFA, W1| BL# W,    PUSHX, SI|                                 MOVXI, BX| W,   MOVXI, DX| 0080 W,                              MOVXI, SI| PARAM-BLOCK W,  TO-REAL,  XCHGX, BX|                 INT, 13 B, PUSHF, POPX, BX| TO-PROT,                            POPX, SI|   PUSHX, BX|  NEXT ;                                CODE READ-BLOCK 4200 R/W-BLOCK  C;                              CODE WRITE-BLOCK 4300 R/W-BLOCK  C;                             DECIMAL                                                         HEX ( copy a hd system, wa written to a floppy to the           hard disk. Done by a Forth booted from another floppy.)         40 CONSTANT HD-OFFSET                                           : COPY-FLOPPY                                                     HERE B/BUF / 1+ 0 DO                                              RW-BUFFER I 1 R/W                                               I WRITE-BLOCK 1 AND .                                         LOOP ;                                                        : RESTORE-BLOCKS 100 0 DO                                          RW-BUFFER I OFFSET @ + 1 R/W                                    I HD-OFFSET + WRITE-BLOCK 1 AND .                            LOOP ;                                                          : SAVE-BLOCKS 100 0 DO                                             I HD-OFFSET + READ-BLOCK 1 AND .                                RW-BUFFER I OFFSET @ + 0 R/W LOOP ;  DECIMAL                 : SAFE HD-OFFSET OFFSET @ = 17 ?ERROR ;                         ( Experimenting with drive parameters ) HEX                     B/BUF SEC/BLK / CONSTANT SEC-LEN                                0 VARIABLE RW-BUFFER B/BUF ALLOT                                0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      HERE 1 - SEC-LEN / , SEC-LEN , 7C0 ,                            ( We use the two l.s. bytes of 64 bit number)                                 1 , 0 , 0 , 0 ,                                    CODE WRITE-SYSTEM                                                PUSHX, SI|                                                      MOVXI, AX| 4300 W,                                              MOVXI, DX| 0080 W,                                              MOVXI, SI| PARAM-BLOCK W,                                       INT, 13  B,                                                     POPX, SI|                                                       PUSHF,                                                          NEXT C;            DECIMAL                                    ( BASIC STYLE MINI EDITOR - FORTH DIM iii/2 @ SHAPIN)           HEX : TEXT HERE C/L 1+ BLANKS WORD HERE PAD C/L 1+ CMOVE ;      : LINE DUP FFF0 AND 17 ?ERROR SCR @ (LINE) DROP ;               : -MOVE LINE C/L CMOVE UPDATE ;                                 : P 1 TEXT PAD 1+ SWAP -MOVE ; DECIMAL                          ( Usage : to change line 1 of screen 3 )                        ( 3 SCR ! 1 P <CONTENT> )                                       : CLEAN BLOCK B/BUF OVER + SWAP DO                                I C@ 0= IF BL I C! THEN  LOOP ;                               : THRU 1+ SWAP DO ." LOADING " I . I LOAD LOOP ;                : L-S SCR @ LIST ; : LO-S SCR @ LOAD ;                          : C-S SWAP BLOCK SWAP BLOCK B/BUF CMOVE UPDATE FLUSH ;          : BIOSI BIOS DROP DROP DROP DROP DROP ;  ( Ignore result)       : MODE 0 0 0 16 BIOSI ;                                         : DISK-INIT 0 0 0 0 19 BIOSI ;                                  : LIST BASE @ 10 - 25 ?ERROR LIST ;                             ( MINI EDITOR FOR MSDOS ) HEX                                   B800 CONSTANT VID   050 CONSTANT VW   19 CONSTANT VH            VH VW * CONSTANT VL                                             : A-L SCR @ (LINE) ;                                            : VA ( I - VS,VO ) DUP + VID SWAP ;                             : >V ( $, OFFSET - )                                            SWAP 0 DO                                                        OVER I + C@ 700 OR   OVER I + VA L!                            LOOP DROP DROP ;                                                : V> ( BUF -LEN OFFSET- )                                       SWAP 0 DO OVER I +   OVER I + VA                                 L@ SWAP C!                                                     LOOP DROP DROP ;                                                : PAGE PAD VL 2DUP BLANKS 0 >V ;                                : PG PAD 10 VW * 2DUP BLANKS 0 >V ;                              DECIMAL                                                        HEX                                                             : GET-S 10 0 DO I A-L I VW * >V LOOP ;                          : PUT-S 10 0 DO I A-L I VW * V> LOOP UPDATE ;                   : GET-L PAD VW ROT VW * >V ;                                    : PUT-L PAD VW ROT VW * V> ;                                    ( 19 CONSTANT PB )   13 CONSTANT HW                             : PUSH-D 10 SWAP DO I 1+ PUT-L I GET-L LOOP ;                   : PUSH-DOWN VH SWAP DO I 1+ PUT-L I GET-L LOOP ;                : DEL-L DUP PUT-L VH  GET-L PUSH-DOWN ;                         : PUSH-UP VH DO I PUT-L I 1+ GET-L -1 +LOOP ;                   : UDL-L DUP PUSH-UP VH PUT-L GET-L ;                            : PUSH-U HW DO I PUT-L I 1+ GET-L -1 +LOOP ;                    : UFL-L DUP PUSH-U VH 1 - PUT-L GET-L ;                         : DUP-L DUP DEL-L DUP UFL-L UDL-L ;                                                                                              DECIMAL                                                        HEX ( CURSOR E.D.)                                              0 VARIABLE CURSOR                                                : CURL CURSOR @ VW / ; : CP CURSOR @ VW MOD  ;                  : BIOS-CURSOR CURSOR @ VW /MOD 100 * + ;                       : SET 200 0 0 BIOS-CURSOR 10 BIOS DROP DROP DROP DROP DROP ;    : MOVE-CURSOR   ( WORD STAR)                                    DUP ^D = IF  1 ELSE   DUP ^E = IF 0 VW - ELSE                   DUP ^I = IF  8 ELSE   DUP ^M = IF VW CP - ELSE                  DUP ^S = IF -1 ELSE   DUP ^X = IF VW ELSE                       0    THEN THEN THEN THEN THEN THEN CURSOR +! ;                  : DELSTORING DUP ^Y  = IF CURL DEL-L ELSE                             DUP ^P = IF CURL UDL-L ELSE                                     DUP ^U = IF CURL UFL-L                                          THEN THEN THEN ;                                          : DUP-L CURL DUP-L ;                                              DECIMAL                                                       HEX                                                             : PAD-B PAD VW BLANKS  ;                                        : GET-R PAD VW CP - CURL VW * CP + >V ;                         : GET-P PAD    CP   CURL VW *      >V ;                         : PUT-R PAD VW CP - CURL VW * CP + V> ;                         : RUBOUT-M PUT-R MINUS CURSOR +! GET-R ;                        : INSERT-M PUT-R DUP CURSOR +! GET-R MINUS CURSOR +! ;          : RUBOUT 1 RUBOUT-M ; : INSERT 1 INSERT-M ;                     : RUB-C PAD-B RUBOUT SET ;                                      : DEL-C 1 CURSOR +! RUB-C ;                                     : INS-C INSERT ;                                                : EOL PAD-B GET-R ;  : FOL PAD-B GET-P ;                        : SPL DUP-L PAD-B PUT-R CURL 1+ GET-L EOL ;                     : JOL PAD-B CURL 1+ PUT-L GET-R CURL 1+ PUSH-D ;                DECIMAL                                                                                                                         HEX                                                              0 VARIABLE I-MODE                                              : INSELETING                                                          DUP ^H = IF RUB-C ELSE                                          DUP ^G = IF DEL-C ELSE                                          DUP ^V = IF I-MODE 1 TOGGLE ELSE                                THEN THEN THEN ;                                          : JOINITTING                                                          DUP ^J = IF JOL   ELSE                                          DUP ^O = IF SPL   ELSE THEN THEN ;                        : EM-C EMIT 1 CURSOR +! ;                                       : PRINT ( C --C . Print it if printable)                          DUP 1F > IF DUP 7F < IF                                         I-MODE @   IF INS-C THEN  DUP EM-C                              THEN THEN ;                                                   DECIMAL                                                         ( DISPATCHER )    HEX                                           : AT-END VH 1 - VW * CURSOR ! SET ;                             : DEBUG CURSOR @ AT-END ^ CURSOR ! ;                            : EXITING KEY &Q - IF PUT-S THEN ;                              : ROUTE BEGIN KEY                                               PRINT DELSTORING                                                INSELETING JOINITTING                                           WORDING MOVE-CURSOR SET                                         ( DEBUG)                                                        ESC = UNTIL ;                                                   : E-S  ( EDIT CURRENT SCREEN )                                  0 CURSOR ! SET   PG                                             GET-S ROUTE EXITING  AT-END ;                                   :  EDIT SCR ! E-S ; : E-R 3 MODE EDIT ;                         DECIMAL                                                                                                                          ( Finding the next word)                                        : BL? VA L@ $FF AND BL = ;                                     : BOUNDARY? BL? 0= OVER 1 - BL? AND ;                           : >SEARCH BEGIN 1 + DUP BOUNDARY? UNTIL  ;                      : <SEARCH BEGIN 1 - DUP BOUNDARY? UNTIL  ;                      : NEXT-W CURSOR @ >SEARCH CURSOR ! ;                            : BACK-W CURSOR @ <SEARCH CURSOR ! ;                            : DEL-W  CURSOR @ NEXT-W SPL                                       CURSOR ! SET SPL CURL 1+ DEL-L JOL ;                         : VTYPE CURSOR @ >V ;                                           : GET-W VH 1 - PUT-L PAD VW -TRAILING 1+ ;                      : UFW GET-W INSERT-M DROP GET-W VTYPE ;                         : WORDING                                                         DUP ^F = IF NEXT-W ELSE   DUP ^A = IF BACK-W ELSE               DUP ^T = IF DEL-W ELSE    DUP ^Z = IF UFW ELSE                THEN THEN THEN THEN ;                                           : FROM-BIOS 100 /MOD VW * + CURSOR ! ;                          : GET 300 0 0 0 10 BIOS DROP FROM-BIOS  DROP DROP DROP ;        : P ( AT-END) GET ROUTE CURL PUT-L                                ( PAD SCRATCH BLOCK LL CMOVE )                                   AT-END CR PAD 50 1 - -TRAILING TYPE SPACE                       PAD TIB @ 50 CMOVE 0 IN !                                    ; ( IMMEDIATE  DOESN'T WORK VIA S)                              DECIMAL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ( TROEP SCEHRM EDITOR)                                          : EKEY 1000 0 0 0 16 BIOS DROP DROP DROP DROP ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          9 1 DO I J ! 5 SPACES ( eerst wat spaties)                             9 1 DO 9 J @ - I BORD @ EMIT SPACE LOOP CR                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       HEX   : HOME 1A EMIT ;   0 VARIABLE I-STATE                     : A-L    SCR @ (LINE) ; ( 1/2 ADDRESS OF LINE)                  : GET-L  A-L F000 SWAP CMOVE ; ( /0 MOVE LINE TO SCREEN)        : PUT-L  A-L F000 ROT ROT CMOVE ; ( /0 MOVE LINE FR SCREEN)     : DISPATCH ( 1/0 EXECUTE CONTROL CHARACTER)                     ( ^D) DUP  4 = IF  1B EMIT  57 EMIT  DROP ELSE                  ( ^I) DUP  9 = IF  I-STATE 1 TOGGLE  DROP ELSE                  ( ^X) DUP 18 = IF  1B EMIT  45 EMIT  DROP ELSE                  ( ^Y) DUP 19 = IF  1B EMIT  52 EMIT  DROP ELSE                  ( ^Q) DUP 11 = IF  ." ABORTED"       QUIT ELSE                    EMIT THEN THEN THEN THEN THEN ;                               : EMIT1  I-STATE @ IF  1B EMIT  51 EMIT  THEN EMIT ; ( 1/0)     : XX     BEGIN  KEY DUP DUP 20 <                                             IF DISPATCH ELSE EMIT1 THEN ( ^E) 5 = UNTIL  ;     : E-L    HOME DUP GET-L XX A EMIT PUT-L UPDATE ;                : C-L    SWAP A-L DROP SWAP A-L CMOVE  ;  -->                   ( GET-S   10 0 DO I A-L F000 I 80 * + SWAP CMOVE LOOP ;     )   ( PUT-S   10 0 DO F000 I 80 * + I A-L UPDATE CMOVE LOOP ;   )   ( CLEAN   F800 F000 DO I C@ 7F AND I C! LOOP ;              )   ( E-S     0 I-STATE !  HOME GET-S XX CLEAN PUT-S HOME )         ( EDIT SCR ! E-S )  : L-S SCR @ LIST ; : LO-S SCR @ LOAD ;      : INIT-STAR 1B 5 BDOS . 43 5 BDOS . 42 5 BDOS .                             1B 5 BDOS . 4E 5 BDOS . 4 5 BDOS . ;                : LAST-SEC ( 0/1 LEAVES ONE MORE THAN THE LAST BLOCK NR)            0 BEGIN 1+ F000 OVER 1 R/W DISK-ERROR @ UNTIL               ;                                                               : EXTEND   ( 1/0 EXTENDS # BLOCKS WITH NUMBER-1 )                 8 * LAST-SEC HOME ( GET AMOUNT OF BLOCKS)                       SWAP OVER + SWAP DO F000 I 0 R/W LOOP                           FCB 10 BDOS DROP    ( CLOSE THE FILE,I.E. UPDATE DIRECTORY)     FCB 0F BDOS DROP    ( OPEN AGAIN  )                           ;   DECIMAL                                                             ( SCR # 3 NIET DEBUGGED 84 AUG 24)                      : M-L-N 15 A-L DROP                                                  1 SCR +!  0 A-L CMOVE   -1 SCR +! ;                        : FETCH  ( 1/0 GET SCREEN-1 INTO MEMORY )                            FLUSH SWAP DUP FETCH                                            B/SCR * SWAP B/SCR * ( GET START BUFFER #'S)                    B/SCR 0 DO                                                         OVER I + BLOCK                                                  OVER I + 0 R/W ( zou gevaarlijk zonder FLUSH)                LOOP                                                            DROP DROP                                                                                                                  ;                                                                                                                                                                                                                                                               ( ERROR MESSAGES   )                                            MSG # 1 : EMPTY STACK                                           MSG # 2 : DICTIONARY FULL                                       MSG # 3 : HAS INCORRECT ADDRESS MODE                            MSG # 4 : ISN'T UNIQUE                                                                                                          MSG # 6 : DISK RANGE ?                                          MSG # 7 : FULL STACK                                            MSG # 8 : DISC ERROR !                                                                                                                                                                                                                                                                                                                                                                                                                                          ( FIG FORTH FOR CP/M 2.0 ADAPTED BY A. VD HORST HCCH )          ( ERROR MESSAGES   )                                            MSG # 17 : COMPILATION ONLY, USE IN DEFINITION                  MSG # 18 : EXECUTION ONLY                                       MSG # 19 : CONDITIONALS NOT PAIRED                              MSG # 20 : DEFINITION NOT FINISHED                              MSG # 21 : IN PROTECTED DICTIONARY                              MSG # 22 : USE ONLY WHEN LOADING                                MSG # 23 : OFF CURRENT EDITING SCREEN                           MSG # 24 : DECLARE VOCABULARY                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    (  DEBUG   SCR#6)    0 VARIABLE BASE'                          : <HEX   BASE @ BASE' ! HEX ;       ( 0/1  SWITCH TO HEX)       : HEX>   BASE' @ BASE !     ;       ( 1/0  AND BACK)            (        1/0  PRINT IN HEX REGARDLESS OF BASE)                  : H.     <HEX 0 <# # # # # #> TYPE SPACE HEX> ;                 (        1/0  IDEM FOR A SINGLE BYTE)                           : B.     <HEX 0 <# # # #> TYPE HEX> ;                           : BASE?  BASE @ H. ;                ( 0/0 TRUE VALUE OF BASE)   : ^      ( 0/0 NON DESTRUCTIVE STACK PRINT)                              CR ." S: " SP@ S0 @ ( FIND LIMITS)                              BEGIN OVER OVER = 0=                                            WHILE 2 - DUP @ H.                                              REPEAT                                                          DROP DROP                                              ;                                                                                                              -->              <HEX ( DEBUG SCR#7 )                                            :  DUMP   ( 2/0  DUMPS FROM ADDRESS-2 AMOUNT-1 BYTES)                     OVER + SWAP FFF0 AND                                            DO                                                                 CR I H. ." : "                                                  I                                                               10 0 DO                                                            DUP I + C@ B.                                                   I 2 MOD IF SPACE THEN                                        LOOP                                                            1B EMIT 67 EMIT                                                 10 0 DO DUP I + C@ EMIT LOOP                                    1B EMIT 47 EMIT                                                 DROP                                                         10 +LOOP         CR                                   ;    HEX>                                                       ." SYSTEM ELECTIVE CP/M FIGFORTH EXTENSIONS 84AUG12 AH"                                                                         ( EDITOR )         1 LOAD                                                                                                       ( HEX UT. )        6 LOAD                                       ( QUADR. ARITHM.)  9 LOAD                                       ( CP/M READ )     15 LOAD                                       ( CP/M WRITE)     18 LOAD                                       ( CP/M LOAD )     21 LOAD   ( BUGS)                             ( KRAKER )        10 LOAD                                       ( NEW SYSTEM)     23 LOAD                                       ( CRC )           71 LOAD                                       ( SPECIAL CHAR )  30 LOAD                                       ( ASSEMBLER)      74 LOAD                                       ( STAR PRINTER )  31 LOAD                                       ( CP/M CONVERT )  80 LOAD                                       ." QUADRUPLE ARITHMETIC 08-02-84 "                              : ADC ( n1,n2-n,c  add, leave sum and carry)                       0 SWAP 0 D+ ;                                                : 2M+ ( d1,d2-d,c  add double )                                   >R SWAP >R    ADC R> ADC   R> SWAP >R                           ADC R> + ;                                                    : 3M+ ROT >R 2M+ R> ADC ;                                       : 4M+ ROT >R 3M+ R> ADC ;                                       : 2U*  ( d1,d2-q unsigned product)                              ROT ( l1,l2,h2,h1)    OVER OVER U* >R >R ^                      ROT ( l1,h2,h1,l2)    OVER OVER U* >R >R ^                      SWAP DROP ROT ROT ( l2,l1,h2) OVER OVER U* >R >R ^              DROP ( l1,l2)    U* ^ R> ADC ^ R> ADC ^                          IF ( carry) R> R> 2M+ 1+ ." C" ELSE                                         R> R> 2M+    ." NC" THEN  ^                         R> R> 2M+ DROP ^ ;                                             CR ." 84NOV22  FORTH KRAKER >1<  ALBERT VAN DER HORST "         0 VARIABLE SELTAB 120 ALLOT   SELTAB VARIABLE SELTOP            : T,  ( N--. Put N in select table)                                 SELTOP @ !  2 SELTOP +!  ;                                  : CFOF ( --N Get cfa of word following )                           [COMPILE] ' CFA ;                                            : C->P 2 + ; ( N--N Converteer cfa naar pfa )                   : ID.. C->P NFA ID. ; ( cfa--. Print a words name )             : SEL@    ( N--M,F F="value N present in table" )                  ( if F then M is vector address else M=N)                          0 SWAP ( initialise flag)                                       SELTOP @ SELTAB DO                                                  DUP I @ = IF ( FOUND!) DROP DROP 1 I 2+ @ THEN              4 +LOOP        SWAP   ( get flag up)  ;                   : <> - 0= 0= ;  : CR 13 EMIT 10 EMIT ;                          30 LOAD 33 LOAD -->                                              CR ." 84NOV24  FORTH KRAKER >2<  ALBERT VAN DER HORST "          HERE VARIABLE LIM                                             : (KRAAK) ( CFA--. Decompile a word from its CFA )                 DUP NEXTN LIM ! ( Get an absolute limit)                        DUP @ SEL@ IF ( Is content of CFA known?)                          EXECUTE ( Assuming CFA also on stack)                        ELSE                                                               CR DROP DUP DUP @ 2 - = IF                                          ." Code definition : " ELSE ." Can't handle : "             ENDIF ID.. CR                                                ENDIF ;                                                      : KRAAK  ( Use KRAAK SOMETHING to decompile the word SOMETHING)     CFOF (KRAAK) ;                                              : ?IM  ( CFA--f tests whether word IMMEDIATE )                       C->P NFA C@ $40 AND ;                                      : ?Q ?TERMINAL IF QUIT THEN ; ( NOODREM) -->                    CR ." 84NOV24  FORTH KRAKER >3<  ALBERT VAN DER HORST "         : BY ( CFA--. the CFA word is decompiled using : )                T, CFOF T, ; ( a word from the input stream )                 ( Example of a defining word decompilation)                     ( It is done by examples of the defined words )                 : -co DUP C->P @ CR H. ." CONSTANT " ID.. CR ;                         CFOF 0 @ BY -co                                          : -va DUP C->P @ CR H. ." VARIABLE " ID.. CR ;                         CFOF SELTAB @ BY -va                                     : -us DUP C->P C@ CR B. ."  USER " ID.. CR ;                           CFOF FENCE @ BY -us                                      : ITEM ( 1/1 Desinterpret next item, increments pointer)            DUP @ SEL@ ( Something special ?)                               IF EXECUTE ( The special) ELSE                                     DUP ?IM IF ." [COMPILE] " THEN ID.. 2+                       THEN ; -->                                                  CR ." 84NOV24  FORTH KRAKER >4<  ALBERT VAN DER HORST "         CFOF TASK @ CONSTANT DOCOL ( Get the  DOCOLON address )         ( Decompilation of special high level words)                     : -hi CR ." : " DUP DUP ID.. 2 +  CR                             BEGIN ?Q DUP @  LIT ;S <> >R DUP LIM @ < R> AND WHILE                ITEM REPEAT                                                CR DROP ." ;" ?IM IF ."  IMMEDIATE " THEN CR ;                      CFOF TASK @  BY -hi                                       ( for all -words: 1/1 pointer before afd after execution)       : -lit 2+ DUP @ H. 2+ ;                                             CFOF LIT BY -lit                                            : -0br CR ." 0BRANCH [ " -lit ." , ] " ;                            CFOF 0BRANCH BY -0br                                        : -br  CR ." BRANCH  [ " -lit ." , ] " ;                            CFOF BRANCH BY -br                                           -->                                                            CR ." 84JAN06  FORTH KRAKER >5<  ALBERT VAN DER HORST "          : -dq 2+ DUP COUNT CR ". EMIT "" EMIT BL EMIT                      TYPE "" EMIT BL EMIT  COUNT + ;                                                         CFOF (.") BY -dq                                                                                     : -do CR ." DO " 2 + ;     CFOF (DO) BY -do                     : -lo CR ." LOOP " 2 + ;   CFOF (LOOP) BY -lo                   : -pl CR ." +LOOP " 2 + ;  CFOF (+LOOP) BY -pl                  : -cm ." COMPILE " -lit ;  CFOF COMPILE BY -cm                  ( DIRTY TRICK FOLLOWING :)                                      : -pc CR ." ;CODE plus code (suppressed)"                         DROP ' TASK ; ( Destroy deecompile pointer !)                     CFOF (;CODE) BY -pc                                                                                                                                                                                                                                        ( DISK IO SCREEN 15 SCHRIJVEN >1< VERSIE #1)                    <HEX  0 VARIABLE FCB2   21 ALLOT  ( BUG: 2nd goes wrong)        : CLEAN-FCB DUP 21 0 FILL  1+ 0B 20 FILL ;                      : FILL-FCB 22 WORD                                                 1+ HERE  COUNT ROT SWAP CMOVE  ;                             : SET-DMA  1A BDOS DROP ;                                       : ?PRES   FCB2 0F BDOS 0FF - IF ." ALREADY PRESENT" QUIT THEN      FCB2 10 BDOS DROP ;                                            -->                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ( SCR # 16 SCHRIJVEN >2<   )                                    0 VARIABLE DISK-BUFFER-W 100 ALLOT                              DISK-BUFFER-W VARIABLE POINTER-W                                : .OPENW FCB2 CLEAN-FCB FCB2 FILL-FCB ?PRES                       FCB2 16 BDOS 0FF = IF ." DISK FULL " QUIT THEN                  DISK-BUFFER-W POINTER-W ! ;                                   : .CLOSEW                                                            DISK-BUFFER-W SET-DMA FCB2 15 BDOS . ." LAST RECORD" CR               FCB2 10 BDOS . ." CLOSE STATUS" CR ;                 0A0D VARIABLE CRLF    1A VARIABLE CTRLZ                         : MOVE-DOWN   -80 POINTER-W +!                                                DISK-BUFFER-W 80 OVER + SWAP 80 CMOVE ;           : TO-DISK DUP >R POINTER-W @ SWAP CMOVE                                   R> POINTER-W +!                                                 POINTER-W @ DISK-BUFFER-W -                                     80 >  IF   -->                                       ( Experimenting with drive parameters ) HEX                     ALIGN 0 VARIABLE RW-BUFFER B/BUF ALLOT                          0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      2 , ( 2 sectors/block) RW-BUFFER , 7C0 ,                        HERE 2 ALLOT  0 , 0 , 0 , CONSTANT BL#                           : R/W-BLOCK  ASSEMBLER  ( MACRO: OPCODE -- . )                   POPX, BX|    POPX, AX|                                          ADD, W| AX1| R| AX|  MOVFA, W1| BL# W, XCHGX, BX|               ADC, W| AX1| R| AX|  MOVFA, W1| BL# 2+ W,                       PUSHX, SI|  MOVXI, BX| W,  MOVXI, DX| 0080 W,                   MOVXI, SI| PARAM-BLOCK W,  TO-REAL,  XCHGX, BX|                 INT, 13 B, PUSHF, POPX, BX| TO-PROT,                            POPX, SI|   PUSHX, BX|  NEXT ;                                 CODE READ-BLOCK2 4200 R/W-BLOCK  C;  ( D - . )                  CODE WRITE-BLOCK2 4300 R/W-BLOCK  C; ( D - . )                 DECIMAL                                                         ( TEST OF HARD DISK )                                           : TEST  0.                                                        BEGIN  CR 2DUP D.                                                      2000. D+ ( SKIP 1 MEG)                                          2DUP READ-BLOCK2 1 AND UNTIL                           DROP DROP ;                                                     HEX                                                             0 VARIABLE SYSTEM-OFFSET                                        : SAVE 140 * SYSTEM-OFFSET !                                      140 0 DO I 0 READ-BLOCK2 .                                             SYSTEM-OFFSET @ I + 0 WRITE-BLOCK2 .                     LOOP ;                                                        DECIMAL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          CR ." READ CP/M files >3< AH   84/06/13"                        : GET-LINE ( ADR -- . reads a line to ADR )                          DUP 40 20 FILL ( preset spaces )                                41 OVER + SWAP ( max $41 char to a line, CR!)                   DO  GET-CHAR                                                        DUP "CR" = IF DROP 20 LEAVE THEN                                DUP ^Z   = IF DROP 20 LEAVE THEN                                I C! ( may leave spurious 81th space)                       LOOP  ;                                                    : .READ ( 2/0 READ SCREEN-2 TO SCREEN -1)                            1+ B/SCR * SWAP B/SCR * ( get start buffer #'s)                 DO  I BLOCK DUP GET-LINE                                            DUP 40 + GET-LINE  81 + 0 SWAP C! UPDATE                        I #BUFF MOD 0= IF ( full load of buffers) FLUSH THEN        LOOP                                                      ; HEX>                                                           ( 01-APR-83 LADEN VAN CP/M FILE  #1 )                           ( EXAMPLE: .OPENR TEMP" 25 26 .LOAD .CLOSER )                   <HEX  0 VARIABLE LBUF 3E ALLOT 0 C,                             : I-F-A ( ADRES -- . ,INTERPRET FROM ADDRESS )                      TIB @ >R  IN @ >R  ( SAVE CURRENT INTERPRET POSITION)           TIB !     0 IN !   ( NEW POSITION)                              0 INTERPRET                                                     >R IN !   >R TIB ! ( RESTORE)  ;                                                                                            : .LOAD ( LOAD THE CPM FILE SPECIFIED IN FCB2 )                         BEGIN   LBUF DUP GET-LINE I-F-A                                 EOF @ UNTIL ;                                                                                                                                                                              HEX>                                                                                                                         CR ." TAARTEN AUTOMATISERING DOOR DRS HENK" CR                  ." EEN VOORBEELD UIT BRODIE"     CR                             ." TYPE HELP VOOR DE GLOSSARY"  CR                              0 VARIABLE TAARTEN     0 VARIABLE DIEP-VRIES                    : HELP CR ." GLOSSARY:" CR ." BAK-TAART"                               CR ." EET-TAART" CR ." VRIES-IN" CR ." ONTDOOI"                 CR ." START" CR ." STATUS" CR ;                          : START 0 TAARTEN ! 0 DIEP-VRIES ! ;                            : BAK-TAART 1 TAARTEN +! ;                                      : EET-TAART TAARTEN @ DUP                                             IF -1 TAARTEN +! CR ." DANKJEWEL !" CR ELSE                       CR ." WELKE TAART ?" CR DROP THEN ;                     : VRIES-IN TAARTEN @ DIEP-VRIES +! 0 TAARTEN ! ;                : ONTDOOI DIEP-VRIES @ TAARTEN +! 0 DIEP-VRIES ! ;              : STATUS CR ." AANTAL AANWEZIGE TAARTEN: " TAARTEN ?              CR ." EN NOG " DIEP-VRIES ? ." IN DE DIEP VRIES " ;            ( EXTENDING THE FORTH SYSTEM #1 84/4/12 A.H.)                  <HEX                                                            : NEW-SYSTEM   ( Generates a new FORTH system, )                               ( using the CP/M SAVE command)                        LATEST PFA NFA 10C ! ( Define new topmost word)                 ( Initial value for VOC-LINK and FENCE:)                        HERE DUP 11C ! 11E !                                            HERE 100 / DECIMAL CR                                           CR ." TYPE: SAVE" . ." NEWFORTH.COM"                            BYE                                                        ;     HEX>                                                                                                                                                                                                                                                                                                                                                                                      ." GILBREATH's benchmark - BYTE jan 83 "  ( VERSIE #1)          8190 CONSTANT SIZE                                              0 VARIABLE FLAGS      SIZE ALLOT                                                                                                : DO-PRIME                                                          FLAGS SIZE 1 FILL                                               0 ( 0 COUNT ) SIZE 0                                            DO FLAGS I + C@                                                    IF I DUP + 3 +  ( DUP . )                                          DUP I +                                                         BEGIN DUP SIZE <                                                WHILE 0 OVER FLAGS +  C!  OVER + REPEAT                         DROP DROP 1+                                                 THEN                                                         LOOP                                                            . ." PRIMES" ;                                              ." ERATOSTHENES >1< Variables - A. van der Horst"  CR           ( User specified variables:)                                    52 VARIABLE CH/L  ( Characters per line)                        22 VARIABLE LN/P  ( Lines per page)                              1 VARIABLE PAUSE ( Boolean: pause between pages)                                                                               ( Other:)                                                       6250 CONSTANT SIZE ( 16 numbers pro byte)                       0 VARIABLE FLAGS      SIZE ALLOT                                FLAGS SIZE + CONSTANT END-FLAGS                                 0 VARIABLE LIM     ( part of FLAGS considered)                  0 VARIABLE C#      0 VARIABLE L#  ( char and line counter)      0 VARIABLE THOUSANDS ( #  thousand to be sieved)                0 VARIABLE MILS      ( Contains current thousand)               0 VARIABLE MANTISSA  ( The current thousands is to be printed)  -->                                                             ." ERATOSTHENES >2< Pretty printing - A. van der Horst"  CR     : FFEED  PAUSE @ IF CR ." KEY FOR NEXT SCREEN" KEY DROP THEN        12 EMIT CR ." ERATOSTHENES SIEVE -- PRIMES LESS THAN"           THOUSANDS @ 5 .R ."  000" CR 2 L# ! 1 MANTISSA ! ;          : ?P ( LENGTH -- . , give FF if LENGTH lines don't fat)              DUP L# +! L# @ LN/P @ > IF FFEED L# +! ELSE DROP THEN ;    : NEWLINE  ( Start at a new line, maybe with a mantissa)            1 ?P CR ( Checks first)                                         MANTISSA @ IF MILS @ 6 .R ELSE 6 SPACES THEN                    6 C# !   0 MANTISSA ! ;                                     : ?L ( LENGTH -- . , give LF if LENGTH char's don't fit)             DUP C# +! C# @ CH/L @ >                                         IF NEWLINE C# +! ELSE DROP THEN ;                          : .P   4 ?L SPACE 0 <# # # # #> TYPE ;                          : INIT-P  FFEED NEWLINE  ;   -->                                                                                                ." ERATOSTHENES >3< Bit manipulation - A. van der Horst " CR      HEX                                                           : NOT   0FF XOR ( N -- N  FLIP ALL BITS OF N) ;                 0 VARIABLE S-MASK -2 ALLOT 01 C, 02 C, 04 C, 08 C,                                         10 C, 20 C, 40 C, 80 C,              0 VARIABLE C-MASK -2 ALLOT                                                  01 NOT C, 02 NOT C, 04 NOT C, 08 NOT C,                         10 NOT C, 20 NOT C, 40 NOT C, 80 NOT C,             : INIT-T   FLAGS SIZE 0FF FILL ; ( Preset to 'prime')           DECIMAL                                                         : 8/MOD   0 8 U/ ; ( May be redefined in assembler )            : CLEAR-B ( BIT# --  clears the specified bit)                            8/MOD FLAGS + SWAP  ( Address in flags table)                   C-MASK + C@         ( Get mask)                                 OVER C@ AND SWAP C! ( Clear the bit)  ;               -->                                                             ." ERATOSTHENES >4< Bit manipulation - A. van der Horst " CR    : SET-B ( BIT# --  sets the specified bit)                                8/MOD FLAGS + SWAP  ( Address in flags table)                   S-MASK + C@         ( Get mask)                                 OVER C@ OR SWAP C!  ( Store with bit set)  ;          : TEST-B ( BIT# -- FLAG  Gets a FLAG testable by IF)                      8/MOD FLAGS + C@ SWAP  ( Get flag)                              S-MASK + C@ AND        ( Result: =0 or #0)     ;      : FLIP ( PRIME,START -- .  , marks multiples of PRIME as               (  non prime starting with START)                                  BEGIN  DUP LIM @ U<  WHILE                                             DUP CLEAR-B  OVER +                                      REPEAT   DROP DROP ;                                  -->                                                                                                                                                                                             ." ERATOSTHENES >5< Main program - A. van der Horst " CR        : BATCH1 ( First batch of 500 numbers)                               500 1 ( Only odd numbers)                                      DO I TEST-B                                                        IF I DUP + 1 + DUP .P ( get prime number)                          I FLIP THEN ( Mark multiple as non-prime)                 LOOP ;                                                      : BATCH ( OFFSET --  every  following batch )                        500 0                                                           DO DUP I + TEST-B IF I DUP + 1 + .P THEN                        LOOP DROP ;                                                : SIEVE  ( N --  Makes list of primes <N*1000 )                     DUP THOUSANDS !   500 * LIM !  0 MILS !                         INIT-T INIT-P 2 .P BATCH1                                       THOUSANDS @ 1                                                   DO I MILS !  1 MANTISSA !  NEWLINE I 500 * BATCH LOOP ;     ." DEFINIEER ^. EN  ''.  85JAN06 ALBERT VAN DER HORST"          <HEX                                                             : TOH 30 - DUP 9 > IF 7 - THEN ;                                   1 WIDTH !                                                    : ". ( 0/1 Leaves ASCII character at .  f.i. 'A leaves 41H)       HERE 2 + C@ [COMPILE] LITERAL ; IMMEDIATE                     : ^. ( 0/1 leaves control character at . f.i. ^A leaves 01H)      HERE 2 + C@ 1F AND [COMPILE] LITERAL ; IMMEDIATE              : $.. ( 0/1 leaves hex number f.i. $0A leaves 0AH)                HERE 2 + C@ TOH 10 * HERE 3 + C@ TOH + [COMPILE] LITERAL ;    IMMEDIATE                                                       : $.... ( 0/1 leaves hex number 16 bits)                           0 HERE 6 + HERE 2 + DO 10 * I C@ TOH + LOOP                     [COMPILE] LITERAL ; IMMEDIATE                                   1F WIDTH ! HEX>                                              $1B CONSTANT ESC    $0F CONSTANT SI   $0E CONSTANT SO          ." 84NOV25 Initialize STAR-printer AH "  <HEX                   : PEMIT 7F AND 5 BDOS DROP ;                                    : PCR   0D PEMIT   0A PEMIT ;                                   : INIT-STAR ( N--. N is lines per pages)                           ESC PEMIT "@ PEMIT ESC PEMIT "C PEMIT ( TOS) PEMIT ;         : CONDENSED  ESC PEMIT "P PEMIT "3 PEMIT ;                      : EMPHASIZED ESC PEMIT  "E PEMIT ;                              : DOUBLE ESC PEMIT "G PEMIT ;                                   : BOLD EMPHASIZED DOUBLE ;                                      ( 137 CH/L !    60 LN/P !     0 PAUSE ! )                        : PSPACES  ( 1/0 print N-1 spaces)                                0 DO 20 PEMIT LOOP ;                                          : PTYPE  ( ADDRESS,LENGTH -- . PRINT LENGTH CHAR AT ADDRESS)            -DUP IF                                                         OVER + SWAP DO I C@ PEMIT LOOP THEN ;                   : P."  "" WORD HERE COUNT PTYPE ;       -->                    ( SUPER-TRIO)                                                     0 VARIABLE L                                                  :  HEADER  CR DUP 3 + SWAP                                         DO 8 PSPACES ." SCR #" I 4 .R 36 PSPACES LOOP ;              : 1LINE  DUP 3 + SWAP                                                DO L @  DUP 8 .R I (LINE) PTYPE                                 LOOP PCR ;                                                  : SUPER-TRIO                                                      CONDENSED 3 /MOD SWAP DROP 3 *                                  DUP HEADER CR CR                                                10 0 DO  I L ! DUP 1LINE                                        LOOP  DROP ; HEX>                                                                                                                                                                                                                                                                                                            CR ." KRAAKER"                                                  : NEXTN ( CFA--NFA Get the NFA of the word defined)               C->P NFA LATEST             ( after the CFA one)                2DUP = IF                                                         DROP DROP HERE  ( No following word)                          ELSE                                                              BEGIN                                                              2DUP PFA LFA @ <> WHILE                                         PFA LFA @                                                    REPEAT                                                          SWAP DROP ( The CFA)                                          ENDIF                                                         ;                                                               : NEXTC ( CFA--CFA Like previous definition, giving CFA)          NEXTN PFA CFA ;                                                                                                               CR ." KRAAKER"                                                  : KRAAK-FROM ( .--. Kraak, starting with following word)          CFOF                                                            BEGIN                                                              DUP NEXTN HERE < WHILE                                          NEXTC DUP (KRAAK)                                            REPEAT                                                          DROP                                                          ;                                                               0 VARIABLE aux                                                  : PEMIT $7F AND 5 BDOS DROP ;                                   : TO-LP-KRAAK-FROM                                                ' EMIT @ aux !                                                  ' PEMIT CFA ' EMIT !                                            KRAAK-FROM                                                      aux @ ' EMIT ! ;                                              : A0 ;                                                          : A1 A0 A0 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    CR ." #36 FROBOZZ AMATEUR ADVENTURER >1< 84/4/5 "               ( DIRECTIONS )                                                  0 CONSTANT N  1 CONSTANT NE                                     2 CONSTANT E  3 CONSTANT SE   8 CONSTANT U                      4 CONSTANT S  5 CONSTANT SW   9 CONSTANT D                      6 CONSTANT W  7 CONSTANT NW                                     14 CONSTANT LEN ( gth of 1 entry in map)                        0 VARIABLE MAP LEN 256 * ALLOT                                  ( Offsets from entry in map :)                                  : [inuse] 0 + ; ( boolean : valid entry )                       : [dist] 1+ ; ( 0=unknown,1..FD=distance+1)                       0 CONSTANT UNK ( nown)   255 CONSTANT TRUE                    254 CONSTANT AMB ( iguous)   255 CONSTANT BLO ( cked)           : [dir] + 2+ ;  ( M D -- A address A from MAP entry M dir D)    : [char] 12 + ; ( characterisation : 2 bytes)                   : ZAP MAP LEN 256 * ERASE ;     -->                             CR  ." #37 FROBOZZ AMATEUR ADVENTURER >2< 84/5/27"              0 VARIABLE STATUS 10 ALLOT   ( last 10 moves)                   0 VARIABLE CURPOS ( This position in map)                       0 VARIABLE OLDPOS ( Previous position  in map)                  : SHIFT STATUS 1+ DUP 1 - 10 CMOVE ;                            STATUS 10 + CONSTANT LASTMOVE                                   : MAP[]   ( N -- M Converts position N to address M)                 LEN * MAP + ;                                              : CN   ( defines a characterization )                                   0 VARIABLE ; ( later misschien net vocabje)              CN AMBIGUOUS  CN BLOCKED  CN UNKNOWN                           : ID..   NFA ID. ;                                              : .CHAR  DUP MAP[] [char] @ ( N-- Print char'n)                   DUP IF                                                            DUP ID.. @ AMB = IF ." #" . ELSE DROP THEN                    ELSE    DROP ." PLACE:#" . THEN ;   -->                       CR ." #38 FROBOZZ AMATEUR ADVENTURER >3< 84/5/27"               : WHERE? CURPOS @ .CHAR ;                                       : C-CONNECT ( C P -- Cross connect links between an )              ( unambigous characterization and a position )                   2DUP SWAP !  ( Point from characterization to map address)      MAP[] [char] ! ( Store char'n in map)                       ;                                                               : P-CONNECT ( P1 P2 D -- Connect from P1 to P2 in direction D)      ROT MAP[] [dir] C!                                          ;                                                               : NEW-ENTRY ( -- n Find first free position n in MAP)               MAP 0  BEGIN 1+ SWAP LEN + SWAP OVER [inuse]  C@ 0= UNTIL       SWAP TRUE SWAP [inuse] !                                    ;              -->                                                                                                                                                                              CR  ." #39 FROBOZZ AMATEUR ADVENTURER >4< 84/4/8 "              : FILL-IN  ( Fills in the information from last move)              OLDPOS @ CURPOS @ LASTMOVE C@ P-CONNECT                      ;                                                               : DIRECTION ( N --  moves the status in direction N)                SHIFT DUP LASTMOVE C!                                           CURPOS C@ MAP[] [dir] C@ ( get # of next place in map)          DUP CR ." OSB: exit is : " .CHAR CR                             ( Is it an unknown exit?)                                       DUP 0= IF DROP NEW-ENTRY THEN                                   DUP BLO - IF ( Only change position if not blocked!)              CURPOS @ OLDPOS !  CURPOS !                                     FILL-IN ( Only effective by a new entry )                     ELSE                                                              DROP                                                          THEN  ;              -->                                   CR  ." #40 FROBOZZ AMATEUR ADVENTURER >5< 84/6/27"               : HERE: ( Defining word:makes a name for the current place)       CURPOS @ MAP[] [char] @ 0= IF                                      0 VARIABLE LATEST PFA CURPOS @ C-CONNECT                        FILL-IN ( The last position connection)                      ELSE                                                               CR ." This place already been characterized" QUIT            THEN ;                                                        : TEXT ." N  NE E  SE S  SW W  NW U  D  " ;                     : .DIR 1+ 3 * ' TEXT + 3 TYPE ;                                 : SEND-DIR 1+ 3 * ' TEXT + 3 PTYPE ;                            : EXIT?  ( Print current exits)                                   CURPOS @ MAP[] 10 0 DO                                            DUP I [dir] C@                                                  DUP BLO - IF CR I .DIR ." : " .CHAR ELSE DROP THEN            LOOP DROP ; -->                                              CR  ." #41 FROBOZZ AMATEUR ADVENTURER >6< 84/4/9 "               : CLEAR! ( N -- Clears a place)                                   MAP[] LEN ERASE ;                                             : AUX! ( P -- Characterizes with P the current place)              CURPOS @ MAP[] [char] @ IF                                        ." This place already characterized"                          ELSE                                                              CURPOS @ CLEAR! ( Throw away)                                   OLDPOS @ SWAP LASTMOVE C@ P-CONNECT                           THEN ;                                                        : HERE! @ DUP AUX! DUP CURPOS ! ; ( Use: TROLL HERE! )          : ALSO! AMB OVER ! CURPOS @ MAP[] [char] ! ; ( Use:MAZE ALSO!)  : BACKK    OLDPOS @ CURPOS !  ;                                 : BLOCKED! BLO AUX! BACKK ;                                     : AMB!     AMB AUX! ;                                           : KILL! DUP @ MAP[] [char] 0 SWAP !  0 SWAP ! ;   -->          CR  ." #42 FROBOZZ AMATEUR ADVENTURER >7< 84/6/28"              : P?    ( P -- Dumps a place)                                     CR ." PLACE# FL AU " TEXT ." CHAR"  CR                          DUP 3 .R 4 SPACES                                               DUP MAP[] LEN 2 - 0 DO DUP I + C@ B. SPACE LOOP DROP            .CHAR                                                         ;                                                               : PATCH ( Use: WHOUSE SHOUSE S PATCH )                                ROT @ ROT @ ROT P-CONNECT ;                               : ?FIX  MAP[] [char] @ DUP 0= 0= SWAP @ AMB = 0= AND ;          : ?SWAP ( P1 P2 -- {P1,P2} Change order such that )                     ( P2 has no fixed characterization)                       DUP ?FIX IF SWAP THEN                                           DUP ?FIX IF                                                          CR ." Places differently characterized"  QUIT              THEN  ;   -->                                                 CR  ." #43 FROBOZZ AMATEUR ADVENTURER >8< 84/4/19"              : REPLACE ( P1 P2--. Replace all references to P2 by P1)          ?SWAP   ( or the other way around if P2 characterized)          CURPOS @ OVER = IF                                                  OVER ( P1) CURPOS !                                         THEN                                                            256  0 DO ( For all place do)                                      I MAP[] 0 [dir] 10 OVER + SWAP DO ( For 10 dir's do)               I C@ OVER ( P2) = IF                                               OVER ( P1) I C!                                              THEN                                                         LOOP                                                         LOOP  DROP DROP                                               ;                                                                   -->                                                                                                                         CR  ." #44 FROBOZZ AMATEUR ADVENTURER >9< 84/5/27"              : MYSELF LATEST PFA CFA , ; IMMEDIATE                           : (IDENT)  ( n1 n1 -- Identify locations n1 and n2)               ?SWAP 2DUP REPLACE SWAP ( Destination location on top)          10 0 DO ( For all directions do)                                   OVER MAP[] I [dir] C@                                           OVER MAP[] I [dir] C@                                           2DUP = >R 2DUP UNK = SWAP UNK =  OR R> OR IF                       MAX OVER MAP[] I [dir] C!                                    ELSE                                                               CR MYSELF                                                    THEN                                                         LOOP                                                            DROP ( Destination location) CLEAR! ( Other)                  ;                                                               : FOUND! @ CURPOS @ (IDENT) ;                                   CR ." #45 FROBOZZ MAGIC COMMUNICATION >9A< 84/6/28 "             <HEX 54 3 C! HEX>                                              ( 30 LOAD 31 LOAD ( Get standard communication)                 0 VARIABLE REMEMBER 254 ALLOT ( keeps last message from host)   0 VARIABLE L-W-L ( Boolean: last character was line-feed)       : STORE ( C--. Store char in REMEMBER)                               127 AND ( strip parity)                                         DUP "> - IF ( unless prompt)                                       L-W-L @ IF 0 REMEMBER C! THEN                                   DUP REMEMBER COUNT + C!      ( Store char an place)             REMEMBER C@ 1 + REMEMBER C!  ( Bump count)                      ^J = L-W-L ! ( Keep flag)                                    ELSE DROP THEN  ;                                          : L-STORE ( A L -. Store A in list L )                           2 OVER +! DUP @ + ! ;    -->                                                                                                  CR  ." #46 FROBOZZ MAGIC COMMUNICATION >10< 84/6/27"                                                                            : ECR 13 4 BDOS DROP ;                                          : WAIT BEGIN 0 3 BDOS DUP EMIT DUP STORE                             127 AND   "> = ?TERMINAL OR UNTIL  ;                        : \ ( Sends a line and wait for a prompt)                           P." ECR ( Send the remainder of the line)                       WAIT ;                                                      : COM-DIR DUP SEND-DIR ECR WAIT DIRECTION ;                     : n N COM-DIR ;  : ne NE COM-DIR ;                              : e E COM-DIR ;  : se SE COM-DIR ;                              : s S COM-DIR ;  : sw SW COM-DIR ;                              : w W COM-DIR ;  : nw NW COM-DIR ;                              : u U COM-DIR ;  : d  D  COM-DIR ;                              : bl BLOCKED! ; : ex EXIT? ; : wh WHERE? ; -->                                                                                  CR  ." #47 FROBOZZ AMATEUR ADVENTURER >11< 84/6/12 "            : SEND-NAME  NFA COUNT 127 AND PTYPE ;                          : DROP! DUP @ IF DUP KILL! THEN                                     DUP CURPOS @ C-CONNECT   ' DROP SEND-NAME 32 PEMIT              SEND-NAME ECR WAIT ;                                        : MARK-AUX ( N-- Marks the exits from N)                          MAP[] DUP [dist] C@ 1+ ( Get the marking on top)                SWAP 0 [dir] 10 OVER + SWAP DO                                     I C@ MAP[] [dist] 2DUP C@ < IF                                    OVER SWAP C! ( I C@ MYSELF) ELSE                                DROP THEN                                                  LOOP  DROP  ;                                                 : M-D  MAP[] [dist] C! ; ( Mark distance)                       : INIT-AUX  ( Zeros all normal places)                            255 UNK M-D 255 AMB M-D 255 BLO M-D                             254 MAP[] [dist] 1 MAP[] [dist] DO 0 I C! LEN +LOOP ; -->     CR  ." #48 FROBOZZ AMATEUR ADVENTURER >12< 84/5/22 "            ( The [dist]'s are in a circular list for each distance)        ( The DIST-LIST contains the start entries in these lists)      0 VARIABLE DIST-LIST 50 ALLOT                                                                                                   : APPEND ( I,J --. Append place #J to Ith circular last)          OVER DIST-LIST + C@ 0= IF  ( so list was empty)                   DUP DUP MAP[] [dist] C! ( Make J refer to itself)               SWAP DIST-LIST + C! ( Make list I refer to place #J)          ELSE                                                               SWAP DIST-LIST + C@   ( Get start of circular last)             2DUP MAP[] [dist] C@ SWAP MAP[] [dist] C! ( Redarect 2nd)       MAP[] [dist] C! ( Make 1th of list point to new entry)       THEN ;   -->                                                                                                                                                                                  CR  ." #49 FROBOZZ AMATEUR ADVENTURER >13< 84/5/22 "                                                                            : MARK-EX ( I,N-- Appends all exits from N to the Ith list)       MAP[] 0 [dir] 10 OVER + SWAP DO                                    I C@ MAP[] [dist] C@ 0= IF ( This exit not yet marked)               DUP I C@ APPEND                                            THEN                                                         LOOP  DROP ;                                                  0 VARIABLE START                                                : MARK-NEW-LIST ( N -- Generate Nth circular list)                  0 OVER DIST-LIST + C! ( initialize to empty)                    DUP 1 - DIST-LIST + C@ DUP START C! ( Keep end of list)         BEGIN 2DUP MARK-EX MAP[] [dist] C@ DUP START C@ = UNTIL         DROP DROP ;                          -->                                                                                                                                                    CR  ." #50 FROBOZZ AMATEUR ADVENTURER >14< 84/5/27 "            : (M-U-F) ( N --M Generates circular lists )                           ( until place #N in last one or last list empty)                ( returns M: moves needed)                                 0 DIST-LIST !                                                   0 CURPOS @ APPEND ( Create 0th circular list )                  0 BEGIN                                                            1+ DUP MARK-NEW-LIST                                         OVER MAP[] [dist] C@ ( place N marked?)                         OVER DIST-LIST + C@ 0= ( dead end?) OR UNTIL                    SWAP DROP ;                                                                                                                    : M-U-F  INIT-AUX (M-U-F) ; ( N--M As M-U-F but initialized)    : L-U-U  ( --M Lists incorrect,find length to first UNKNOWN)       INIT-AUX   0 UNK M-D  UNK (M-U-F) ;                                -->                                                        C->P NFA LATEST             ( after the CFA one)                2DUP = IF                                                                  ( from place #K to #J in direction D)                           ( Leaves -1 if nothing found)                        -1 ROT ROT SWAP ( Initiate not found flag)                      MAP[] 0 [dir] ( get first exit from #K)                         10 0 DO                                                            2DUP I + C@ = IF                                                  DROP I ROT ROT LEAVE ( the direction as a flag)               THEN                                                         LOOP  DROP DROP ;                                                                             -->                                                                                                                                                                                                                                                                                             CR ." #52 FROBOZZ AMATEUR ADVENTURER >16< 84/6/12 "             : FIND-FROM ( M,J--D,N Find out place #N in sublist #J)                     ( from where to go in direction D to arrive at M)    DIST-LIST + C@                                                  BEGIN                                                              MAP[] [dist] C@ 2DUP ( get next place from list)                SWAP CONNECTED? -1 -                                         UNTIL                                                           DUP ROT CONNECTED? ( Repeat last,sucessful query)              ; -->                                                                                                                                                                                                                                                                                                                                                                                                                                                           CR ." #53 FROBOZZ AMATEUR ADVENTURER >17< 84/6/28 "                                                                             : F-P-B-N ( N--{0,DN..D2,D1} Find place by its number N)          ( N is reachable by going direction D1,D2..Dn)                  -1 SWAP ( leave stack bottom) DUP M-U-F                         DUP DIST-LIST + C@ IF                                              1 - -1 SWAP DO                                                     I FIND-FROM SWAP                                             -1 +LOOP DROP                                                ELSE                                                               CR ." CAN'T REACH THAT ROOM " CR                             THEN ;                                                                                                                        : GOTO!# ( Use: KITCHEN @ GOTO!# )                                 F-P-B-N CR BEGIN DUP 1+ WHILE COM-DIR CR REPEAT DROP ;       : GOTO!  @ GOTO!# ; ( Use: KITCHEN @ GOTO!# ) -->               CR  ." #54 FROBOZZ INTELLIGENT ENQUIRER >18< 84/6/12 "                                                                          : KEEP: ( Get the info from REMEMBER into a named buffer)         0 VARIABLE HERE 2 -   REMEMBER C@ ALLOT                         REMEMBER SWAP OVER C@ 1+ CMOVE ;                                                                                              : =$ ( S1,S2--F Leaves flag indication equality of strings)          1 ROT ROT ( Start with equal flag)                              DUP C@ 1+ 0 DO                                                     OVER I + C@ OVER I + C@ - IF                                       ROT DROP 0 ROT ROT ( Replace flag with 0) LEAVE              THEN                                                         LOOP DROP DROP  ;                                            -->                                                                                                                                                                                           CR  ." #55 FROBOZZ INTELLIGENT ENQUIRER >19< 84/5/27 "                                                                          : COMPARE-TEXTS ( T--F Leaves flag indicating whether one of th       ( from the array of pointers T has arrived)                 0 SWAP ( Start with no flag)                                    DUP @ -DUP IF                                                     0 DO                                                               DUP I 1+ 2 * + @ REMEMBER =$ IF                                    SWAP DROP 1 SWAP LEAVE                                       THEN                                                         LOOP                                                          THEN  DROP ;                                                                                                                    -->                                                                                                                                                                                           CR  ." #56 FROBOZZ INTELLIGENT ENQUIRER >20< 84/6/27"           0 VARIABLE BLK-TEXTS 10 ALLOT                                   : BLOCKED? BLK-TEXTS COMPARE-TEXTS IF                                     BLOCKED!                                                     ELSE                                                               CR ." Please do by hand! " CR QUIT                           THEN ;                                                   : TRY-HERE ( investigates all exits of the current position)       ( If it discovers blocked exits, it will take care of that,)    ( Special cases are left to the adventurer himself)            CURPOS @ MAP[] 0 [dir] 10 0 DO                                    DUP I + C@ UNK = IF                                                I SEND-DIR ECR WAIT ( try this direction)                       I DIRECTION    BLOCKED?                                      THEN                                                          LOOP ;   -->                                                  CR  ." #57 FROBOZZ INTELLIGENT ENQUIRER >21< 84/6/27 "                                                                          : TRY-EVERY-WHERE ( As TRY-HERE but in the whole map)           TRY-HERE                                                        BEGIN  ?TERMINAL 0= WHILE                                         L-U-U 1 - DIST-LIST + C@ ( Get some place from prev. list)      M-U-F UNK SWAP FIND-FROM                                        DROP ( direction found)                                         GOTO!# ( the place with an UNknown exit)                        TRY-HERE                                                        BLOCKED?                                                      REPEAT                                                          ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0                                                                1                                                                2                                                                3                                                                4                                                                5                                                                6                                                                7                                                                8                                                                9                                                                a                                                                B                                                                C                                                                D                                                                E                                                                F                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 CR ." #70 FROBOZZ AMATEUR ADVENTURER >12< 84/4/8"                ( ****** START SITUATIE *****************)                      ZAP                                                             UNKNOWN UNK C-CONNECT    BLOCKED BLO C-CONNECT                  AMBIGUOUS AMB C-CONNECT                                         CHARACTERIZATION WHOUSE                                         WHOUSE NEW-ENTRY C-CONNECT                                      1 CURPOS !                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ." CRC CHECK FOR FIG  85JAN06 ALBERT VAN DER HORST"             ( Adapted from FORTH DIMENSIONS IV-3 )                           : ACCUMULATE ( oldcrc/char -- newcrc )                            $0100 * XOR                                                     8 0 DO                                                             DUP 0< IF $4002 XOR DUP + 1+ ELSE DUP + THEN                 LOOP ;                                                        : DISPOSE ( crcvalue/adres/len -- newcrcvalue)                     OVER DUP C@ "( = SWAP 1+ C@ BL = AND OVER 1 = AND IF               ( comment; skip it) DROP DROP ") WORD                        ELSE                                                               1+ OVER + SWAP DO I C@ ACCUMULATE LOOP                       THEN ;                                                       : MORE ( -- adr f  Leaves flag if there is more in the block)      BL WORD HERE DUP C@ 2 < OVER 1+ C@ "! < AND 0=               ;                                                               ." CRC 2 "                                                      : VERIFY-BLOCK ( oldcrc/blnr -- newcrc)                           BLK @ >R IN @ >R   BLK !  0 IN !                                BEGIN MORE WHILE                                                    BL OVER COUNT + C! COUNT DISPOSE                            REPEAT DROP ( drop the address left by MORE)                    R> IN ! R> BLK ! ;                                            : VERIFY ( scrnr/crc)                                             0 SWAP B/SCR * DUP B/SCR + SWAP DO                                 I VERIFY-BLOCK                                               LOOP                                                          ;                                                               : VER   SCR @ VERIFY U. ;                                                                                                                                                                                                                                      ( Test screen)                                                       For program exchange, the medium of hard copy is cheap,    convenient, and machine-independent. Its primary disadvantages  are the time required for hand-typing the source code and the   possibility of human error in the process. Even if the screens  LOAD without error messages, some errors may pass undetected    until run-time, when the system crashes mysteriously.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >1<"                    HEX VOCABULARY ASSEMBLER IMMEDIATE : 8* DUP + DUP + DUP + ;     ' ASSEMBLER CFA ' ;CODE 8 + !        ( PATCH ;CODE IN NUCLEUS ) : CODE ?EXEC CREATE [COMPILE] ASSEMBLER !CSP ; IMMEDIATE        : C; CURRENT @ CONTEXT ! ?EXEC ?CSP SMUDGE ; IMMEDIATE          : LABEL ?EXEC 0 VARIABLE SMUDGE -2 ALLOT [COMPILE] ASSEMBLER        !CSP ; IMMEDIATE     ASSEMBLER DEFINITIONS                  4 CONSTANT H    5 CONSTANT L     7 CONSTANT A    6 CONSTANT PSW 2 CONSTANT D    3 CONSTANT E     0 CONSTANT B    1 CONSTANT C   6 CONSTANT M    6 CONSTANT SP     ' ;S 0B + @ CONSTANT (NEXT)   : 1MI <BUILDS C, DOES> C@ C, ;  : 2MI <BUILDS C, DOES> C@ + C, ; : 3MI <BUILDS C, DOES> C@ SWAP 8* +  C, ;                      : 4MI <BUILDS C, DOES> C@ C, C, ;                               : 5MI <BUILDS C, DOES> C@ C, , ;  : PSH1 C3 C, (NEXT) 1 - , ;   : PSH2 C3 C, (NEXT) 2 - , ;       : NEXT C3 C, (NEXT) , ;        -->                                                            CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >2<"                    00 1MI NOP     76 1MI HLT     F3 1MI DI     FB 1MI EI           07 1MI RLC     0F 1MI RRC     17 1MI RAL    1F 1MI RAR          E9 1MI PCHL    F9 1MI SPHL    E3 1MI XTHL   EB 1MI XCHG         27 1MI DAA     2F 1MI CMA     37 1MI STC    3F 1MI CMC          80 2MI ADD     88 2MI ADC     90 2MI SUB    98 2MI SBB          A0 2MI ANA     A8 2MI XRA     B0 2MI ORA    B8 2MI CMP          09 3MI DAD     C1 3MI POP     C5 3MI PUSH   02 3MI STAX         0A 3MI LDAX    04 3MI INR     05 3MI DCR    03 3MI INX          0B 3MI DCX     C7 3MI RST     D3 4MI OUT    DB 4MI IN           C6 4MI ADI     CE 4MI ACI     D6 4MI SUI    DE 4MI SBI          E6 4MI ANI     EE 4MI XRI     F6 4MI ORI    FE 4MI CPI          22 5MI SHLD    2A 5MI LHLD    32 5MI STA    3A 5MI LDA          CD 5MI CALL    C3 5MI JMP                                                      ( CZ,CNZ,CCY,CNC)  -->                                                                                           CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >3<"                    C9 1MI RET                   C2 CONSTANT 0=  D2 CONSTANT CS     E2 CONSTANT PE  F2 CONSTANT 0<   : NOT 8 + ;                    : MOV 8* 40 + + C, ;   : MVI 8* 6 + C, C, ;   : LXI 8* 1+ C, , ;: THEN HERE SWAP ! ;               : IF C, HERE 0 , ;           : ELSE C3 IF SWAP THEN ;           : BEGIN HERE ;               : UNTIL C, , ;                     : WHILE IF ;                 : REPEAT SWAP C3 C, , THEN ;                                    ;S                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              CR ." SIMPLE PROFILER AH   85FEB15"                             LABEL NEXT2      ( REPLACES NEXT!)                                 B LDAX   B INX   A L MOV                                        B LDAX   B INX   A H MOV   (NEXT) 6 + JMP C;                    (NEXT) 3 + JMP C;                                             ODE PROFILE  ( PATCHES THE CODE AT NEXT FOR PROFILING)            $C3 A MVI  (NEXT) STA                                           NEXT2 H LXI    (NEXT) 1+ SHLD     NEXT C;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ыuDFW---HD  р @№	             )@           FAT12      Р       И BК О> ЭУш` А Д ВPЭшU А шk ШшK А шa АDш\ Ш!Рuъ РАFшL њШиаРМ  ћД ВPЭrЙшЊџrДАWш- ш щOАш" А
щ XPPрш XPБвјш X$'ФБвь00џДЭУ                                                                                                                                                                                                                                                                                               UЊщ!щ М Иї@     їИїї    ЧЧ (ГИїИї    PЁ0	Рt=џџt9№twЁ2	Рt9№rыX­УыRP­УкBџ'LIд  o­ыьEXECUTХg~[ысBRANCШr4ыЯ0BRANCШX	РtыFFыК(LOOPЉАЛ ^ F +F1иxЬХFFыNOOаЅввыжыкы(+LOOPЉЧш[ыШ(DOЉмєZXьPRьщ`џЩыF щSџDIGIдџZX,0r<	v,<
r8аs	)вТАщ+џ)Рщ'џ(FINDЉBиР[YЯТ2$?uCG2 РusєУSИ (іщёўCr Рыї	лuЭИ  щнўENCLOSХ7X[SД КџџKCB:tњR:'uаBщЖўCB:t	:'uіащЇўа@щЁўCв.m
 ECMOVХМеќѓY_^иРѓЄощyўUЊЫэX[їущhўUЏцќ[ZX9кsїѓщUўИџџТщMўANФѕX[!ищ?ўOв&X[	ищ1ўXOв5X[1ищ"ўSPР-DрщўSPЁ<Q,gщўRPРIcшщі§RPЁ[p,oщх§;гhv EEщж§LEAVХzF FщУ§>вЃ[MM^ щГ§RОГF EEщЃ§вЌ0НЛШX	РИ tHщ§0МСлX	РИ xHщw§ЋдэX[ищj§DЋчћXZ[YЪищW§MINUгєXїищH§DMINUг![Y)РТ)Ъищ/§OVEв7ZXPщ §DROа.FXщ§SWAа=SZXщ§DUаJ`XPщљќ2DUаXnXZRPщшќ+Ёe|[XщмќTOGGLХuX[0щЪќР[щНќCРЈ[(фщЎќ2РЁЗ[WщќЁАЦ[XщќCЁРд[Xщќ2ЁЭт[XXGщrќLРлє[Yкйкщ]ќLЁэ[YкйXкщIќСК.з		аТФ\
Џ
BMMv жщ&ќСЛ.
8
q
N
CONSTANд9.q
YЏ
BгщіћVARIABLХK.VЏ
BRщсћUSEвh.VЏ
Bг(џ>,щУћА~Ё1РщИћБЌИ щЌћВІИИ щ ћГВФИ щћBЬО`  C/ЬЪ`@ FIRSдг`јїLIMIдн`  EЭщ`  B/BUЦѕ` B/SCвў` +ORIGIЮ
.m ыSА RА* TIТ3
 WIDTШ< WARNINЧF FENCХR Dа` VOC-LINЫl BLЫu IЮ OUд SCв OFFSEдЁ  CONTEXдЋ  CURRENдИ" STATХЦ$ BASХд& DPЬр( FLФы* CSаѕ, RЃџ. HLФ	0 1Ћ#X@щ6њ2Ћ/X щ(њHERХ(.qALLOд6.qzЌE.=ФЖMCЌU.=вЊM­e|ZX)ащлљНv.zЦМZXг1Уx)а	РИ  y@щДљUМ.l3й DйЦ zйОЊ.QROдЫпZ[XSщwљSPACХз.ЯE-DUац.^ ^TRAVERSХі.Q5ыm 5І№џQDLATESд		.аLFС0	.m zCFСC	.ЖzNFСS	.m zmџџ	PFСa	.Њ	m ы!CSаw	.BФ?ERROв	.Q  D?COMа	.мЦm Ѕ	?EXEУЗ	.мm Ѕ	?PAIRгЯ	.zm Ѕ	?CSах	.Bzm Ѕ	?LOADINЧњ	.Цm Ѕ	COMPILХ
.П	Б^-ЁYСл.
.мФнJ
.mР мФSMUDGХX
.9	m  HEиh
.m чФDECIMAЬ}
.m
 чФ(;CODEЉ
.Б9	}	Y	ФХ;CODХЅ
.
8
Џ
N
Ю<BUILDгН
.VDOESОг
.Б9	}	ФЏ
ьVьBг7BBRщVїCOUNдх
.^!QІ-TRAILINЧ	.^ђ55ыЊzІЯz  ЊzЎрџ(."Љ.П^!БыЁТ.ЂU.m" м 8
\`=І!M
 `=QUERйp.BmP yФС.* ЊzФЊzЦ з	БD БDFILЬЛ XY_лУќѓЊщRіERASХї.ўBLANKг.ЯўHOLФ.mџџzвPAФ..=mT ыWORФG. A BыQ=m" &z5zЁП=вы=!Бг(NUMBERЉY.!^ЁІч, QчыDнчыљё! ЊёzБЦџБNUMBEвІ.н^!Іm- ^ЁыmџџёФБ^ІЯz ^Іm. zЅ	мџDБ -FINФѓ.Я`=Т@^Ц
 D=9	@(ABORTЉL.хERROвv.\й =\? O§ QИIDЎ.Mm  m_ ў^}	I	5zMQгMm ЊzlыІm EюCREATХН.T Dg	Уm ю=^ІNп!M^m  =Њzm 9	YаФ=-YЩ[COMPILEн.TЦЅ	DY	YЧLITERAЬX.м 8
mYШDLITERAЬv.м Q?STACЫ.B/QЏЊЅ	B=m ыЏm Ѕ	INTERPREдЏ.T м
 Y	Y Y	|И =ќё!  DИТџIMMEDIATХм.9	m@ VOCABULARй*.н
m YаY	Y=YФэ
-ТФХFORTШBљ
o М  DEFINITIONгw.ТаФСЈ.m) `QUIдЃ.ФN
nСЇшмЦ \OKчџABORдБ.O
ИСc\IBM-PC Fig-Forth 2.0.CИОщIђWARЭн.мхОNИ  иЛ CCШи&аРќ..щђWCOLФ.мхkФхvФmm,m гmmФхS->ФPZ)Р	вyHщФё+­.й D+­.й ABгЊ.^DABгМ.^АMIЮЪ.lЯ QDMAий.l QDMЊя.l3ЁТQТыБАMЏ.5ЁЁбПТњБП3QБQЊ .
D/MOФG.ЁБ%ЏS.ZQDMOФf.ZD*/MOФt.Ё
Б%*Џ.QDM/MOФ.ЁПњБQЁњБ(LINEЉЅ.Ёm@ БKыAыm@ .LINХУ.Ь)MESSAGХъ.\ §
 m ђю \MSG # 'PCРќ7Zь(фщ №PCЁ/FZXющ№PР>SZэщ№PЁL_ZXящњяUSХXyјїPREжeyјї#BUFЦo` +BUЦz.mы^ё Dх^vzUPDATХ.vm $vФEMPTY-BUFFERг­.хё5zBUFFEвЬ.mџ k^ЁќџkФПй П-Пmџ~ПФПvФБ-BLOCЫъ.mџ ДыЁv^Пz^ы4 Ц DПѓ^ПЊ~Жz^Пz^ыЦжџ^vФБD-FLUSШ9.!ђѓDЎјџLOAФ.ЁЁФKФшБФБФУ--ОН.
Ф5zzzBIOг№XЂ&ZY[XVUЭ ]^PSQRщ.юBDOг:ZY[XЭ!PSQRщюSMALЬ1.mOm
m DDDDDEXPECдH.5ы5ђѓ^m  * D^^БЖzыЁ
 m  m ( ^m  DЯ ^в!ФEЎџDKEйp.m m DDDDmџ TYPХэ.§ 5ыQђІEЎјџ DEMIд.Њzm ^m
  m xФx(EMITЉ>.m ыm DDDDD?TERMINAЬo.m m m@ ЦЁDDDDБPOUд.m DDDDDDRIVХЬy  RECORФэy  SEC/BLЫљ` DISK-ERROвy  LBAPAвy    Р        RBLЫ%IXVЦUИ BК Э]^щьWBLЫ@eXVЦUИ CК Э]^щчыR/з\.Ёm K.m ыФ.m ыФ.П G c^!ФЊ^ m	 БzЅ	СЇx.TЦЅ	DFORGEдШ.аТzm Ѕ	Ь^hm Ѕ	^g	qФI	ТФBACЫм.=zYХBEGIЮ.П	=ЊХENDIЦ,.П	Жю	=5zQФФTHEЮ>.FТDЯZ.8
ђ=ТФLOOаg.Тю	8
Ў"Х+LOOаx.Тю	8
ц"ХUNTIЬ.Њю	8
"УENФЃ.ЋХAGAIЮЙ.Њю	8
"ЦREPEAдХ.ЁЁЭББЖzFТIЦл.8
=YЖФELSХј.Жю	8
=YQЖFЖХWHILХ.§-SPACEг..ѕ§ ђюЎќџ<Ѓ>.MФ#О_.DDM5zSIGЮn.нй m- 5Ѓ.ч­нm	 5 m ыm0 ы5#г.Ђ55$ЦєџD.вШ.ЁQ5бdЭsБ5zG.вп.ЁБхDЎ.хюЎ.П#.'UЎ/.VLISд;.m ФТйЯ
 СФ^Уюю}	I	^ЦЄ$дџDBYХHЭ'LISд.
С^ЇФ\SCR # 'm ђСm юЇђЄ ЎтџСINDEи.m EС!QђСm юђЄ ЎфџTRIAФц.m Em jm Km 5ыQђСЃЄ Ў№џС.CPе.чm$ чФm(  ЕчФMATCШ\їY[Z^VЌ:uSQVItJtCЌ:tє^Y[Juцщ YYY№^)№ўщЁчTASЫ.TRIAФ.m 9m jm Km 5ыQђСM Ў№џС.CPеШ.чm$ чФm(  ЕУчФMATCШ5їY[Z^VЌ:uSQVItJtCЌ:tє^Y[Juцщ YYY№^)№ўщїцTASЫ+.1.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ыYDFW--EXP  р @№	             )о}NO NAME    FAT12   шЮ А Д В ЭшУ А шй ШшЙ А шЯ АDшЪ Ш!Рuъk РАFшК њШиаРМ  ћД В ЭrЙЙ" Л ш rЎ;Ё |ѕАWш шe щ_ЭQSШ1вї6 бўС1вї6 жХВ ИЭ[У YAУш> ш1 Шш8 ш) иш0 ш! Рш( ш аш  ш №ш ш	 јш ш УАш" А
щ XPPрш XPБвјш X$'ФБвь00џДЭУ                                                                                                                                                                                                             UЊ№џџ@ `  	  Р р №џџ/@` Рр ! #@%`') +Р-р/ 1 3@5`79 ;Р=р? A C@E`GI KРMрO Q S@U`WY [Р]р_ a c@e`gi kРmрo q s@u`wy {Р}р  @` Рр 	 	@	`		 	Р	р	 
Ё 
Ѓ@
Ѕ`
Ї
Љ 
ЋР
­р
Џ Б Г@Е`ЗЙ ЛРНрП С У@Х`ЧЩ ЫРЭрЯ б г@е`зй лРнрп с у@х`чщ ыРэря ё ѓ@ѕ`їљ ћР§рџ !Aa	ЁСс!AaЁСс!!#A%a')Ё+С-с/1!3A5a79Ё;С=с?A!CAEaGIЁKСMсOQ!SAUќLЁэ[YкйXкщIќСК.з		аТФ\
Џ
BMMv жщ&ќСЛ.
8
q
N
CONSTANд9.q
YЏ
BгщіћVARIABLХK.VЏ
BRщсћUSEвh.VЏ
Bг(џ>,щУћА~Ё1РщИћБЌИ щЌћВІИИ щ ћГВФИ щћBЬО`  C/ЬЪ`@ FIRSдг`јїLIMIдн`  EЭщ`  B/BUЦѕ` B/SCвў` +ORIGIЮ
.m ыSА RА* TIТ3
 WIDTШ< WARNINЧF FENCХR Dа` VOC-LINЫl BLЫu IЮ OUд SCв OFFSEдЁ  CONTEXдЋ  CURRENдИ" STATХЦ$ BASХд& DPЬр( FLФы* CSаѕ, RЃџ. HLФ	0 1Ћ#X@щ6њ2Ћ/X щ(њHERХ(.qALLOд6.qzЌE.=ФЖMCЌU.=вЊM­e|ZX)ащлљНv.zЦМZXг1Уx)а	РИ  y@щДљUМ.l3й DйЦ zйОЊ.QROдЫпZ[XSщwљSPACХз.Я9-DUац.^ ^TRAVERSХі.Q5ыm 5І№џQDLATESд		.аLFС0	.m zCFСC	.ЖzNFСS	.m zmџџ	PFСa	.Њ	m ы!CSаw	.BФ?ERROв	.Q  D?COMа	.мЦm Ѕ	?EXEУЗ	.мm Ѕ	?PAIRгЯ	.zm Ѕ	?CSах	.Bzm Ѕ	?LOADINЧњ	.Цm Ѕ	COMPILХ
.П	Б^-ЁYСл.
.мФнJ
.mР мФSMUDGХX
.9	m  HEиh
.m чФDECIMAЬ}
.m
 чФ(;CODEЉ
.Б9	}	Y	ФХ;CODХЅ
.
8
Џ
N
Ю<BUILDгН
.VDOESОг
.Б9	}	ФЏ
ьVьBг7BBRщVїCOUNдх
.^!QІ-TRAILINЧ	.^ђ55ыЊzІЯz  ЊzЎрџ(."Љ.П^!БыЁТ.ЂU.m" м 8
\`=І!M
 `=QUERйp.BmP mФС.* ЊzФЊzЦ з	БD БDFILЬЛ XY_лУќѓЊщRіERASХї.ўBLANKг.ЯўHOLФ.mџџzвPAФ..=mT ыWORФG. ; BыQ=m" &z5zЁП=вы=!Бг(NUMBERЉY.!^ЁІч, QчыDнчыљё! ЊёzБЦџБNUMBEвІ.н^!Іm- ^ЁыmџџёФБ^ІЯz ^Іm. zЅ	мџDБ -FINФѓ.Я`=Т@^Ц
 D=9	@(ABORTЉL.хERROвv.\й =\? O§ QИIDЎ.Mm  m_ ў^}	I	5zMQгMm ЊzlыІm 9юCREATХН.T Dg	Уm ю=^ІNп!M^m  =Њzm 9	YаФ=-YЩ[COMPILEн.TЦЅ	DY	YЧLITERAЬX.м 8
mYШDLITERAЬv.м Q?STACЫ.B/QЏЊЅ	B=m ыЏm Ѕ	INTERPREдЏ.T м
 Y	Y Y	|И =ќё!  DИТџIMMEDIATХм.9	m@ VOCABULARй*.н
m YаY	Y=YФэ
-ТФХFORTШBљ
o Т  DEFINITIONгw.ТаФСЈ.m) `QUIдЃ.ФN
nСЇшмЦ \OKчџABORдБ.O
ИСi\IBM-PC Fig-Forth 2.0.AИОщIђWARЭн.мхОNИ  иЛ CCШи&аРќ..щђWCOLФ.мхkФхvФmm,m гmmФхS->ФPZ)Р	вyHщФё+­.й D+­.й ABгЊ.^DABгМ.^АMIЮЪ.lЯ QDMAий.l QDMЊя.l3ЁТQТыБАMЏ.5ЁЁбПТњБП3QБQЊ .
D/MOФG.ЁБ%ЏS.ZQDMOФf.ZD*/MOФt.Ё
Б%*Џ.QDM/MOФ.ЁПњБQЁњБ(LINEЉЅ.Ёm@ БKы;ыm@ .LINХУ.Ь)MESџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџџіііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііііі; NASM listing: Make some MASM directives harmless up front.
%macro IGNORE1 1+ ; One or more parameters
%endmacro
%define IGNORE   ; no parameters
%define PAGE IGNORE
%define CSEG IGNORE1
%define ASSUME IGNORE1
%define PROC IGNORE1
%define TITLE IGNORE1
%define OFFSET IGNORE
%define END IGNORE1
; ENDP can only be made harmless by commenting the whole line out
; `comment x' is replace by `%if 0' constructions.
	; PAGE  66,106
 TITLE   FIG-FORTH FOR IBM-PC   1.0
%if 0 
              FIG-FORTH
   implemented by:  Charlie Krajewski
                    205 ( BIG ) Blue Rd.
		    Middletown, CT  06457

        NASM assembler version by:
                Albert van der Horst
                HCC Forth user group
                The Netherlands
                www.forth.hccnet.nl

  This implementation supports only one 64k segment

  The listing has been made possible by the
  prior work of:
               Thomas Newman, Hayward, Ca.

 : other_acknowledgements
         John_Cassidy
         Kim_Harris
         George_Flammer
         Robert_D._Villwock ;
 To upgrade, modify, and understand Fig Forth, the
 value of the following book cannot be overstated:
         Systems Guide to FIG Forth
         C. H. Ting, PhD
 It is available through MVP.  See any recent issue
 of FORTH Dimensions for their ad.

No one who programs with FORTH can afford to be without:
  Starting Forth
  Leo Brodie
Get it.  Available through FORTH Interest Group.
Can also be found in many book stores.
Chapter 3 serves as a guide for the EDITOR that you
will probably type in from the FIG-Forth installation
manual.

Although there is much to be said for typing in your own
listing and getting it running, there is much to be said 
not typing in your own listing.  If you feel that 100+
pages of plinking is nutty, contact me for availability
of a disc with source & executable files.  Obtainable at
a bargain basement price, prepare yourself for bargain
basement support.

All publications of the FORTH Interest Group are public domain.
They may be further distributed by the inclusion of this
credit notice:
               This publication has been made available by:
       
               FORTH Interest Group
               P.O. Box 1105
               San Carlos, Ca.  94070
%endif
	PAGE
FIGREL	EQU	1	; FIG RELEASE #
FIGREV	EQU	0	;FIG REVISION #
USRVER  EQU     0  	; USER VERSION NUMBER
;
;	ASCII CHARACTER EQUIVALENTS
;
ABL	EQU	20H	; SPACE
ACR	EQU    	0DH	; CR
ADOT	EQU	2EH	; PERIOD
BELL	EQU	07H	; ^G
BSIN	EQU	08H	; INPUT DELETE CHARACTER
BSOUT	EQU	08H	; OUTPUT BACKSPACE ( ^H )
DLE	EQU	10H	; ( ^P )  MAKE PRINTER OUTPUT DEVICE
LF	EQU 	0AH	; LINE FEED
FF	EQU	0CH	; FORM FEED
;
;	MEMORY + I/O CONSTANTS
;
SEC_DSK	EQU	360
PRINTER_NO	EQU	0
EM	EQU	04000H	; END OF MEMORY + 1
NSCR	EQU	2	; NO. 1024 BYTE SCREENS
KBBUF	EQU	512	;DATA BYTES PER DISK BUFFER
US	EQU	40H	; USER VARIABLE SPACE
RTS	EQU	0A0H	; RETURN STACK & TERM BUFFER
;
CO	EQU	KBBUF+4		; DISK BUFFER + 4 BYTES
NBUF	EQU	NSCR*1024/KBBUF	; NO. OF BUFFERS
BUF1	EQU	EM-CO*NBUF	; FIRST DISK BUFFER
INITR0	EQU	BUF1-US		; ( RO )
INITS0	EQU	INITR0-RTS	; ( S0 )
;
 PAGE
 CSEG    SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG,DS:CSEG,SS:CSEG,ES:CSEG
	ORG	100H	; FOR EXE2BIN COMMAND AFTER LINK
;			  SEE PG 10-14 OF DOS 2.0 MANUAL
;                         FOR EXPLANATION OF EXE2BIN
ORIG	PROC	FAR	; SEE PG 5-31, MACRO ASSEMBLER
	NOP
	JMP	LCLD     ;VECTOR TO COLD START
	NOP
	JMP	WRM	; VECTOR TO WARM START
;
	DB	FIGREL	; FIG RELEASE #
	DB	FIGREV	; FIG REVISION #
	DB	USRVER	; USER REVISION #
	DB	0EH	; VERSION ATTRIBUTES
	DW	TASK-7	; TOP WORD IN FORTH VOCABULARY
	DW	BSIN	; BACKSPACE
	DW	INITR0	; INIT (UP)
;
;	<<<<< following used in COLD start >>>>>
;       <<<<< must be in same order as user variables >>>>>
;
	DW 	INITS0	; INIT (S0)
	DW 	INITR0	; INIT (R0)
	DW 	INITS0	; INIT (TIB)
	DW	32	;       INIT (WIDTH)
	DW	0	; 	INIT (WARNING)
	DW	INITDP	;	INIT (FENCE)
	DW	INITDP  ;	INIT (DP)
	DW	FORTH+6	;	INIT (VOC-LINK)
	;
;	<<<<< end of data used by cold start >>>>>
;
;	The following is the CPU's name, printed
;       during cold start.
;       The name is 32 bits in base 32.
;
	DW	5H,0B328H	; '8088'
UP	DW	INITR0	; USER AREA POINTER
RPP	DW	INITR0	; RETURNS STACK POINTER
	PAGE
%if 0
   FORTH REGISTERS

   FORTH   8088     FORTH PRESERVATION RULES
   -----   ----     ----- ------------ -----
    IP      SI      Interpreter pointer.  Must be preserved
                    across FORTH words.

     W      DX      Working register.  Jump to 'DPUSH' will
                    push contents onto the parameter stack
                    before executing 'APUSH'.
 
    SP      SP      Parameter stack pointer.  Must be preserved 
                    across FORTH words.
 
    RP      BP      Return stack.  Must be preserved across
                    FORTH words.

            AX      General register.  Must be preserved across
                    FORTH words.

            BX      General purpose register.
 
            CX      General purpose register.

            DI      General purpose register.

            CS      Segment register.  Must be preserved
                    across FORTH words.

            DS      ditto
        
            SS      ibid
 
            ES      Temporary segment register only used by
                    a few words.

---------------------------------------------------------- 
%endif
	PAGE
%if 0 
---------------------------------------------

   COMMENT CONVENTIONS
   ------- -----------

   =       IS EQUAL TO
   <-      ASSIGNMENT

  NAME        =  Address of name
  (NAME)      =  Contents of name
  ((NAME))    =  Indirect contents

  CFA         =  Address of CODE FIELD
  LFA         =  Address of LINK FIELD
  NFA         =  Address of NAME FIELD
  PFA         =  Address of PARAMETER FIELD

  S1          =  Parameter stack - 1st word
  S2          =  Parameter stack - 2nd word
  R1          =  Return stack    - 1st word
  R2          =  Return stack    - 2nd word

  LSB         =  Least significant bit
  MSB         =  Most  significant bit
  LB          =  Low byte
  HB          =  High byte
  LW          =  Low  word

------------------------------------------------------------ 
%endif
	PAGE
%if 0 
             DEBUG SUPPORT

THIS ROUTINE WILL ALLOW YOU TO STEP THRU FORTH PROGRAMS
EVERY TIME 'NEXT' IS EXECUTED.

IN ORDER TO USE THE STEP FEATURE YOU MUST DO THE FOLLOWING:

	1.  PATCH THE INSTRUCTION IN 'NEXT' WITH A JUMP
            TO 'TNEXT'
 
    	2.  PATCH YOUR BREAKPOINT ROUTINE AT
            LABEL   'BREAK'
	
	3.  SET VARIABLES, `BIP' & `BIPE' TO THE
            ADDRESSES YOU WANT TO STEP THRU.

THE CONTENTS OF THE 2 VARIABLES 'BIP` AND `BIPE'
ARE INTERPRETED AS FOLLOWS:

BIP	BIPE	DEBUG-CONDITION
---	----	---------------

  0	   X	OFF
 -1	   X    TRACE ALL `NEXT' CALLS
ADDR1      0    TRACE `ADDR1' ONLY
ADDR1  ADDR2    TRACE `ADDR1' TO `ADDR1'

NOTE:	THE ABOVE ADDRESSES CAN'T POINT TO A
	`CODE FIELD ADDRESS'. 
       	X = DON'T CARE

----------------------------------------------------- 
%endif

BIP	DW	0	; BREAKPOINT START ADDRESS
BIPE	DW	0	; BREAKPOINT END ADDR
	PAGE
;	THIS IS THE `NEXT' WITH DEBUG SUPPORT

TNEXT:  PUSHF		;SAVE REGISTER
	PUSH	AX
	MOV	AX,[BIP]  ; BREAKPOINT START ADDR
	OR	AX,AX	; ZERO?
	JZ	TNEXT2	; NO BREAKPOINT
	CMP	AX,-1
	JZ	TNEXT1	; STEP ALL POINTS
	CMP	AX,SI	; IN BREAKPOINT RANGE?
	JZ	TNEXT1	; STEP THIS LOCATION
	JA	TNEXT2	; NO
	MOV	AX,[BIPE] ; BREAKPOINT END ADDR
	OR	AX,AX	; ZERO?
	JZ	TNEXT2	; ONLY 1 LOCATION
	CMP	AX,SI	; IN RANGE STILL?
	JB	TNEXT2	; NO

;	PAUSE ON ADDRESS
;
TNEXT1: POPF
;
;********  ADD YOUR BREAKPOINT HERE  **********
;
BREAK:  JMP	SHORT	TNEXT3	;CONT WITH PROGRAM
;
;	NO BREAKPOINT PAUSE - RESTORE REGISTERS
;
TNEXT2:	POP	AX
	POPF
TNEXT3:	LODSW		; AX <- (IP)
	MOV	BX,AX
	JMP	SHORT	NEXT1
	PAGE
DPUSH:	PUSH	DX
APUSH:	PUSH	AX
%if 0

	Patch the next 3 locations
( using a DBUG monitor )
with a `JMP TNEXT' for tracing through
high level FORTH words.
%endif
NEXT:	LODSW		;AX <- (IP)
	MOV	BX,AX
;
;
NEXT1:	MOV	DX,BX	; (W) <- (IP)
	INC	DX	; (W) <- (W) + 1
	JMP     [BX]    ; TO `CFA'
	PAGE
DP0	DB	83H
	DB	'LI'
	DB	'T'+80H
	DW	0	; START OF DICTIONARY
LIT	DW	$+2	; (S1) <- ((IP))
	LODSW		; AX <- LITERAL
	JMP SHORT     APUSH   ; TO TOP OF STACK

;        EXECUTE
;
	DB	87H
	DB	'EXECUT'
	DB	'E'+80H
	DW	LIT-6
EXEC	DW	$+2
	POP	BX	; GET CFA
	JMP SHORT     NEXT1   ; EXECUTE NEXT
;
;	BRANCH
;
	DB	86H	; BRANCH
	DB	'BRANC'
	DB	'H'+80H
	DW	EXEC-0AH
BRAN	DW	$+2
BRAN1:	ADD	SI,[SI]
	JMP SHORT     NEXT    ; JUMP TO OFFSET
;
;	0BRANCH
;
	DB	87H
	DB	'0BRANC'
	DB	'H'+80H
	DW	BRAN-9
ZBRAN	DW	$+2
	POP	AX	; GET STACK VALUE
	OR	AX,AX	; ZERO?
	JZ	BRAN1	; YES, BRANCH
	INC	SI	; NO - CONTINUE...
	INC 	SI
	JMP SHORT     NEXT
;
	PAGE
;
;	(LOOP)
	DB	86H
	DB	'(LOOP'
	DB	')'+80H
	DW	ZBRAN-0AH
XLOOP	DW	$+2
	MOV	BX,1	; INCREMENT
XLOO1:	ADD	[BP],BX	; INDEX = INDEX + INCR
	MOV	AX,[BP]	; GET NEW INDEX
	SUB	AX,[2+BP]        ; COMPARE WITH LIMIT
	XOR	AX,BX	; TEST SIGN
	JS	BRAN1	; KEEP LOOPING
;
;  END OF `DO' LOOP
	ADD	BP,BYTE 4    ; ADJ RETURN STACK
	INC	SI	; BYPASS BRANCH OFFSET
	INC	SI
	JMP SHORT     NEXT
;	DEBUG STUFF
;
	DB	84H
	DB	'NOO'
	DB	'P'+80H
	DW	XLOOP-9
NOOP	DW	$+4
NOP0	DW	$+2
	JMP SHORT     NEXT
NOP1	DW 	$+2
	JMP SHORT     NEXT
NOP2	DW	$+2
	JMP SHORT     NEXT
;
;	(+LOOP)
;
	DB	87H
	DB	'(+LOOP'
	DB	')'+80H
	DW	NOOP-7
XPLOO	DW	$+2
	POP	BX	; GET LOOP VALUE
	JMP SHORT     XLOO1
;
;	(DO)
;
	DB	84H
	DB	'(DO'
	DB	')'+80H
	DW	XPLOO-0AH
XDO	DW	$+2
	POP	DX	; INITIAL INDEX VALUE
	POP	AX	; LIMIT VALUE
	XCHG	BP,SP	; GET RETURN STACK
	PUSH	AX
	PUSH	DX
	XCHG	BP,SP	; GET PARAMETER STACK
	JMP	NEXT
	PAGE
;
;	I
;
	DB	81H
	DB	'I'+80H
	DW	XDO-7
IDO	DW	$+2	; (SI) <- (RI)
	MOV	AX,[BP]	; GET INDEX VALUE
	JMP	APUSH	; TO PARAMETER STACK
;
 	DB	85H
	DB	'DIGI'
	DB	'T'+80H
	DW	IDO-4
DIGIT	DW	$+2
	POP	DX	;NUMBER BASE
	POP	AX	;ASCII DIGIT
	SUB	AL,'0'
	JB	DIGI2	;NUMBER ERROR
	CMP	AL,9
	JBE	DIGI1	;NUMBER = 0 THRU 9
	SUB	AL,7
	CMP	AL,10	;NUMBER 'A' THRU 'Z'?
	JB	DIGI2	;NO
DIGI1:	CMP	AL,DL	; COMPARE NUMBER TO BASE
	JAE	DIGI2	;NUMBER ERROR
	SUB	DX,DX	;ZERO
	MOV	DL,AL	;NEW BINARY NUMBER
	MOV	AL,1	;TRUE FLAG
	JMP	DPUSH	;ADD TO STACK
;   NUMBER ERROR
DIGI2:	SUB	AX,AX	;FALSE FLAG
	JMP	APUSH
	PAGE
;
	DB	86H
	DB	'(FIND'
	DB	')'+80H
	DW	DIGIT-8
PFIND	DW	$+2
	MOV	AX,DS
	MOV	ES,AX	;ES = DS
	POP	BX	;NFA
	POP	CX	;STRING ADDR
;
;  SEARCH LOOP
PFIN1:  MOV	DI,CX	;GET ADDR
	MOV	AL,[BX]	;GET WORD LENGTH
	MOV	DL,AL	;SAVE WORD LENGTH
	XOR	AL,[DI]
	AND	AL,3FH	;CHECK LENGTHS
	JNZ	PFIN5	;LENGTHS DIFFER

;
;   LENGTHS MATCH - CHECK EACH CHARACTER IN NAME
PFIN2:	INC	BX
	INC	DI	; NEXT CHAR OF NAME
	MOV	AL,[BX]
	XOR	AL,[DI]	;COMPARE NAMES
	ADD	AL,AL	;THIS WILL BE TEST BIT 8
	JNZ	PFIN5	;NO MATCH
	JNB	PFIN2	;MATCH SO FAR - LOOP
;
;   FOUND END OF NAME (BIT 8 SET) - A MATCH
	ADD	BX,BYTE 5    ; BX = PFA
	PUSH	BX	; (S3) <- PFA
	MOV	AX,1	;TRUE VALUE
	SUB	DH,DH
	JMP	DPUSH
;
;   NO NAME MATCH - TRY ANOTHER
;
; GET NEXT LINK FIELD ADDR (LFA)
; ( ZERO = FIRST WORD OF DICTIONARY )
;
PFIN5:	INC	BX	;NEXT ADDR
	JB	PFIN6	;END OF NAME
	MOV	AL,[BX]	;GET NEXT CHAR
	ADD	AL,AL	;SET/RESET CARRY
	JMP SHORT     PFIN5   ;LOOP UNTIL FOUND
;
PFIN6:	MOV	BX,[BX]	; GET LINK FIELD ADDR
	OR	BX,BX	; START OF DICT ( 0 )
	JNZ	PFIN1	; NO , LOOK MORE
	MOV	AX,0	; FALSE FLAG
	JMP	APUSH	; DONE ( NO MATCH FOUND )
;
	PAGE
	DB	87H
	DB	'ENCLOS'
	DB	'E'+80H
	DW	PFIND-9
ENCL	DW	$+2
	POP	AX	;S1 - TERMINATOR CHAR
	POP	BX	;S2 - TEXT ADDR
	PUSH	BX	;ADDR - BACK TO STACK ( IT RHYMES )
	MOV	AH,0	;ZERO
	MOV	DX,-1	;CHAR OFFSET COUNTER
	DEC	BX	;ADDR -1
;
;   SCAN TO FIRST NON-TERMINATOR CHARACTER
ENCL1:	INC	BX	;ADDR+1
	INC	DX	;COUNT+1
	CMP	AL,[BX]
	JZ	ENCL1	;WAIT FOR NON-TERMINATOR
	PUSH	DX	;OFFSET TO 1ST TEXT CHAR
	CMP	AH,[BX]	;NULL CHAR?
	JNZ	ENCL2	;NO
;
;  FOUND NULL BEFORE 1ST NON-TERM CHAR
	MOV	AX,DX	;COPY COUNTER
	INC	DX	; +1
	JMP	DPUSH
;
;   FOUND FIRST TEXT CHAR - COUNT THE CHARS
ENCL2:	INC	BX	; ADDR+1
	INC	DX	;COUNT+1
	CMP	AL,[BX]	;TERMINATOR CHAR?
	JZ	ENCL4	;YES
	CMP	AH,[BX]	;NULL CHAR?
	JNZ	ENCL2	;NO, LOOP AGAIN
;
;   FOUND NULL AT END OF TEXT
ENCL3:	MOV	AX,DX	;COUNTERS ARE EQUAL
	JMP	DPUSH
;
;   FOUND TERMINATOR CHARACTER
ENCL4:	MOV	AX,DX
	INC	AX	;COUNT+1
	JMP	DPUSH
	PAGE
	; At line     LINE ~500
;	EMIT
	DB	84H
	DB	'EMI'
	DB	'T'+80H
	DW	ENCL-0AH
EMIT	DW	DOCOL
	DW	PEMIT
	DW	ONE,OUTT
	DW	PSTOR,SEMIS
;
;	KEY
	DB	83H
	DB	'KE'
	DB	'Y'+80H
	DW	EMIT-7
KEY	DW	$+2
	JMP	PKEY
;
;	?TERMINAL
	DB	89H
	DB	'?TERMINA'
	DB	'L'+80H
	DW	KEY-6
QTERM	DW	$+2
	JMP	PQTER
;
;	CR
	DB	82H
	DB	'C'
	DB	'R'+80H
	DW	QTERM-0CH
CR	DW	$+2
	JMP	PCR
	PAGE
;	CMOVE
	DB	85H
	DB	'CMOV'
	DB	'E'+80H
	DW	CR-5
LCMOVE   DW      $+2
	CLD             ;INC DIRECTION
	MOV	BX,SI	;SAVE IF
	POP	CX	;COUNT
	POP	DI	;DEST
	POP	SI	;SOURCE
	MOV	AX,DS
	MOV	ES,AX	;ES <- DS
	REP	MOVSB	;THAT'S THE MOVE
	MOV	SI,BX	;GET BACK IP
	JMP	NEXT
;
;	U*
;
	DB	82H
	DB	'U'
	DB	'*'+80H
	DW	LCMOVE-8
USTAR	DW	$+2
	POP	AX
	POP	BX
	MUL	BX	;UNSIGNED
	XCHG	AX,DX	;AX NOW = MSW
	JMP	DPUSH	;STORE DOUBLE WORD
;
;	U/
;
	DB	82H
	DB	'U'
	DB	'/'+80H
	DW	USTAR-5
USLAS	DW	$+2
	POP	BX	;DIVISOR
	POP	DX	;MSW OF DIVIDEND
	POP	AX	;LSW OF DIVIDEND
	CMP	DX,BX	;DICIDE BY 0?
	JNB	DZERO	; ERROR - ZERO DIVIDE
	DIV	BX	;16 BIT DIVIDE
	JMP	DPUSH	;STORE QUOT/REM
;
;	DIVIDE BY ZERO ERROR - SHOW MAX NUMBERS
DZERO:	MOV	AX,-1
	MOV	DX,AX
	JMP	DPUSH	;STORE QUOT/REM
	PAGE
;	AND
;
	DB	83H
	DB	'AN'
	DB	'D'+80H
	DW	USLAS-5
ANDD	DW	$+2
	POP	AX
	POP	BX
	AND	AX,BX
	JMP	APUSH
;
;	OR
;
	DB	82H
	DB	'O'
	DB	'R'+80H
	DW	ANDD-6
ORR	DW	$+2	; (S1) <- (S1) OR (S2)
	POP	AX
	POP	BX
	OR	AX,BX
	JMP	APUSH
;
;	XOR
;
	DB	83H
	DB	'XO'
	DB	'R'+80H
	DW	ORR-5
XORR	DW	$+2	; (S1) <- (S1) XOR (S2)
	POP	AX
	POP	BX
	XOR	AX,BX
	JMP	APUSH
	PAGE
;	SP@
;
	DB	83H
	DB	'SP'
	DB	'@'+80H
	DW	XORR-6
SPAT	DW	$+2	; (S1) <- (SP)
	MOV	AX,SP
	JMP	APUSH
;
;	SP!
;
	DB	83H
	DB	'SP'
	DB	'!'+80H
	DW	SPAT-6
SPSTO	DW	$+2
	MOV	BX,[UP]   ;USER VAR BASE ADDR
	MOV	SP,[6+BX]        ;RESET PARAM STACK POINTER
	JMP	NEXT
;
;	RP@
;
	DB	83H
	DB	'RP'
	DB	'@'+80H
	DW	SPSTO-6
RPAT	DW	$+2	;(S1) <- (RP)
	MOV	AX,BP	;RETURN STACK ADDR
	JMP	APUSH
;
;	RP!
;
	DB	83H
	DB	'RP'
	DB	'!'+80H
	DW	RPAT-6
RPSTO	DW	$+2
	MOV	BX,[UP]   ;(AX) <- USR VAR BASE
	MOV	BP,[8+BX]        ;RESET RETURN STACK PTR
	JMP	NEXT
;
	PAGE
;	;S
;
;   END OF SCREEN OR RUN TIME COLON WORDS
;
	DB	82H
	DB	';'
	DB	'S'+80H
	DW	RPSTO-6
SEMIS	DW	$+2
	MOV	SI,[BP]	;(IP) <- (R1)
	INC	BP
	INC	BP	;ADJUST STACK
	JMP	NEXT
;
;	LEAVE
;
	DB	85H
	DB	'LEAV'
	DB	'E'+80H
	DW	SEMIS-5
LLEAV   DW      $+2     ;LIMIT <- INDEX
	MOV	AX,[BP]	;GET INDEX
	MOV	[2+BP],AX        ;STORE IT AT LIMIT
	JMP	NEXT
	PAGE
;
;	>R
;
	DB	82H
	DB	'>'
	DB	'R'+80H
	DW	LLEAV-8
TOR	DW	$+2	; (R1) <- (S1)
	POP	BX	;GET STACK PARAMETER
	DEC	BP
	DEC	BP	;MOVE RETURN STACK DOWN
	MOV	[BP],BX	;ADD TO RETURN STACK
	JMP	NEXT
;
;	R>
;
	DB	82H
	DB	'R'
	DB	'>'+80H
	DW	TOR-5
FROMR	DW	$+2	;(S1) <- (R1)
	MOV	AX,[BP]	; GET RETURN STACK VALUE
	INC	BP	;DELETE FROM STACK
	INC	BP
	JMP	APUSH
;
;	R
;
	DB	81H
	DB	'R'+80H
	DW	FROMR-5
RR	DW	IDO+2
	PAGE
;	0=
;
	DB	82H
	DB	'0'
	DB	'='+80H
	DW	RR-4
ZEQU	DW	$+2
	POP	AX
	OR	AX,AX	;DO TEST
	MOV	AX,1	;TRUE
	JZ	ZEQU1	;IT'S 0
	DEC	AX	;FALSE
ZEQU1:	JMP	APUSH
;
;	0<
;
	DB	82H
	DB	'0'
	DB	'<'+80H
	DW	ZEQU-5
ZLESS	DW	$+2
	POP	AX
	OR	AX,AX	;SET FLAGS
	MOV	AX,1	;TRUE
	JS	ZLESS1
	DEC	AX	;FALSE
ZLESS1:	JMP	APUSH
;
;	+
;
	DB	81H
	DB	'+'+80H
	DW	ZLESS-5
PLUS	DW	$+2	;(S1) <- (S1) + (S2)
	POP	AX
	POP	BX
	ADD	AX,BX
	JMP	APUSH
	PAGE
;	D+
;
;  XLW  XHW    YLW  YHW  -->  SLW  SHW
;   S4   S3     S2   S1        S2   S1
;
	DB	82H
	DB	'D'
	DB	'+'+80H
	DW	PLUS-4
DPLUS	DW	$+2
	POP	AX	; YHW
	POP	DX	; YLW
	POP	BX	; XHW
	POP	CX	; XLW
	ADD	DX,CX	; SLW
	ADC	AX,BX	; SHW
	JMP	DPUSH
;
;	MINUS
;
	DB	85H
	DB	'MINU'
	DB	'S'+80H
	DW	DPLUS-5
MINUS	DW	$+2
	POP	AX
	NEG	AX
	JMP	APUSH
;
;	DMINUS
;
	DB	86H
	DB	'DMINU'
	DB	'S'+80H
	DW	MINUS-8
DMINU	DW	$+2
	POP	BX
	POP	CX
	SUB	AX,AX
	MOV	DX,AX
	SUB	DX,CX	; MAKE 2'S COMPLEMENT
	SBB	AX,BX	; HIGH WORD
	JMP	DPUSH
	PAGE
;
;	OVER
;
	DB	84H
	DB	'OVE'
	DB	'R'+80H
	DW	DMINU-9
OVER	DW	$+2
	POP	DX
	POP	AX
	PUSH	AX
	JMP	DPUSH
;
;	DROP
;
	DB	84H
	DB	'DRO'
	DB	'P'+80H
	DW	OVER-7
DROP	DW	$+2
	POP	AX
	JMP	NEXT
;
;	SWAP
;
	DB	84H
	DB	'SWA'
	DB	'P'+80H
	DW	DROP-7
SWAP	DW	$+2
	POP	DX
	POP	AX
	JMP	DPUSH
;
;	DUP
;
	DB	83H
	DB	'DU'
	DB	'P'+80H
	DW	SWAP-7
DUPE	DW	$+2
	POP	AX
	PUSH	AX
	JMP	APUSH
	PAGE
;	2DUP
;
	DB	84H
	DB	'2DU'
	DB	'P'+80H
	DW	DUPE-6
TDUP	DW 	$+2
	POP	AX
	POP	DX
	PUSH	DX
	PUSH	AX
	JMP	DPUSH
;
;	+!
;
	DB	82H
	DB	'+'
	DB	'!'+80H
	DW	TDUP-7
PSTOR	DW	$+2
	POP	BX	;ADDRESS
	POP	AX	;INCREMENT
	ADD	[BX],AX
	JMP	NEXT
;
;	TOGGLE
;
	DB	86H
	DB	'TOGGL'
	DB	'E'+80H
	DW	PSTOR-5
TOGGL	DW	$+2
	POP	AX	;BIT PATTERN
	POP	BX	;ADDR
	XOR	[BX],AL	;
	JMP	NEXT
;
;	@
;
	DB	81H
	DB	'@'+80H
	DW	TOGGL-9
FETCH      DW      $+2
	POP	BX
	MOV	AX,[BX]
	JMP	APUSH
	PAGE
;	C@
;
	DB	82H
	DB	'C'
	DB	'@'+80H
	DW	FETCH-4
CAT	DW	$+2
	POP	BX
	MOV	AL,[BX]
	SUB	AH,AH
	JMP	APUSH
;
;	2@
;
	DB	82H
	DB	'2'
	DB	'@'+80H
	DW	CAT-5
TAT	DW	$+2
	POP	BX	;ADDR
	MOV	AX,[BX]	;MSW
	MOV	DX,[2+BX]        ;LSW
	JMP	DPUSH
;
;	!
;
	DB	81H
	DB	'!'+80H
	DW	TAT-5
STORE	DW	$+2
	POP	BX	;ADDR
	POP	AX	;DATA
	MOV	[BX],AX
	JMP	NEXT
;
;	C!
;
	DB	82H
	DB	'C'
	DB	'!'+80H
	DW	STORE-4
CSTOR	DW	$+2
	POP	BX	;ADDR
	POP	AX	;DATA
	MOV	[BX],AL
	JMP	NEXT
;
;	2!
;
	DB	82H
	DB	'2'
	DB	'!'+80H
	DW	CSTOR-5
TSTOR	DW	$+2
	POP	BX	;ADDR
	POP	AX	;MSW
	MOV	[BX],AX
	POP	AX	;LSW
	MOV	[2+BX],AX
	JMP	NEXT
;
;	L@
;
	DB	82H	;( SEG# IP -- N )
	DB	'L'
	DB	'@'+80H
	DW	TSTOR-5
LAT     DW      $+2
	POP	BX	;MEM LOC
	POP	CX	;SEG REG VAL
	MOV	DX,DS
	MOV	DS,CX
	MOV	AX,[BX]
	MOV	DS,DX
	JMP	APUSH
;
;	L!
;
	DB	82H	;( N SEG# IP -- )
	DB	'L'
	DB	'!'+80H
	DW	LAT-5
LSTORE	DW	$+2
	POP	BX
	POP	CX
	MOV	DX,DS
	MOV	DS,CX
	POP	AX
	MOV	[BX],AX
	MOV	DS,DX
	JMP	NEXT
	PAGE
	; At line     LINE ~1000
;
;	:
;
	DB	0C1H
	DB	':'+80H
	DW	LSTORE-5
COLON	DW	DOCOL
	DW	QEXEC
	DW	SCSP
	DW	CURR
	DW	FETCH
	DW	CONT
	DW	STORE
	DW	CREAT
	DW	RBRAC
	DW	PSCOD
DOCOL:	INC	DX	;W=W+1
	DEC	BP
	DEC	BP	;(RP) <- (RP)-2
	MOV	[BP],SI	;R1 <- (RP)
	MOV	SI,DX	;(IP) <- (W)
	JMP	NEXT
;
;	;
;
	DB	0C1H
	DB	';'+80H
	DW	COLON-4
SEMI	DW	DOCOL
	DW	QCSP
	DW	COMP
	DW	SEMIS
	DW	SMUDG
	DW	LBRAC
	DW	SEMIS
	PAGE
;	CONSTANT
;
	DB	88H
	DB	'CONSTAN'
	DB	'T'+80H
	DW	SEMI-4
CON	DW	DOCOL
	DW	CREAT
	DW	SMUDG
	DW	COMMA
	DW	PSCOD
DOCON:	INC	DX	;PFA
	MOV	BX,DX
	MOV	AX,[BX]	;GET DATA
	JMP	APUSH
;
;	VARIABLE
;
	DB	88H
	DB	'VARIABL'
	DB	'E'+80H
	DW	CON-0BH
VAR	DW	DOCOL
	DW	CON
	DW	PSCOD
DOVAR:	INC	DX	;(DE) <- PFA
	PUSH	DX
	JMP	NEXT
;
;	USER
;
	DB	84H
	DB	'USE'
	DB	'R'+80H
	DW	VAR-0BH
USER	DW	DOCOL
	DW	CON
	DW	PSCOD
DOUSE:	INC	DX	;PFA
	MOV	BX,DX
	MOV	BL,[BX]
	SUB	BH,BH
	MOV	DI,[UP]   ;USER VAR ADDRESS
	LEA	AX,[BX+DI]	;ADDR OF VARIABLE
	JMP	APUSH
	PAGE
;	0
	DB	81H
	DB	'0'+80H
	DW	USER-7
ZERO	DW	$+2
	XOR	AX,AX
	JMP	APUSH
;
;	1
;
	DB	81H
	DB	'1'+80H
	DW	ZERO-4
ONE	DW	$+2
	MOV	AX,1
	JMP	APUSH
;
;	2
;
	DB	81H
	DB	'2'+80H
	DW	ONE-4
TWO	DW	$+2
	MOV	AX,2
	JMP	APUSH
;
;	3
;
	DB	81H
	DB	'3'+80H
	DW	TWO-4
THREE	DW	$+2
	MOV	AX,3
	JMP	APUSH
;
;	BL
;
;	THIS IS ONLY A SPAC
	DB	82H
	DB	'B'
	DB	'L'+80H
	DW	THREE-4
BLS	DW	DOCON
	DW	20H
;
;	C/L
;
	DB	83H	;CHARACTERS/LINE
	DB	'C/'
	DB	'L'+80H
	DW	BLS-5
CSLL	DW	DOCON
	DW	64
;
;	FIRST
;
	DB	85H
	DB	'FIRS'
	DB	'T'+80H
	DW	CSLL-6
FIRST	DW	DOCON
	DW	BUF1
;
;	LIMIT
;
	DB	85H
	DB	'LIMI'
	DB	'T'+80H
	DW	FIRST-8
LIMIT	DW	DOCON
	DW	EM
;
;	B/BUF
;
	DB	85H	;BYTES/BUFFER
	DB	'B/BU'
	DB	'F'+80H
	DW	LIMIT-8
BBUF	DW	DOCON
	DW	KBBUF
;
;	B/SCR
;
	DB	85H	;BUFFERS/SCREEN
	DB	'B/SC'
	DB	'R'+80H
	DW	BBUF-8
BSCR	DW	DOCON
	DW	400H/KBBUF
;
;	+ORIGIN
;
	DB	87H
	DB	'+ORIGI'
	DB	'N'+80H
	DW	BSCR-8
PORIG	DW	DOCOL
	DW	LIT
	DW	ORIG
	DW	PLUS
	DW	SEMIS
	PAGE
;
;	S0
;
	DB	82H
	DB	'S'
	DB	'0'+80H
	DW	PORIG-0AH
SZERO	DW	DOUSE
	DW	6
;
;	R0
;
	DB	82H
	DB	'R'
	DB	'0'+80H
	DW	SZERO-5
RZERO	DW	DOUSE
	DW	8
;
;	TIB
;
	DB	83H
	DB	'TI'
	DB	'B'+80H
	DW	RZERO-5
TIB	DW	DOUSE
	DW	0AH
;
;	WIDTH
;
	DB	85H
	DB	'WIDT'
	DB	'H'+80H
	DW	TIB-6
WIDTHE  DW	DOUSE
	DW	0CH
;
;	WARNING
;
	DB	87H
	DB	'WARNIN'
	DB	'G'+80H
	DW	WIDTHE-8
WARN	DW	DOUSE
	DW	0EH
;
;	FENCE
;
	DB	85H
	DB	'FENC'
	DB	'E'+80H
	DW	WARN-0AH
FENCE	DW	DOUSE
	DW	10H
;
;	DP
;
	DB	82H
	DB	'D'
	DB	'P'+80H
	DW	FENCE-8
DP	DW	DOUSE
	DW	12H
;
;	VOC-LINK
;
	DB	88H
	DB	'VOC-LIN'
	DB	'K'+80H
	DW	DP-5
VOCL	DW	DOUSE
	DW	14H
;
;	BLK
;
	DB	83H
	DB	'BL'
	DB	'K'+80H
	DW	VOCL-0BH
BLK	DW	DOUSE
	DW	16H
	PAGE
;
;	IN
;
	DB	82H
	DB	'I'
	DB	'N'+80H
	DW	BLK-6
INN	DW	DOUSE
	DW	18H
;
;	OUT
;
	DB	83H
	DB	'OU'
	DB	'T'+80H
	DW	INN-5
OUTT	DW	DOUSE
	DW	1AH
;
;	SCR
;
	DB	83H
	DB	'SC'
	DB	'R'+80H
	DW	OUTT-6
SCR	DW	DOUSE
	DW	1CH
;
;	OFFSET
;
	DB	86H
	DB	'OFFSE'
	DB	'T'+80H
	DW	SCR-6
OFSET	DW	DOUSE
	DW	0
;
;	CONTENT
;
	DB	87H
	DB	'CONTEX'
	DB	'T'+80H
	DW	OFSET-9
CONT	DW	DOUSE
	DW	20H
;
;	CURRENT
;
	DB	87H
	DB	'CURREN'
	DB	'T'+80H
	DW	CONT-0AH
CURR	DW	DOUSE
	DW	22H
;
;	STATE
;
	DB	85H
	DB	'STAT'
	DB	'E'+80H
	DW	CURR-0AH
STATE	DW	DOUSE
	DW	24H
;
;	BASE
;
	DB	84H
	DB	'BAS'
	DB	'E'+80H
	DW	STATE-8
BASE	DW	DOUSE
	DW	26H
;
;	DPL
;
	DB	83H
	DB	'DP'
	DB	'L'+80H
	DW	BASE-7
DPL	DW	DOUSE
	DW	28H
;
;	FLD
;
	DB	83H
	DB	'FL'
	DB	'D'+80H
	DW	DPL-6
LFLD     DW      DOUSE
	DW	2AH
;
;	CSP
;
	DB	83H
	DB	'CS'
	DB	'P'+80H
	DW	LFLD-6
CSPP	DW	DOUSE
	DW	2CH
;
;	R#
;
	DB	82H
	DB	'R'
	DB	'#'+80H
	DW	CSPP-6
RNUM	DW	DOUSE
	DW	2EH
;
;	HLD
;
	DB	83H
	DB	'HL'
	DB	'D'+80H
	DW	RNUM-5
HLD	DW	DOUSE
	DW	30H
;
;========== END USER VARIABLES =============;
	PAGE
;
;	1+
;
	DB	82H
	DB	'1'
	DB	'+'+80H
	DW	HLD-6
ONEP	DW	$+2
	POP	AX
	INC	AX
	JMP	APUSH
;
;	2+
;
	DB	82H
	DB	'2'
	DB	'+'+80H
	DW	ONEP-5
TWOP	DW	$+2
	POP	AX
	ADD	AX,2
	JMP	APUSH
;
;	HERE
;
	DB	84H
	DB	'HER'
	DB	'E'+80H
	DW	TWOP-5
HERE	DW	DOCOL
	DW	DP
	DW	FETCH
	DW	SEMIS
;
;	ALLOT
;
	DB	85H
	DB	'ALLO'
	DB	'T'+80H
	DW	HERE-7
ALLOT	DW	DOCOL
	DW	DP
	DW	PSTOR
	DW	SEMIS
;
;	'
;
	DB	81H
	DB	','+80H
	DW	ALLOT-8
COMMA	DW	DOCOL
	DW	HERE
	DW	STORE
	DW	TWO
	DW	ALLOT
	DW	SEMIS
;
;	C,
;
	DB	82H
	DB	'C'
	DB	','+80H
	DW	COMMA-4
CCOMM	DW	DOCOL
	DW	HERE
	DW	CSTOR
	DW	ONE
	DW	ALLOT
	DW	SEMIS
;
;	-
;
	DB	81H
	DB	'-'+80H
	DW	CCOMM-5
SUBB	DW	$+2
	POP	DX	;S1
	POP	AX
	SUB	AX,DX
	JMP	APUSH	;S1 = S2 - S1
;
;	=
;
	DB	81H
	DB	'='+80H
	DW	SUBB-4
EQUAL	DW	DOCOL
	DW	SUBB
	DW	ZEQU
	DW	SEMIS
;
;	<
;
	DB	81H
	DB	'<'+80H
	DW	EQUAL-4
LESS	DW	$+2
	POP	DX	;S1
	POP	AX	;S2
	MOV	BX,DX
	XOR	BX,AX	;TEST FOR EQUAL SIGNS
	JS	LES1	;SIGNS ARE NOT THE SAME
	SUB	AX,DX
LES1:	OR	AX,AX	;TEST SIGN BIT
	MOV	AX,0	;ASSUME FALSE
	JNS	LES2	;NOT LESS THAN
	INC	AX	;TRUE (1)
LES2:	JMP	APUSH
;
;	U<
;
	DB	82H
	DB	'U'
	DB	'<'+80H
	DW	LESS-4
ULESS	DW	DOCOL,TDUP
	DW	XORR,ZLESS
	DW	ZBRAN
	DW	OFFSET ULES1-$	;IF
	DW	DROP,ZLESS
	DW	ZEQU
	DW	BRAN
	DW	OFFSET ULES2-$
ULES1	DW	SUBB,ZLESS	;ELSE
ULES2	DW	SEMIS		;ENDIF
;
;	>
	DB	81H
	DB	'>'+80H
	DW	ULESS-5
GREAT	DW	DOCOL
	DW	SWAP
	DW	LESS
	DW	SEMIS
;
;	ROT
;
	DB	83H
	DB	'RO'
	DB	'T'+80H
	DW	GREAT-4
ROT	DW	$+2
	POP	DX	;S1
	POP	BX	;S2
	POP	AX	;S3
	PUSH	BX
	JMP	DPUSH
;
;	SPACE
;
	DB	85H
	DB	'SPAC'
	DB	'E'+80H
	DW	ROT-6
SPACE	DW	DOCOL
	DW	BLS
	DW	EMIT
	DW	SEMIS
;
;	-DUP
;
	DB	84H
	DB	'-DU'
	DB	'P'+80H
	DW	SPACE-8
DDUP	DW	DOCOL
	DW	DUPE
	DW	ZBRAN	; IF
	DW	OFFSET DDUP1-$
	DW	DUPE	;ENDIF
DDUP1	DW	SEMIS
;
;	TRANVERSE
;
	DB	88H
	DB	'TRAVERS'
	DB	'E'+80H
	DW	DDUP-7
TRAV	DW	DOCOL
	DW	SWAP
TRAV1	DW	OVER	;BEGIN
	DW	PLUS
	DW	LIT,7FH
	DW	OVER
	DW	CAT
	DW	LESS
	DW	ZBRAN	;UNTIL
	DW	OFFSET TRAV1-$
	DW	SWAP
	DW	DROP
	DW	SEMIS
;
;	LATEST
;
	DB	86H
	DB	'LATES'
	DB	'T'+80H
	DW	TRAV-0BH
LATES	DW	DOCOL
	DW	CURR
	DW	FETCH
	DW	FETCH
	DW	SEMIS
;
;	LFA
;
	DB	83H
	DB	'LF'
	DB	'A'+80H
	DW	LATES-9
LFA	DW	DOCOL
	DW	LIT,4
	DW	SUBB
	DW	SEMIS
;	CFA
;
	DB	83H
	DB	'CF'
	DB	'A'+80H
	DW	LFA-6
CFA	DW	DOCOL
	DW	TWO
	DW	SUBB
	DW	SEMIS
;
;	NFA
;
	DB	83H
	DB	'NF'
	DB	'A'+80H
	DW	CFA-6
NFA	DW	DOCOL
	DW	LIT,5
	DW	SUBB
	DW	LIT,0FFFFH
	DW	TRAV
	DW	SEMIS
;
;	PFA
;
	DB	83H
	DB	'PF'
	DB	'A'+80H
	DW	NFA-6
PFA	DW	DOCOL
	DW	ONE
	DW	TRAV
	DW	LIT,5
	DW	PLUS
	DW	SEMIS
	PAGE
	; At line     LINE ~1500
;	!CSP
;
	DB	84H
	DB	'!CS'
	DB	'P'+80H
	DW	PFA-6
SCSP	DW	DOCOL
	DW	SPAT
	DW	CSPP
	DW	STORE
	DW	SEMIS
;
;	?ERROR
;
	DB	86H
	DB	'?ERRO'
	DB	'R'+80H
	DW	SCSP-7
QERR	DW	DOCOL
	DW	SWAP
	DW	ZBRAN	;IF
	DW	OFFSET QERR1-$
	DW	ERROR
	DW	BRAN	;ELSE
	DW	OFFSET QERR2-$
QERR1	DW	DROP	;ENDIF
QERR2	DW	SEMIS
;
;	?COMP
;
	DB	85H
	DB	'?COM'
	DB	'P'+80H
	DW	QERR-9
QCOMP	DW	DOCOL
	DW	STATE
	DW	FETCH
	DW	ZEQU
	DW	LIT,11H
	DW	QERR
	DW	SEMIS
	PAGE
;	?EXEC
;
	DB	85H
	DB	'?EXE'
	DB	'C'+80H
	DW	QCOMP-8
QEXEC	DW	DOCOL
	DW	STATE
	DW	FETCH
	DW	LIT,12H
	DW	QERR
	DW	SEMIS
;
;	?PAIRS
;
	DB	86H
	DB	'?PAIR'
	DB	'S'+80H
	DW	QEXEC-8
QPAIR	DW	DOCOL
	DW	SUBB
	DW	LIT,13H
	DW	QERR
	DW	SEMIS
;
;	?CSP
;
	DB	84H
	DB	'?CS'
	DB	'P'+80H
	DW	QPAIR-9
QCSP	DW	DOCOL
	DW	SPAT
	DW	CSPP
	DW	FETCH
	DW	SUBB
	DW	LIT,14H
	DW	QERR
	DW	SEMIS
;
;	?LOADING
;
	DB	88H
	DB	'?LOADIN'
	DB	'G'+80H
	DW	QCSP-7
QLOAD	DW	DOCOL
	DW	BLK
	DW	FETCH
	DW	ZEQU
	DW	LIT,16H
	DW	QERR
	DW	SEMIS
	PAGE
;	COMPILE
;
	DB	87H
	DB	'COMPIL'
	DB	'E'+80H
	DW	QLOAD-0BH
COMP	DW	DOCOL
	DW	QCOMP
	DW	FROMR
	DW	DUPE
	DW	TWOP
	DW	TOR
	DW	FETCH
	DW	COMMA
	DW	SEMIS
;
;	[
;
	DB	0C1H
	DB	'['+80H
	DW	COMP-0AH
LBRAC	DW	DOCOL
	DW	ZERO
	DW	STATE
	DW	STORE
	DW	SEMIS
;
;	]
;
	DB	81H
	DB	']'+80H
	DW	LBRAC-4
RBRAC	DW	DOCOL
	DW	LIT,0C0H
	DW	STATE
	DW	STORE
	DW	SEMIS
	PAGE
;	SMUDGE
;
	DB	86H
	DB	'SMUDG'
	DB	'E'+80H
	DW	RBRAC-4
SMUDG	DW	DOCOL
	DW	LATES
	DW	LIT,20H
	DW	TOGGL
	DW	SEMIS
;
;	HEX
;
	DB	83H
	DB	'HE'
	DB	'X'+80H
	DW	SMUDG-9
HEX	DW	DOCOL
	DW	LIT,16
	DW	BASE
	DW	STORE
	DW	SEMIS
;
;	DECIMAL
;
	DB	87H
	DB	'DECIMA'
	DB	'L'+80H
	DW	HEX-6
DECA	DW	DOCOL
	DW	LIT,10
	DW	BASE
	DW	STORE
	DW	SEMIS
;
;	(;CODE)
;
	DB	87H
	DB	'(;CODE'
	DB	')'+80H
	DW	DECA-0AH
PSCOD	DW	DOCOL
	DW	FROMR
	DW	LATES
	DW	PFA
	DW	CFA
	DW	STORE
	DW	SEMIS
;
;	;CODE
;
	DB	0C5H
	DB	';COD'
	DB	'E'+80H
	DW	PSCOD-0AH
SEMIC	DW	DOCOL
	DW	QCSP
	DW	COMP
	DW	PSCOD
	DW	LBRAC
SEMI1	DW	NOOP	; ( ASSEMBLER )
	DW	SEMIS
;
;	<BUILDS
;
	DB	87H
	DB	'<BUILD'
	DB	'S'+80H
	DW	SEMIC-8
BUILD	DW	DOCOL
	DW	ZERO
	DW	CON
	DW	SEMIS
;
;	DOES>
;
	DB	85H
	DB	'DOES'
	DB	'>'+80H
	DW	BUILD-0AH
DOES	DW	DOCOL
	DW	FROMR
	DW	LATES
	DW	PFA
	DW	STORE
	DW	PSCOD
DODOE:	XCHG	BP,SP	;GET RETURN STACK
	PUSH	SI	; (RP) <- (IP)
	XCHG	BP,SP
	INC	DX	;PFA
	MOV	BX,DX
	MOV	SI,[BX]	;NEW CFA
	INC	DX
	INC	DX
	PUSH	DX	;PFA
	JMP	NEXT
;
;	COUNT
;
	DB	85H
	DB	'COUN'
	DB	'T'+80H
	DW	DOES-8
COUNT	DW	DOCOL
	DW	DUPE
	DW	ONEP
	DW	SWAP
	DW	CAT
	DW	SEMIS
;
;	TYPE
;
	DB	84H
	DB	'TYP'
	DB	'E'+80H
	DW	COUNT-8
TYPES	DW	DOCOL
	DW	DDUP
	DW	ZBRAN	; IF
	DW	OFFSET TYPE1-$
	DW	OVER
	DW	PLUS
	DW	SWAP
	DW	XDO	; DO
TYPE2	DW	IDO
	DW	CAT
	DW	LIT,7FH
	DW	ANDD	;STRIP 80H FROM LAST CHAR
	DW	EMIT
	DW	XLOOP	; LOOP
	DW	OFFSET TYPE2-$
	DW	BRAN	; ELSE
	DW	OFFSET TYPE3-$
TYPE1	DW	DROP	; ENDIF
TYPE3	DW	SEMIS
;
;	-TRAILING
;
	DB	89H
	DB	'-TRAILIN'
	DB	'G'+80H
	DW	TYPES-7
DTRAI	DW	DOCOL
	DW	DUPE
	DW	ZERO
	DW	XDO	;DO
DTRA1	DW	OVER
	DW	OVER
	DW	PLUS
	DW	ONE
	DW	SUBB
	DW	CAT
	DW	BLS
	DW	SUBB
	DW	ZBRAN	;IF
	DW	OFFSET DTRA2-$
	DW	LLEAV
	DW	BRAN	; ELSE
	DW	OFFSET DTRA3-$
DTRA2	DW	ONE
	DW	SUBB	; ENDIF
DTRA3	DW	XLOOP	; LOOP
	DW	OFFSET DTRA1-$
	DW	SEMIS
	PAGE
	; At line     LINE ~2000
;	(.")
;
	DB	84H
	DB	'(."'
	DB	')'+80H
	DW	DTRAI-0CH
PDOTQ	DW	DOCOL
	DW	RR
	DW	COUNT
	DW	DUPE
	DW	ONEP
	DW	FROMR
	DW	PLUS
	DW	TOR
	DW	TYPES
	DW	SEMIS
;
;	."
;
	DB	0C2H
	DB	'.'
	DB	'"'+80H
	DW	PDOTQ-7
DOTQ	DW	DOCOL
	DW	LIT,22H
	DW	STATE
	DW	FETCH
	DW	ZBRAN	; IF
	DW	OFFSET DOTQ1-$
	DW	COMP
	DW	PDOTQ
	DW	WORDS
	DW	HERE
	DW	CAT
	DW	ONEP
	DW	ALLOT
	DW	BRAN	; ELSE
	DW	OFFSET DOTQ2-$
DOTQ1	DW	WORDS
	DW	HERE
	DW	COUNT
	DW	TYPES	; ENDIF
DOTQ2	DW	SEMIS
	PAGE
;	EXPECT
;
	DB	86H
	DB	'EXPEC'
	DB	'T'+80H
	DW	DOTQ-5
EXPEC	DW	DOCOL
	DW	OVER
	DW	PLUS
	DW	OVER
	DW	XDO	; DO
EXPE1	DW	KEY
	DW	DUPE
	DW	LIT,0EH
	DW	PORIG
	DW	FETCH
	DW	EQUAL
	DW	ZBRAN	; IF
	DW	OFFSET EXPE2-$
	DW	DROP
	DW	DUPE
	DW	IDO
	DW	EQUAL
	DW	DUPE
	DW	FROMR
	DW	TWO
	DW	SUBB
	DW	PLUS
	DW	TOR
	DW	ZBRAN	; IF
	DW	OFFSET EXPE6-$
	DW	LIT
	DW	BELL
	DW	BRAN	; ELSE
	DW	OFFSET EXPE7-$
EXPE6	DW	LIT
	DW	BSOUT	; ENDIF
EXPE7	DW	BRAN	; ELSE
	DW	OFFSET EXPE3-$
EXPE2	DW	DUPE
	DW	LIT,0DH
	DW	EQUAL
	DW	ZBRAN	; IF
	DW	OFFSET EXPE4-$
	DW	LLEAV
	DW	DROP
	DW	BLS
	DW	ZERO
	DW	BRAN	; ELSE
	DW	OFFSET EXPE5-$
EXPE4	DW	DUPE	; ENDIF
EXPE5	DW	IDO
	DW	CSTOR
	DW	ZERO
	DW	IDO
	DW	ONEP
	DW	STORE	; ENDIF
EXPE3	DW	EMIT
	DW	XLOOP	; LOOP
	DW	OFFSET EXPE1-$
	DW	DROP
	DW	SEMIS
;
;	QUERY
;
	DB	85H
	DB	'QUER'
	DB	'Y'+80H
	DW	EXPEC-9
QUERY	DW	DOCOL
	DW	TIB
	DW	FETCH
	DW	LIT,50H
	DW	EXPEC
	DW	ZERO
	DW	INN
	DW	STORE
	DW	SEMIS
	PAGE
	;	0 (NULL)
;
	DB	0C1H	; A BINARY ZERO
	DB	80H
	DW	QUERY-8
NULL	DW	DOCOL
	DW	BLK
	DW	FETCH
	DW	ZBRAN	; IF
	DW OFFSET NULL1-$
	DW	ONE
	DW	BLK
	DW	PSTOR
	DW	ZERO
	DW	INN
	DW	STORE
	DW	BLK
	DW	FETCH
	DW	BSCR
	DW	ONE
	DW	SUBB
	DW	ANDD
	DW	ZEQU
	DW	ZBRAN	; IF
	DW	OFFSET NULL2-$
	DW	QEXEC
	DW	FROMR
	DW	DROP	; ENDIF
NULL2	DW	BRAN	; ELSE
	DW	OFFSET NULL3-$
NULL1	DW	FROMR
	DW	DROP	; ENDIF
NULL3	DW	SEMIS
;
;	FILL
;
	DB	84H
	DB	'FIL'
	DB	'L'+80H
	DW	NULL-4
FILL	DW	$+2
	POP	AX	; FILL CHAR
	POP	CX	; FILL COUNT
	POP	DI	; BEGIN ADDR
	MOV	BX,DS
	MOV	ES,BX	; ES <- DS
	CLD		; INC DIRECTION
	REP	STOSB	;STORE BYTE
	JMP	NEXT
;
;	ERASE
;
	DB	85H
	DB	'ERAS'
	DB	'E'+80H
	DW	FILL-7
ERASEE	DW	DOCOL
	DW	ZERO
	DW	FILL
	DW	SEMIS
;
;	BLANKS
;
	DB	86H
	DB	'BLANK'
	DB	'S'+80H
	DW	ERASEE-8
BLANK	DW	DOCOL
	DW	BLS
	DW	FILL
	DW	SEMIS
;
;	HOLD
;
	DB	84H
	DB	'HOL'
	DB	'D'+80H
	DW	BLANK-9
HOLD	DW	DOCOL
	DW	LIT,-1
	DW	HLD
	DW	PSTOR
	DW	HLD
	DW	FETCH
	DW	CSTOR
	DW	SEMIS
;
;	PAD
;
	DB	83H
	DB	'PA'
	DB	'D'+80H
	DW	HOLD-7
PAD	DW	DOCOL
	DW	HERE
	DW	LIT,84
	DW	PLUS
	DW	SEMIS
;
;	WORD
;
	DB	84H
	DB	'WOR'
	DB	'D'+80H
	DW	PAD-6
WORDS	DW	DOCOL
	DW	BLK
	DW	FETCH
	DW	ZBRAN	; IF
	DW	OFFSET WORD1-$
	DW	BLK
	DW	FETCH
	DW	BLOCK
	DW	BRAN	; ELSE
	DW	OFFSET WORD2-$
WORD1	DW	TIB
	DW	FETCH      ; ENDIF
WORD2	DW	INN
	DW	FETCH
	DW	PLUS
	DW	SWAP
	DW	ENCL
	DW	HERE
	DW	LIT,22H
	DW	BLANK
	DW	INN
	DW	PSTOR
	DW	OVER
	DW	SUBB
	DW	TOR
	DW	RR
	DW	HERE
	DW	CSTOR
	DW	PLUS
	DW	HERE
	DW	ONEP
	DW	FROMR
	DW	LCMOVE
	DW	SEMIS
	PAGE
;	(NUMBER)
;
	DB	88H
	DB	'(NUMBER'
	DB	')'+80H
	DW	WORDS-7
PNUMB	DW	DOCOL
PNUM1	DW	ONEP	; BEGIN
	DW	DUPE
	DW	TOR
	DW	CAT
	DW	BASE
	DW	FETCH
	DW	DIGIT
	DW	ZBRAN	; WHILE
	DW	OFFSET PNUM2-$
	DW	SWAP
	DW	BASE
	DW	FETCH
	DW	USTAR
	DW	DROP
	DW	ROT
	DW	BASE
	DW	FETCH
	DW	USTAR
	DW	DPLUS
	DW	DPL
	DW	FETCH
	DW	ONEP
	DW	ZBRAN	; IF
	DW	OFFSET PNUM3-$
	DW	ONE
	DW	DPL
	DW	PSTOR	; ENDIF
PNUM3	DW	FROMR
	DW	BRAN	; REPEAT
	DW	OFFSET PNUM1-$
PNUM2	DW	FROMR
	DW	SEMIS
	PAGE
;	NUMBER
;
	DB	86H
	DB	'NUMBE'
	DB	'R'+80H
	DW	PNUMB-0BH
NUMB	DW	DOCOL
	DW	ZERO
	DW	ZERO
	DW	ROT
	DW	DUPE
	DW	ONEP
	DW	CAT
	DW	LIT,2DH
	DW	EQUAL
	DW	DUPE
	DW	TOR
	DW	PLUS
	DW	LIT,-1
NUMB1	DW	DPL	; BEGIN
	DW	STORE
	DW	PNUMB
	DW	DUPE
	DW	CAT
	DW	BLS
	DW	SUBB
	DW	ZBRAN	; WHILE
	DW	OFFSET NUMB2-$
	DW	DUPE
	DW	CAT
	DW	LIT,2EH
	DW	SUBB
	DW	ZERO
	DW	QERR
	DW	ZERO
	DW	BRAN	; REPEAT
	DW	OFFSET NUMB1-$
NUMB2	DW	DROP
	DW	FROMR
	DW	ZBRAN	; IF
	DW	OFFSET NUMB3-$
	DW	DMINU	; ENDIF
NUMB3	DW	SEMIS
	PAGE
;	-FIND
;
	DB	85H
	DB	'-FIN'
	DB	'D'+80H
	DW	NUMB-9
DFIND	DW	DOCOL
	DW	BLS
	DW	WORDS
	DW	HERE
	DW	CONT
	DW	FETCH
	DW	FETCH
	DW	PFIND
	DW	DUPE
	DW	ZEQU
	DW	ZBRAN	;IF
	DW	OFFSET DFIN1-$
	DW	DROP
	DW	HERE
	DW	LATES
	DW	PFIND	;ENDIF
DFIN1	DW	SEMIS
;
;	(ABORT)
;
	DB	87H
	DB	'(ABORT'
	DB	')'+80H
	DW	DFIND-8
PABOR	DW	DOCOL
	DW	ABORT
	DW	SEMIS
;
;	ERROR
;
	DB	85H
	DB	'ERRO'
	DB	'R'+80H
	DW	PABOR-0AH
ERROR	DW	DOCOL
	DW	WARN
	DW	FETCH
	DW	ZLESS
	DW	ZBRAN	;IF
	DW	OFFSET ERRO1-$
	DW	PABOR	;ENDIF
ERRO1	DW	HERE
	DW	COUNT
	DW	TYPES
	DW	PDOTQ
	DB	2
	DB	'? '
	DW	MESS
	DW	SPSTO
;
;	CHANGE FROM FIG MODEL
;	DW INN,FETCH,BLK,FETCH
;
	DW	BLK,FETCH
	DW	DDUP
	DW	ZBRAN	; IF
	DW	OFFSET ERRO2-$
	DW	INN,FETCH
	DW	SWAP	;ENDIF
ERRO2	DW	QUIT
;
;	ID.
;
	DB	83H
	DB	'ID'
	DB	'.'+80H
	DW	ERROR-8
IDDOT	DW	DOCOL
	DW	PAD
	DW	LIT,20H
	DW	LIT,5FH
	DW	FILL
	DW	DUPE
	DW	PFA
	DW	LFA
	DW	OVER
	DW	SUBB
	DW	PAD
	DW	SWAP
	DW	LCMOVE
	DW	PAD
	DW	COUNT
	DW	LIT,1FH
	DW	ANDD
	DW	TYPES
	DW	SPACE
	DW	SEMIS
	PAGE
;	CREATE
;
	DB	86H
	DB	'CREAT'
	DB	'E'+80H
	DW	IDDOT-6
CREAT	DW	DOCOL
	DW	DFIND
	DW	ZBRAN	;IF
	DW	OFFSET CREA1-$
	DW	DROP
	DW	NFA
	DW	IDDOT
	DW	LIT,4
	DW	MESS
	DW	SPACE	;ENDIF
CREA1	DW	HERE
	DW	DUPE
	DW	CAT
	DW	WIDTHE
	DW	FETCH
	DW	MIN
	DW	ONEP
	DW	ALLOT
	DW	DUPE
	DW	LIT,0A0H
	DW	TOGGL
	DW	HERE
	DW	ONE
	DW	SUBB
	DW	LIT,80H
	DW	TOGGL
	DW	LATES
	DW	COMMA
	DW	CURR
	DW	FETCH
	DW	STORE
	DW	HERE
	DW	TWOP
	DW	COMMA
	DW	SEMIS
	PAGE
;	[COMPILE]
;
	DB	0C9H
	DB	'[COMPILE'
	DB	']'+80H
	DW	CREAT-9
BCOMP	DW	DOCOL
	DW	DFIND
	DW	ZEQU
	DW	ZERO
	DW	QERR
	DW	DROP
	DW	CFA
	DW	COMMA
	DW	SEMIS
;
;	LITERAL
;
	DB	0C7H
	DB	'LITERA'
	DB	'L'+80H
	DW	BCOMP-0CH
LITER	DW	DOCOL
	DW	STATE
	DW	FETCH
	DW	ZBRAN	;IF
	DW	OFFSET LITE1-$
	DW	COMP
	DW	LIT
	DW	COMMA	;ENDIF
LITE1	DW	SEMIS
	PAGE
;
;	DLITERAL
;
	DB	0C8H
	DB	'DLITERA'
	DB	'L'+80H
	DW	LITER-0AH
DLITE	DW	DOCOL
	DW	STATE
	DW	FETCH
	DW	ZBRAN	; IF
	DW	OFFSET DLIT1-$
	DW	SWAP
	DW	LITER
	DW	LITER	; ENDIF
DLIT1	DW	SEMIS
;
;	?STACK
;
	DB	86H
	DB	'?STAC'
	DB	'K'+80H
	DW	DLITE-0BH
QSTAC	DW	DOCOL
	DW	SPAT
	DW	SZERO
	DW	FETCH
	DW	SWAP
	DW	ULESS
	DW	ONE
	DW	QERR
	DW	SPAT
	DW	HERE
	DW	LIT,80H
	DW	PLUS
	DW	ULESS
	DW	LIT,7
	DW	QERR
	DW	SEMIS
	PAGE
	; At line     LINE ~2500
;	INTERPRET
;
	DB	89H
	DB	'INTERPRE'
	DB	'T'+80H
	DW	QSTAC-9
INTER	DW	DOCOL
INTE1	DW	DFIND	;BEGIN
	DW	ZBRAN	;IF
	DW	OFFSET INTE2-$
	DW	STATE
	DW	FETCH
	DW	LESS
	DW	ZBRAN	;IF
	DW	OFFSET INTE3-$
	DW	CFA
	DW	COMMA
	DW	BRAN	;ELSE
	DW	OFFSET INTE4-$
INTE3	DW	CFA
	DW	EXEC	;ENDIF
INTE4	DW	QSTAC
	DW	BRAN	;ELSE
	DW	OFFSET INTE5-$
INTE2	DW	HERE
	DW	NUMB
	DW	DPL
	DW	FETCH
	DW	ONEP
	DW	ZBRAN	;IF
	DW	OFFSET INTE6-$
	DW	DLITE
	DW	BRAN	;ELSE
	DW	OFFSET INTE7-$
INTE6	DW	DROP
	DW	LITER	;ENDIF
INTE7	DW	QSTAC	;ENDIF
INTE5	DW	BRAN	;AGAIN
	DW	OFFSET INTE1-$
	PAGE
;	IMMEDIATE
;
	DB	89H
	DB	'IMMEDIAT'
	DB	'E'+80H
	DW	INTER-0CH
IMMED	DW	DOCOL
	DW	LATES
	DW	LIT,40H
	DW	TOGGL
	DW	SEMIS
;
;	VOCABULARY
;
	DB	8AH
	DB	'VOCABULAR'
	DB	'Y'+80H
	DW	IMMED-0CH
VOCAB	DW	DOCOL
	DW	BUILD
	DW	LIT
	DW	0A081H
	DW	COMMA
	DW	CURR
	DW	FETCH
	DW	CFA
	DW	COMMA
	DW	HERE
	DW	VOCL
	DW	FETCH
	DW	COMMA
	DW	VOCL
	DW	STORE
	DW	DOES
DOVOC	DW	TWOP
	DW	CONT
	DW	STORE
	DW	SEMIS
	PAGE
;	FORTH
;
;   THE 'TASK-7' IS A COLD START VALUE ONLY.
;   IT IS CHANGED EACH TIME A DEFINITION IS
;   APPENDED TO THE 'FORTH' VOCABULARY.
;
	DB	0C5H
	DB	'FORT'
	DB	'H'+80H
	DW	VOCAB-0DH
FORTH	DW	DODOE
	DW	DOVOC
	DW	0A081H
	DW	TASK-7	;COLD START VALUE ONLY
	DW	0	; END OF VOCABULARY LIST
;
;	DEFINITIONS
;
	DB	8BH
	DB	'DEFINITION'
	DB	'S'+80H
	DW	FORTH-8
DEFIN	DW	DOCOL
	DW	CONT
	DW	FETCH
	DW	CURR
	DW	STORE
	DW	SEMIS
;
;	(
;
	DB	0C1H
	DB	'('+80H
	DW	DEFIN-0EH
PAREN	DW	DOCOL
	DW	LIT,')'
	DW	WORDS
	DW	SEMIS
	PAGE
;	QUIT
;
	DB	84H
	DB	'QUI'
	DB	'T'+80H
	DW	PAREN-4
QUIT	DW	DOCOL
	DW	ZERO
	DW	BLK
	DW	STORE
	DW	LBRAC
QUIT1	DW	RPSTO	;BEGIN
	DW	CR
	DW	QUERY
	DW	INTER
	DW	STATE
	DW	FETCH
	DW	ZEQU
	DW	ZBRAN	;IF
	DW	OFFSET QUIT2-$
	DW	PDOTQ
	DB	2
	DB	'OK'	;ENDIF
QUIT2	DW	BRAN	;AGAIN
	DW	OFFSET QUIT1-$
;
;	ABORT
;
	DB	85H
	DB	'ABOR'
	DB	'T'+80H
	DW	QUIT-7
ABORT	DW	DOCOL
	DW	SPSTO
	DW	DECA
	DW	QSTAC	; IT DID TO & INCL THIS
	DW	CR
	DW	DOTCPU
	DW	PDOTQ
	DB	20
	DB	'IBM-PC Fig-Forth '
	DB	FIGREL+30H,ADOT,FIGREV+30H
	DW	FORTH
	DW	DEFIN
	DW	QUIT
	PAGE
;	WARM START VECTOR COMES HERE
;
WRM:	MOV	SI,OFFSET WRM1
	JMP	NEXT
;
WRM1	DW	WARM
;
;	WARM
;
	DB	84H
	DB	'WAR'
	DB	'M'+80H
	DW	ABORT-8
WARM	DW	DOCOL
	DW	MTBUF
	DW	ABORT
;
;	COLD START VECTOR COMES HERE
;
LCLD:    MOV     SI,OFFSET CLD1  ; (IP) <-
	MOV	AX,0
	MOV	DS,AX		;TO VECTOR AREA
	MOV	BX,08CH
	LEA	AX,[WRM]
	MOV	[BX],AX		;JUMP TO WRM ON <CTRL-BREAK>
	INC	BX
	INC	BX
	MOV	[BX],CS
	MOV	AX,CS
	MOV	DS,AX		; SET DATA SEG
	MOV	SP,[ORIG+12H]    ;PARAM. STACK
	MOV	SS,AX		; SET STACK SEGMENT
	MOV	ES,AX		; SET EXTRA SEG
	CLD			; DIR = INC
	MOV	BP,[RPP]          ; RETURN STACK
	JMP	NEXT
;
CLD1	DW	COLD
;
;	COLD
;
	DB	84H
	DB	'COL'
	DB	'D'+80H
	DW	WARM-7
COLD	DW	DOCOL
	DW	MTBUF
	DW	FIRST
	DW	USE,STORE
	DW	FIRST
	DW	PREV,STORE
	DW	DRZER
	DW	LIT,0
	DW	LIT,EPRINT
	DW	STORE
	DW	LIT
	DW	ORIG+12H
	DW	LIT,UP
	DW	FETCH
	DW	LIT,6
	DW	PLUS
	DW	LIT,10H
	DW	LCMOVE
	DW	LIT,ORIG+0CH
	DW	FETCH
	DW	LIT,FORTH+6
	DW	STORE
	DW	ABORT
	PAGE
;	S->D
;
	DB	84H
	DB	'S->'
	DB	'D'+80H	; 1 WORD TO 2 WORDS
	DW	COLD-7
STOD	DW	$+2
	POP	DX	;S1
	SUB	AX,AX
	OR	DX,DX
	JNS	STOD1	;POS
	DEC	AX	;NEG
STOD1:	JMP	DPUSH
;
;	+-
;
	DB	82H
	DB	'+'
	DB	'-'+80H
	DW	STOD-7
PM	DW	DOCOL
	DW	ZLESS
	DW	ZBRAN	;IF
	DW	OFFSET PM1-$
	DW	MINUS	;ENDIF
PM1	DW	SEMIS
;
;	D+-
;
	DB	83H
	DB	'D+'
	DB	'-'+80H
	DW	PM-5
DPM	DW	DOCOL
	DW	ZLESS
	DW	ZBRAN	;IF
	DW	OFFSET DPM1-$
	DW	DMINU	;ENDIF
DPM1	DW	SEMIS
;
;	ABS
;
	DB	83H
	DB	'AB'
	DB	'S'+80H
	DW	DPM-6
ABS1	DW	DOCOL
	DW	DUPE
	DW	PM
	DW	SEMIS
;
;	DABS
;
	DB	84H
	DB	'DAB'
	DB	'S'+80H
	DW	ABS1-6
DABS	DW	DOCOL
	DW	DUPE
	DW	DPM
	DW	SEMIS
;
;	MIN
;
	DB	83H
	DB	'MI'
	DB	'N'+80H
	DW	DABS-7
MIN	DW	DOCOL,TDUP
	DW	GREAT
	DW	ZBRAN	;IF
	DW	OFFSET MIN1-$
	DW	SWAP	;ENDIF
MIN1	DW	DROP
	DW	SEMIS
;
;	MAX
;
	DB	83H
	DB	'MA'
	DB	'X'+80H
	DW	MIN-6
MAX	DW	DOCOL,TDUP
	DW	LESS
	DW	ZBRAN	;IF
	DW	OFFSET MAX1-$
	DW	SWAP	;ENDIF
MAX1	DW	DROP
	DW	SEMIS
	PAGE
;	M*
;
	DB	82H
	DB	'M'
	DB	'*'+80H
	DW	MAX-6
MSTAR	DW	DOCOL,TDUP
	DW	XORR
	DW	TOR
	DW	ABS1
	DW	SWAP
	DW	ABS1
	DW	USTAR
	DW	FROMR
	DW	DPM
	DW	SEMIS
;
;	M/
;
	DB	82H
	DB	'M'
	DB	'/'+80H
	DW	MSTAR-5
MSLAS	DW	DOCOL
	DW	OVER
	DW	TOR
	DW	TOR
	DW	DABS
	DW	RR
	DW	ABS1
	DW	USLAS
	DW	FROMR
	DW	RR
	DW	XORR
	DW	PM
	DW	SWAP
	DW	FROMR
	DW	PM
	DW	SWAP
	DW	SEMIS
;
;	*
;
	DB	81H
	DB	'*'+80H
	DW	MSLAS-5
STAR	DW	DOCOL
	DW	MSTAR
	DW	DROP
	DW	SEMIS
;
;	/MOD
;
	DB	84H
	DB	'/MO'
	DB	'D'+80H
	DW	STAR-4
SLMOD	DW	DOCOL
	DW	TOR
	DW	STOD
	DW	FROMR
	DW	MSLAS
	DW	SEMIS
;
;	/
;
	DB	81H
	DB	'/'+80H
	DW	SLMOD-7
SLASH	DW	DOCOL
	DW	SLMOD
	DW	SWAP
	DW	DROP
	DW	SEMIS
;
;	MOD
;
	DB	83H
	DB	'MO'
	DB	'D'+80H
	DW	SLASH-4
MODD	DW	DOCOL
	DW	SLMOD
	DW	DROP
	DW	SEMIS
;
;	*/MOD
;
	DB	85H
	DB	'*/MO'
	DB	'D'+80H
	DW	MODD-6
SSMOD	DW	DOCOL
	DW	TOR
	DW	MSTAR
	DW	FROMR
	DW	MSLAS
	DW	SEMIS
;
;	*/
;
	DB	82H
	DB	'*'
	DB	'/'+80H
	DW	SSMOD-8
SSLA	DW	DOCOL
	DW	SSMOD
	DW	SWAP
	DW	DROP
	DW	SEMIS
;
;	M/MOD
;
	DB	85H
	DB	'M/MO'
	DB	'D'+80H
	DW	SSLA-5
MSMOD	DW	DOCOL
	DW	TOR
	DW	ZERO
	DW	RR
	DW	USLAS
	DW	FROMR
	DW	SWAP
	DW	TOR
	DW	USLAS
	DW	FROMR
	DW	SEMIS
	PAGE
;	(LINE)
;
	DB	86H
	DB	'(LINE'
	DB	')'+80H
	DW	MSMOD-8
PLINE	DW	DOCOL
	DW	TOR
	DW	LIT,64
	DW	BBUF
	DW	SSMOD
	DW	FROMR
	DW	BSCR
	DW	STAR
	DW	PLUS
	DW	BLOCK
	DW	PLUS
	DW	LIT,64
	DW	SEMIS
;
;	.LINE
;
	DB	85H
	DB	'.LIN'
	DB	'E'+80H
	DW	PLINE-9
DLINE	DW	DOCOL
	DW	PLINE
	DW	DTRAI
	DW	TYPES
	DW	SEMIS
;
;	MESSAGE
;
	DB	87H
	DB	'MESSAG'
	DB	'E'+80H
	DW	DLINE-8
MESS	DW	DOCOL
	DW	WARN
	DW	FETCH
	DW	ZBRAN	;IF
	DW	OFFSET MESS1-$
	DW	DDUP
	DW	ZBRAN	;IF
	DW	OFFSET MESS2-$
	DW	LIT,4
	DW	OFSET
	DW	FETCH
	DW	BSCR
	DW	SLASH
	DW	SUBB
	DW	DLINE
	DW	SPACE	;ENDIF
MESS2	DW	BRAN	;ELSE
	DW	OFFSET MESS3-$
MESS1	DW	PDOTQ
	DB	6
	DB	'MSG # '
	DW	DOT	;ENDIF
MESS3	DW	SEMIS
	PAGE
	; At line     LINE ~3000
;--------------------------------------------
;
;	8086/88 PORT FETCH AND STORE
;
;--------------------------------------------
;
;	PC@
;
; FETCH CHARACTER (BYTE) FROM PORT
;
	DB	83H
	DB	'PC'
	DB	'@'+80H
	DW	MESS-0AH
PTCAT	DW	$+2
	POP	DX	; PORT ADDR
	IN	AL,DX	; BYTE INPUT
	SUB	AH,AH
	JMP	APUSH
;
;	PC!
;
; STORE CHARACTER (BYTE) FETCH PORT
;
	DB	83H
	DB	'PC'
	DB	'!'+80H
	DW	PTCAT-6
PTCSTO	DW	$+2
	POP	DX	;PORT ADDR
	POP	AX	;DATA
	OUT	DX,AL	; BYTE OUTPUT
	JMP	NEXT
;
;	P@
; FETCH WORD FROM PORT
;
	DB	82H
	DB	'P'
	DB	'@'+80H
	DW	PTCSTO-6
PTAT	DW	$+2
	POP	DX	;PORT ADDR
	IN	AX,DX	;WORD INPUT
	JMP	APUSH
;
;	PC!
; STORE WORD FETCH PORT
;
	DB	82H
	DB	'P'
	DB	'!'+80H
	DW	PTAT-5
PTSTO	DW	$+2
	POP	DX	;PORT ADDR
	POP	AX	;DATA
	OUT	DX,AX	;WORD OUTPUT
	JMP	NEXT
;
BPS	EQU	512	;BYTES PER SECTOR
MXDRV	EQU	2	; MAX # DRIVES
;
;
;	USE
;
	DB	83H	;ADDR OF NEXT BUFR TO USE
	DB	'US'
	DB	'E'+80H
	DW	PTSTO-5
USE	DW	DOVAR
	DW BUF1
;
;	PREV
;
	DB	84H	;ADDR OF PREV USED BUFR
	DB	'PRE'
	DB	'V'+80H
	DW	USE-6
PREV	DW	DOVAR
	DW	BUF1
;
;	SEC/BLK
;
	DB	87H	;# SECTORS/BLOCK
	DB	'SEC/BL'
	DB	'K'+80H
	DW	PREV-7
SPBLK	DW	DOCON
	DW	KBBUF/BPS
	PAGE
;	#BUFF
;
	DB	85H	;NO. OF BUFFERS
	DB	'#BUF'
	DB	'F'+80H
	DW	SPBLK-10
NOBUF	DW	DOCON,NBUF
;
;	+BUF
;
	DB	84H
	DB	'+BU'
	DB	'F'+80H
	DW	NOBUF-8
PBUF	DW	DOCOL
	DW	LIT,CO
	DW	PLUS,DUPE
	DW	LIMIT,EQUAL
	DW	ZBRAN
	DW	OFFSET PBUF1-$
	DW	DROP,FIRST
PBUF1	DW	DUPE,PREV
	DW	FETCH,SUBB
	DW	SEMIS
;
;	UPDATE
;
	DB	86H
	DB	'UPDAT'
	DB	'E'+80H
	DW	PBUF-7
UPDAT	DW	DOCOL,PREV
	DW	FETCH,FETCH
	DW	LIT,8000H
	DW	ORR
	DW	PREV,FETCH
	DW	STORE,SEMIS
;
;	EMPTY-BUFFERS
;
	DB	8DH
	DB	'EMPTY-BUFFER'
	DB	'S'+80H
	DW	UPDAT-9
MTBUF	DW	DOCOL,FIRST
	DW	LIMIT,OVER
	DW	SUBB,ERASEE
	DW	SEMIS
	PAGE
;	DR0
;
	DB	83H
	DB	'DR'
	DB	'0'+80H
	DW	MTBUF-16
DRZER	DW	DOCOL,ZERO
	DW	OFSET,STORE
	DW	SEMIS
;
;	BUFFER
;
; NOTE: THIS WORD WON'T WORK IF ONLY
;	USING SINGLE BUFFER
;
	DB	86H
	DB	'BUFFE'
	DB	'R'+80H
	DW	DRZER-6
BUFFE	DW	DOCOL,USE
	DW	FETCH,DUPE
	DW	TOR
BUFF1	DW	PBUF
	DW	ZBRAN
	DW	OFFSET BUFF1-$
	DW	USE,STORE
	DW	RR,FETCH
	DW	ZLESS
	DW	ZBRAN
	DW	OFFSET BUFF2-$
	DW	RR,TWOP
	DW	RR,FETCH
	DW	LIT,7FFFH
	DW	ANDD,ZERO
	DW	RSLW
BUFF2	DW	RR,STORE
	DW	RR,PREV
	DW	STORE,FROMR
	DW	TWOP,SEMIS
	PAGE
;	BLOCK
;
	DB	85H
	DB	'BLOC'
	DB	'K'+80H
	DW	BUFFE-9
BLOCK	DW	DOCOL,OFSET
	DW	FETCH,PLUS
	DW	TOR,PREV
	DW	FETCH,DUPE
	DW	FETCH,RR
	DW	SUBB
	DW	DUPE,PLUS
	DW	ZBRAN
	DW	OFFSET BLOC1-$
BLOC2	DW	PBUF,ZEQU
	DW	ZBRAN
	DW	OFFSET BLOC3-$
	DW	DROP,RR
	DW	BUFFE,DUPE
	DW	RR,ONE
	DW	RSLW
	DW	TWO,SUBB
BLOC3	DW	DUPE,FETCH
	DW	RR,SUBB
	DW	DUPE,PLUS
	DW	ZEQU
	DW	ZBRAN
	DW	OFFSET BLOC2-$
	DW	DUPE,PREV
	DW	STORE
BLOC1	DW	FROMR,DROP
	DW	TWOP,SEMIS
	PAGE
WERR	DB  	'DISK WRITE ERROR  $'
RERR	DB  	'DISK READ ERROR   $'
;
SSEC	PROC	NEAR
;	( ADDR  SEC# -- )
;	THIS ROUTINE WILL SELECT THE HEAD & DRIVE
	POP	DI	;SAVE RETURN
	POP	AX	;SECTOR #
	CMP	AX,SEC_DSK	;B DRIVE?
	JB	LDR0
	SUB	AX,SEC_DSK
	MOV	DX,AX	;LOAD LOGICAL SECTOR #
	MOV	AL,1	;SELECT DR B
	JMP	GSEC1
LDR0:    MOV     DX,AX   ;DR A
	MOV	AL,0	;SELECT DR A
GSEC1:	POP	BX	;TRANSFER ADDR
	MOV	CX,1	;READ 1 SECTOR
	PUSH	DI	;GET THAT RETURN BACK
	RET
;SSEC    ENDP
;
;	RSEC
;
	DB	84H
	DB	'RSE'
	DB	'C'+80H
	DW	BLOCK-8
RSEC	DW	$+2
	CALL	SSEC
	PUSH	SI	;PRESERVE INTERPRETER POINTER
	PUSH	BP	;RETURN POINTER
	INT	25H
	JNC	DOK	;NO ERRORS
	LEA	DX,[RERR]
	JMP	DERR
;
;	WSEC
;
	DB	84H
	DB	'WSE'
	DB	'C'+80H
	DW	RSEC-7
WSEC	DW	$+2
    	CALL	SSEC
	PUSH	SI
	PUSH	BP
	INT	26H
	JNC	DOK
	LEA	DX,[WERR]
DERR:	PUSH	AX
	MOV	AH,9	;STRING WRITE FNCN
	INT	21H
	POP	AX	;ERROR CODE IN AX
;  WRITE ERROR MESSAGE HERE
;
DOK:	POPF		;POP FLAGS
	POP	BP	;RETURN STACK
	POP	SI	;INTERPRETER PNTR
	JMP	NEXT
;
;	R/W
;
;	( ADDR  SECTOR#  FLAG (0=W, 1=R) --- )
 	DB	83H
	DB	'R/'
	DB	'W'+80H
	DW	WSEC-7
RSLW	DW	DOCOL
	DW	ZBRAN
	DW	OFFSET RSLW1-$
	DW	RSEC
	DW	BRAN
	DW	OFFSET RSLW2-$
RSLW1	DW	WSEC
RSLW2	DW	SEMIS
	PAGE
;	FLUSH
;
	DB	85H
	DB	'FLUS'
	DB	'H'+80H
	DW	RSLW-6
FLUSH	DW	DOCOL
	DW	NOBUF,ONEP
	DW	ZERO,XDO
FLUS1	DW	ZERO,BUFFE
	DW	DROP
	DW	XLOOP
	DW	OFFSET FLUS1-$
	DW	SEMIS
;
;	LOAD
;
	DB	84H
	DB	'LOA'
	DB	'D'+80H
	DW	FLUSH-8
LOAD	DW	DOCOL,BLK
	DW	FETCH,TOR
	DW	INN,FETCH
	DW	TOR,ZERO
	DW	INN,STORE
	DW	BSCR,STAR
	DW	BLK,STORE	;BLK <- SCR * B/SCR
	DW	INTER	;INTERPRET FROM OTHER
SCREEN	DW	FROMR,INN
	DW	STORE
	DW	FROMR,BLK
	DW	STORE
	DW	SEMIS
	PAGE
;	-->
;
	DB	0C3H
	DB	'--'
	DB	'>'+80H
	DW	LOAD-7
ARROW	DW	DOCOL
	DW	QLOAD
	DW	ZERO
	DW	INN
	DW	STORE
	DW	BSCR
	DW	BLK
	DW	FETCH
	DW	OVER
	DW	MODD
	DW	SUBB
	DW	BLK
	DW	PSTOR
	DW	SEMIS
	PAGE
;
;------------------------------------
; QUERY KEYBOARD FOR KEY PRESSED
;------------------------------------
;
; ( TRUE = CHAR READY, FALSE = NO CHAR )
;
; CALLED FROM  "?TERMINAL"
;
; USE 'KEY' TO GET KEY VALUE
;
PQTER:	CALL	CSTAT	;TEST FOR KEY
	OR	AL,AL	;ANY KEY?
	JZ	PQTER1	;NO
	MOV	AL,1	;TRUE = CHAR FOUND
PQTER1:	MOV	AH,0	;MAKE 16 BITS
	JMP	APUSH	;SAVE STATUS
;
;----------------------------
; CONSOLE INPUT ROUTINE
;----------------------------
;
; WAITS FOR A KEYBOARD CHAR
;
; CTRL-P WILL TOGGLE PRINTER ECHO FLAG
;
; CALLED FROM 'KEY'
;
PKEY:	CALL	CI	;CONSOLE INPUT
	CMP	AL,DLE	;PRINTER TOGGLE?
	JNE	PKEY1	;NO
	XOR BYTE      [EPRINT], 1        ;TOGGLE ECHO
	JMP	PKEY	;GET ANOTHER KEY
PKEY1:	MOV	AH,0	;MAKE 16 BITS
	JMP	APUSH	;SAVE KEY VALUE
;
;---------------------------------------
; CONSOLE/PRINTER CHAR OUTPUT
;---------------------------------------
;
; CALLED FROM 'EMIT'
;
PEMIT	DW	$+2
	POP	AX	;GET CHAR
	CALL	POUT	;CHAR OUTPUT
	JMP	NEXT
	PAGE
;------------------------------
; CRLF TO CONSOLE/PRINTER
;------------------------------
;
; CALLED FROM 'CR'
;
PCR:	MOV	AL,ACR
	CALL	POUT	;CHAR OUTPUT
	MOV	AL,LF
	CALL	POUT
	JMP	NEXT
;
;-------------------------------------
; TRUE CONSOLE/PRINTER OUTPUT ROUTINE
;-------------------------------------
;
POUT	PROC	NEAR
     	CALL	CHO	;CONSOLE OUT
	TEST BYTE   [EPRINT],1        ;PRINTER ECHO?
        NOP     ; To get the same code layout as with MASM
	JZ	POUT1	;OFF
	CALL	LO	;LIST OUTPUT
POUT1:	RET
;POUT    ENDP
;
; PRINTER ECHO FLAG
;
; VALUE: 0 = OFF, 1 = ON
;
EPRINT	DB	0,0
;
;------------------------
; GET KEYBOARD STATUS
;------------------------
;
; RETURNS KEYBOARD STATUS
;
;
; EXIT: REG AL = 0 IF NO KEY PRESSED
;       REG AL = CHAR IF  KEY PRESSED
;
CSTAT	PROC	NEAR
	PUSH	DX
	MOV	DX,0FFH
	MOV	AX,0600H
	INT	21H
	POP	DX
STATRT: RET
;CSTAT   ENDP
;
;-------------------------
; CONSOLE INPUT
;-------------------------
;
; WAITS FOR KEY FROM KEYBOARD
;
CI	PROC	NEAR
   	MOV	AH,0	; READ CHAR FUNCTION
	INT	16H
	RET
;CI      ENDP
	PAGE
;--------------------
; CONSOLE OUTPUT
;--------------------
;
; OUTPUTS CHAR IN REG AL TO CONSOLE
;
; EXIT:	REG AL = CHAR
;
CHO	PROC	NEAR
	PUSH	DX
    	PUSH	AX	;SAVE CHAR
	MOV	DL,AL	;CHAR TO WRITE
	MOV	AH,2	;CHAR OUT FUNCTION
	INT	21H	;DOS
	POP	AX
	POP	DX
	RET
;CHO     ENDP
;
;----------------------
;	LIST OUTPUT
;----------------------
;
; OUTPUTS CHAR IN REG AL TO
; LIST DEVICE (PRINTER)
;
; EXIT: REG AL = CHAR
;
LO	PROC	NEAR
   	PUSH	AX	;SAVE CHAR
	PUSH	DX
	MOV	DX,PRINTER_NO
	MOV	AH,0	;PRINT CHAR
	INT	17H
	POP	DX
	POP	AX
	RET
;LO      ENDP
	PAGE
	; At line     LINE ~3500
;	'
;
	DB	0C1H
	DB	0A7H
	DW	ARROW-6
TICK	DW	DOCOL
	DW	DFIND
	DW	ZEQU
	DW	ZERO
	DW	QERR
	DW	DROP
	DW	LITER
	DW	SEMIS
;
;	FORGET
;
	DB	86H
	DB	'FORGE'
	DB	'T'+80H
	DW	TICK-4
FORG	DW	DOCOL
	DW	CURR
	DW	FETCH
	DW	CONT
	DW	FETCH
	DW	SUBB
	DW	LIT,18H
	DW	QERR
	DW	TICK
	DW	DUPE
	DW	FENCE
	DW	FETCH
	DW	LESS
	DW	LIT,15H
	DW	QERR
	DW	DUPE
	DW	NFA
	DW	DP
	DW	STORE
	DW	LFA
	DW	FETCH
	DW	CONT
	DW	FETCH
	DW	STORE
	DW	SEMIS
	PAGE
;	BACK
;
	DB	84H
	DB	'BAC'
	DB	'K'+80H
	DW	FORG-9
BACK	DW	DOCOL
	DW	HERE
	DW	SUBB
	DW	COMMA
	DW	SEMIS
;
;	BEGIN
;
	DB	0C5H
	DB	'BEGI'
	DB	'N'+80H
	DW	BACK-7
BEGIN	DW	DOCOL
	DW	QCOMP
	DW	HERE
	DW	ONE
	DW	SEMIS
;
;	ENDIF
;
	DB	0C5H
	DB	'ENDI'
	DB	'F'+80H
	DW	BEGIN-8
ENDIFF	DW	DOCOL
	DW	QCOMP
	DW	TWO
	DW	QPAIR
	DW	HERE
	DW	OVER
	DW	SUBB
	DW	SWAP
	DW	STORE
	DW	SEMIS
	PAGE
;	THEN
;
	DB	0C4H
	DB	'THE'
	DB	'N'+80H
	DW	ENDIFF-8
THEN	DW	DOCOL
	DW	ENDIFF
	DW	SEMIS
;
;	DO
;
	DB	0C2H
	DB	'D'
	DB	'O'+80H
	DW	THEN-7
DO	DW	DOCOL
	DW	COMP
	DW	XDO
	DW	HERE
	DW	THREE
	DW	SEMIS
;
;	LOOP
;
	DB	0C4H
	DB	'LOO'
	DB	'P'+80H
	DW	DO-5
LOOPC	DW	DOCOL
	DW	THREE
	DW	QPAIR
	DW	COMP
	DW	XLOOP
	DW	BACK
	DW	SEMIS
	PAGE
;	+LOOP
;
	DB	0C5H
	DB	'+LOO'
	DB	'P'+80H
	DW	LOOPC-7
PLOOP	DW	DOCOL
	DW	THREE
	DW	QPAIR
	DW	COMP
	DW	XPLOO
	DW	BACK
	DW	SEMIS
;
;	UNTIL
;
	DB	0C5H
	DB	'UNTI'
	DB	'L'+80H
	DW	PLOOP-8
UNTIL	DW	DOCOL
	DW	ONE
	DW	QPAIR
	DW	COMP
	DW	ZBRAN
	DW	BACK
	DW	SEMIS
;
;	END
;
	DB	0C3H
	DB	'EN'
	DB	'D'+80H
	DW	UNTIL-8
ENDD	DW	DOCOL
	DW	UNTIL
	DW	SEMIS
	PAGE
;	AGAIN
;
	DB	0C5H
	DB	'AGAI'
	DB	'N'+80H
	DW	ENDD-6
AGAIN	DW	DOCOL
	DW	ONE
	DW	QPAIR
	DW	COMP
	DW	BRAN
	DW	BACK
	DW	SEMIS
;
;	REPEAT
;
	DB	0C6H
	DB	'REPEA'
	DB	'T'+80H
	DW	AGAIN-8
REPEA	DW	DOCOL
	DW	TOR
	DW	TOR
	DW	AGAIN
	DW	FROMR
	DW	FROMR
	DW	TWO
	DW	SUBB
	DW	ENDIFF
	DW	SEMIS
;
;	IF
;
	DB	0C2H
	DB	'I'
	DB	'F'+80H
	DW	REPEA-9
IFF	DW	DOCOL
	DW	COMP
	DW	ZBRAN
	DW	HERE
	DW	ZERO
	DW	COMMA
	DW	TWO
	DW	SEMIS
	PAGE
;	ELSE
;
	DB	0C4H
	DB	'ELS'
	DB	'E'+80H
	DW	IFF-5
ELSEE	DW	DOCOL
	DW	TWO
	DW	QPAIR
	DW	COMP
	DW	BRAN
	DW	HERE
	DW	ZERO
	DW	COMMA
	DW	SWAP
	DW	TWO
	DW	ENDIFF
	DW	TWO
	DW	SEMIS
;
;	WHILE
;
	DB	0C5H
	DB	'WHIL'
	DB	'E'+80H
	DW	ELSEE-7
WHILE	DW	DOCOL
	DW	IFF
	DW	TWOP
	DW	SEMIS
	PAGE
;	SPACES
;
	DB	86H
	DB	'SPACE'
	DB	'S'+80H
	DW	WHILE-8
SPACS	DW	DOCOL
	DW	ZERO
	DW	MAX
	DW	DDUP
	DW	ZBRAN
	DW	OFFSET SPAX1-$
	DW	ZERO
	DW	XDO	;DO
SPAX2	DW	SPACE
	DW	XLOOP	;LOOP
	DW	OFFSET SPAX2-$
SPAX1	DW	SEMIS
;
;	<#
;
	DB	82H
	DB	'<'
	DB	'#'+80H
	DW	SPACS-9
BDIGS	DW	DOCOL
	DW	PAD
	DW	HLD
	DW	STORE
	DW	SEMIS
;
;	#>
;
	DB	82H
	DB	'#'
	DB	'>'+80H
	DW	BDIGS-5
EDIGS	DW	DOCOL
	DW	DROP
	DW	DROP
	DW	HLD
	DW	FETCH
	DW	PAD
	DW	OVER
	DW	SUBB
	DW	SEMIS
	PAGE
;	SIGN
;
	DB	84H
	DB	'SIG'
	DB	'N'+80H
	DW	EDIGS-5
SIGN	DW	DOCOL
	DW	ROT
	DW	ZLESS
	DW	ZBRAN	;IF
	DW	OFFSET SIGN1-$
	DW	LIT,2DH
	DW	HOLD	;ENDIF
SIGN1	DW	SEMIS
;
;	#
;
	DB	81H
	DB	'#'+80H
	DW	SIGN-7
DIG	DW	DOCOL
	DW	BASE
	DW	FETCH
	DW	MSMOD
	DW	ROT
	DW	LIT,9
	DW	OVER
	DW	LESS
	DW	ZBRAN	;IF
	DW	OFFSET DIG1-$
	DW	LIT,7
	DW	PLUS	;ENDIF
DIG1	DW	LIT,30H
	DW	PLUS
	DW	HOLD
	DW	SEMIS
;
;	#S
;
	DB	82H
	DB	'#'
	DB	'S'+80H
	DW	DIG-4
DIGS	DW	DOCOL
DIGS1	DW	DIG	;BEGIN
	DW	OVER
	DW	OVER
	DW	ORR
	DW	ZEQU
	DW	ZBRAN	;UNTIL
	DW	OFFSET DIGS1-$
	DW	SEMIS
;
;	D.R.
;
	DB	83H
	DB	'D.'
	DB	'R'+80H
	DW	DIGS-5
DDOTR	DW	DOCOL
	DW	TOR
	DW	SWAP
	DW	OVER
	DW	DABS
	DW	BDIGS
	DW	DIGS
	DW	SIGN
	DW	EDIGS
	DW	FROMR
	DW	OVER
	DW	SUBB
	DW	SPACS
	DW	TYPES
	DW	SEMIS
;
;	.R
;
	DB	82H
	DB	'.'
	DB	'R'+80H
	DW	DDOTR-6
DOTR	DW	DOCOL
	DW	TOR
	DW	STOD
	DW	FROMR
	DW	DDOTR
	DW	SEMIS
	PAGE
;	D.
;
	DB	82H
	DB	'D'
	DB	'.'+80H
	DW	DOTR-5
DDOT	DW	DOCOL
	DW	ZERO
	DW	DDOTR
	DW	SPACE
	DW	SEMIS
;
;	.
;
	DB	81H
	DB	'.'+80H
	DW	DDOT-5
DOT	DW	DOCOL
	DW	STOD
	DW	DDOT
	DW	SEMIS
;
;	?
;
	DB	81H
	DB	'?'+80H
	DW	DOT-4
QUES	DW	DOCOL
	DW	FETCH
	DW	DOT
	DW	SEMIS
;
;	U.
;
	DB	82H
	DB	'U'
	DB	'.'+80H
	DW	QUES-4
UDOT	DW	DOCOL
	DW	ZERO
	DW	DDOT
	DW	SEMIS
	PAGE
	; At line     LINE ~4000
;	VLIST
;
	DB	85H
	DB	'VLIS'
	DB	'T'+80H
	DW	UDOT-5
VLIST	DW	DOCOL
	DW	LIT,80H
	DW	OUTT
	DW	STORE
	DW	CONT
	DW	FETCH
	DW	FETCH
VLIS1	DW	OUTT	;BEGIN
	DW	FETCH
	DW	CSLL
	DW	GREAT
	DW	ZBRAN	;IF
	DW	OFFSET VLIS2-$
	DW	CR
	DW	ZERO
	DW	OUTT
	DW	STORE	;ENDIF
VLIS2	DW	DUPE
	DW	IDDOT
	DW	SPACE
	DW	SPACE
	DW	PFA
	DW	LFA
	DW	FETCH
	DW	DUPE
	DW	ZEQU
	DW	QTERM
	DW	ORR
	DW	ZBRAN	;UNTIL
	DW	OFFSET VLIS1-$
	DW	DROP
	DW	SEMIS
;
;	BYE
;
; EXIT TO PC-DOS
;
	DB	83H
	DB	'BY'
	DB	'E'+80H
	DW	VLIST-8
BYE	DW	$+2
	INT	27H	;I'M HISTORY
	PAGE
;	LIST
;
	DB	84H
	DB	'LIS'
	DB	'T'+80H
	DW	BYE-6
LISTC	DW	DOCOL,DECA
	DW	CR,DUPE
	DW	SCR,STORE
	DW	PDOTQ
	DB	6,'SCR # '
	DW	DOT
	DW	LIT,10H
	DW	ZERO,XDO
LIST1	DW	CR,IDO
	DW	LIT,3
	DW	DOTR,SPACE
	DW	IDO,SCR
	DW	FETCH,DLINE
	DW	QTERM	; ?TERMINAL
	DW	ZBRAN
	DW	OFFSET LIST2-$	;IF
	DW	LLEAV
LIST2	DW	XLOOP
	DW	OFFSET LIST1-$	;ENDIF
	DW	CR,SEMIS
;
;	INDEX
;
	DB	85H
	DB	'INDE'
	DB	'X'+80H
	DW	LISTC-7
INDEX	DW	DOCOL
	DW	LIT,FF
	DW	EMIT,CR
	DW	ONEP,SWAP
	DW	XDO
INDE1	DW	CR,IDO
	DW	LIT,3
	DW	DOTR,SPACE
	DW	ZERO,IDO
	DW	DLINE,QTERM
	DW	ZBRAN
	DW	OFFSET INDE2-$
	DW	LLEAV
INDE2	DW	XLOOP
	DW	OFFSET INDE1-$
	DW	SEMIS
	PAGE
;	TRIAD
;
	DB	85H
	DB	'TRIA'
	DB	'D'+80H
	DW	INDEX-8
TRIAD	DW	DOCOL
	DW	LIT,FF
	DW	EMIT
	DW	LIT,3
	DW	SLASH
	DW	LIT,3
	DW	STAR
	DW	LIT,3
	DW	OVER,PLUS
	DW	SWAP,XDO
TRIA1	DW	CR,IDO
	DW	LISTC
	DW	QTERM	; ?TERMINAL
	DW	ZBRAN
	DW	OFFSET TRIA2-$	;IF
	DW	LLEAV   ;LEAVE
TRIA2	DW	XLOOP	;ENDIF
	DW	OFFSET TRIA1-$
	DW	CR
	DW	SEMIS
;
;	.CPU
;
; PRINT CPU TYPE (8088)
;
	DB	84H
	DB	'.CP'
	DB	'U'+80H
	DW	TRIAD-8
DOTCPU	DW	DOCOL
	DW	BASE,FETCH
	DW	LIT,36
	DW	BASE,STORE
	DW	LIT,22H
	DW	PORIG,TAT
	DW	DDOT
	DW	BASE,STORE
	DW	SEMIS
	PAGE
%if 0 

            CODE LEVEL "MATCH" DEFINITIONS

 STACK PARAMETERS:

 ( cursor:addr   byte:left   str:addr  str:len
           ---   flag  new:cursor:offset         )

 This version of MATCH will handle string lengths
      up to 65535 bytes in length.

%endif
	DB	85H	; MATCH
	DB	'MATC'
	DB	'H'+80H
	DW	DOTCPU-7
MATCH	DW	$+2
	MOV	DI,SI	; SAVE IP
	POP	CX	; STRING COUNT
	POP	BX	;STRING ADDR
	POP	DX	;BYTES LEFT TO SEARCH
	POP	SI	;CURSOR ADDR
	PUSH	SI	;SAVE COPY
MAT1:	LODSB		;GET FIRST BYTE
	CMP	AL,[BX]	;MATCH?
	JNZ	MAT3	;NO
	PUSH	BX	;SAVE STRING ADDR
	PUSH	CX	; &   STRING COUNT
	PUSH	SI	; &   CURSOR ADDR
; TRY TO MATCH REMAINING CHARS IN STRING
;
MAT2:	DEC	CX	;STR. COUNT -1
	JZ	MATCHOK	;EXIT - MATCH FOUND
	DEC	DX	;BYTES LEFT -1
	JZ	NOMATCH	;EXIT - NO MATCH
	INC	BX	;NEXT STR CHAR ADDR
	LODSB		;GET FIRST BYTE
	CMP	AL,[BX]	;MATCH?
	JZ	MAT2	;YES, GET MORE
; NO MATCH YET
	POP	SI
	POP	CX
	POP	BX	;RESTORE POINTERS
MAT3:	DEC	DX	;BYTE LEFT COUNT -1
	JNZ	MAT1	;START OVER
	JMP	MAT4	;EXIT...NO MATCH
MATCHOK:
NOMATCH:
	POP	CX	;ADJUST STACK
	POP	CX	;FOR EXIT
	POP	CX
; EXIT HERE: DX = TRUE/FALSE FLAG ( 0=NO MATCH)
;
MAT4:	MOV	AX,SI	;NEW CURSOR ADDR
	POP	SI	;GET STARTING ADDR
	SUB	AX,SI	;COMPUTE CURSOR OFFSET
	MOV	SI,DI	;GET BACK UP
	JMP	DPUSH	; BYE..BYE
	PAGE
;
;**** LAST DICTIONARY WORD ****
;            T A S K
;
	DB	84H
	DB	'TAS'
	DB	'K'+80H
	DW	MATCH-8
TASK	DW	DOCOL
	DW	SEMIS
;
INITDP	EQU	$	;SHOW END OF DICTIONARY
;
%if 0 

The remaining memory ( up to 'EM' ) is 
used for:

	1. EXTENSION DICTIONARY
	2. PARAMETER STACK
	3. TERMINAL INPUT BUFFER
	4. RETURN STACK
	5. USER VARIABLE AREA
	6. DISK BUFFERS


%endif
					
	RESB    EM-($-$$)    ; Make EM The last location.
 CSEG    ENDS
; ORIG    ENDP
	PAGE
%if 0 

  MISC. NOTES AND SCATTERED THOUGHTS

- This source will assemble on all platforms where NASM is available by the
  command line:
  nasm -fbin fig86.asm -o fig86.exe
  The result will run on MSDOS systems only.

- When in FORTH, <Ctrl> P  will echo all output to the
  printer.

- Use the installation manual.  Descriptions for all FIG
  words are given.  Those ERROR messages you get in FORTH
  correspond to the relative line numbers in blocks
  4 and 5 of the installation manual's model.  

- Remember that all the FORTH words in this version are
  upper case letters.  Use <CAPS LOCK> when in FORTH.

- Changing variable EM will allow you to create a larger
  dictionary space.  However I suggest you develop and
  DEBUG with EM set to 4000H.  Setting it to a larger value
  will result in a larger FORTH.EXE file, and you may
  need to run EXE2BIN ( Chap 10, DOS 2.0 ) to get enough
  disk space.  Once you are satisfied with what you have,
  then by all means take that extra memory.

- Reading the section on batch files may speed up your
  developement.  See the example files that came with
  the Macro Assembler.

- Subscribe to FORTH Dimensions.  It is a valuable source
  of system and application ideas.  Talking with fellow
  FORTH programmers is sure to stir up some exciting ideas.
  Consider joining a FIG chapter.  See the back of FORTH
  Dimensions for more info.

- <Ctrl-Break> will vector to WARM start ( Label WRM: )

%endif

	END	ORIG
