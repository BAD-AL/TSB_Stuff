;    ********************************************************************************
;    *			            *
;    *	              TSB 2007-32.asm 	            *
;    *	               version 1.13	            *
;    *	                2006-2010	            *
;    *			            *
;    ********************************************************************************
;    *			            *
;    *       THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,        *
;    *       EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES      *
;    *       OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND	            *
;    *       NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT            *
;    *       HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,           *
;    *       WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING           *
;    *       FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR          *
;    *       OTHER DEALINGS IN THE SOFTWARE. IF YOU DO NOT AGREE WITH THESE         *
;    *       TERMS, THEN DO NOT USE THIS SOFTWARE.	            *
;    *			            *
;    ********************************************************************************
;
;
;	[ ] field goal cutscene, ball heading towards uprights
;	     (1st persion) doesn't use weather palettes
;
;
;
;
;===================
;    THANKS
;===================
;
; BAD_AL	editing tools, misc. info
; BO FB Offtackle Left 	defensive ratings
; bruddog	misc. info, playtesting
; cxrom	rom hacking, playtesting
; GRG	graphics
; jstout	rom hacking, misc. info, bug fixes
; kingsoby1	offensive ratings
; MrBeef	project manager ;-p, updating rosters, playtesting
; MrNFL	tweaking/updating of final rosters
; Rod Woodson	use of webspace, misc. info
; slim_jimmy7	use of webspace
; TomTupa	roster updating, playtesting
;
;
;===================
;    BUILD
;===================
;
; JN6502A.JN6502A $File $BaseName.nes -patch tsb-Max.nes
;
; "START OF HACK SPACE" = end of last prg bank
;

	.include "\data\const.asm"

;----------------------------------------------------------------------------------------------
	.rambank		; SRAM $6000 - $7FFF
	.include "\data\ram.asm"


;----------------------------------------------------------------------------------------------

	.prgbank 0		; insert at 0x00010 - 0x0400F
	.org $8000
	.include "\data\reg28.asm"

	.org $B000
	.incbin "\data\reg28atts.bin"

;----------------------------------------------------------------------------------------------

	.prgbank 1		; insert at 0x04010 - 0x0800F

;----------------------------------------------------------------------------------------------

	.prgbank 2		; insert at 0x08010 - 0x0C00F

;----------------------------------------------------------------------------------------------

	.prgbank 3		; insert at 0x0C010 - 0x1000F
	.low
	
	.org $A002
	.dw titleScreen_txtData
	
	
	.org $A119		; insert at 0x0C129
	.db YEAR

	.org $A4D4		; insert at 0x0C4E4
	.db YEAR

	.org $B586		; insert at 0x0D596
	.hex F3139A6B0A00FB078A6B	; this repositions the flashing
	.hex 53544152542047414D45FB07FC88B5	; "START GAME" on title screen

			; new title screen text data
	.org $BD10		; insert at 0x0DD20
titleScreen_txtData:	.hex FD0DA5		; [original data]
	.hex 8A293332205445414D2045444954494F4E	; "32 TEAM EDITION"
	.hex 8A671B1C19		; [original data]
	.hex 2053544152542047414D4520191C1B8A	; [original data]
	.hex C5544D20414E442040205445434D4F5C	; [original data]
	.hex 4C54442E
	.db  YEAR
	.hex B24E494E54454E44		; [original data]
	.hex 4F204F4620414D455249434120494E43	; [original data]
	.hex 2E8B0B4C4943454E534544204259F903	; [original data]
	.hex BEBFC0EB203FDD08FBF0	; [original data]
	.hex FC08A5C8F2CCF723C00190181AFE	; not part of data, but must be
			; duplicated for compatibility

;----------------------------------------------------------------------------------------------

	.prgbank 4		; insert at 0x10010 - 0x1400F

	.low

; helmet struct potiners
	.org $A060		; insert at 0x10070
	.hex D8A501A60FA61DA62BA6B2A6D59EE39E
	.hex 55A672A647A606A7F8A6CEA6C0A6DCA6
	.hex F3A5F19E39A622A7A4A6EAA696A630A7
	.hex 3EA74CA75AA7FF9E92A776A768A7AEA7
	
	.org $A5F3		; insert at 0x10603
	.hex F670FFFFFFFC06F8393A	; JETS
	.db >Jets_LH_logo - 8192
	.db <Jets_LH_logo
	.hex AB17
	
	.hex F670FFFFFFFC07F83242	; CIN
	.db >Bengals_LH_logo - 8192
	.db <Bengals_LH_logo
	.hex AB17
	
	.hex F670FFFFFFFC08F83642	; CLE
	.db >Browns_LH_logo - 8192
	.db <Browns_LH_logo
	.hex AB17
	
	.hex F670FFFFFFFC09F83C37	; BAL
	.db >Ravens_LH_logo - 8192
	.db <Ravens_LH_logo
	.hex AB17

	.hex F671FFFFFFFC0AF8363B	; PIT
	.db >Steelers_LH_logo - 8192
	.db <Steelers_LH_logo
	.hex AB17
	
	.hex F671FFFFFFFC0BF8343A	; DEN
	.db >Broncos_LH_logo - 8192
	.db <Broncos_LH_logo
	.hex AB17
	
	.hex F671FFFFFFFC0CF8363A	; KC
	.db >Chiefs_LH_logo - 8192
	.db <Chiefs_LH_logo
	.hex AB17
	


	.org $A688		; insert at 0x10698
	.hex F672FFFFFFFC0FF83B36	; SEA
	.db >Seahawks_LH_logo - 8192
	.db <Seahawks_LH_logo
	.hex AB17

	.hex F672FFFFFFFC10F83638	; DAL
	.db >Cowboys_LH_logo - 8192
	.db <Cowboys_LH_logo
	.hex AB17

	.hex F672FFFFFFFC11F8383A	; GIA
	.db >Giants_LH_logo - 8192
	.db <Giants_LH_logo
	.hex AB17

	.hex F670FFFFFFFC02F83639	; IND
	.db >Colts_LH_logo - 8192
	.db <Colts_LH_logo
	.hex AB17

	.hex F670FFFFFFFC03F83639	; BUF
	.db >Bills_LH_logo - 8192
	.db <Bills_LH_logo
	.hex AB17

	.hex F670FFFFFFFC04F83639	; MIA
	.db >Dolphins_LH_logo - 8192
	.db <Dolphins_LH_logo
	.hex AB17

	.hex F670FFFFFFFC05F8353D	; NE
	.db >Patriots_LH_logo - 8192
	.db <Patriots_LH_logo
	.hex AB17

	.hex F671FFFFFFFC0DF8363A	; OAK
	.db >Raiders_LH_logo - 8192
	.db <Raiders_LH_logo
	.hex AB17

	.hex F672FFFFFFFC0EF8323E	; SD
	.db >Chargers_LH_logo - 8192
	.db <Chargers_LH_logo
	.hex AB17

	.hex F672FFFFFFFC12F8343E	; PHI
	.db >Eagles_LH_logo - 8192
	.db <Eagles_LH_logo
	.hex AB17

	.hex F672FFFFFFFC13F8373A	; ARZ
	.db >Cardinals_LH_logo - 8192
	.db <Cardinals_LH_logo
	.hex AB17

	.hex F671FFFFFFFC14F8363A	; WAS
	.db >Redskins_LH_logo - 8192
	.db <Redskins_LH_logo
	.hex AB17

	.hex F671FFFFFFFC15F8373C	; CHI
	.db >Bears_LH_logo - 8192
	.db <Bears_LH_logo
	.hex AB17

	.hex F673FFFFFFFC16F83738	; DET
	.db >Lions_LH_logo - 8192
	.db <Lions_LH_logo
	.hex AB17

	.hex F674FFFFFFFC17F8363C	; GB
	.db >Packers_LH_logo - 8192
	.db <Packers_LH_logo
	.hex AB17

	.hex F674FFFFFFFC18F83A3A	; MIN
	.db >Vikings_LH_logo - 8192
	.db <Vikings_LH_logo
	.hex AB17

	.hex F673FFFFFFFC19F83536	; TB
	.db >Buccaneers_LH_logo - 8192
	.db <Buccaneers_LH_logo
	.hex AB17

	.hex F674FFFFFFFC1AF83739	; ATL
	.db >Falcons_LH_logo - 8192
	.db <Falcons_LH_logo
	.hex AB17

	.hex F671FFFFFFFC1BF8323A	; STL
	.db >Rams_LH_logo - 8192
	.db <Rams_LH_logo
	.hex AB17

	.hex F673FFFFFFFC1CF8363B	; NO
	.db >Saints_LH_logo - 8192
	.db <Saints_LH_logo
	.hex AB17

	.hex F673FFFFFFFC1DF8353B	; SF
	.db >SF49ers_LH_logo - 8192
	.db <SF49ers_LH_logo
	.hex AB17
	
	.org $B18D		; insert at 0x1119D
	.include "\data\lh_logos.asm"

	.org $BF5C		; insert at 0x11F6C
; [LHLogoDesign]  for expansion teams
TexansHelmetDesign:	.db $9F, $3D, $1E, $01, $34, $05, $36, $80, $3D, $1F
	.db $01, $35, $05, $37, $81, $3D, $3C, $01, $3D, $05
	.db $39, $82, $01, $2A, $FF

JaguarsHelmetDesign:	.db $9E, $3D, $0E, $01, $24, $9F, $3D, $0F, $01, $25
	.db $05, $27, $80, $3D, $1A, $01, $30, $05, $32, $81
	.db $3D, $1B, $01, $31, $FF

TitansHelmetDesign:	.db $9F, $3D, $0A, $01, $20, $05, $22, $80, $3D, $0B
	.db $01, $21, $05, $23, $81, $3D, $0E, $01, $24, $05
	.db $26, $FF

PanthersHelmetDesign:	.db $9E, $3D, $3A, $01, $3B, $9F, $3D, $32, $01, $38
	.db $80, $39, $3E, $3D, $33, $01, $39, $81, $39, $0A
	.db $3D, $36, $01, $3C, $FF


;----------------------------------------------------------------------------------------------

	.prgbank 5		; insert at 0x14010 - 0x1800F

	.high
; this is the original code to load the team sim data pointer
	.org $91D5		; insert at 0x171E5
	TAX
	jmp SubGetEXPSimData
simDataRetREG:	STA $44
	LDA $A118,X
simDataRetEXP:	STA $45


;----------------------------------------------------------------------------------------------

	.prgbank 6		; insert at 0x18010 - 0x1C00F

	.low
	
	.org $A153		; insert at 0x18163
	.include "\data\sim_data.asm"

; this routine gets the address for team data in SRAM, with redirection
	.org $ACA0		; insert at 0x18CB0
	TAY
	jmp SubGetSRAMaddr
sramAddrREG:	STA $42
	LDA $ACAD,Y
sramAddrEXP:	STA $43
	RTS

; [SavData] pointers for regular teams (this is duplicated in the $DFxx page of prg15)
	.org $ACAC		; insert at 0x18CBC
	.dw Bills_SramPtr, Dolphins_SramPtr, Patriots_SramPtr, Jets_SramPtr
	.dw Bengals_SramPtr, Browns_SramPtr, Oilers_SramPtr, Steelers_SramPtr
	.dw Colts_SramPtr, Texans_SramPtr, Jaguars_SramPtr, Titans_SramPtr
	.dw Broncos_SramPtr, Chiefs_SramPtr, Raiders_SramPtr, Chargers_SramPtr
	.dw Redskins_SramPtr, Giants_SramPtr, Eagles_SramPtr, Cowboys_SramPtr
	.dw Bears_SramPtr, Lions_SramPtr, Packers_SramPtr, Vikings_SramPtr,
	.dw Buccaneers_SramPtr, Saints_SramPtr, Falcons_SramPtr, Panthers_SramPtr

	.org $AD5B
;$AD5B:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$AD5D:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; this code adds the stats for the previous play into the temp
; stat data (in-game), used for rush yards, pass yards, etc.
	.org $B637
	;LDA ($40),Y		; insert at 0x19647
	;CLC
	jsr Func_check2PT_forStats
	ADC $44
	STA ($40),Y
	INY
	LDA ($40),Y
	ADC $45
	STA ($40),Y
	RTS
	.org $B646
; this code adds the stats for the previous play into the temp
; stat data (in-game), used for rush tds, ints, etc.
	;LDA ($40),Y		; insert at 0x19656
	;CLC
	jsr Func_check2PT_forStats
	ADC #$01
	BCS _prg06_B64F
	STA ($40),Y
_prg06_B64F:	RTS

; this routine redirects the pointers for loading sim data
;   X=index of team
	.org $B990		; insert at 0x199A0
SubGetEXPSimData:	cpx teamindexLOW * 2
	bcs EXPsimdata
	
REGsimdata:	LDA $A117, X
	jmp simDataRetREG

EXPsimdata:	cpx teamindexHIGH * 2
	bcs REGsimdata
	lda EXPsimPointers - 60, X
	sta $44
	lda EXPsimPointers - 59, X
	jmp simDataRetEXP

; the expansion team sim data pointers and sim data
EXPsimPointers:	.dw Sf_simdata, Stl_simdata, Sea_simdata, Arz_simdata
Sf_simdata:	.hex 47011503645664562243218316251624	; NFC-WEST
	.hex 15241523156414643A2A40303E3E240D
	.hex 0D0D140C080C080C08104A54544A9441

Stl_simdata:	.hex 28021503754654853255229428372736
	.hex 17252726146413532A4E4E44241E2C10
	.hex 0D0B10081010180808084A4A4A549896

Sea_simdata:	.hex 49012302839764553255229517251725
	.hex 1625272615641464463A2A323A243A10
	.hex 10100C0C0C08080808085F544A54A4DB

Arz_simdata:	.hex 1703250285A744242455325529262926
	.hex 13941523146413534C3A461E2E183210
	.hex 0F0D110C0C0C080C080C4A4A4A54A9E0

; this function determines if stats should be counted
Func_check2PT_forStats:	jsr Func_IsIt2PtAttempt_1	; if (not 2PT_ATTEMPTED)
	bcc _check2PT_useStats		;   branch to use stats	
_check2PT_ignoreStats:	pla		; pop old return addr
	pla		;
	rts		;   and RTS like the calling function
_check2PT_useStats:	LDA ($40),Y		; load stat needed
	CLC		;   (compatibilty)
	rts		;   return to calling function












	.high
	
;######WEATHER######
;   these are new palettes for the weather hack, everything else is labeled otherwise
;###################


	.org $A000		; insert at 0x1A010
; #$00: Gameplay
_pal_00_wCLEAR:	.db $0F, $21, $31, $30, $0F, CLEAR_PAL, CLEAR_PAL, $2A, $0F, $21, $31, $30, $0F, $00, $00, $00

	.org $A0F0
; #$0F: Play select screen
_pal_0F_wCLEAR:	.db $0F, $21, $25, $30, $0F, CLEAR_PAL, $25, $30, $0F, $0F, $00, $30, $0F, CLEAR_PAL, $00, $30



; change the palette for "Preseason", "Team Data", and "Team Control" screens
	.org $A140		; insert at 0x1A150
	.hex 111610301110260F11300128110A2130
	.org $A830		; insert at 0x1A840
	.hex 1131301411160F261128163011301730


	.org $A160
; #$16: RUSH TD [slam]
; #$17: FG - close kick
_pal_16_wCLEAR:	.db $0F, CLEAR_DARK_PAL, $10, $30, $0F, $22, $28, $30, $0F, $22, $31, $30, $0F, $27, $15, $30
_pal_17_wCLEAR:	.db $0F, $23, $35, $26, $0F, $30, $10, CLEAR_PAL, $0F, $10, $11, $30, $0F, $10, $15, $30

	.org $A320
; #$32: XPT, SUCCESSFUL TRY, REC TD [run], SACK
_pal_32_wCLEAR:	.db $0F, $21, CLEAR_PAL, $30, $0F, CLEAR_PAL, $00, $10, $0F, $21, $10, $30, $0F, $38, $25, $30





	.org $BEE0
; this function changes pointers if a cut scene with grass is
; going to be shown and weather is on. 
			;###some c-esque psedocode###
Sub_GetPalPtrs:	LDA $0050, Y		; byte A = mem();
	ldy #00		; byte Y = 0;
	cmp #$00		; switch (A)
	beq _chk_weath_is00		; {
	cmp #$0F		;
	beq _chk_weath_is0F		;
	cmp #$16		;
	beq _chk_weath_is16		;
	cmp #$17		;
	beq _chk_weath_is17		;
	cmp #$32		;
	beq _chk_weath_is32		;
	rts		;   case default:	return;
_chk_weath_is32:	iny		;   case $32:	Y++;
_chk_weath_is17:	iny		;   case $17:	Y++;
_chk_weath_is16:	iny		;   case $16:	Y++;
_chk_weath_is0F:	iny		;   case $0F:	Y++;
			;   case $00:	break;
_chk_weath_is00:	sty TempY		; }
			;############################
	pla		; pop return addr
	pla		;
	ldy weatherType		; get offset to palette pointer
	lda _weatherPal_Offs, Y		;
	clc		;
	adc TempY		;   (factor in "Y")
	asl		; get pointer to data
	tay		;
	lda _weatherPal_Ptrs, Y		;
	sta $3E		;
	lda _weatherPal_Ptrs + 1, Y	;
	;sta $3F	; (saved after jmp)	;
	ldy #00		;
	jmp _getPalPtrs_weatherRet	;

_weatherPal_Offs:	.db $00, $05, $0A
_weatherPal_Ptrs:	.dw _pal_00_wCLEAR, _pal_0F_wCLEAR, _pal_16_wCLEAR, _pal_17_wCLEAR, _pal_32_wCLEAR
	.dw _pal_00_wSNOW, _pal_0F_wSNOW, _pal_16_wSNOW, _pal_17_wSNOW, _pal_32_wSNOW
	.dw _pal_00_wRAIN, _pal_0F_wRAIN, _pal_16_wRAIN, _pal_17_wRAIN, _pal_32_wRAIN

_pal_00_wSNOW:	.db $0F, $21, $31, $30, $0F, SNOW_PAL, SNOW_PAL, $2A, $0F, $21, $31, $30, $0F, $00, $00, $00
_pal_00_wRAIN:	.db $0F, $21, $31, $30, $0F, RAIN_PAL, RAIN_PAL, $2A, $0F, $21, $31, $30, $0F, $00, $00, $00
_pal_0F_wSNOW:	.db $0F, $21, $25, $30, $0F, SNOW_PAL, $25, $30, $0F, $0F, $00, $30, $0F, SNOW_PAL, $00, $30
_pal_0F_wRAIN:	.db $0F, $21, $25, $30, $0F, RAIN_PAL, $25, $30, $0F, $0F, $00, $30, $0F, RAIN_PAL, $00, $30
_pal_16_wSNOW:	.db $0F, SNOW_DARK_PAL, $10, $30, $0F, $22, $28, $30, $0F, $22, $31, $30, $0F, $27, $15, $30
_pal_16_wRAIN:	.db $0F, RAIN_DARK_PAL, $10, $30, $0F, $22, $28, $30, $0F, $22, $31, $30, $0F, $27, $15, $30
_pal_17_wSNOW:	.db $0F, $23, $35, $26, $0F, $30, $10, SNOW_PAL, $0F, $10, $11, $30, $0F, $10, $15, $30
_pal_17_wRAIN:	.db $0F, $23, $35, $26, $0F, $30, $10, RAIN_PAL, $0F, $10, $11, $30, $0F, $10, $15, $30
_pal_32_wSNOW:	.db $0F, $21, SNOW_PAL, $30, $0F, SNOW_PAL, $00, $10, $0F, $21, $10, $30, $0F, $38, $25, $30
_pal_32_wRAIN:	.db $0F, $21, RAIN_PAL, $30, $0F, RAIN_PAL, $00, $10, $0F, $21, $10, $30, $0F, $38, $25, $30




;----------------------------------------------------------------------------------------------

	.prgbank 7		; insert at 0x1C010 - 0x2000F

	.low
	.org $B300		; insert at 0x1D310
	.include "\data\def_playbooks.asm"


;	.org $BF00		; insert at 0x1DF10
; Computer Juice:	x1DF10 to x1DF65 
;
; Hex Boost Order:	Defensive Speed
;	Offensive Speed
;	Interception
;	Pass Control
;	Reception
;
; If you change all the values to 03 04 06 09 09 the computer
; will play like you are 16-0 every time that you play.


	.high

	.org $A000		; insert at 0x1E010
	.dw data_newMainMenu	;   update a pointer
	
	.org $A118		; insert at 0x1E128
	.db YEAR

	
; "Preseason" String positions and pointers
	.org $A22F		; insert at 0x1E23F
	.db $88, $E4, $FD
	.dw TD_row1
	.db $88, $EC, $FD
	.dw TD_row2
	.db $88, $FC, $FD	; DEN column
	.dw PTC_row3
	.db $8A, $64, $FD
	.dw TD_row4
	.db $8A, $6C, $FD
	.dw TD_row5
	.db $88, $F4, $FD	; IND column
	.dw PTC_row6

	.org $A27A		; insert at 0x1E28A
	.db YEAR

	.org $A2AD		; insert at 0x1E2BD
	.db YEAR

; "Team Control" String positions and pointers
	.org $A335		; insert at 0x1E345
	.db $88, $C4, $FD
	.dw TD_row1
	.db $88, $CC, $FD
	.dw TD_row2
	.db $88, $DC, $FD	; DEN column
	.dw PTC_row3
	.db $8A, $44, $FD
	.dw TD_row4
	.db $8A, $4C, $FD
	.dw TD_row5
	.db $88, $D4, $FD	; IND column
	.dw PTC_row6

; "NFL Standings" Strings
	.org $A546		; insert at 0x1E556
	.db $20, "AFC", $20, "EAST", $20, "NORTH", $20, "SOUTH", $20, "WEST"

	.org $A56B		; insert at 0x1E57B
	.db $20, "NFC", $20, "EAST", $20, "NORTH", $20, "SOUTH", $20, "WEST"

; changes a pointer for AFC "Division 3RD" slot
	.org $A643		; insert at 0x1E653
	.db $B2, $A6

; changes a pointer for NFC "Division 3RD" slot
	.org $A67F		; insert at 0x1E68F
	.db $B2, $A6

; this string data is used on the playoff bracket during the regular season
; to mark which seed is placed where
	.org $A6C5		; insert at 0x1E6D5
	.db $20, $20, $20, $20, "2ND", $FE, $FE, $FE, $FE
	.db "3RD", $FE
	.db "1ST", $FE
	.db "2ND", $FE
	.db $20, $20, $20, $20, "4TH", $FE, $FE, $FE, $FE
	.db $20, $20, $20, $20, "1ST", $FE, $FE, $FE, $FE

; "Team Data" String positions and pointers
	.org $A933		; insert at 0x1E943
	.db $89, $24, $FD
	.dw TD_row1
	.db $89, $2C, $FD
	.dw TD_row2
	.db $89, $3C, $FD	; DEN column
	.dw TD_row3
	.db $8A, $64, $FD
	.dw TD_row4
	.db $8A, $6C, $FD
	.dw TD_row5
	.db $89, $34, $FD	; IND column
	.dw TD_row6

; text pointers for team standings (NFC-S and NFC-W stored elsewhere)
	.org $AFAF		; insert at 0x1EFBF
	.db $FD, $D3, $AF, $FC, $E5, $AF
	.db $FD, $D3, $AF, $FC, $EA, $AF
	.db $FD, $D3, $AF, $FC, $F0, $AF
	.db $FD, $D3, $AF, $FC, $F6, $AF
	.db $FD, $DC, $AF, $FC, $E5, $AF
	.db $FD, $DC, $AF, $FC, $EA, $AF

; Team standings string data
	.org $AFE5	; insert at 0x1F00C
	.db "EAST", $FF
	.db "NORTH", $FF
	.db "SOUTH", $FF
	.db "WEST", $FF, $FF, $FF

; adjust some pointers for the offense
; drop-down menu on the play select screen
	.org $B498		; insert at 0x1F4A8
	.dw off_dropdown_menu

	.org $B4BA		; insert at 0x1F4CA
	.dw off_dropdown_menu

	.org $B88B		; insert at 0x1F89B
	.db YEAR

; String layout
	.org $B8C0		; insert at 0x1F8D0 [0xF0]
TD_row1:	.db $D6, $00, $B1, $D6, $01, $B1, $D6, $02, $B1, $D6, $03, $FE
TD_row2:	.db $D6, $04, $B1, $D6, $05, $B1, $D6, $06, $B1, $D6, $07, $FE
TD_row3:	.db $D6, $0C, $B1, $D6, $0D, $B1, $D6, $0E, $B1, $D6, $0F, $B3
	.db $D6, $1E, $B1, $D6, $1F, $B1, $D6, $20, $B1, $D6, $21, $FE
TD_row4:	.db $D6, $10, $B1, $D6, $11, $B1, $D6, $12, $B1, $D6, $13, $FE
TD_row5:	.db $D6, $14, $B1, $D6, $15, $B1, $D6, $16, $B1, $D6, $17, $FE
TD_row6:	.db $D6, $08, $B1, $D6, $09, $B1, $D6, $0A, $B1, $D6, $0B, $B3
	.db $D6, $18, $B1, $D6, $19, $B1, $D6, $1A, $B1, $D6, $1B, $FE

PTC_row3:	.db $D6, $0C, $B1, $D6, $0D, $B1, $D6, $0E, $B1, $D6, $0F, $B5
	.db $D6, $1E, $B1, $D6, $1F, $B1, $D6, $20, $B1, $D6, $21, $FE
PTC_row6:	.db $D6, $08, $B1, $D6, $09, $B1, $D6, $0A, $B1, $D6, $0B, $B5
	.db $D6, $18, $B1, $D6, $19, $B1, $D6, $1A, $B1, $D6, $1B, $FE

; this routine checks if the NFC-S or NFC-W
; text pointers for the division standings screen
; are being read and redirects if true
SubGetTxtPtrsForDivStandings:
	cpx #$60		; see if NFC-S or NFC-W txt ptrs
	beq checkTempVarForExpMenu	;     are possibly being accessed
	cpx #$62
	beq checkTempVarForExpMenu	;     and branch if true

returnTxtPtrsREG:	lda #00		; else
	sta $FF		;     clear $FF
	LDA $A000,X		;     and get the low byte of ptr
	jmp subGetTxtPtrsRetREG

checkTempVarForExpMenu:	lda $FF		; else verify it with $FF
	cmp #$30
	beq tempVarIsExpMenu
	cmp #$31
	beq tempVarIsExpMenu
	jmp returnTxtPtrsREG

tempVarIsExpMenu:	sec		; adjust pointer table index
	sbc #$30
	asl
	tax
	lda #00		;     clear $FF
	sta $FF
	lda expTxtPtrs, X		;     get new pointer
	sta $C2
	lda expTxtPtrs + 1, X
	jmp subGetTxtPtrsRetEXP

expTxtPtrs:	.dw NFCStxtPtrs, NFCWtxtPtrs
NFCStxtPtrs:	.db $FD, $DC, $AF, $FC, $F0, $AF	; text pointers for NFC-S
NFCWtxtPtrs:	.db $FD, $DC, $AF, $FC, $F6, $AF	; and NFC-W

; this is the new drop-down menu for offense
off_dropdown_menu:	.hex 0108E4870D0109FEA1010C8B00010EFE
	.hex A10D0C2043414E43454C202020200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C2054494D454F55542020200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C2050554E54204B49434B200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C204649454C4420474F414C0EFE
	.hex A1010C8B00010EFE
	.hex A10D0C204348414E
	.hex 4745202020200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C20504C4159424F4F4B20200EFE
	.hex A1010A8B0F010BFF

;   same as above except for 2PT conversions
drpDwnMenu_2PT_struct:	.hex 88A4D4E10180A3
	.dw off_dropdown_menu_2PT
	.db $FF
off_dropdown_menu_2PT:	.hex 0108E4870D0109FEA1010C8B00010EFE
	.hex A10D0C2043414E43454C202020200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C2054494D454F55542020200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C2050554E54204B49434B200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C204B49434B2050415420200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C204348414E4745202020200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C20504C4159424F4F4B20200EFE
	.hex A1010A8B0F010BFF

; this is the new main menu
data_newMainMenu:	.hex C9F2D0201AF68C485445434D4F8C8453
	.hex 5550455220424F574CF59D0D050D9524
	.hex 0B0C95320B0E9E850D0FAD0408AD1209
	.hex AE840AAE920B8D05
	.db  YEAR
	.hex 204E464C
	.hex 8D46505245534541534F4E8D86534541
	.hex 534F4E2047414D458DC650524F20424F
	.hex 574C8E065445414D20444154418E464F
	.hex 5054494F4E53FF05505010FF


	.org $BC00		; insert at 0x1FC10
	.include "\data\teamstrings.asm"


;----------------------------------------------------------------------------------------------

	.prgbank 8		; insert at 0x20010 - 0x2400F
	.low

; init cursor coordinates for main menu
	.org $80B2
	LDY <main_menu_coor
	LDX >main_menu_coor
	LDA #$02
	JSR $D68A

	.org $80CA
; this code handles menu selects for main menu:
;   PRESEASON
;   SEASON GAME
;   PRO BOWL
;   TEAM DATA
;   [OPTIONS]
;$80CA:20 F4 94  JSR $94F4
;$80CD:A9 F0     LDA #$F0
;$80CF:8D 00 02  STA $0200 = #$F0
;$80D2:A5 E1     LDA $00E1 = #$04
;$80D4:0A        ASL
;$80D5:AA        TAX
;$80D6:BD E0 80  LDA $80E0,X @ $80FB = #$20
;$80D9:48        PHA
;$80DA:BD DF 80  LDA $80DF,X @ $80FA = #$01
;$80DD:48        PHA
;$80DE:60        RTS
	JSR $94F4
	LDA #$F0
	STA $0200
	jsr Sub_OptionsMenuHook
	TAX
	LDA $80E0,X
	PHA
	LDA $80DF,X
	PHA
	RTS

; this code just replaces sram references with labels so that
; if anything moves around, the reference is still valid
	.org $828F		; insert at 0x2029F
	LDA SRAMSeasonWeekNumber	; SRAM CODE

	.org $82AB		; insert at 0x202BB
	LDA SRAMSeasonWeekNumber	; SRAM CODE

	.org $8383		; insert at 0x20393
	LDX SRAMSeasonWeekNumber	; SRAM CODE

	.org $838B		; insert at 0x2039B
	CPX SRAMAutoSkipWeekNumber	; SRAM CODE

	.org $8390		; insert at 0x203A0
	LDX SRAMAutoSkipWeekNumber	; SRAM CODE

	.org $83E4		; insert at 0x203F4
	STA SRAMAutoSkipWeekNumber	; SRAM CODE


	.org $8448		; insert at 0x20458
; this is the code for the data reset menu
;     i cut out one of the confirmations in order to free up some sram space
	BIT $3A
	BVC #$03
	JMP $84BB
	BPL #$EC
	LDA $E1
	BNE #$03
	JMP $84BB
	
	JMP $8497	; instead of doin all the bull shit below
;$845B:A9 4D	LDA #$4D	;     jump to the next text line
;$845D:85 3E	STA $3E
;$845F:A9 22	LDA #$22
;$8461:85 3F	STA $3F
;$8463:A9 03	LDA #$03
;$8465:85 40	STA $40
;$8467:A9 62	LDA #$62
;$8469:85 41	STA $41
;$846B:A2 1C	LDX #$1C
;$846D:A0 0B	LDY #$0B
;$846F:20 D4 94	JSR $94D4
;$8472:A9 08	LDA #$08
;$8474:A2 0F	LDX #$0F
;$8476:20 A2 C3	JSR $C3A2
;$8479:A0 09	LDY #$09
;$847B:A2 BA	LDX #$BA
;$847D:A9 02	LDA #$02
;$847F:20 8A D6	JSR $D68A
;$8482:A9 01	LDA #$01
;$8484:20 9A CC	JSR $CC9A
;$8487:20 B4 D6	JSR $D6B4
;$848A:20 F9 D6	JSR $D6F9
;-------------
;$848D:24 3A	BIT $3A
;$848F:70 21	BVS $84B2
;$8491:10 EF	BPL $8482
;$8493:A5 E1	LDA $E1
;$8495:F0 1B	BEQ $84B2
;$8497:A9 19	LDA #$19	; <------------jump here
;$8499:A0 0C	LDY #$0C
;$849B:A2 80	LDX #$80
;$849D:20 54 C4	JSR $C454
;$84A0:A9 19	LDA #$19
;$84A2:A0 06	LDY #$06
;$84A4:A2 80	LDX #$80
;$84A6:20 54 C4	JSR $C454
;$84A9:4C 8F 82	JMP $828F
;$84AC:20 4C B3	JSR $B34C
;$84AF:4C 99 82	JMP $8299

; this sets the dest address for the "NFL Standings" scroll
;     i shifted it up to preserve sram space
	.org $8514		; insert at 0x20524
	LDA #$90	; [write]
	STA $40
	LDA #$60
	STA $41

	.org $85B5		; insert at 0x205C5
	LDA #$90	; [read]
	STA $3E
	LDA #$60
	STA $3F

; this sets the dest address for the "Tean Rankings" scroll
;     i shifted it up to preserve sram space
	.org $85ED		; insert at 0x205FD
	LDA #$C8	; [write]
	STA $40
	LDA #$60
	STA $41

	.org $8662		; insert at 0x20672
	LDA #$C8	; [read]
	STA $3E
	LDA #$60
	STA $3F

; expand the "Team Data" grid size
	.org $88F6		; insert at 0x20906
	.db $22


	.org $8C82		; insert at 0x20C92
;$8C82:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$8C84:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; this code adjust the team index when selecting players for pro-bowl roster
;     i shrank the code down a bit and was able to add half a routine
;     in the free space. the original codes can also branch to the PLA PLA.
	.org $8C9F
	BIT $3A		; 01 02
	BVS _skip_AFCNFC_shit		; 03 04
	LDA $3A		; 05 06
	LSR		; 07
	BCS _pb_inc_index		; 08 09
	LSR		; 10
	BCC _pb_exit		; 11 12
_pb_dec_index:	ldy #PRG15_DEC_PROBWL_INDEX	; 13 14
	jsr SubCallFunc_PRG15		; 15 1617
	rts		; 18
_pb_inc_index:	ldy #PRG15_INC_PROBWL_INDEX	; 19 20
	jsr SubCallFunc_PRG15		; 21 2223
_pb_exit:	rts		; 24
; ----------------  only 14 bytes here ---------------
; this is part 1 of the swaping routine hack
swap_player_part1:	cmp #$1C		; 01 02
	beq _swap_probowl_player	; 03 04
	jmp _swap_player_part2		; 05 0607
_swap_probowl_player:	jmp swap_player_return_probowl	; 08 0910
; ------------------------------------------------------
;     this continues from above
	.org $8CC3
_skip_AFCNFC_shit:	PLA	; $8CC3:68        PLA
	PLA	; $8CC4:68        PLA

	; 36 bytes [original code]
	;$8C9F:24 3A     BIT $003A = #$00
	;$8CA1:70 20     BVS $8CC3
	;$8CA3:A5 3A     LDA $003A = #$00
	;$8CA5:4A        LSR
	;$8CA6:B0 0D     BCS $8CB5
	;$8CA8:4A        LSR
	;$8CA9:90 17     BCC $8CC2
	;$8CAB:C6 A0     DEC $00A0 = #$00
	;$8CAD:10 04     BPL $8CB3
	;$8CAF:A9 0D     LDA #$0D
	;$8CB1:85 A0     STA $00A0 = #$00
	;$8CB3:38        SEC
	;$8CB4:60        RTS
	;$8CB5:E6 A0     INC $00A0 = #$00
	;$8CB7:A5 A0     LDA $00A0 = #$00
	;$8CB9:C9 0E     CMP #$0E
	;$8CBB:90 04     BCC $8CC1
	;$8CBD:A9 00     LDA #$00
	;$8CBF:85 A0     STA $00A0 = #$00
	;$8CC1:38        SEC
	;$8CC2:60        RTS
	;$8CC3:68        PLA
	;$8CC4:68        PLA



	.org $8D36
;$8D36:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$8D38:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;




	.org $8F08		; insert at 0x20F18
;$8F08:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$8F0A:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;


	.org $8F36		; insert at 0x20F46
;$8F36:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$8F38:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;


; this adjust the index for afc or nfc teams
	.org $8F7E
	LDX $6F
	CPX #$1D
	BCC $8F87
	CLC
	ADC #$10
	RTS

; expand the String table for "Playbook" screen
	.org $8FF3		; insert at 0x21003
	ADC #$44


; this code refreshes the playbook screen
; after a reset
	.org $91CF		; insert at 0x211DF
	LDA $6E		; FUNC2
	jmp Sub_Refresh_PBScreen
	nop
;$91D1:C9 1C	[CMP #$1C]	; replaced with JMP $xxxx
;$91D3:B0 09	[BCS $91DE]	;   and NOP
;$91D5:20 69 9D	JSR $9D69
;$91D8:20 AA 9C	JSR $9CAA
;$91DB:4C D0 8F	JMP $8FD0
;$91DE:20 D5 8E	JSR $8ED5
;$91E1:4C D0 8F	JMP $8FD0

	.org $928B		; insert at 0x2129B
; this code returns from a game to the main menu (preseason)
;   CursorX ($E2) does not need to be zeroed for main menu
;$928B:A9 00     LDA #$00
;$928D:85 E1     STA $00E1 = #$02
;$928F:85 E2     STA $00E2 = #$01
;$9291:4C 89 80  JMP $8089
	LDA #$00
	STA CursorY
	sta CurrentQuarter
	JMP $8089

	.org $93CE		; insert at 0x213DE
; this code returns from a game to the main menu (season)
;   CursorX ($E2) does not need to be zeroed for main menu
;$93CE:A9 02     LDA #$02
;$93D0:85 E1     STA $00E1 = #$02
;$93D2:A9 00     LDA #$00
;$93D4:85 E2     STA $00E2 = #$07
	LDA #$02
	STA CursorY
	LDA #$00
	sta CurrentQuarter

; set the weather for season
; (when current game is read from sram)
	.org $9497		; insert at 0x214A7
	jsr SetWeatherSEASON
	nop
	nop

	.org $94DC		; inerst at 0x214EC
;$94DC:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$94DE:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; expand the String table for "O-starters" screen
	.org $9666		; insert at 0x21676
	ADC #$44

; this code allows all teams to have their own
; default offensive formation
	.org $9634		; insert at 0x21654
	LDX $6E
	LDA Base_off_form, X
	TAY
	JMP $9650

; this code resets the starters from the "Team Data" menu
	.org $9719		; insert at 0x21729
	LDA $6E		; 01 02
	CMP #$1C		; 03 04
	beq _reset_afc_starters		; 05 06
	cmp #$1D		; 07 08
	beq _reset_nfc_starters		; 09 10

_reset_reg_starters:	JSR $B883		; 11 1213
	JSR $9CAA		; 14 1516
	JMP _start_reset_reg		; 17 1819

_reset_afc_starters:	LDA #$19		; 20 21
	LDY #$21		; 22 23
	LDX #$80		; 24 25
	JMP _start_reset_pb		; 26 2728

_reset_nfc_starters:	LDA #$19		; 29 30
	LDY #$24		; 31 32
	LDX #$80		; 33 34
_start_reset_pb:	JSR $C454		; 35 3637
	JSR $8ED5		; 38 3940
	nop		; 41
_start_reset_reg:	LDY #$42		; 42 43
	;----------------
	;    ORIGINAL CODE [43 bytes]
	; $9719:A5 6E     LDA $006E = #$1E
	; $971B:C9 1C     CMP #$1C
	; $971D:B0 09     BCS $9728
	; $971F:20 83 B8  JSR $B883
	; $9722:20 AA 9C  JSR $9CAA
	; $9725:4C 42 97  JMP $9742
	; $9728:D0 0C     BNE $9736
	; $972A:A9 19     LDA #$19
	; $972C:A0 21     LDY #$21
	; $972E:A2 80     LDX #$80
	; $9730:20 54 C4  JSR $C454
	; $9733:4C 3F 97  JMP $973F
	; $9736:A9 19     LDA #$19
	; $9738:A0 24     LDY #$24
	; $973A:A2 80     LDX #$80
	; $973C:20 54 C4  JSR $C454
	; $973F:20 D5 8E  JSR $8ED5
	; $9742:A0 42     LDY #$42

; this is the original code that determine which offensive starter
; routine to call (regular team or pro-bowl).
	.org $9961		; insert at 0x21971
	LDA $6E		; $9961:A5 6E     LDA $006E = #$00
	jmp SubJumpOFstartRoutine	; $9963:C9 1C     CMP #$1C
	.db $FF		; $9965:B0 59     BCS $99C0
	LDX #$00		; $9967:A2 00     LDX #$00

	.org $9B56		; insert at 0x21B66
; this code swaps starters for "Team Data" menu
	LDA $6E
	jmp swap_player_part1	; $9B58:C9 1C     CMP #$1C
	.db $FF	; $9B5A:B0 36     BCS $9B92
swap_player_return_regTeam:
;$9B5C:20 C8 DE  JSR $DEC8
;$9B5F:A0 F6     LDY #$F6
;$9B61:A5 93     LDA $93
;$9B63:20 EB 9B  JSR $9BEB
;$9B66:A5 95     LDA $95
;$9B68:20 F2 9B  JSR $9BF2
;$9B6B:C8        INY
;$9B6C:A5 97     LDA $97
;$9B6E:20 EB 9B  JSR $9BEB
;$9B71:A5 99     LDA $99
;$9B73:20 F2 9B  JSR $9BF2
;$9B76:C8        INY
;$9B77:A5 9B     LDA $9B
;$9B79:20 EB 9B  JSR $9BEB
;$9B7C:A5 9D     LDA $9D
;$9B7E:20 F2 9B  JSR $9BF2
;$9B81:C8        INY
;$9B82:A5 9F     LDA $9F
;$9B84:20 EB 9B  JSR $9BEB
;$9B87:A5 A1     LDA $A1
;$9B89:20 F2 9B  JSR $9BF2
;$9B8C:20 AA 9C  JSR $9CAA
;$9B8F:4C DC 9B  JMP $9BDC
	.org $9B92
swap_player_return_probowl:
;$9B92:A2 00     LDX #$00

	.org $9BE5
;$9BE5:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$9BE7:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

	.org $9CD1
;$9CD1:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$9CD3:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;


	.org $9D94		; insert at 0x21DA4
;$9D94:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$9D96:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

	.org $9DD4		; insert at 0x21DE4
;$9DD4:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$9DD6:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;


; this routine adjust the team index and data pointers for loading mini-helmet shit
	.org $9FC8		; insert at 0x21FD8
SubAdjustMiniHelmetIndex:
	cmp teamindexLOW
	bcs teamindexisadjusted		; (index >= #$1E) then don't adjust

	lda #$1E		; else inc to first exp team slot
	sta $90

teamindexisadjusted:	cmp teamindexHIGH
	bcs minihelemtisfinished	; (index >= #$22) branch to exit

	sec		; else get adjusted pointers
	sbc #$1E

	ldy $C2
	cpy #$55		; if (Y == #$55) then Team Data
	beq screenisTeamData
	cpy #$51		; if (Y == #$51) then Preseason
	beq screenisPreSTeamCtrl
	cpy #$53		; if (Y == #$53) then Team Control
	bne screenisUnknown		; else branch to exit normally

screenisPreSTeamCtrl:	clc
	adc #$04
screenisTeamData:	asl
	tay

	lda EXPminiHelemtTDptrs, Y
	sta $8E
	lda EXPminiHelemtTDptrs + 1, Y
	sta $8F
	jmp $A848		;     and loop again

minihelemtisfinished:	ldy #PRG15_NEW_ATT
	jsr SubCallFunc_PRG15		; update the att table
screenisUnknown:	JMP $A81E		; exit loop




	.high
; make the string table larger for the large helmet intro to games
	.org $A016		; insert at 0x22026
	ADC #$22

	.org $A026		; insert at 0x22036
	ADC #$44

	.org $A036		; insert at 0x22046
	ADC #$22

	.org $A046		; insert at 0x22056
	ADC #$44



	.org $A062
;$A062:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$A064:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;



; show scoreboard (q1,q2) then swap teams
	.org $A0F8		; insert at 0x2210A
;$A0F8:A9 21	LDA #$21
;$A0FA:20 FA 9D	JSR $9DFA
	LDA #$21
	jsr SwapTeamSides

; show scoreboard (q2,q3) then swap teams
;   && skip halftime show if (WEATHER != CLEAR)
	.org $A102		; insert at 0x22114
;$A102:A9 22     LDA #$22                        ;   show scoreboard
;$A104:20 FA 9D  JSR $9DFA                       ;
;$A107:20 0D AE  JSR $AE0D                       ;   goto halftime show
	LDA #$22
	jsr SwapTeamSides
	jsr Sub_CheckHalfTimeShow

; show scoreboard (q3,q4) then swap teams
	.org $A12C		; insert at 0x2213C
;$A12C:A9 23	LDA #$23
;$A12E:20 FA 9D	JSR $9DFA	; show scoreboard
;$A131:20 36 A2	JSR $A236	; execute 4th
	LDA #$23
	jsr SwapTeamEndOfGame
	nop	; skip line:     $A131:20 36 A2	JSR $A236
	nop	; 4th quarter is done in "SwapTeamEndOfGame"
	nop
;$A134:AD 99 03	LDA $0399 = #$06	;   if (P1_Score == P2_Score)
;$A137:CD 9E 03	CMP $039E = #$00	;
;$A13A:F0 05	BEQ $A141	;     goto "Overtime"
;$A13C:A9 4E	LDA #$4E	;   else ???
;$A13E:4C FA 9D	JMP $9DFA	;     exit to blue screen




; set the clock at start of a quarter
	.org $A236		; insert at 0x22246
;$A236:A9 00     LDA #$00
;$A238:85 6A     STA $006A = #$00
;$A23A:A9 05     LDA #$05
;$A23C:85 6B     STA $006B = #$00
	LDA #$00
	STA Time_Seconds
	jsr Sub_GetQtrLength
	nop

	.org $A42C		; insert at 0x2243C
;$A42C:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$A42E:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;




; update pointer
	.org $A4AB		; insert at 0x224BB
	CMP SRAMAutoSkipWeekNumber	; SRAM CODE

; this code cycles through each division and shows the standings
;     the two new divisions are handled somewhere else
	.org $A5EF		; insert at 0x226DF
	LDA #$00
	JSR $A64A
	LDA #$01
	JSR $A64A
	LDA #$02
	JSR $A64A
	LDA #$03
	JSR $A64A
	LDA #$04
	JSR $A64A
	LDA #$05
	JSR SubFinishEndOfSeasonCycle

; this code changes an address to fix the team standings
; cycle at the end of the season
	.org $A64A		; insert at 0x2265A
	JSR $AF28

; shift working ram space up to preserve sram space for stats
;     this is called for "NFL Standings" screen [write]
	.org $A698
	LDA #$48
	STA $40
	LDA #$60
	STA $41

	.org $A6A7		; insert at 0x226B7
;$A6A7:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$A6A9:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; this routine loads the top 2 tiles for the mini-helmet sprites
	.org $A6F9		; insert at 0x22709
	LDY $44
	jmp SubGetSmallHelmetDataTop
smallhelmetTopRetREG:	STA $033A,X
	INX
	LDA $BBB7,Y
smallhelmetTopRetEXP:	STA $033A,X
	INX
	JSR $D2C8

; this routine loads the bottom 2 tiles for the mini-helmet sprites
	.org $A71C		; insert at 0x2272C
	LDY $44
	jmp SubGetSmallHelmetDataBot
smallhelmetBotRetREG:	STA $033A,X
	INX
	LDA $BBB9,Y
smallhelmetBotRetEXP:	STA $033A,X
	INX
	JSR $D2C8
	
; this fixes the playoff bracket palette glitch
; by adjusting the location of the sram scratchpad
	.org $A750		; insert at 0x22760
	adc #$45

; this routine gets the byte that controls color for the mini-helmets
	.org $A77C		; insert at 0x2278C
	jsr SubGetSmallHelmetDataAtt

; this routine gets the byte that controls color for the mini-helmets
	.org $A7A0		; insert at 0x227B0
	jsr SubGetSmallHelmetDataAtt
	AND #$03

	.org $A7AA		; insert at 0x227BA
;$A7AA:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$A7AC:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; this routine gets the byte that controls the mini-logo for the mini-helmets
	.org $A7C3		; insert at 0x227D3
	jsr SubGetSmallHelmetDataAtt
	AND #$FC


; shift working ram space up to preserve sram space for stats
;     this is called for "NFL Standings" screen [read]
	.org $A831
	LDA #$48
	STA $3E
	LDA #$60
	STA $3F

; this routine is the control loop for loading mini helmet data
	.org $A85F		; insert at 0x2286F
	LDA $8E
	CLC
	ADC #$02
	STA $8E
	LDA $8F
	ADC #$00
	STA $8F
	INC $90
	LDA $90
	CMP #$1C
	BCC #$D4
	jmp SubAdjustMiniHelmetIndex

; this overrides the large helmet data addess if needed
	.org $A882		; insert at 0x22892
	LDX $3F
	jsr SubGetLHBaseAddr

; get the "0x40" (helmet type) data for the large helmet intro to game
	.org $A89C		; insert at 0x228AC
	LDX $3F
	jsr SubGetLHBaseAddr


	.org $A8BB		; insert at 0x228CB
;$A8BB:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$A8BD:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;



	.org $A8E7
;$A8E7:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$A8E9:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;



; get the "0x40" (helmet type) data for the "Team Data" screen
	.org $A8C8		; insert at 0x228D8
	LDX $3F
	jsr SubGetLHBaseAddr


; this is the original routine to load the large helmet palette with my jump statement inserted.
	.org $A98A		; insert at 0x2299A in rom
	jmp SubGetLHP
LHPreturnREG:	TAX
	LDA $BD69,X
	STA $031F,Y
	LDA $BD6A,X
	STA $0320,Y
	LDA $BD6B,X
	STA $0321,Y
	LDA $BD6C,X
	STA $032C,Y
	LDA $BD6D,X
	STA $032D,Y
	LDA $BD6E,X
	STA $032F,Y
	LDA $BD6F,X
	STA $0330,Y
	LDA $BD70,X
	STA $0331,Y
LHPreturnEXP:	LDA #$0F
	STA $032B,Y
	RTS

; set the weather for preseason (1-human)
; (when home team [p1] selects a team)
	.org $AA0D		; insert at 0x22A1D
	jsr SetWeatherPRESEASON
	nop
	nop

; set the weather for preseason (2-humans)
; (when home team [p1] selects a team)
	.org $AADA		; insert at 0x22AEA
	jsr SetWeatherPRESEASON
	nop
	nop

; this is the original routine to load the team index for "Preseason" and "Team Control"
; with redirection to check for expanded menu
	.org $ABFF
	jmp SubCheckExpPTCMenu		; insert at 0x22C0F
	RTS

; "Preseason" and "Team Control" team index values
	.org $AC03		; insert at 0x22C13
	.db $00, $04, $08, $0C
	.db $01, $05, $09, $0D
	.db $02, $06, $0A, $0E
	.db $03, $07, $0B, $0F

	.db $10, $14, $18, $1E
	.db $11, $15, $19, $1F
	.db $12, $16, $1A, $20
	.db $13, $17
	; last two stored elsewhere

; this is the original routine to load team index for "Team Data" screen with
; redirection to check for expanded menu
	.org $AC22		; insert at 0x22C32
	jmp SubCheckExpTDMenu
	RTS

; "Team Data" team index values
	.org $AC26		; insert at 0x22C36 [0x1E]
	.db $FF, $FF
	.db $00, $04, $08, $0C
	.db $01, $05, $09, $0D
	.db $02, $06, $0A, $0E
	.db $03, $07, $0B, $0F

	.db $10, $14, $18, $1E
	.db $11, $15, $19, $1F
	.db $12, $16, $1A, $20
	; last line stored elsewhere

; this corrects the flashing glitch the occurs for the expanded
; "Preseason" and "Team Control" menus
	.org $AC55		; insert at 0x22C65
	jmp SubExpMenuFlash
	JMP $AC5D

; this is the orignal code to check each division for an undisputed
; division champ, with an extension at the end for the 2 new divisions
	.org $AE37		; insert at 0x22E47
	LDA $6758	; if (week# < 0x09) then
	CMP #$09
	BCC $AE5C	;     branch to skip check
	LDA #$00
	JSR $AE5D
	LDA #$01
	JSR $AE5D
	LDA #$02
	JSR $AE5D
	LDA #$03
	JSR $AE5D
	LDA #$04
	JSR $AE5D
	LDA #$05
	jmp extendedDivChampCheck
extendedDivCheckReturn:	RTS
;-----------------------------------------------
	TAY
	LDX $67A2,Y
	BMI #$01
	RTS
;-----------------------------------------------
	STA $8E
	ASL
	TAY
	LDA Static_DivSetup, Y
	STA $8F
	STA $90
	LDA Static_DivSetup + 1, Y
	STA $91
	STA $92
	LDA #$00
	STA $93

	.org $AE5E		; insert at 0x22E6E
; the address changed, so update it
	LDX SRAMDivLeadWldCardData, Y

	.org $AEFA		; insert at 0x22F0A
	STA SRAMDivLeadWldCardData, X

; this affects the division standings screen
; -using $E1 and $E2 to calculate which division needs to be displayed
;     0=AFC-E, 1=AFC-N, 2=AFC-S, 3=AFC-W
;     4=NFC-E, 5=NFC-N, 6=NFC-S, 7=NFC-W
	.org $AF21		; insert at 0x22F31
	lda $E1
	asl
	asl
	clc
	adc $E2
	sta $45
	clc
	adc #$2A
	sta $FF
	ldx #$0F
	jsr $C3A2

; this is the original code to load the division info screen for NFL Standings
	.org $AF34		; insert at 0x22F44
	LDA $45
	ASL
	TAY
	LDA Static_DivSetup,Y
	LDX Static_DivSetup + 1,Y
	STX $90

; this fixes a glitch where any team number over $1F would be masked out (CAR and TEN)
	.org $AFCE		; insert at 0x22FDF
	AND #$3F

; change the pointer for "NFL Standings"
	.org $B0FD		; insert at 0x2310D
	CMP SRAMDivLeadWldCardData, X

; this expands the number of divisions to 8 for the division champ/wild card markers
; on the team standing screens
	.org $B10A		; insert at 0x2311A
	CPX #$08

	.org $B1DA		; insert at 0x231EA
; this code is executed at the conclusion of the season
; and handles all the post season shit
;
; jstout:
;
; AFC:                       NFC:
;    $6786               $678A
;    $6787               $678B
; $6776                     $677A
; $6777                     $677B
;       $6796         $679A
;          $679E   $679F
;       $6797         $679B
; $677F                     $6783
; $677E                     $6782
;    $678F               $6791
;    $678E               $6792

	LDA #$00		; force a division champ, if not already awarded
	JSR $B2A4
	LDA #$01
	JSR $B2A4
	LDA #$02
	JSR $B2A4
	LDA #$03
	JSR $B2A4
	LDA #$04
	JSR $B2A4
	LDA #$05
	JSR $B2A4
	lda #$06
	jsr $B2A4
	lda #$07
	jsr $B2A4

	LDA #$80
	STA MMC3_PRGRAM_CTRL
			; figure out seed# for AFC div champs
	LDA SRAMDivLeadWldCardData	;     AFC-EAST
	STA $97
	JSR $B40C
	STA $96
	LDA SRAMDivLeadWldCardData + 1	;     AFC-NORTH
	STA $99
	JSR $B40C
	STA $98
	LDA SRAMDivLeadWldCardData + 2	;     AFC-SOUTH
	STA $9B
	JSR $B40C
	STA $9A
	lda SRAMDivLeadWldCardData + 3	;     AFC-WEST
	sta $9D
	jsr $B40C
	sta $9C
	;----
	LDX #$04		;     re-order according to rank
	JSR $B30C
	LDA $97		;     write to playoff bracket
	STA $678E
	LDA $99
	STA $6786
	LDA $9B
	STA $6776
	lda $9D
	sta $677E
			; figure out seed# for NFC div champs
	LDA SRAMDivLeadWldCardData + 4	;     NFC-EAST
	STA $97
	JSR $B40C
	STA $96
	LDA SRAMDivLeadWldCardData + 5	;     NFC-NORTH
	STA $99
	JSR $B40C
	STA $98
	LDA SRAMDivLeadWldCardData + 6	;     NFC-SOUTH
	STA $9B
	JSR $B40C
	STA $9A
	lda SRAMDivLeadWldCardData + 7	;     NFC-WEST
	sta $9D
	jsr $B40C
	sta $9C
	;----
	LDX #$04		;     re-order according to seed#
	JSR $B30C
	LDA $97		;     write to playoff bracket
	STA $6792
	LDA $99
	STA $678A
	LDA $9B
	STA $677A
	lda $9D
	sta $6782

	LDA #$00		; figure out the AFC wildcards
	JSR $B2DF
	LDA $97
	STA $6777
	STA SRAMDivLeadWldCardData + 8
	jmp FuncLengthenWildCardRoutine 	;     ran out of room (see prg31)

	.org $B29B
func_lenWldCrd_ret:	JSR $C4B3
	LDA #$C0
	STA MMC3_PRGRAM_CTRL
	RTS


	.org $B2A4		; insert at 0x232B4
; this routine forces a division champ base on A
;
;     in:    A = xxxx xddd
;                      +++---division
;	       000=AFC East
;	       001=AFC North
;	       010=AFC South
;	       011=AFC West
;	       100=NFC East
;	       101=NFC North
;	       110=NFC South
;	       111=NFC West
	TAY
	LDX SRAMDivLeadWldCardData, Y
	BPL #$34
	STY $92
	ASL
	TAY
	LDA Static_DivSetup, Y
	LDX Static_DivSetup + 1, Y
	STX $90
	JSR $B3EC
	LDX $90
	JSR $B30C
	LDA #$80
	STA $A001
	LDX $92
	LDA $97
	STA SRAMDivLeadWldCardData, X
	STA $6E
	JSR $C4B3
	LDA #$C0
	STA $A001
	LDA #$56
	LDX #$06
	JSR $C3A2
	JMP $B489
	RTS	
; this routine ranks 16 teams (each conference) based on what A is	; insert at 0x232EF
; A = #$00    AFC
; A = #$10    NFC
	STA $8E		; set conference parameters
	LDA #$10
	STA $8F
	LDA #$00
	STA $91

	LDA $8E
	LDX #$08		; see if team is a divisonal champ
	CMP SRAMDivLeadWldCardData - 1, X
	BEQ #$12
	DEX
	BNE #$F8
	JSR $B40C		;     calculate team "score"
	LDX $91		;     get array index
	STA $96, X		;     write team index & "score" to array
	LDA $8E
	STA $97, X
	INC $91		;     inc array index var
	INC $91
	jmp SubAdjustWildCardLoopIndex
	.db $FF
subadjustwldcrdindRET:	BNE #$DF

	LDX #$0C		; (# of teams to loop)
;	DEX		; reorder them
;	STX $8F
;	LDA $8F
;	STA $8E
;	LDX #$00
;	LDA $96, X
;	CMP $98,X
;	BCC #$23
;	BNE #$24
;
;	JSR $B152
;	BNE #$1A
;
;	LDY #$B5
;	LDA ($40),Y
;	CMP ($3E),Y
;	STA $44
;	INY
;	LDA ($40),Y
;	SBC ($3E),Y
;	ORA $44
;	BNE #$09
;
;	LDA $3D
;	AND #$04
;	BEQ #$08
;
;	JMP $B33E
;
;	BCS #$03
;	JSR $B1B8
;	INX
;	INX
;	DEC $8E
;	BNE #$CE
;	DEC $8F
;	BNE #$C4
;	RTS

; this is the original routine to read the data needed for the "Team Rankings" menu
	.org $B651		; insert at 0x23661
	LDA #$00
	STA $92
rankingsReturnLoop:	LDA $91
	STA $6E
	LDA #$B6
	PHA
	LDA #$61
	PHA
	JMP ($0094)
	LDA $92
	ASL
	ASL
	TAX
	LDA $8E
	STA $03A1,X
	LDA $8F
	STA $03A2,X
	LDA $91
	STA $03A0,X
	INC $91
	INC $92
	jmp SubCheckRankingsIndex
	.db $FF
rankingsReturnExit:	LDA $A9
	SEC
	SBC $A8
	SEC
	SBC #$01
	STA $8F
	LDA $8F
	STA $8E

; adjust team name pointers for "Team Rankings" (make string table larger)
	.org $B75A		; insert at 0x2376A
	ADC #$44
	
; reset the KR/PR on a starter reset
	.org $B919		; insert at 0x2392B
	LDX $6E
	jsr SubGet_KR_PR_starterreset
	LSR
	LSR
	LSR
	LSR
	LDY #$29
	JSR $B93D
	LDX $6E
	jsr SubGet_KR_PR_starterreset

	.org $B937		; insert 0x23947
;$B937:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$B939:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; these adjust the array indexes for the "Team Rankings" screen

;    Offense - NFL
	.org $B96C		; insert at 0x2397C
	.db $00, $20
;    Offense - AFC
	.org $B970		; insert at 0x23980
	.db $00, $10
;    Offense - NFC
	.org $B974		; insert at 0x23984
	.db $10, $20
;    Defense - NFL
	.org $B978		; insert at 0x23988
	.db $00, $20
;    Defense - AFC
	.org $B97C		; insert at 0x2398C
	.db $00, $10
;    Defense - NFC
	.org $B980		; insert at 0x23990
	.db $10, $20
	
; default KR/PR data ("Starters" from OF Starters screen)
	.org $B9C3		; insert at 0x239D3
	.include "\data\def_KR_PR.asm"

; "NFL Standings" dimensions and [YX] cursor values
	.org $BAC9		; insert at 0x23AD9
	.db $03, $04

	.db $A0, $40, $A0, $68, $A0, $98, $A0, $C8
	.db $B0, $40, $B0, $68, $B0, $98, $B0, $C8
	.db $C0, $48  ; rest of line defaults to $C0 + $48 (Playoffs)

; "Team Data" dimensions and [YX] cursor values
	.org $BB3B		; insert at 0x23B4B
	.db $0A, $04

	.db $20, $20, $FF, $FF, $FF, $FF, $FF, $FF
	.db $30, $20, $FF, $FF, $FF, $FF, $FF, $FF

	.db $48, $18, $48, $58, $48, $98, $48, $D8
	.db $58, $18, $58, $58, $58, $98, $58, $D8
	.db $68, $18, $68, $58, $68, $98, $68, $D8
	.db $78, $18, $78, $58, $78, $98, $78, $D8

	.db $98, $18, $98, $58, $98, $98, $98, $D8
	.db $A9, $18, $A8, $58, $A8, $98, $A8, $D8
	.db $B8, $18, $B8, $58, $B8, $98, $B8, $D8
	; last line stored elsewhere

; mini helmet data (teams 0-27)
	.org $BBB6		; insert at 0x23BC6
	.include "\data\mini_helmet.asm"

; mini helmet logo designs
	.org $BC42		; insert at 0x23C52
	.hex 0004141C202C383C4450606874788400
	
	.hex C7010000B9030000A1030808A2030008
	.hex 8B030801D002FC00D1020400C2020100
	.hex CB210000C9210808CA210001ED00FC00
	.hex FB000401ED00FC00FA020101C403FC00
	.hex FF030401D8020001D8020001D8020000
	.hex 8F200000892008088A2000088B200800
	.hex AE010000AF010800C8220000C9220808
	.hex CA220000C5020100FD010808FE010008
	.hex 83010800C60100

; mini helmet coordinates
;	"Preseason" and "Team Control"
	.org $BCD9		; insert at 0x23CE9
	.db $30, $04
	.db $40, $04
	.db $50, $04
	.db $60, $04
	.db $30, $24
	.db $40, $24
	.db $50, $24
	.db $60, $24
	.db $30, $44
	.db $40, $44
	.db $50, $44
	.db $60, $44
	.db $30, $64
	.db $40, $64
	.db $50, $64
	.db $60, $64
	.db $90, $04
	.db $A0, $04
	.db $B0, $04
	.db $C0, $04
	.db $90, $24
	.db $A0, $24
	.db $B0, $24
	.db $C0, $24
	.db $90, $44
	.db $A0, $44
	.db $B0, $44
	.db $C0, $44

;	"Team Data"
	.org $BD11		; insert at 0x23D21
	.db $40, $04
	.db $50, $04
	.db $60, $04
	.db $70, $04
	.db $40, $24
	.db $50, $24
	.db $60, $24
	.db $70, $24
	.db $40, $44
	.db $50, $44
	.db $60, $44
	.db $70, $44
	.db $40, $64
	.db $50, $64
	.db $60, $64
	.db $70, $64
	.db $90, $04
	.db $A0, $04
	.db $B0, $04
	.db $C0, $04
	.db $90, $24
	.db $A0, $24
	.db $B0, $24
	.db $C0, $24
	.db $90, $44
	.db $A0, $44
	.db $B0, $44
	.db $C0, $44

	.org $BD69		; insert at 0x23D79
	.include "\data\lh_palettes.asm"
	
	; helmet types
	.hex 40404041
	.hex 43404141
	.hex 40414141
	.hex 40414141
	
	.hex 40414140
	.hex 41404041
	.hex 40404140

; "Preseason" and "Team Control" dimensions and [YX] cursor values
	.org $BE83		; insert at 0x23E93
	.db $08, $04

	.db $38, $10, $38, $50, $38, $90, $38, $D0
	.db $48, $10, $48, $50, $48, $90, $48, $D0
	.db $58, $10, $58, $50, $58, $90, $58, $D0
	.db $68, $10, $68, $50, $68, $90, $68, $D0

	.db $98, $10, $98, $50, $98, $90, $98, $D0
	.db $A8, $10, $A8, $50, $A8, $90, $A8, $D0
	.db $B8, $10, $B8, $50, $B8, $90, $B8, $D0
	.db $C8, $10, $C8, $50
	; last 2 stored elsewhere

; this division setup variables (NFL Standings)
	.org $BF5D		; insert at 0x23F6D
	.db $00, $04
	.db $04, $04
	.db $08, $04
	.db $0C, $04
	.db $10, $04
	.db $14, $04

; this is part 2 of the swaping routine hack (dirty, i know)
	.org $BFD5
_swap_player_part2:	CMP #$1D		; 01 02
	beq _swap_pb_plyr		; 03 04
_swap_reg_player:	jmp swap_player_return_regTeam	; 05 0607
_swap_pb_plyr:	jmp swap_player_return_probowl	; 08 0910

; [LHelmetPalette] for the expansion teams
	.org $BFE0		; insert at 0x23FF0
SF_lh_pal:	.hex 0F180505150F3005
STL_lh_pal:	.hex 180C0C0F0C012801
SEA_lh_pal:	.hex 101C1C0F0C0C301A
ARZ_lh_pal:	.hex 303010001006280F

;----------------------------------------------------------------------------------------------

	.prgbank 9		; insert at 0x24010 - 0x2800F
	.low



; this code checks if a tackle was on a 2pt conversion (past LOS, P1)
;$81E3:A9 F0     LDA #$F0		; remove a sprite???
;$81E5:8D 0C 02  STA $020C = #$F0
;$81E8:20 CC 90  JSR $90CC
	.org $81EB		; insert at 0x241FB
	jsr Sub_PastLOS_P1
;$81EB:20 29 8F  JSR $8F29
;$81EE:B0 0F     BCS $81FF		;   branch if (turnover on downs)
;$81F0:20 01 93  JSR $9301		; player still has possession
;$81F3:20 D9 9A  JSR $9AD9
;$81F6:20 05 90  JSR $9005
;$81F9:20 63 9E  JSR $9E63
;$81FC:4C 23 81  JMP $8123
;$81FF:20 14 93  JSR $9314		; turnover on downs
;$8202:20 63 9E  JSR $9E63
;$8205:4C 7B 87  JMP $877B

; incomplete pass (P1, incomplete/deflection)
;
;$829E:A9 F0     LDA #$F0
;$82A0:8D 0C 02  STA $020C = #$F0
;$82A3:A9 00     LDA #$00
;$82A5:85 69     STA $0069 = #$00
;$82A7:A9 9B     LDA #$9B
;$82A9:20 32 93  JSR $9332
;$82AC:A9 3C     LDA #$3C
;$82AE:20 9A CC  JSR $CC9A
;$82B1:20 23 93  JSR $9323
;$82B4:A5 7F     LDA $007F = #$F6
;$82B6:85 93     STA $0093 = #$F6
;$82B8:A5 80     LDA $0080 = #$08
;$82BA:85 94     STA $0094 = #$08
	.org $82BC
	jsr Sub_CheckTOD_P1_incomp
;$82BC:20 BC 8F  JSR $8FBC	; increase Down
;$82BF:90 03     BCC $82C4	;   determine possession
;$82C1:4C 7B 87  JMP $877B	; side change (TOD)
;$82C4:20 01 93  JSR $9301	; player retains possession
;$82C7:20 D9 9A  JSR $9AD9
;$82CA:20 05 90  JSR $9005
;$82CD:4C 23 81  JMP $8123

; this code checks if tackle was on a 2pt conversion (qb sack, P1)
;
;$82F4:A9 F0     LDA #$F0		; remove a sprite???
;$82F6:8D 0C 02  STA $020C = #$F0
;$82F9:A5 93     LDA $0093 = #$44
;$82FB:C9 71     CMP #$71
;$82FD:A5 94     LDA $0094 = #$09
;$82FF:E9 06     SBC #$06
;$8301:90 2B     BCC $832E
	.org $8303
	jsr Sub_CheckTOD_sack_P1
;$8303:20 BC 8F  JSR $8FBC		; determine TOD
;$8306:B0 14     BCS $831C
;$8308:20 14 93  JSR $9314		; player still has possession (QB sack)
;$830B:A9 26     LDA #$26
;$830D:20 C5 A1  JSR $A1C5
;$8310:20 D9 9A  JSR $9AD9
;$8313:20 05 90  JSR $9005
;$8316:20 63 9E  JSR $9E63
;$8319:4C 23 81  JMP $8123
;$831C:A9 00     LDA #$00		; turnover on downs
;$831E:85 69     STA $0069 = #$80
;$8320:20 14 93  JSR $9314
;$8323:A9 27     LDA #$27
;$8325:20 C5 A1  JSR $A1C5
;$8328:20 63 9E  JSR $9E63
;$832B:4C 7B 87  JMP $877B


; this code displays "FIELD GOAL" slidebar. not it
; chooses between that and "TRY FOR POINT".
	.org $847E		; insert at 0x2448E
;$847E:A9 92	LDA #$92
;$8480:20 32 93	JSR $9332
	nop
	nop
	jsr Sub_GetCutScene_XPT



; this is the code that adds 3pts for a FG (P1)
	.org $84C3		; insert at 0x244D3
;$84C3:A9 03	LDA #$03
;$84C5:20 42 93	JSR $9342
	jsr Sub_getKickPts
	nop
	nop


; this is the code that adds 6pts for a TD (P1)
	.org $8615		; insert at 0x24625
;$8615:A9 06	LDA #$06	; add 6
;$8617:20 42 93	JSR $9342	;
;$861A:A9 98	LDA #$98	; play touchdown scene
;$861C:20 32 93	JSR $9332	;
	jsr Sub_getEzPts
	nop
	nop
	jsr Sub_GetCutSceneValue
	nop
	nop

; this jumps to the PAT code (P1)
	.org $863E		; insert at 0x24651
;$863E:20 C5 A1	JSR $A1C5
;$8641:4C 89 86	JMP $8689
	jsr Sub_CheckTD_isA_TD
	jmp Sub_2PtConv_P1





; this jumps to the PAT code (P1) (defense?)
	.org $865E		; insert at 0x2466E
	jmp Sub_2PtConv_P1





;$870D:A9 F0     LDA #$F0	; P2 intercepted P1 (touchback)
;$870F:8D 0C 02  STA $020C = #$F0
;$8712:A9 03     LDA #$03
;$8714:20 9A CC  JSR $CC9A
;$8717:A5 93     LDA $0093 = #$71
;$8719:85 7F     STA $007F = #$71
;$871B:A5 94     LDA $0094 = #$09
;$871D:85 80     STA $0080 = #$09
;$871F:A0 18     LDY #$18
;$8721:A2 AE     LDX #$AE
;$8723:20 64 97  JSR $9764
;$8726:A0 18     LDY #$18
;$8728:A2 B6     LDX #$B6
;$872A:20 A4 97  JSR $97A4
;$872D:20 B1 A1  JSR $A1B1
;$8730:A9 1D     LDA #$1D
;$8732:20 32 93  JSR $9332
;$8735:A9 01     LDA #$01
;$8737:20 DC 95  JSR $95DC
;$873A:8D F3 07  STA $07F3 = #$00
	.org $873D
	jsr Sub_CheckTOD_P2_intP1
;$873D:20 70 90  JSR $9070	;<--CODE HERE (P2)
;$8740:B0 39     BCS $877B















; this code checks if a tackle was on a 2pt conversion (past LOS, P2)
;
;$896B:A9 F0     LDA #$F0
;$896D:8D 0C 02  STA $020C = #$F0
;$8970:20 DC 90  JSR $90DC
	.org $8973
	jsr Sub_PastLOS_P2
;$8973:20 74 8F  JSR $8F74
;$8976:B0 0F     BCS $8987	;   branch if (turnover on downs)
;$8978:20 01 93  JSR $9301	; player still has possession
;$897B:20 D9 9A  JSR $9AD9
;$897E:20 05 90  JSR $9005
;$8981:20 7B 9E  JSR $9E7B
;$8984:4C AB 88  JMP $88AB
;$8987:20 14 93  JSR $9314	; turnover on downs
;$898A:20 7B 9E  JSR $9E7B
;$898D:4C 03 8F  JMP $8F03

; incomplete pass (P2, incomplete/deflection)
;
;$8A26:A9 F0     LDA #$F0
;$8A28:8D 0C 02  STA $020C = #$F0
;$8A2B:A9 00     LDA #$00
;$8A2D:85 69     STA $0069 = #$00
;$8A2F:A9 1B     LDA #$1B
;$8A31:20 32 93  JSR $9332
;$8A34:A9 3C     LDA #$3C
;$8A36:20 9A CC  JSR $CC9A
;$8A39:20 23 93  JSR $9323
;$8A3C:A5 7F     LDA $007F = #$8C
;$8A3E:85 93     STA $0093 = #$8C
;$8A40:A5 80     LDA $0080 = #$08
;$8A42:85 94     STA $0094 = #$08
	.org $8A44
	jsr Sub_CheckTOD_P2_incomp
;$8A44:20 BC 8F  JSR $8FBC	; increase Down
;$8A47:90 03     BCC $8A4C	;   determine possession
;$8A49:4C 03 8F  JMP $8F03	; side change (TOD)
;$8A4C:20 01 93  JSR $9301	; player retains possession
;$8A4F:20 D9 9A  JSR $9AD9
;$8A52:20 05 90  JSR $9005
;$8A55:4C AB 88  JMP $88AB


; this code checks if a tackle was on a 2pt conversion (qb sack, P2)
;	
;8A7C:A9 F0      LDA #$F0
;$8A7E:8D 0C 02  STA $020C = #$F0
;$8A81:A5 93     LDA $0093 = #$3A
;$8A83:C9 90     CMP #$90
;$8A85:A5 94     LDA $0094 = #$08
;$8A87:E9 09     SBC #$09
;$8A89:B0 2B     BCS $8AB6
	.org $8A8B
	jsr Sub_CheckTOD_sack_P2
;$8A8B:20 BC 8F  JSR $8FBC
;$8A8E:B0 14     BCS $8AA4		;   branch if (turnover on downs)
;$8A90:20 14 93  JSR $9314		; player still has possession
;$8A93:A9 26     LDA #$26
;$8A95:20 C5 A1  JSR $A1C5
;$8A98:20 D9 9A  JSR $9AD9
;$8A9B:20 05 90  JSR $9005
;$8A9E:20 7B 9E  JSR $9E7B
;$8AA1:4C AB 88  JMP $88AB
;$8AA4:A9 00     LDA #$00		; turnover on downs
;$8AA6:85 69     STA $0069 = #$80
;$8AA8:20 14 93  JSR $9314
;$8AAB:A9 27     LDA #$27
;$8AAD:20 C5 A1  JSR $A1C5
;$8AB0:20 7B 9E  JSR $9E7B
;$8AB3:4C 03 8F  JMP $8F03

; this is the code that adds 3pts for a FG (P1)
	.org $8C4B
;$8C4B:A9 03     LDA #$03
;$8C4D:20 63 93  JSR $9363
	jsr Sub_getKickPts_P2
	nop
	nop

; this is the code that adds 6pts for a TD (P2)
	.org $8D9D
;$8D9D:A9 06	LDA #$06	; add 6
;$8D9F:20 63 93	JSR $9363	;
;$8DA2:A9 18	LDA #$18	; play touchdown scene
;$8DA4:20 32 93	JSR $9332	;
	jsr Sub_getEzPts_P2
	nop
	nop
	jsr Sub_GetCutSceneValue
	nop
	nop

; this jumps to the PAT code (P2)
	.org $8DC6
;$8DC6:20 C5 A1	JSR $A1C5
;$8DC9:4C 11 8E	JMP $8E11
	jsr Sub_CheckTD_isA_TD
	jmp Sub_2PtConv_P2


; this jumps to the PAT code (P2) (defense?)
	.org $8DE6		; insert at 0x24DF6
	jmp Sub_2PtConv_P2



;$8E95:A9 F0     LDA #$F0	; P1 intercepted P2 (touchback)
;$8E97:8D 0C 02  STA $020C = #$F0
;$8E9A:A9 03     LDA #$03
;$8E9C:20 9A CC  JSR $CC9A
;$8E9F:A5 93     LDA $0093 = #$63
;$8EA1:85 7F     STA $007F = #$8E
;$8EA3:A5 94     LDA $0094 = #$06
;$8EA5:85 80     STA $0080 = #$06
;$8EA7:A0 18     LDY #$18
;$8EA9:A2 AE     LDX #$AE
;$8EAB:20 A4 97  JSR $97A4
;$8EAE:A0 18     LDY #$18
;$8EB0:A2 B6     LDX #$B6
;$8EB2:20 64 97  JSR $9764
;$8EB5:20 B1 A1  JSR $A1B1
;$8EB8:A9 9D     LDA #$9D
;$8EBA:20 32 93  JSR $9332
;$8EBD:A9 00     LDA #$00
;$8EBF:20 DC 95  JSR $95DC
;$8EC2:8D F3 07  STA $07F3 = #$00
	.org $8EC5
	jsr Sub_CheckTOD_P1_intP2
;$8EC5:20 57 90  JSR $9057	;<--CODE HERE (P1)
;$8EC8:B0 39     BCS $8F03



	.org $8FCC 		; insert at 0x24FDC
; change the amount of yards needed for a first
;[$8FCA:A5 3B	LDA $003B = #$5F] this line is duplicated in "Func_cpx_yardsFirst"
; -----
;[$8FCC:A6 44	LDX $0044 = #$13] this line is duplicated in "Func_cpx_yardsFirst"
; $8FCE:E0 50	CPX #$50
; $8FD0:90 1E	BCC $8FF0
; $8FD2:E0 58	CPX #$58
; $8FD4:B0 0C	BCS $8FE2
	jsr Func_cpx_yardsFirst_n
	BCC $8FF0
	jsr Func_cpx_yardsFirst_l
	BCS $8FE2

	.org $8FF0
; $8FF0:E0 48	CPX #$48
; $8FF2:90 0F	BCC $9003
	jsr Func_checkShort_yardsFirst
	nop



; this code plays the "OUT OF BOUNDS" slidebar for fumbles (other?)
; now it chooses between the original string or
; "NO GOOD!" for a fumbled 2PT conversion.
	.org $91D7		; insert at 0x251E7
;$91D7:A9 27	LDA #$27
;$91D9:20 90 92	JSR $9290
	nop
	nop
	jsr Sub_GetCutScene_Fumble









	
; this code saves stats after a game that
; involves a MAN p1
	.org $9DA0		; insert at 0x25DB0
	LDA $6C
	jmp Sub_P1savecode_part1
	nop
;$9DA2:C9 1C	[CMP #$1C]	; replaced: JMP $xxxx
;$9DA4:B0 06	[BCS $9DAC]	;   and NOP
;$9DA6:AD 11 66	LDA $6611 = #$00
;$9DA9:4C 7F C5	JMP $C57F
;$9DAC:A9 00	LDA #$00
;$9DAE:4C CB 9D	JMP $9DCB
;$9DB1:A9 00	LDA #$00
;$9DB3:85 6F	STA $006F = #$00
	.org $9DB5
	LDA $6C
	jmp Sub_P1savecode_part2
	nop
;$9DB7:C9 1C	[CMP #$1C]	; replaced: JMP $xxxx
;$9DB9:B0 0C	[BCS $9DC7]	;   and NOP
;$9DBB:A5 88	LDA $0088 = #$01
;$9DBD:29 1F	AND #$1F
;$9DBF:0A	ASL
;$9DC0:A8	TAY
;$9DC1:B9 11 66	LDA $6611,Y @ $6631 = #$16
;$9DC4:4C 7F C5	JMP $C57F
;$9DC7:A5 88	LDA $0088 = #$01

; this code saves stats after a game that
; involves a MAN P1 (K and P)
	.org $9DD0
	LDA $6C
	jmp Sub_P1_K_P_savecode
	nop
;$9DD2:C9 1D	[CMP #$1D]
;$9DD4:B0 07	[BCS $9DDD]
;$9DD6:B9 C0 66	LDA $66C0,Y @ $66C0 = #$00
;$9DD9:4A	LSR
;$9DDA:4C 7F C5	JMP $C57F
;$9DDD:B9 C8 66	LDA $66C8,Y @ $66C8 = #$00

; this code saves stats after a game that
; involves a MAN P2
	.org $9DE9		; insert at 0x25DF9
	LDA $6D
	jmp Sub_P2savecode_part1
	nop
;$9DEB:C9 1C	[CMP #$1C]	; replaced: JMP $xxxx
;$9DED:B0 06	[BCS $9DF5]	;   and NOP
;$9DEF:AD 45 66	LDA $6645 = #$00
;$9DF2:4C 7F C5	JMP $C57F
;$9DF5:A9 00	LDA #$00
;$9DF7:4C 14 9E	JMP $9E14
;$9DFA:A9 01	LDA #$01
;$9DFC:85 6F	STA $006F = #$00
	.org $9DFE
	LDA $6D
	jmp Sub_P2savecode_part2
	nop
;$9E00:C9 1C	[CMP #$1C]	; replaced: JMP $xxxx
;$9E02:B0 0C	[BCS $9E10]	;   and NOP
;$9E04:A5 89	LDA $0089 = #$0B
;$9E06:29 1F	AND #$1F
;$9E08:0A	ASL
;$9E09:A8	TAY
;$9E0A:B9 45 66	LDA $6645,Y @ $6665 = #$16
;$9E0D:4C 7F C5	JMP $C57F
;$9E10:A5 89	LDA $0089 = #$0B

; this code saves stats after a game that
; involves a MAN P2 (K and P)
	.org $9E19
	LDA $6D
	jmp Sub_P2_K_P_savecode
	nop
;$9E1B:C9 1D	[CMP #$1D]
;$9E1D:B0 07	[BCS $9E26]
;$9E1F:B9 C0 66	LDA $66C0,Y @ $66C0 = #$00
;$9E22:4A	LSR
;$9E23:4C 7F C5	JMP $C57F
;$9E26:B9 C8 66	LDA $66C8,Y @ $66C8 = #$00

; update the reference
	.org $9EEC		; insert at 0x25EFC
	CMP SRAMAutoSkipWeekNumber	; SRAM CODE

	.org $9F97		; insert at 0x25FA7
; ------------------------------
Sub_P1savecode_part1:	cmp teamindexLOW
	bcs _savCodeP1_isReg_team1
	cmp probowlINDEX
	bcs _savCodeP1_isPrB_team1
_savCodeP1_isReg_team1:	jmp $9DA6
_savCodeP1_isPrB_team1:	jmp $9DAC
; ------------------------------
Sub_P1savecode_part2:	cmp teamindexLOW
	bcs _savCodeP1_isReg_team2
	cmp probowlINDEX
	bcs _savCodeP1_isPrB_team2
_savCodeP1_isReg_team2:	jmp $9DBB
_savCodeP1_isPrB_team2:	jmp $9DC7
; ------------------------------
Sub_P2savecode_part1:	cmp teamindexLOW
	bcs _savCodeP2_isReg_team1
	cmp probowlINDEX
	bcs _savCodeP2_isPrB_team1
_savCodeP2_isReg_team1:	jmp $9DEF
_savCodeP2_isPrB_team1:	jmp $9DF5
; ------------------------------
Sub_P2savecode_part2:	cmp teamindexLOW
	bcs _savCodeP2_isReg_team2
	cmp probowlINDEX
	bcs _savCodeP2_isPrB_team2
_savCodeP2_isReg_team2:	jmp $9E04
_savCodeP2_isPrB_team2:	jmp $9E10
; ------------------------------
Sub_P1_K_P_savecode:	cmp teamindexLOW
	bcs _saveP1_KP_reg
	cmp probowlINDEX
	bcs _saveP1_KP_PrB
_saveP1_KP_reg:	jmp $9DD6
_saveP1_KP_PrB:	jmp $9DDD
; ------------------------------
Sub_P2_K_P_savecode:	cmp teamindexLOW
	bcs _saveP2_KP_reg
	cmp probowlINDEX
	bcs _saveP2_KP_PrB
_saveP2_KP_reg:	jmp $9E1F
_saveP2_KP_PrB:	jmp $9E26
; ------------------------------

	.high

; this code plays the animation sequences for FGs
; (hacked to work for XPTs)
	.org $A0B6		; insert at 0x260C6
; A=scene type [$11=FG Good!  $23=XPT Good!]
;$A0B6:A2 06	LDX #$06
;$A0B8:20 A2 C3	JSR $C3A2
	LDX #$06
	jsr Sub_CheckFG_isA_FG

; update the reference
; (this swaps into $Axxx, not $8xxx like the rest of the 8K)
	.org $A40F		; insert at 0x2641F
	CMP SRAMAutoSkipWeekNumber	; SRAM CODE


	.org $A45F		; insert at 0x2646F
; update the chain markers for a first down (P1)
;$A45F:18        CLC
;$A460:69 50     ADC #$50	; safe to trash Y at this point
	jsr Func_adc_yardsForFirst

	.org $A489		; insert at 0x26499
; update the chain markers for a first down (P2)
;$A489:38        SEC
;$A48A:E9 50     SBC #$50	; safe to trash Y at this point
	jsr Func_sbc_yardsForFirst





; this code normally jumps to playbook chooser menu ($8812)
;  instead...determine if jump to: Kickoff or Playchooser
	.org $8800		; insert at 0x26810
	JMP Sub_2pt_CheckReturnNorm

; make the string table larger for the play select screen (used for city name)
	.org $8845		; insert at 0x26855
	ADC #$44

	.org $8851		; insert at 0x26861
	ADC #$44

; init cursor coordinates for offense menu (P1)
	.org $897D		; insert at 0x2698D
	LDY <offense_menu_coor_p1
	LDX >offense_menu_coor_p1
	LDA #$00
	JSR $D68A

; P1 chose an option from the drop-down offense menu
	.org $899E
	jsr off_menu_p1
	LDA $89AC, X
	PHA
	LDA $89AB, X
	PHA
	RTS

; init cursor coordinates for offense menu (P2)
	.org $8C23
	LDY <offense_menu_coor_p2
	LDX >offense_menu_coor_p2
	LDA #$01
	JSR $D68A

; P2 chose an option from the drop-down offense menu
	.org $8C4D
	jsr off_menu_p2
	LDA $8C5B, X
	PHA
	LDA $8C5A, X
	PHA
	RTS


; these shift the temp screen buffer up in order
; to compact the working ram that is in sram
;     player 1 - offense: menu write
; 		this sets the parameters for copying a portion of a
; 		nametable to sram in order to write it back to vram
; 		at a later time. (P1 offense)
	.org $8F14
	LDA #$A3		; set vram source
	STA $3E
	LDA #$20
	STA $3F
	LDA #$03		; set sram dest
	STA $40
	LDA #$60
	STA $41
	LDX #$0E		; width
	LDY #$0E		; height
	JSR $D2F1		; copy(src, dest, w, h)

;     player 1 - defense: menu write (screen data under main defense menu)
;	.org $8F5A
;$8F5A:A9 03     LDA #$03
;$8F5C:85 40     STA $40
;$8F5E:A9 60     LDA #$60
;$8F60:85 41     STA $41

;     player 1 - defense: menu read (screen data under main defense menu)
;	.org $8F8A
;$8F8A:A9 03     LDA #$03
;$8F8C:85 3E     STA $3E
;$8F8E:A9 60     LDA #$60
;$8F90:85 3F     STA $3F

;     player 1 - offense: time out write
	.org $8FB4		; insert at 0x27FC4
	LDA #$C4
	STA $40
	LDA #$60
	STA $41

;     player 1 - defense: time out write (screen data under time out notice)
	.org $8FF3
	LDA #$C4
	STA $40
	LDA #$60
	STA $41

;     player 1 - offense: time out read
;                defense: time out read (screen data under time out notice)
	.org $9020		; insert at 0x27030
	LDA #$C4
	STA $3E
	LDA #$60
	STA $3F

;     player 2 - offense menu write
; 		this sets the parameters for copying a portion of a
; 		nametable to sram in order to write it back to vram
; 		at a later time. (P2 offense)
	.org $9066		; insert at 0x27076
	LDA #$B1
	STA $3E
	LDA #$20
	STA $3F
	LDA #$30
	STA $40
	LDA #$61
	STA $41
	LDX #$0E
	LDY #$0E
	JSR $D2F1


;     player 2 - defense menu write
	.org $90AC		; insert at 0x270BC
	LDA #$30
	STA $40
	LDA #$61
	STA $41

;     player 2 - defense menu read
	.org $90DC		; insert at 0x270EC
	LDA #$30
	STA $3E
	LDA #$61
	STA $3F

;     player 2 - offense: time out write
	.org $9106		; insert at 0x27116
	LDA #$C6
	STA $40
	LDA #$60
	STA $41

;     player 2 - defense: time out write (screen data under time out notice)
	.org $9145
	LDA #$C6
	STA $40
	LDA #$60
	STA $41

;     player 2 - offense: time out read
	.org $9172		; insert at 0x27182
	LDA #$C6
	STA $3E
	LDA #$60
	STA $3F

	.org $91C8
;$91C8:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$91CA:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

	.org $91E2		; insert at 0x271F2
;$91E2:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$91E4:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; this is the original routine to load a team's run/pass preference with redirection
	.org $9387		; insert at 0x27397
	LDX $6C		; P1
	jsr SubGetRunPassPref
	STA $A2

	.org $93A2		; insert at 0x273B2
	LDX $6D		; P2
	jsr SubGetRunPassPref
	STA $A2


	.org $9467		; insert at 0x27477
	LDX $6C		; P1 (sim)
	jsr SubGetRunPassPref
	STA $0620
	LDX $6D		; P2 (sim)
	jsr SubGetRunPassPref
	STA $0621


; Run/Pass Preference: (1 byte per team, range = 0-3 )
;           0 = Little more rushing, 1 = Heavy Rushing, 2 = little more passing, 3 = Heavy Passing
	.org $9516		; insert at 0x27526
	.db $01, $00, $02, $02		;     AFC-E
	.db $02, $00, $00, $00		;     AFC-N
	.db $02, $03, $00, $00		;     AFC-S
	.db $01, $01, $02, $01		;     AFC-W
	.db $00, $02, $03, $00		;     NFC-E
	.db $01, $02, $02, $01		;     NFC-N
	.db $00, $00, $00, $02		;     NFC-S
	.db $00, $00		;     probowl
	

; ----------------------------EMPTY SPACE---------------------------------------------
;
; this routine load the Run/Pass preference for the expansion team or it resumes as
; normal on a regular team
	.org $9FB6		; insert at 0x27FC6
SubGetRunPassPref:	cpx teamindexLOW
	bcs runpassEXP
runpassREG:	LDA $9516, X
	rts

runpassEXP:	cpx teamindexHIGH
	bcs runpassREG
	lda ExpTeamRunPassPref - 30, X
	rts

ExpTeamRunPassPref:	.db $00, $03, $00, $03		;     NFC-W

	.org $BFD0
; determines if TD cut scene should be
; played after the plane of endzone was crossed
Sub_CheckTD_isA_TD:	sta TempA		;
	jsr Func_IsIt2PtAttempt_1	; if(not 2pt conv)
	bcs _chkTDisTD_is2PT		;   branch to skip TD scene
_chkTDisTD_isTD:	lda TempA		; -show TOUCHDOWN (run or pass)
	JMP $A1C5		;   cut scene ($A1C5 has RTS)
_chkTDisTD_is2PT:	lda #$23		; -show SUCCESSFUL TRY
	JMP $A1C5		;   cut scene ($A1C5 has RTS)

; determines if FG cut scene should be
; played for FG or XPT made
Sub_CheckFG_isA_FG:	sta TempA		;
	cmp #$11		; if (scene != "FIELD GOAL")
	bne _chkFG_notFGGood		;   branch to exit
	jsr Func_IsIt2PtAttempt_1	; if (2PT != attempted)
	bcc _chkFG_notFGGood		;   branch to exit
	lda #00		; reset 2pt status
	sta twoPtAttempted		;
	lda #$23		; -show SUCCESSFUL TRY
	jmp $C3A2		;   cut scene ($C3A2 has RTS)
_chkFG_notFGGood:	lda TempA		; -show FIELD GOAL
	jmp $C3A2		;   cut scene ($C3A2 has RTS)

;----------------------------------------------------------------------------------------------

	.prgbank 10		; insert at 0x28010 - 0x2C00F

; ---------------------------
; 0x2be74: Rushing Power (RP) 	$BE64
	.org $8150
;   $8150:B9 64 BE	LDA $BE64,Y @ $BE6C = #$05
	jsr Func_lda_y_RPdata

; ---------------------------
; 0x2be84: Running Speed (RS) 	$BE74
	.org $815B
;   $815B:B9 74 BE	LDA $BE74,Y @ $BE7C = #$16
	jsr Func_lda_y_RSdata

; ---------------------------
; 0x2be74: Rushing Power (RP) 	$BE64
	.org $8180
;   $8180:BD 64 BE	LDA $BE64,X @ $BEEA = #$28
	jsr Func_lda_x_RPdata

; ---------------------------
; 0x2bf04: Fumbles (BC)		$BEF4
	.org $86CC		; 0x286DC
;   $86CC:D9 F4 BE	CMP $BEF4,Y @ $BEFB = #$0B
	jsr Func_cmp_y_BCdata
	BCS $86E8
	JMP $86DA

; ---------------------------
; 0x2bf14: Interceptions (PC)	$BF04
	.org $9E48
;   $9E48:B9 04 BF	LDA $BF04,Y @ $BF10 = #$55
	jsr Func_lda_y_PCdata

; ---------------------------
; 0x2bf24: Receptions (REC)	$BF14
	.org $9E6D
;   $9E6D:B9 14 BF	LDA $BF14,Y @ $BF20 = #$55
	jsr Func_lda_y_RECdata

; ---------------------------
; check if fumble happened on a 2pt conversion
	.org $B505
	jsr Sub_checkFumbleOn2PT
;$B505:85 72	STA $72		; saves status of fumble recovery
;$B507:60	RTS

; ---------------------------
; 0x2be74: Rushing Power (RP) 	$BE64
	.org $B9C2
;   $B9C2:B9 64 BE	LDA $BE64,Y @ $BE6E = #$03
	jsr Func_lda_y_RPdata

; ---------------------------
; 0x2be84: Running Speed (RS) 	$BE74
	.org $B9CD
;   $B9CD:B9 74 BE	LDA $BE74,Y @ $BE7E = #$18
	jsr Func_lda_y_RSdata





; this is the RP table
	.org $BE64
_rp_data:	.db $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $03, $02, $02, $01, $01
_rs_data:	.db $0E, $0F, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D

; this is the BC table
	.org $BEF4		; 0x2BF04
_bc_data:	.db $12, $11, $10, $0F, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03
_pc_data:	.db $3D, $3F, $41, $43, $45, $47, $49, $4B, $4D, $4F, $51, $53, $55, $57, $59, $5B
_rec_data:	.db $3D, $3F, $41, $43, $45, $47, $49, $4B, $4D, $4F, $51, $53, $55, $57, $59, $5B






	

	.org $BF38
Sub_checkFumbleOn2PT:	STA $72		; preserve value
	jsr Func_IsIt2PtAttempt		;
	bcc _chkFmb_convOFF		;
	lda #$40		; set fumble went out of bounds
	sta $72		;
	lda $69		; stop the clock
	and #$7F		;
	sta $69		;
_chkFmb_convOFF:	lda $72		; restore value of A
	RTS		;

; load BC data, adjust for weather
Func_cmp_y_BCdata:	pha		; save fumble value
	lda _bc_data, Y		; get base value
	sty TempY		;
	ldy weatherType		;
	clc		;
	adc _bc_weather_dif, Y		; add weather effect in
	sta TempA		;
	ldy TempY		;
	pla		; get fumble value
	cmp TempA		; cmp with new value
	rts		; exit
; load RP data, adjust for weather
Func_lda_y_RPdata:	lda _rp_data, Y		; get base value
	sty TempY		;
	ldy weatherType		;
	clc		;
	adc _rp_y_weather_dif, Y	; add weather effect in
	ldy TempY		;
	rts		; exit
Func_lda_x_RPdata:	lda _rp_data, X		; get base value
	stx TempX		;
	ldx weatherType		;
	clc		;
	adc _rp_x_weather_dif, X	; add weather effect in
	ldx TempX		;
	rts		; exit
; load RS data, adjust for weather
Func_lda_y_RSdata:	lda _rs_data, Y
	sty TempY
	ldy weatherType
	clc
	adc _rs_weather_dif, Y
	ldy TempY
	rts
; load PC data, adjust for weather
Func_lda_y_PCdata:	lda _pc_data, Y
	sty TempY
	ldy weatherType
	clc
	adc _pc_weather_dif, Y
	ldy TempY
	rts
; load REC data, adjust for weather
Func_lda_y_RECdata:	lda _rec_data, Y
	sty TempY
	ldy weatherType
	clc
	adc _rec_weather_dif, Y
	ldy TempY
	rts

	;   clr, snw, rn
_rp_y_weather_dif:	.db $00, $01, $00	; def
_rp_x_weather_dif:	.db $00, $02, $01	; off
_rs_weather_dif:	.db $00, $FE, $FF
_bc_weather_dif:	.db $00, $06, $02
_pc_weather_dif:	.db $00, $FC, $FE
_rec_weather_dif:	.db $00, $FC, $FE


;----------------------------------------------------------------------------------------------

	.prgbank 11		; insert at 0x2C010 - 0x3000F

	.low



; this fixes the palette for the middle of the field
	.org $809F		; 0x2C0AF
	LDY #$F0
	jsr SubGetFieldPalette
	.db $00, $00, $00
	.db $00
	.db $00, $00

; this fixes the palette for the xpt attempt (right endzone)
	.org $80B4
;$80B4:A9 1A	LDA #$1A
;$80B6:8D 1F 03	STA $031F = #$02
	nop
	nop
	jsr SubGetREndzonePalette


; this fixes the palette when the field scrolls (right endzone)
	.org $8143		; 0x2C153
	nop
	nop
	jsr SubGetREndzonePalette





 ; this eliminates the third jersey color (original: was KC, 32team: JAX)
	.org $823F		; insert at 0x2C24F
	CMP #$FF

; this routine loads the uniform palettes for the teams durring game play.
; redirection is used for the expansion teams
	.org $82A5		; insert at 0x2C2B5
	jmp SubCheckUniformPal
	.db $FF
checkUnifRetREG:	STA $031A,X
	STA $031E,X
	LDA #$36
	STA $031C,X
	LDA ($44),Y
	STA $031B,X
	STA $031F,X
	INY
	LDA ($44),Y
	STA $0320,X
	INY
	LDA ($44),Y
	STA $031D,X
	STA $0321,X
	RTS

; updated uniform palettes
	.org $82D4		; insert at 0x2C2E4 to x2C3FB
BillsUniformPal:	.db $05, $16, $0C, $05, $0F, $30, $00, $00, $00, $00
DolphinsUniformPal:	.db $30, $06, $1C, $30, $06, $3B, $50, $10, $6C, $20
PatriotsUniformPal:	.db $10, $16, $0C, $30, $16, $0C, $86, $22, $41, $80
JetsUniformPal:	.db $30, $16, $0A, $30, $16, $0A, $F5, $5C, $69, $A0
BengalsUniformPal:	.db $26, $06, $0F, $26, $06, $30, $D0, $D0, $04, $30
BrownsUniformPal:	.db $26, $06, $08, $26, $06, $30, $80, $20, $93, $00
RavensUniformPal:	.db $0F, $06, $14, $0F, $06, $30, $80, $20, $93, $00
SteelersUniformPal:	.db $0F, $16, $28, $0F, $16, $30, $00, $62, $92, $40
ColtsUniformPal:	.db $30, $06, $11, $30, $16, $11, $00, $00, $00, $00
TexansUniformPal:	.db $0C, $16, $30, $0C, $16, $05, $70, $04, $49, $A0
JaguarsUniformPal:	.db $0F, $16, $1C, $0F, $16, $30, $E0, $C1, $2C, $60
TitansUniformPal:	.db $30, $16, $0C, $30, $16, $0C, $50, $10, $6C, $20
BroncosUniformPal:	.db $0C, $06, $17, $0C, $06, $17, $21, $04, $00, $00
ChiefsUniformPal:	.db $15, $06, $30, $15, $06, $30, $00, $00, $00, $00
RaidersUniformPal:	.db $10, $16, $0F, $10, $16, $30, $10, $52, $22, $01
ChargersUniformPal:	.db $38, $06, $21, $38, $16, $21, $F7, $DD, $6D, $FF
RedskinsUniformPal:	.db $05, $0F, $28, $06, $0F, $30, $02, $00, $00, $00
GiantsUniformPal:	.db $02, $16, $10, $02, $06, $15, $84, $D0, $2C, $B0
EaglesUniformPal:	.db $09, $16, $10, $09, $16, $0F, $48, $80, $00, $20
CowboysUniformPal:	.db $10, $06, $02, $10, $16, $02, $08, $80, $20, $00
BearsUniformPal:	.db $0F, $06, $0F, $0F, $06, $30, $00, $00, $00, $00
LionsUniformPal:	.db $10, $06, $11, $10, $06, $11, $21, $04, $00, $00
PackersUniformPal:	.db $28, $06, $09, $28, $06, $30, $48, $80, $00, $20
VikingsUniformPal:	.db $04, $0F, $14, $04, $0F, $30, $00, $00, $00, $00
BuccaneersUniformPal:	.db $10, $0F, $06, $10, $0F, $06, $48, $80, $00, $20
SaintsUniformPal:	.db $18, $16, $0F, $18, $0F, $30, $50, $10, $6C, $20
FalconsUniformPal:	.db $0F, $06, $15, $0F, $16, $10, $00, $00, $00, $00
PanthersUniformPal:	.db $31, $16, $0F, $31, $06, $0F, $52, $22, $01, $00


; default palette
	.org $8409		; 0x2C419
weatherCLEARpalette:	.db $0F, $02, $16, $30, $0F, $02, $16, $30, $0F, CLEAR_PAL, $02, $30, $0F, $37, $16, $30







; this routine loads a new address for indrection
; if an expansion team is being used (uniform palette)
	.org $8F33		; insert at 0x2CF43
SubCheckUniformPal:	lda $45		; if the upper indirection
	cmp #$84		;     byte == #$84 then it's
	beq isPossExpTeam		;     a possible expansion team

isREGTeam:	LDX $43		; else
	LDA #$0F
	jmp checkUnifRetREG		;    resume as normal

isPossExpTeam:	ldx #00		; if the lower indirection
	lda $44		;     byte == <any if these>
	cmp #$00		;         8400 = EXP1
	beq isHOU
	cmp #$0A		;         840A = EXP2
	beq isJAX
	cmp #$14		;         8414 = EXP3
	beq isTEN
	cmp #$1E		;         841E = EXP4
	beq isCAR		;     then branch to expansion team routine

	jmp isREGTeam		; else branch to resume as normal

isCAR:	inx		; get team pointer index
isTEN:	inx
isJAX:	inx
isHOU:
	txa
	asl
	tax

	lda EXPUniformPalettePtrs, X	; update the indirection variables
	sta $44
	lda EXPUniformPalettePtrs + 1, X
	sta $45

	jmp isREGTeam		; and resume as normal

EXPUniformPalettePtrs:
	.dw SF49ersUniformPal, RamsUniformPal
	.dw SeahawksUniformPal, CardinalsUniformPal
SF49ersUniformPal:	.db $38, $06, $15, $38, $06, $15, $92, $20, $05, $40
RamsUniformPal:	.db $18, $0F, $02, $18, $0F, $30, $40, $49, $24, $00
SeahawksUniformPal:	.db $1C, $16, $0C, $1C, $16, $30, $92, $20, $05, $40	
CardinalsUniformPal:	.db $30, $06, $15, $30, $0F, $15, $80, $C0, $30, $10





; this routine sets the correct palette
; for when the camera is in the middle
; of the field (possibly left endzone too)
SubGetFieldPalette:	lda weatherBool
	beq useplainPAL
	
	stx TempX
	ldx weatherType
	lda _fieldPal_palValues, X
	pha
	ldx #00
_useWeatherPal:	LDA $8319,Y	
	cpx #09
	bne _getFieldPal_notFieldColor
	pla
_getFieldPal_notFieldColor:
	STA $022A,Y
	inx
	INY
	BNE _useWeatherPal
	ldx TempX
	rts

useplainPAL:	LDA $8319,Y
	STA $022A,Y
	INY
	BNE useplainPAL
	rts

_fieldPal_palValues:	.db CLEAR_PAL, SNOW_PAL, RAIN_PAL


; this routine sets the correct palette
; when the camera scrolls to the right enzone
SubGetREndzonePalette:	lda weatherBool
	beq useplainendzone
	lda weatherType
	beq useplainendzone
	cmp #WEATHER_RAIN
	beq userainendzone

usesnowendzone:	lda #SNOW_PAL
	.db $2C
userainendzone:	lda #RAIN_PAL
	.db $2C
useplainendzone:	lda #CLEAR_PAL
	sta $031F
	sta $0323
	rts




















; this updates the team name pointer for the sliding bar across the top
; of the screen (on touchdowns)
	.org $93B9		; insert at 0x2D3C9
	ADC #$44

; this updates the pointer to the down markers ("1st", "2nd", "3rd", "4th")
; durring game play
	.org $9408		; insert at 0x2D418
	ADC #$66

; this updates the team name pointer for the sliding bar across the top
; of the screen (on fumbles)
	.org $94C8		; insert at 0x2D4D8
	ADC #$44


	.high
; this is the original routine to get the text pointers
; for the team standings screen with redirection
	.org $804B		; insert at 0x2E05B
	LDA $C2
	ASL
	TAX
	jmp SubFixStartUpGlitch
subGetTxtPtrsRetREG:	STA $C2
	LDA $A001, X
subGetTxtPtrsRetEXP:	STA $C3

	.org $8483		; insert at 0x2E493
;$8483:18	CLC
;$8484:69 50	ADC #$50
	jsr Func_adc_yardsForFirst

	.org $84B2		; insert at 0x2E4C2
;$84B2:38	SEC
;$84B3:E9 50	SBC #$50
	jsr Func_sbc_yardsForFirst


; this routine determines the Conference for the Team Roster screen
	.org $87E3		; insert at 0x2E7F5
	LDA $6E
	tay
	lda TeamConferences, Y
	nop
	nop
getConferenceRET:	LDY $C6


; this is the original routine to load the division index
	.org $8801		; insert at 0x2E811
	LDX $6E
	jmp SubGetTeamDiv
getDivisionReturn:	LDY $C6


; new division data
; $70 = East
; $71 = North
; $7A = South <-hacked
; $72 = West
	.org $8812		; insert at 0x2E822
	.db $70, $70, $70, $70
	.db $71, $71, $71, $71
	.db $7A, $7A, $7A, $7A
	.db $72, $72, $72, $72
	.db $70, $70, $70, $70
	.db $71, $71, $71, $71
	.db $7A, $7A, $7A, $7A
	; the expansion team division data is stored elsewhere


; not really sure what this does, but the game crashes without it
	.org $8838		; insert at 0x2E848
	LDA $6E
	jmp SubChkForceDflt1
	.db $FF
;$8838:A5 6E     LDA $006E = #$01
;$883A:A2 14     LDX #$14
;$883C:86 45     STX $0045 = #$80	
forceDefualtRet1:	LDY $C6
	LDX $C7
	JSR $8DDE

; these two lines adjust the string table size for the division champion screen
	.org $886A		; insert at 0x2E87A
	adc #$22
	.org $8872		; insert at 0x2E882
	adc #$44

; make the string table larger for the coin toss screen
	.org $888B		; insert at 0x2E89B
	ADC #$22

	.org $8897		; insert at 0x2E8A7
	ADC #$22

	.org $88A7		; insert at 0x2E8B7
	ADC #$44

	.org $88B3		; insert at 0x2E8C3
	ADC #$44

; adjust the pointer for MAN, COA, COM, SKP on coin toss screen
	.org $88C3
	ADC #$76		; insert at 0x2E8D3

	.org $88D1
	ADC #$76		; insert at 0x2E8E1

; this adjust the string table for the playoff bracket screen
	.org $8AAF		; insert at 0x2EABF
	ADC #$44

; this adjust the string table for the "Team Rankings" screen (NFL, AFC, NFC)
	.org $8BA5		; insert at 0x2EBB5
	ADC #$73

; here so the game doesn't override expansion teams
	.org $8DE7		; insert at 0x2EDF7
	nop
	nop

; this changes the start of the teams names
; and city names to where they have been shifted
	.org $8DF8		; insert at 0x2EE08
	LDA CityPtrs + 2,Y
	SEC
	SBC CityPtrs,Y
	STA $41
	LDA NamePtrs + 2,Y
	SEC
	SBC NamePtrs,Y
	STA $40

	.org $8E32
	LDA CityPtrs,Y
	STA $65
	LDA CityPtrs + 1,Y
	STA $66

	.org $8E51		; insert at 0x2EE61
	LDA NamePtrs,Y
	STA $65
	LDA NamePtrs + 1,Y
	STA $66

; make the string table larger for the end of game stat screen
	.org $8EEF		; insert at 0x2EEFF
	ADC #$44

	.org $8EFB		; insert at 0x2EF0B
	ADC #$44

; this routine test for expansion teams when displaying the end of game stats
	.org $9108		; insert at 0x2F118
	jmp SubCheckExpTeamAtEndGame
	.db $FF
checkEndGameREG0:	STX $44
	LDX #$00
	CMP #$1D
	BCC #$02
	LDX #$3C
	STX $45
	LDA $92
	ASL
	CLC
	ADC $45
	TAX
	LDA $66D1,X
	STA $92
	LDA $66D0,X
	LDX $44
checkEndGameREG1:
checkEndGameEXP:
	RTS

; this is part of the original routine that loads the
; base address of the selected team's large helmet data
; with a jump inserted
	.org $9662		; insert at 0x2F672 in rom
	LDX $44
	JMP SubGetLHAddr
LHreturnREG:	ASL
	CLC
	ADC #$00
	STA $C9
	LDA #$A0
	ADC #$00
	STA $CA
	LDY #$00
	LDA ($C9), Y
	TAX
	INY
	LDA ($C9),Y
	STA $CA
	STX $C9
LHreturnEXP:	LDX $44

	.org $9EA0		; insert at 0x2FEB0
; this routine loads the division index for the expansion teams
SubGetTeamDiv:	cpx teamindexLOW
	bcs expDiv

regDiv:	LDA $8812,X
	jmp getDivisionReturn

expDiv:	cpx teamindexHIGH
	bcs regDiv

	txa
	sec
	sbc #$1E
	tax
	lda expTeamDivision,X
	jmp getDivisionReturn

expTeamDivision:	.db $72, $72, $72, $72

; this routine force the default team index to zero (Bills) if an expansion
; team is being used (again, not sure why this needs to be here)
SubChkForceDflt1:	asl
	sta $67
	cmp teamindexLOW		; if(A < #$1E)
	bcc dontForceDefault1		;     branch to resume as normal

	lda #$00		; else load default team sram
dontForceDefault1:
	LDX #$14
	STX $45
	jmp forceDefualtRet1

; [HelmetPointer] for expansion teams
HDATAPTR:	.hex A0A784A788A614A7

; [HelmetData] for expansion teams
; $80 = HOU, TEN, BAL
; $81 = JAX
; $82 = CAR

TexansHelmetData:	.db $F6, $80, $FF, $FF, $FF, $FC, $09, $F8, $36, $39
	.db >TexansHelmetDesign - 8192
	.db <TexansHelmetDesign
	.db $AB, $17

JaguarsHelmetData:	.db $F6, $81, $FF, $FF, $FF, $FC, $0F, $F8, $36, $3B
	.db >JaguarsHelmetDesign - 8192
	.db <JaguarsHelmetDesign
	.db $AB, $17

TitansHelmetData:	.db $F6, $80, $FF, $FF, $FF, $FC, $04, $F8, $35, $37
	.db >TitansHelmetDesign - 8192
	.db <TitansHelmetDesign
	.db $AB, $17

PanthersHelmetData:	.db $F6, $82, $FF, $FF, $FF, $FC, $15, $F8, $38, $3A
	.db >PanthersHelmetDesign - 8192
	.db <PanthersHelmetDesign
	.db $AB, $17

; conference indexes for teams
; note: the game originally used the teamIndex to
;       determine a team's conference. all this
;       data was added to handle the expansion teams
;       and SEA (they switched to NFC)
; note2: this data is no longer needed with the teams
;        being reordered
TeamConferences:	.db $1C, $1C, $1C, $1C
	.db $1C, $1C, $1C, $1C
	.db $1C, $1C, $1C, $1C
	.db $1C, $1C, $1C, $1C
	.db $1D, $1D, $1D, $1D
	.db $1D, $1D, $1D, $1D
	.db $1D, $1D, $1D, $1D
	.db $1C, $1D		; AFC/NFC
	.db $1D, $1D, $1D, $1D

;----------------------------------------------------------------------------------------------

	.prgbank 12		; insert at 0x30010 - 0x3400F

	.low

; this is the routine that loads the array indexes
; for loading data for the "NFL Leaders" screen
	.org $8017
	LDA $42
	STA $6F
	BEQ NFLleaders
	CMP #$01
	BEQ AFCleaders
NFCleaders:	lda #$10	; for NFC
	tax
	JMP $8032
AFCleaders:	lda #$00	; for AFC
	ldx #$10
	JMP $8032
NFLleaders:	lda #$00	; for NFL
	ldx #$20
	STA $6E
	STA $AA
	STX $9E
	STX $A9

	.org $8E45		; insert at 0x30E55
; Player 2 Conditions Fix (thanks to jstout)
; x30E55
; 20 80 9F   JSR CHECK_PLAYER
	jsr Sub_CheckPlayerCondition


; original routine to load the background color for the player stat screen with some redirection
	.org $8D99
	jmp SubGetRostBKGcolor
getRosColorRET:	STA $031A

; stat background colors
	.org $9130		; insert at 0x31140
	.hex 060C0609	; AFC-E
	.hex 0606010F	; AFC-N
	.hex 010C0B12	; AFC-S
	.hex 01060001	; AFC-W
	.hex 06010901	; NFC-E
	.hex 0F010904	; NFC-N
	.hex 060F0F00	; NFC-S

; these are the control loops for all of the "NFL Leaders"
; menu, with jumps to adjust the team index when needed

;     Passer sub-categories
;         -LST. INT %
	.org $9723		; insert at 0x31733
	pha
	lda #05
	jmp SubCheckLeadersIndex
passerSubCat_exit:	JSR $9C2D


;     Leading Punter, Kick Returner, && Punt Returner
	.org $97AA
	pha
	lda #00
	jmp SubCheckLeadersIndex
leadPKrPrExit:  	JSR $9C2D

;     Leading Receiver, Sacks, && Interceptions
	.org $97FF
	pha
	lda #01
	jmp SubCheckLeadersIndex
leadRecSacIntExit:	JSR $9C2D

;     Leading Rusher
	.org $9847
	pha
	lda #02
	jmp SubCheckLeadersIndex
leadRusherExit:	JSR $9C2D

;     Leading Passer
	.org $9868		; insert at 0x31878
	pha
	lda #03
	jmp SubCheckLeadersIndex
leadPasserExit:	JSR $9C2D

;    Leading Scorer
	.org $9A63
	pha
	lda #04
	jmp SubCheckLeadersIndex
leadScorerLoop:  	JMP $9989
leadScorerExit:	JSR $9C2D

; loads the color for player stat screen for the expansion teams
	.org $9E60
SubGetRostBKGcolor:	cpx teamindexLOW
	bcs bkgColorEXP

bkgColorREG:	LDA $9130,X
	jmp getRosColorRET

bkgColorEXP:	cpx teamindexHIGH
	bcs bkgColorREG

	txa
	sec
	sbc #$1E
	tax

	lda expansionBKGcolor,X
	jmp getRosColorRET

expansionBKGcolor:	.hex 06010106 ; NFC-W

; this routine adjust the "NFL Leaders" team index
; if needed, and either branches or exits the loop	NOTE: A has been preserved before the sub call
SubCheckLeadersIndex:	pha		; preserve the return index (A)
	txa		; preserve X
	stx $FE

	INC $6E		; original code
	DEC $9E

	lda $6E		; make sure that the index stays
	cmp #$1C		;
	bne dontadjustleadersindex	;     valid ($6E != #$1C) && ($6E != #$1D)
	lda #$1E		; not valid index so shift to first
	sta $6E		;     expansion slot

dontadjustleadersindex:
	pla		; get the return index
	asl
	tax
	pla		; preserve the orginal value for A
	sta $FD
	lda $9E		; check if routine needs to be looped
	bne loopNFLLeaders		;     or if it needs to be exited

exitNFLLeaders:	lda leadersExitAddrs + 1, X	; get exit address
	pha
	lda leadersExitAddrs , X
	jmp finishLeaderIndexAdjust

loopNFLLeaders:	lda leadersBranchAddrs + 1, X	; get loop address
	pha
	lda leadersBranchAddrs, X

finishLeaderIndexAdjust:
	pha
	
	lda #00
	sta pAPU_CTRL		; disable sound channels (fixes "bleep" sound)	
	
	lda $FD		; restore A and X
	ldx $FE
	rts

	; branch addressess
leadersBranchAddrs:	.dw $976B - 1, $97E9 - 1, $9811 - 1, $9851 - 1
	.dw leadScorerLoop - 1, $9700 - 1
		
	; exit addressess
leadersExitAddrs:	.dw leadPKrPrExit - 1, leadRecSacIntExit - 1, leadRusherExit - 1, leadPasserExit - 1
	.dw leadScorerExit - 1, passerSubCat_exit - 1

; Player 2 conditions fix (thanks to jstout)
; x31F90
; CHECK_PLAYER:
; A6 6E      LDX $6E ; Load Current Player
; E4 6D      CPX $6D ; Load Player 2
; F0 02      BEQ :+
; PLAYER 1
; 18         CLC
; 60         RTS
; PLAYER 2
; 38       : SEC
; 60         RTS
Sub_CheckPlayerCondition:
	ldx $6E
	cpx $6D
	beq _condFix_P2
_condFix_P1:	clc
	rts
_condFix_P2:	sec
	rts
	









	.high

; this code just replaces sram references with labels so that
; if anything moves around, the reference are still valid
	.org $8049		; insert at 0x32059
	CMP SRAMSeasonWeekNumber	; SRAM CODE

	.org $805D		; insert at 0x3206D
	LDA <SRAMSeasonCurWeekMatchUps	; SRAM CODE [addr low]
	STA $8E
	LDA >SRAMSeasonCurWeekMatchUps	; [addr high]
	STA $8F
	
	.org $8092		; insert at 0x320A2
	.dw sched_vramptrs

	.org $8095		; insert at 0x320A5
	.dw sched_vramptrs + 1
	
	.org $80B6		; insert at 0x320C6
	.db $10	; games per week

	.org $816B		; insert at 0x3217B
	LDA SRAMSeasonWeekNumber	; SRAM CODE

	.org $8178		; insert at 0x32188
	LDA SRAMSeasonWeekNumber	; SRAM CODE

	.org $817E		; insert at 0x3218E
	.db $20	; games per week * 2

	.org $8182		; insert at 0x32192
	LDA SRAMSeasonGameNumber	; SRAM CODE
	
	.org $818B		; insert at 0x3219B
	.dw sched_vramptrs

	.org $8190		; insert at 0x321A0
	.dw sched_vramptrs + 1

	.org $81B5		; insert at 0x321C5
	LDA SRAMSeasonGameNumber	; SRAM CODE
	ASL
	TAX
	LDA SRAMSeasonCurWeekMatchUps, X
	STA $45
	LDA SRAMSeasonCurWeekMatchUps + 1, X
	STA $44

; this code initializes sram that is for the season mode
	.org $824A		; insert at 0x32267
	LDA #$40		; zero out team data ($67A0 - $7FFF)
	LDX #$19
	LDY #$C0
	STY $44
	LDY #$66
	JSR $D60E
	jsr SubClearExpSlots		;     clear JAX and CAR
	LDA #$00		; init team data (conditions, etc.)
	STA $43
func_ext_retLoop:	LDA $43
	JSR $82A4
	LDA $43
	JSR $82F1
	jmp FuncExtendInitLoop
	;.db $FF		;     (used for JSR SubClearExpSlots)
	;.db $FF, $FF
	.db $FF, $FF
func_ext_retExit:	LDA #$FF		; init Div Champ/Wild Card array
	LDY #$F4
	STA SRAMDivLeadWldCardData - 244, Y
	INY
	BNE $8271
	LDA #$03		; init Team Control data
	LDY #$DE
	STA SRAMTeamCtrlSettings - 222, Y
	INY
	BNE $827B

; this gets the dest addr in sram for the current team
;     in order to init their stat block
	.org $82A4		; insert at 0x322B4
	jmp SubGetInitDestAddr
getInitAddr_retREG:	LDA $DF17, Y
	STA $3E
	LDA $DF18, Y
getInitAddr_retEXP:	STA $3F
	jsr SubGet_KR_PR_datareset	; $82B1:BD C3 88	LDA $88C3,X


	.org $82EB		; insert at 0x322FB
;$82EB::A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$82ED:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; this routine loads the defualt playbooks for the regular/pro-bowl teams, with some mods/redirection
	.org $82F6		; insert at 0x32306
	LDA $43		; load team index
	cmp #$1C
	beq loadDefPB_AFC
	cmp #$1D
	beq loadDefPB_NFC
	TAX
	ASL
	TAY
	jmp SubGetPBSRAMaddr		; get addr in sram
retPBSRAMaddrREG:	STA $3E
	LDA $DF18,Y
retPBSRAMaddrEXP:	STA $3F
	TXA		; transfer defaults to sram
	ASL
	ASL
	jmp SubGetDefPBaddr
retDefPBaddrREG:	LDA $B300,X
	STA ($3E),Y
	INY
	LDA $B301,X
	STA ($3E),Y
	INY
	LDA $B302,X
	STA ($3E),Y
	INY
	LDA $B303,X
	STA ($3E),Y
	JMP exitLoadDefPB
;------------------------------------------------
loadDefPB_AFC:	LDY #$F8
loopPB_AFC:	LDA $B278,Y
	STA $6650,Y
	INY
	BNE loopPB_AFC
	JMP exitLoadDefPB
;------------------------------------------------
loadDefPB_NFC:	LDY #$F8
loopPB_NFC:	LDA $B280,Y
	STA $6658,Y
	INY
	BNE loopPB_NFC
exitLoadDefPB:	LDX #$11
	JSR $D8E3
	RTS


	.org $835A
;$835A:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$835C:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;


	.org $836E		; insert at 0x3237E
;$836E:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$8370:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;


	.org $8397		; insert at 0x323A7
;$8397:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$8399:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;



	.org $83A8		; insert at 0x323B8
;$83A8:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$83AA:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;




; this updates the String table size for "D-starters" screen
	.org $840C		; insert at 0x3241C
	ADC #$44

; this routine is the control for loading "SKP", "MAN", "COA", and "COM"
; for the team control screen
	.org $851B		; insert at 0x3252B
	LDA #$00
	STA $45
	LDX $45
	jsr SubGetTeamCtrlStatus
	STA $44
	JSR $8596
	INC $45
	LDA $45
	CMP #$22		; upper limit is now $22
	BNE #$EE

; this code saves the changes to Team Control data to sram
	.org $857D		; insert at 0x3258D
	LDA SRAMTeamCtrlSettings, X	; SRAM CODE
	CLC
	ADC #$01
	AND #$03
	STA SRAMTeamCtrlSettings, X

; this routine loads the vram address for "SKP", "MAN", "COA", and "COM" for the
; team control screen (X is the team index)
	.org $8596		; insert at 0x325A6
	jmp SubGetVramAddrCtrlStatus
getvramaddrRetrunREG:	LDY $891F ,X
	LDA $8920 ,X
getvramaddrRetrunEXP:	TAX

; update string pointer for "Team Control" screen ("skp", "man", "com", "coa")
; (make string table larger)
	.org $85A5		; insert at 0x325B5
	ADC #$6A

; this is the old routine to load the index for the Team
; Control screen when changing MAN, COM, COA, and SKP
	.org $85AB		; insert at 0x325BB
	jsr SubGetSramTCIndex

; these are indexes for the Team Control screen		BOOKMARK
; used for changing MAN, COM, COA, and SKP in sram
	.org $85AF		; insert at 0x325BF
	.db $00, $04, $08, $0C
	.db $01, $05, $09, $0D
	.db $02, $06, $0A, $0E
	.db $03, $07, $0B, $0F
	; --------
	.db $10, $14, $18, $1E
	.db $11, $15, $19, $1F
	.db $12, $16, $1A, $20
	.db $13, $17		; CAR and ARZ stored elsewhere
	

; update the schedule dates
	.org $8743		; insert at 0x32753
	.db $06, "SEP", $2E, "9", $E3, $FF
	.db $06, "SEP", $2E, "16", $FF
	.db $06, "SEP", $2E, "23", $FF
	.db $06, "SEP", $2E, "30", $FF
	.db $06, "OCT", $2E, "7", $E3, $FF
	.db $06, "OCT", $2E, "14", $FF
	.db $06, "OCT", $2E, "21", $FF
	.db $06, "OCT", $2E, "28", $FF
	.db $06, "NOV", $2E, "4", $E3, $FF
	.db $06, "NOV", $2E, "11", $FF
	.db $06, "NOV", $2E, "18", $FF
	.db $06, "NOV", $2E, "25", $FF
	.db $06, "DEC", $2E, "2", $E3, $FF
	.db $06, "DEC", $2E, "9", $E3, $FF
	.db $06, "DEC", $2E, "16", $FF
	.db $06, "DEC", $2E, "23", $FF
	.db $06, "DEC", $2E, "30", $FF
	.db $06, "JAN", $2E, "6", $E3, $FF
	
	.org $8843		; insert at 0x32853
	.include "\data\probowl_roster.asm"
	
; default KR/PR data ("Data Reset" from schedule screen)
	.org $88C3		; insert at 0x328D3
	.include "\data\def_KR_PR.asm"

; "Team Control" dimensions and cursor [YX]
	.org $88E1		; insert at 0x328F1
	.db $08, $04
	.db $37, $20, $37, $60, $37, $A0, $37, $E0
	.db $47, $20, $47, $60, $47, $A0, $47, $E0
	.db $57, $20, $57, $60, $57, $A0, $57, $E0
	.db $67, $20, $67, $60, $67, $A0, $67, $E0
	.db $97, $20, $97, $60, $97, $A0, $97, $E0
	.db $A7, $20, $A7, $60, $A7, $A0, $A7, $E0
	.db $B7, $20, $B7, $60, $B7, $A0, $B7, $E0
	.db $C7, $20, $C7, $60  ; the other 2 points are stored elsewhere

; Address (in vram) of SKP,MAN,COM, COA text on "Team Control" screen
	.org $891F		; insert at 0x3292F
	.db $E5, $20, $25, $21, $65, $21, $A5, $21
	.db $ED, $20, $2D, $21, $6D, $21, $AD, $21
	.db $F5, $20, $35, $21, $75, $21, $B5, $21
	.db $FD, $20, $3D, $21, $7D, $21, $BD, $21

	.db $65, $22, $A5, $22, $E5, $22, $25, $23
	.db $6D, $22, $AD, $22, $ED, $22, $2D, $23
	.db $75, $22, $B5, $22, $F5, $22, $35, $23
	; Expansion team slot stored elsewhere

; updated schedule
	.org $8997		; insert at 0x329A7
SchedulePointers:	.dw week1PTR, week2PTR, week3PTR, week4PTR
	.dw week5PTR, week6PTR, week7PTR, week8PTR
	.dw week9PTR, week10PTR, week11PTR, week12PTR
	.dw week13PTR, week14PTR, week15PTR, week16PTR
	.dw week17PTR
NumGamesPerWeek:	.db $10, $10, $10, $0E
	.db $0E, $0D, $0E, $0D
	.db $0E, $0E, $10, $10
	.db $10, $10, $10, $10
	.db $10
	.db $FF	; this is a dummy byte

	.include "\data\sched.asm"

; this routine loads the expansion address (dest) of data in sram (if EXP), else just resumes
; as normal [only for Default Playbooks]
SubGetPBSRAMaddr:	cpy teamindexLOW * 2
	bcs getPBSRAMaddrEXP

getPBSRAMaddrREG:	LDA $DF17,Y
	jmp retPBSRAMaddrREG

getPBSRAMaddrEXP:	cpy teamindexHIGH * 2
	bcs getPBSRAMaddrREG

	tya
	sec
	sbc teamindexLOW * 2
	tay
	lda EXPsramaddr, Y
	sta $3E
	lda EXPsramaddr + 1, Y
	jmp retPBSRAMaddrEXP

; this routine loads the address of the default playbooks for the expansion teams
; and then writes them to the correct sram slot
SubGetDefPBaddr:	TAX
	LDY #$BD
	cpx teamindexLOW * 4
	bcs getDefPBaddrEXP

getDefPBaddrREG:	jmp retDefPBaddrREG

getDefPBaddrEXP:	cpx teamindexHIGH * 4
	bcs getDefPBaddrREG

	sec
	sbc teamindexLOW * 4
	tax

	lda SF49ers_DefPB, X
	STA ($3E),Y
	INY
	lda SF49ers_DefPB + 1, X
	STA ($3E),Y
	INY
	lda SF49ers_DefPB + 2, X
	STA ($3E),Y
	INY
	lda SF49ers_DefPB + 3, X
	STA ($3E),Y
	jmp exitLoadDefPB

; this routine adjust the X-index if needed
; for expansion slots. used on the "Team Control"
; screen when loading from sram
SubGetTeamCtrlStatus:	cpx #$1C		; if the old upper bound is hit
	bne dontadjustXindex		; start on 1st expansion ($1E)
	ldx #$1E		; skip AFC ($1C) and NFC ($1D)
	stx $45		; get the status (skp, man, coa, com)
dontadjustXindex:	LDA SRAMTeamCtrlSettings, X	; SRAM CODE
	rts

; this routine gets redirects where to pull the
; dest vram address if an expansion slot is being
; accessed, else just returns as normal
SubGetVramAddrCtrlStatus:
	cpx teamindexLOW
	bcs vramaddrEXP

vramaddrREG:	TXA
	ASL
	TAX
	jmp getvramaddrRetrunREG

vramaddrEXP:	cpx teamindexHIGH
	bcs vramaddrREG

	TXA
	ASL
	TAX

	LDY Slot0TCvramAddr - 60, X
	LDA Slot0TCvramAddr - 59, X

	jmp getvramaddrRetrunEXP
Slot0TCvramAddr:	.db $7D, $22	; SF
Slot1TCvramAddr:	.db $BD, $22	; STL
Slot2TCvramAddr:	.db $FD, $22	; SEA
Slot3TCvramAddr:	.db $3D, $23	; ARZ

; this routine lengthens the table of indexes
; for the "Team Control" screen. (see 0x325BF)
SubGetSramTCIndex:	cpx teamindexLOW
	bcs sramTCindexEXP

sramTCindexREG:	LDA $85AF,X
	rts

sramTCindexEXP:	cpx teamindexHIGH
	bcs sramTCindexREG

	lda expmenuTCindex - 30, X
	rts

expmenuTCindex:	.db $1B, $21

; this is just an extension of the init sram loop that fucks
;    with the loop index to get the expanded slots included
FuncExtendInitLoop:	INC $43
	LDA $43
	CMP teamindexHIGH
	BCC extloop_loopmore

extloop_exitloop:	jmp func_ext_retExit

extloop_loopmore:	cmp #$1C
	bne extloop_dontadjust
	lda teamindexLOW
	sta $43

extloop_dontadjust:	jmp func_ext_retLoop


; this routine gets the sram dest addr for the current team
;     so that there stat block can be initialized
SubGetInitDestAddr:	TAX
	ASL
	TAY
	cpy teamindexLOW * 2
	bcs getInitDestAddrEXP

getInitDestAddrREG:	jmp getInitAddr_retREG

getInitDestAddrEXP:	cpy teamindexHIGH * 2
	bcs getInitDestAddrREG

	lda EXPsramaddr - 60, Y
	sta $3E
	lda EXPsramaddr - 59, Y
	jmp getInitAddr_retEXP

; this clears the two expanded team data slots at $6250 - $63EF
; and clears some variables
SubClearExpSlots:	lda #$A0		; clear expanded stats area
	ldx #$01
	ldy #$50
	sty $44
	ldy #$62
	jsr $D60E
	ldx #00		; clear vars
	stx weatherBool
	stx preseasonWeather
	stx twoPtConv
	stx yardsForFirstLen
	stx cpuDifficulty
	inx	; X=1
	stx QtrLength
	rts

; this stub gets the default KR and PR when a data reset is called
SubGet_KR_PR_datareset:
	cpx teamindexLOW
	bcs _getKRPR_EXP
_getKRPR_REG:	LDA $88C3, X
	rts
_getKRPR_EXP:	cpx teamindexHIGH
	bcs _getKRPR_REG
	lda Exp_Slot_Def_KR_PR - 30, X
	rts

Exp_Slot_Def_KR_PR:	.hex 44998855

; new schedule screen layout
sched_vramptrs:	.hex A120C120E1200121	; top
	.hex A920C920E9200921
	.hex B120D120F1201121
	.hex B920D920F9201921
	.hex 61218121A121C121	; mid-top
	.hex 69218921A921C921
	.hex 71219121B121D121
	.hex 79219921B921D921
	.hex 2122412261228122	; mid-bot
	.hex 2922492269228922
	.hex 3122512271229122
	.hex 3922592279229922
	.hex E122012321234123	; bot
	.hex E922092329234923
	.hex F122112331235123
	.hex F922192339235923

;----------------------------------------------------------------------------------------------

	.prgbank 13		; insert at 0x34010 - 0x3800F

	.low

	.org $811B
; these load the "juice" values
	jsr Func_CheckDifficulty
;$811B:BD 00 BF	LDA $BF00,X @ $BF00 = #$00	***REPLACED***
;$811E:8D 78 66	STA $6678 = #$00
;$8121:BD 01 BF	LDA $BF01,X @ $BF01 = #$01
;$8124:8D 79 66	STA $6679 = #$00
;$8127:BD 02 BF	LDA $BF02,X @ $BF02 = #$00
;$812A:8D 7A 66	STA $667A = #$00
;$812D:BD 03 BF	LDA $BF03,X @ $BF03 = #$00
;$8130:8D 7B 66	STA $667B = #$00
;$8133:BD 04 BF	LDA $BF04,X @ $BF04 = #$00
;$8136:8D 7C 66	STA $667C = #$00
;$8139:4C 4D 81	JMP $814D


	.org $814D		; insert at 0x3415D
;$814D:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$814F:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; this is the original routine that loads the action
; sequence palette for the first player
	.org $81A6		; insert at 0x341B6
	LDA $6C
	LDX $6D
	JMP SubCheckActionSeqPalEXP

; this is the original routine that loads the action
; sequence palette for the second player
	.org $81BE		; insert at 0x341D2
	LDA $6D
	LDX $6C
	jmp SubCheckActionSeqPalEXP
actSeqPalRetREG:	CLC
	ADC #$C8
	STA $44
	LDA #$00
	ADC #$82
actSeqPalRetEXP:	STA $45

; this is the original routine to load the jersey
; colors for a team when they win their division title
	.org $8235		; insert at 0x34245
	LDA $6E
	jmp SubCheckDivChampPal
divchamppalRetREG:	ADC $6E
	TAX
	LDA $83D8,X
	STA $031C
	LDA $83D9,X
	STA $031F
	LDA $83DA,X
	STA $0320
	LDA $83DB,X
	STA $0323
	LDA $83DC,X
	STA $0324
divchamppalRetEXP:	RTS

; this is the original routine to load the jersey
; colors for a team when they lose their conference championship
	.org $8267
	LDA $6F
	jmp SubCheckConfChampPalLoser
confloserpalRetREG:	LDA $8484, X
	STA $0323
	STA $0333
	LDA $8485, X
	STA $0324
	STA $0334
	LDA $8486, X
	STA $0327
	STA $0337
	LDA $8487, X
confloserpalRetEXP:	STA $0328
	STA $0338
; this is the original routine to load the jersey
; colors for a team when they win their conference championship
	LDA $6E
	jmp SubCheckConfChampPalWinner
confchamppalRetREG:	LDA $8484,X
	STA $031B
	STA $032B
	LDA $8485,X
	STA $031C
	STA $032C
	LDA $8486,X
	STA $031F
	STA $032F
	LDA $8487,X
confchamppalRetEXP:	STA $0320
	STA $0330
	RTS

; "action sequence" palettes
	.org $82C8		; insert at 0x342D8
	.include "\data\actseq_pal.asm"

; division champ palettes
	.org $83D8		; insert at 0x343E8
	.include "\data\divchamp_pal.asm"

; conference champ palettes
	.org $8484		; insert at 0x34494
	.include "\data\confchamp_pal.asm"

	.org $88C0		; insert at 0x348D0
; this routine loads the action sequence palettes for any expansion team being used
SubCheckActionSeqPalEXP:
	cmp teamindexLOW
	bcs actSeqPalEXP

actSeqPalREG:	ASL
	ASL
	ASL
	jmp actSeqPalRetREG

actSeqPalEXP:	cmp teamindexHIGH
	bcs actSeqPalREG

	stx $FD
	asl
	tax
	lda expActSeqPtrs - 60, X
	sta $44
	lda expActSeqPtrs - 59, X
	ldx $FD
	jmp actSeqPalRetEXP

expActSeqPtrs:	.dw team28_actseq_pal, team29_actseq_pal, team30_actseq_pal, team31_actseq_pal
team28_actseq_pal:	.hex 3815381592200540	; SF
team29_actseq_pal:	.hex 1802183040492400	; STL
team30_actseq_pal:	.hex 1C0C1C3092200540	; SEA
team31_actseq_pal:	.hex 3015301580C03010	; ARZ

; this routine loads the jersey palette for any
; expansion team winning their division title
SubCheckDivChampPal:	cmp teamindexLOW
	bcs divchampEXPpal

divchampREGpal:	ASL
	ASL
	CLC
	jmp divchamppalRetREG

divchampEXPpal:	cmp teamindexHIGH
	bcs divchampREGpal

	tax
	lda divpalindex - 30, X
	tax
	LDA divpalettes, X
	STA $031C
	LDA divpalettes + 1, X
	STA $031F
	LDA divpalettes + 2, X
	STA $0320
	LDA divpalettes + 3, X
	STA $0323
	LDA divpalettes + 4, X
	STA $0324
	jmp divchamppalRetEXP

divpalindex:	.db $00, $05, $0A, $0F
divpalettes:	.hex 0515053028	;SF
	.hex 0838282111	;STL
	.hex 0111013031	;SEA	
	.hex 0515053010	;ARZ


; this routine loads the jersey palette for any
; expansion team winning their conference championship
SubCheckConfChampPalWinner:
	cmp teamindexLOW
	bcs confchampEXPpal

confchampREGpal:	ASL
	ASL
	TAX
	jmp confchamppalRetREG
	
confchampEXPpal:	cmp teamindexHIGH
	bcs confchampREGpal

	tax
	lda confpalindex - 30, X
	tax
	LDA confpalettes, X
	STA $031B
	STA $032B
	LDA confpalettes + 1, X
	STA $031C
	STA $032C
	LDA confpalettes + 2, X
	STA $031F
	STA $032F
	LDA confpalettes + 3,X
	jmp confchamppalRetEXP

; same as above except for loser
SubCheckConfChampPalLoser:
	cmp teamindexLOW
	bcs confloserEXPpal

confloserREGpal:	ASL
	ASL
	TAX
	jmp confloserpalRetREG
	
confloserEXPpal:	cmp teamindexHIGH
	bcs confloserREGpal

	tax
	lda confpalindex - 30, X
	tax
	LDA confpalettes, X
	STA $0323
	STA $0333
	LDA confpalettes + 1, X
	STA $0324
	STA $0334
	LDA confpalettes + 2, X
	STA $0327
	STA $0337
	LDA confpalettes + 3, X
	jmp confloserpalRetEXP

confpalindex:	.db $00, $04, $08, $0C
confpalettes:	.hex 28152515	;SF
	.hex 11283828	;STL	
	.hex 31112111	;SEA
	.hex 30152515	;ARZ

; this routine checks if the CPU juice needs
; to be maxed out, or based on W-L record
Func_CheckDifficulty:	lda cpuDifficulty	; if (CPU_DIFFICULTY != JUICE)
	bne _chkDif_useJuice	;
	LDA $BF00, X 	;   read 1st regular value
	RTS	;   return to read values normally
		; else
_chkDif_useJuice:	pla	;   pop return addr
	pla	;
	LDA #03	;   set juice to max
	STA $6678	;
	LDA #04	;
	STA $6679	;
	LDA #06	;
	STA $667A	;
	LDA #09	;
	STA $667B	;
	LDA #09	;
	STA $667C	;
	JMP $814D	;   skip reading values, but jump normally





	.high

	.org $8487		; insert at 0x36497

; these changes disable a couple of DMC
; samples played. needed to use the
; space in $Fxxx for other purposes
		; this plays "ready!"
	LDA #$0F	; disable DMC
	STA $4015	;
	STA $4010	; set DMC Play mode and frequency
	LDA #$95	; :sample addr = $E540
	STA $4012	;
	LDA #$3F	; :sample len = $3F0
	STA $4013	;
	LDA #$1F	; enable DMC
	STA $4015	;
	JMP $81ED	;
	;------------------------
		; this plays "down!"
;	jmp $81ED
;	nop
;	nop
	LDA #$0F	; disable DMC		; these were replaced by	
	STA $4015	;		;  the JMP and NOPs
	STA $4010	; set DMC Play mode and frequency
	LDA #$D8	; :sample addr = $F600
	STA $4012	;
	LDA #$40    ;#$50	; :sample len = $500
	STA $4013	;
	LDA #$1F	; enable DMC
	STA $4015	;
	JMP $81ED	;
	;------------------------
		; this plays "hut, hut, hut, ... "
	jmp $81ED
	nop
	nop
;	LDA #$0F	; disable DMC		; these were replaced by	
;	STA $4015	;		;  the JMP and NOPs
	STA $4010	; set DMC Play mode and frequency
	LDA #$EC	; :sample addr = $FB00
	STA $4012	;
	LDA #$30	; :sample len = $300
	STA $4013	;
	LDA #$1F	; enable DMC
	STA $4015	;
	JMP $81ED	;


; this plays the "TOUCHDOWN" sample, but
; skips if the "TD" was a 2pt conversion
	.org $84D5		; insert at 0x0364E5
;$84D5:A9 0F	LDA #$0F		; {0}{1}
;$84D7:8D 15 40	STA $4015		; {2}{3}{4}
	jmp Func_checkTDSample		; [0][1][2]
	nop		; [3]
	nop		; [4]
;$84DA:8D 10 40	STA $4010
;$84DD:A9 A4	LDA #$A4
;$84DF:8D 12 40	STA $4012
;$84E2:A9 CF	LDA #$CF
;$84E4:8D 13 40	STA $4013
;$84E7:A9 1F	LDA #$1F
;$84E9:8D 15 40	STA $4015
;$84EC:4C ED 81	JMP $81ED


	.org $9FE8		; insert at 0x037FF8
Func_checkTDSample:	jsr Func_IsIt2PtAttempt		;
	bcs _skipTDsample		;
			;
	LDA #$0F	; ORIGINAL	;
	STA $4015	; ORIGINAL	;
	jmp $84DA		;
			;
_skipTDsample:	JMP $84EC		; jump back to sample code but
			; skip writes to pAPU registers

;----------------------------------------------------------------------------------------------
	.prgbank 14		; insert at 0x38010 - 0x3C00F

;----------------------------------------------------------------------------------------------
;
; prgbanks 15-30 are expanded areas
; prgbank 31 is hardwired to CPU $C000-$FFFF
;
	.prgbank 15		; insert at 0x3C010 - 0x4000F
	.low

	.org $A000		; insert at 0x3C010
; this routine loads the new attribute table data.
;   normally this is generated on-the-fly, but because these screens
;   don't change, it's easier just to use a static attribute table
SubWriteNewAttTable:	stx TempX

	ldy #00
	sty pAPU_CTRL		; disable sound channels (fixes "bleep" sound)

	LDA #$80
	STA MMC3_PRGRAM_CTRL

	lda $C2		; if (A == #$55) then Team Data
	cmp #$55		; if (A == #$51) then Preseason
	beq useTDattTable		; if (A == #$53) then Team Control
usePSTCattTable:	ldy #$40
useTDattTable:	ldx #00
loopwritemorelowarray:	lda TDAttTable, Y
	sta AttTableArray0, X
	iny
	inx
	cpx #$20
	bne loopwritemorelowarray
	ldx #00
loopwritemorehigharray:	lda TDAttTable, Y
	sta AttTableArray1, X
	iny
	inx
	cpx #$20
	bne loopwritemorehigharray

	ldx TempX

	rts

; "Team Data" att table
TDAttTable:	.hex 000000000000000000000000080A0A02
	.hex 3000550050000A00F0005500A500A500
	.hex 2000500050000000F000F5005500FA00
	.hex 00000200050000000000000000000000

; "Preseason" and "Team Control" att table
PandTCAttTable:	.hex 000000000000000000005000000BAA02
	.hex 0300550055005000FF0005005A005A00
	.hex 2000500050000000F000F5005500FA00
	.hex 00000200050000000000000000000000

; this routine messes with the pro-bowl player change menu
;     this is called whenever the player cycles back through the list.
SubDecProBowlIndex:	dec $A0		; team index
	bpl dontwrap_dec

	lda $6F
	cmp #$1D
	beq wrap_nfc_dec
wrap_afc_dec:	lda #$0F
	jmp cont_dec
wrap_nfc_dec:	lda #$11
	jmp cont_dec

dontwrap_dec:	lda $6F
	cmp #$1D
	bne exit_dec
	lda $A0
	cmp #$0D
	bne exit_dec
	lda #$0B

cont_dec:	sta $A0
exit_dec:	sec
	rts

; same as the above except when you cycle forward
SubIncProBowlIndex:	inc $A0
	lda $6F
	cmp #$1D
	beq wrap_nfc_inc

wrap_afc_inc:	lda $A0
	cmp #$10
	bcc afc_not_overflow
	lda #$00
afc_not_overflow:	sta $A0
	sec
	rts

wrap_nfc_inc:	lda $A0
	cmp #$0C
	bcc nfc_not_overflow
	cmp #$0E
	bcs nfc_not_probowl
	lda #$0E
nfc_not_probowl:	cmp #$12
	bcc nfc_not_overflow
	lda #$00
nfc_not_overflow:	sta $A0
	sec
	rts
	
	.include "\data\switchsides.asm"
	.include "\data\playbook_ed.asm"
	.include "\data\options_menu.asm"
	.include "\data\routines.asm"
	.include "\data\weather.asm"



	.high
	.org $8000		; insert at 0x077A0
	.include "\data\team28-31.asm"

;----------------------------------------------------------------------------------------------
	.prgbank 16		; insert at 0x40010 - 0x4400F

;----------------------------------------------------------------------------------------------
	.prgbank 17		; insert at 0x44010 - 0x4800F

;----------------------------------------------------------------------------------------------
	.prgbank 18		; insert at 0x48010 - 0x4C00F

;----------------------------------------------------------------------------------------------
	.prgbank 19		; insert at 0x4C010 - 0x5000F

;----------------------------------------------------------------------------------------------
	.prgbank 20		; insert at 0x50010 - 0x5400F

;----------------------------------------------------------------------------------------------
	.prgbank 21		; insert at 0x54010 - 0x5800F

;----------------------------------------------------------------------------------------------
	.prgbank 22		; insert at 0x58010 - 0x5C00F

;----------------------------------------------------------------------------------------------
	.prgbank 23		; insert at 0x5C010 - 0x6000F

;----------------------------------------------------------------------------------------------
	.prgbank 24		; insert at 0x60010 - 0x6400F

;----------------------------------------------------------------------------------------------
	.prgbank 25		; insert at 0x64010 - 0x6800F

;----------------------------------------------------------------------------------------------
	.prgbank 26		; insert at 0x68010 - 0x6C00F

;----------------------------------------------------------------------------------------------
	.prgbank 27		; insert at 0x60010 - 0x6400F

;----------------------------------------------------------------------------------------------
	.prgbank 28		; insert at 0x70010 - 0x7400F
	
;----------------------------------------------------------------------------------------------
	.prgbank 29		; insert at 0x74010 - 0x7800F
	
;----------------------------------------------------------------------------------------------
	.prgbank 30		; insert at 0x78010 - 0x7C00F
	
;----------------------------------------------------------------------------------------------

	.prgbank 31		; insert at 0x7C010 - 0x8000F

	.org $C007
;$C007:A9 40	LDA #$40
;$C009:8D 01 A0	STA $A001
	LDA #$80		; enable sram writes
	STA MMC3_PRGRAM_CTRL		;

; this code clears ram on Power-on/Reset	SRAM CODE
; [code only clears $6000 - ($624F)]
	.org $C070		; insert at 0x3C080
;$C070:A9 80	LDA #$80		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$C072:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;
	LDA #$43		; (A - 1) == last byte to clear on last page
	LDX #$02		; X == # of pages to clear
	LDY #$00		; addr lsb
	STY $44		;
	LDY #$60		; addr msb
	JSR $D60E		;
;$C082:A9 C0	LDA #$C0		; NOP the write to
	nop		;   MMC3_PRGRAM_CTRL
	nop		;
;$C084:8D 01 A0	STA $A001		;
	nop		;
	nop		;
	nop		;

; this code originally checked that a string of data was writen to sram. since i
; used that area for something else, i changed it to setting some variables and NOPs
	.org $C0BE
	; NEW CODE		; OLD CODE
	lda #00		; $C0BE:A2 06     LDX #$06
	sta twoPtStatus		; $C0C0:BD B7 66  LDA $66B7, X
	sta twoPtAttempted		; $C0C3:DD 29 C1  CMP $C129, X
	sta weatherType		; $C0C6:D0 10     BNE $C0D8
			; $C0C8:CA        DEX
	nop		; $C0C9:10 F5     BPL $C0C0
	nop
	JSR $C4BD		; calculate current checksum
	CPY SRAMChecksum		; this code validates the checksum
	BNE $C0D8
	CPX SRAMChecksum + 1
	BEQ $C10A

; this is a string that was used as a 2nd way to verify sram data
;     integrity, but i used the 1st 6 bytes ($03s) for additional
;     team control values (hence the $03 [$03==SKP])
	.org $C129		; insert at 0x3C139
	.db $03, $03, $03, $03, $03, $03, $4F


; this is the joypad reading routine,
; hacked to account for players switching sides
;$C24F:A5 48     LDA $48	; ???
;$C251:85 34     STA $34	; ???
;$C253:A2 02     LDX #$02	; start on joypad2
;$C255:A9 04     LDA #$04	; set joypad loop = 4
;$C257:85 47     STA $47	;
;$C259:B5 34     LDA $34, X	; set curLoop_buttons == "old" 
;$C25B:85 48     STA $48	;   or lastLoop_buttons (depends on loop index)
;$C25D:A9 01     LDA #$01	; strobe joypad port
;$C25F:8D 16 40  STA $4016	;
;$C262:A9 00     LDA #$00	;
;$C264:8D 16 40  STA $4016	;
;$C267:A0 08     LDY #$08	; set button loop == 8
;
;$C269:BD 15 40  LDA $4015, X	; read joypad port
;$C26C:4A        LSR		; shift button bit to C flag
;$C26D:26 46     ROL $46	; combine C flag with button var
;$C26F:29 01     AND #$01	;
;$C271:05 46     ORA $46	;
;$C273:85 46     STA $46	;
;$C275:88        DEY		;
;$C276:D0 F1     BNE $C269	; loop if more buttons to read
;
;$C278:C5 48     CMP $48	; if(curLoop_buttons == lastLoop_buttons)
;$C27A:F0 07     BEQ $C283	;   branch to save
;$C27C:C6 47     DEC $47	; else, decrease joypad loop counter
;$C27E:D0 DB     BNE $C25B	; if (not zero) read current joypad again
;$C280:4C 8F C2  JMP $C28F	; else, jump to advance to next joypad
;
;$C283:B5 34     LDA $34, X	; get "old" button presses
;$C285:45 46     EOR $46	;	;
;$C287:25 46     AND $46	;	;
;$C289:95 37     STA $37, X	; save "new" buttons for this frame
;$C28B:A5 46     LDA $46	;	;
;$C28D:95 34     STA $34, X	; save "new" buttons to "old"
;$C28F:CA        DEX		; goto next joypad index
;$C290:D0 C7     BNE $C259	; loop if joypad1 not read
;
;$C292:A5 35     LDA $35	; merge both button presses
;$C294:05 36     ORA $36	; 
;$C296:85 37     STA $37	;
;$C298:A5 38     LDA $38	; merge both new button presses
;$C29A:05 39     ORA $39	;
;$C29C:85 3A     STA $3A	;
	.org $C29E	; insert at 0x7C2AE
;	jsr Sub_SwapJoypadReads
;$C29E:20 6D C4  JSR $C46D	; <-this has nothing to do with joypad reading















; this code saves the new checksum
	.org $C4B6		; insert at 0x3C4C6
	STY SRAMChecksum		; SRAM CODE
	STX SRAMChecksum + 1
	







; alter palette pointers on some cut scenes, if needed for weather
	.org $D24C
	jsr Sub_GetPalPtrs
;$D24C:B9 50 00	LDA $0050,Y @ $0066 = #$23
;$D24F:A0 00	LDY #$00
;$D251:84 3F	STY $003F = #$B5
;$D253:0A	ASL
;$D254:26 3F	ROL $003F = #$B5
;$D256:0A	ASL
;$D257:26 3F	ROL $003F = #$B5
;$D259:0A	ASL
;$D25A:26 3F	ROL $003F = #$B5
;$D25C:0A	ASL
;$D25D:26 3F	ROL $003F = #$B5
;$D25F:18	CLC
;$D260:7D 82 D2	ADC $D282,X @ $D2A7 = #$D2
;$D263:85 3E	STA $003E = #$15
;$D265:A5 3F	LDA $003F = #$B5
;$D267:7D 83 D2	ADC $D283,X @ $D2A8 = #$29
	.org $D26A
_getPalPtrs_weatherRet:
;$D26A:85 3F	STA $003F = #$B5











; this code loads pointers for player #s/names
;$D47C:85 3F     STA $003F = #$1E	; save team index
;$D47E:86 3E     STX $003E = #$00	; save player index
;$D480:A5 2E     LDA $002E = #$00	; ???
;$D482:85 43     STA $0043 = #$18	; ???
	.org $D484
	jsr Sub_CheckNameBank
	nop
	nop
;$D484:A2 00     [LDX #$00]	; swap $8000: prg-0 low
;$D486:20 DD D8  [JSR $D8DD]	;
;$D489:A2 01     LDX #$01	; swap $A000: prg-0 high
;$D48B:20 E3 D8  JSR $D8E3	;
;$D48E:A6 3E     LDX $003E = #$00	; get player index
;$D490:A5 3F     LDA $003F = #$00	; get team index
;$D492:0A        ASL
;$D493:A8        TAY
;$D494:B9 00 80  LDA $8000,Y @ $8025 = #$84	; get team pointers
;$D497:85 3E     STA $003E = #$00
;$D499:B9 01 80  LDA $8001,Y @ $8026 = #$B8
;$D49C:85 3F     STA $003F = #$00
;$D49E:8A        TXA
;$D49F:0A        ASL
;$D4A0:A8        TAY	
;$D4A1:B1 3E     LDA ($3E),Y @ $0025 = #$00	; get player pointers
;$D4A3:AA        TAX
;$D4A4:C8        INY
;$D4A5:B1 3E     LDA ($3E),Y @ $0025 = #$00
;$D4A7:48        PHA
;$D4A8:C8        INY
;$D4A9:B1 3E     LDA ($3E),Y @ $0025 = #$00
;$D4AB:86 3E     STX $003E = #$00
;$D4AD:38        SEC
;$D4AE:E5 3E     SBC $003E = #$00
;$D4B0:A8        TAY
;$D4B1:68        PLA
;$D4B2:85 3F     STA $003F = #$00
;$D4B4:88        DEY
;$D4B5:98        TYA
;$D4B6:60        RTS

	.org $D4B7
;$D4B7:A0 00     LDY #$00	; ###
;$D4B9:B1 3E     LDA ($3E),Y @ $80F2 = #$FE	; ###
;$D4BB:4A        LSR
;$D4BC:4A        LSR
;$D4BD:4A        LSR
;$D4BE:4A        LSR
	

; this is the original routine to load the pointer
; [YX] coordinates with a jump statement inserted
	.org $D77F		; insert at 0x3D78F
	ADC #$04
	jmp SubCheckExpandedMenu
menuReturnREG:	STA $0200
	INY
	LDA ($E3),Y
	STA $0203
menuReturnEXP:	RTS

; this is part of the original routine that loads the
; base address of the selected team's attribute data
; with a jump inserted
	.org $DDB0		; insert at 0x3DDC0
	TAX
	jmp SubGetAttAddr
AttReturnREG:	CLC
	ADC $DF77,X
	STA ATTaddrLO
	LDA #$00
	ADC $DF78,X
	STA ATTaddrHI
AttReturnEXP:	LDA $2F


; this routine gets the base address in
; sram for a team's W-L-T record, with redirection
	.org $DEDF		; insert at 0x3DEEF
	TAY
	jmp SubGetWLTaddr
retWLTaddrREG:	STA $3E
	LDA $DF18,Y
retWLTaddrEXP:	STA $3F
	RTS

	; [SavData] pointers to data in sram (this is duplicated in the $ACxx page of prg6)
	.org $DF17
	.dw Bills_SramPtr, Dolphins_SramPtr, Patriots_SramPtr, Jets_SramPtr
	.dw Bengals_SramPtr, Browns_SramPtr, Oilers_SramPtr, Steelers_SramPtr
	.dw Colts_SramPtr, Texans_SramPtr, Jaguars_SramPtr, Titans_SramPtr
	.dw Broncos_SramPtr, Chiefs_SramPtr, Raiders_SramPtr, Chargers_SramPtr, 
	.dw Redskins_SramPtr, Giants_SramPtr, Eagles_SramPtr, Cowboys_SramPtr
	.dw Bears_SramPtr, Lions_SramPtr, Packers_SramPtr, Vikings_SramPtr,
	.dw Buccaneers_SramPtr, Saints_SramPtr, Falcons_SramPtr, Panthers_SramPtr

			; START OF HACK SPACE
	.org $F9C0	; $FB00	; insert at 0x3FB10 [cannot be moved!]
; this routine loads the expansion address
; of data in sram (if EXP), else just resumes
; as normal [only for W-L-T record]
SubGetWLTaddr:	cpy teamindexLOW * 2
	bcs getWLTaddrEXP

getWLTaddrREG:	LDA $DF17,Y
	jmp retWLTaddrREG

getWLTaddrEXP:	cpy teamindexHIGH * 2
	bcs getWLTaddrREG

	lda EXPsramaddr - 60, Y
	sta $3E
	lda EXPsramaddr - 59, Y
	jmp retWLTaddrEXP

; this routine loads the expansion address
; of data in sram (if EXP), else just resumes
; as normal
SubGetSRAMaddr:	cpy teamindexLOW * 2
	bcs sramEXPteam

sramREGteam:	LDA $ACAC,Y
	jmp sramAddrREG

sramEXPteam:	cpy teamindexHIGH * 2
	bcs sramREGteam

	lda EXPsramaddr - 60, Y
	sta $42
	lda EXPsramaddr - 59, Y
	jmp sramAddrEXP

EXPsramaddr:	.dw SF49ers_SramPtr, Rams_SramPtr, Seahawks_SramPtr, Cardinals_SramPtr

; this routine fixes the helmet data issue with
; the expansion teams
SubGetLHBaseAddr:	cpx teamindexLOW
	bcs lhbaEXP

lhbaREG:	LDA $BE49,X
	rts

lhbaEXP:	cpx teamindexHIGH
	bcs lhbaREG

	lda lhBaseAddrData - 30,X
	rts

lhBaseAddrData:	.db $40, $42, $41, $40	; these determine the helmet type


; this routine gets the top 2 tiles of mini-helmet data
; for the expansion teams, else does the normal shit
SubGetSmallHelmetDataTop:
	lda $45
	cmp teamindexLOW
	bcs smallHelmetTopEXP

smallHelmetTopREG:	LDA $BBB6, Y
	jmp smallhelmetTopRetREG

smallHelmetTopEXP:	cmp teamindexHIGH
	bcs smallHelmetTopREG

	asl
	tay
	lda TopSmallHelmetData - 60, Y
	STA $033A, X
	INX
	LDA TopSmallHelmetData - 59, Y
	ldy $44		; reset y
	jmp smallhelmetTopRetEXP

; this routine gets the bottom 2 tiles of mini-helmet data
; for the expansion teams, else does the normal shit
SubGetSmallHelmetDataBot:
	lda $45
	cmp teamindexLOW
	bcs smallHelmetBotEXP

smallHelmetBotREG:	LDA $BBB8, Y
	jmp smallhelmetBotRetREG

smallHelmetBotEXP:	cmp teamindexHIGH
	bcs smallHelmetBotREG

	asl
	tay
	lda BotSmallHelmetData - 60, Y
	STA $033A, X
	INX
	LDA BotSmallHelmetData - 59,Y
	ldy $44		; reset y
	jmp smallhelmetBotRetEXP

; this routine gets the logo tile of mini-helmet data
; for the expansion teams, else does the normal shit
SubGetSmallHelmetDataAtt:
	lda $45
	cmp teamindexLOW
	bcs smallHelmetAttEXP

smallHelmetAttREG:	LDA $BBBA, Y
	rts

smallHelmetAttEXP:	cmp teamindexHIGH
	bcs smallHelmetAttREG

	tay
	lda MiniLogoSmHelmetData - 30, Y
	rts

	;    SF,STL,SEA,ARZ
TopSmallHelmetData:	.hex A4A5B4B586878C8D
BotSmallHelmetData:	.hex A69BB68382008E83
MiniLogoSmHelmetData:	.hex 30023B3C


; this is the mini-helmet coordinates for expansion
EXPminiHelemtTDptrs:	.dw Slot0minicoorTD, Slot1minicoorTD, Slot2minicoorTD, Slot3minicoorTD
EXPminiHelmetPSRCptrs:	.dw Slot0minicoorPSTC, Slot1minicoorPSTC, Slot2minicoorPSTC, Slot3minicoorPSTC

Slot0minicoorTD:	.db $90, $64
Slot1minicoorTD:	.db $A0, $64
Slot2minicoorTD:	.db $B0, $64
Slot3minicoorTD:	.db $C0, $64

Slot0minicoorPSTC:	.db $90, $64
Slot1minicoorPSTC:	.db $A0, $64
Slot2minicoorPSTC:	.db $B0, $64
Slot3minicoorPSTC:	.db $C0, $64

; this is an anchor point for calling functions outside their needed banks
; Y=funciton index
SubCallFunc_PRG15:	lda DataPtr		; save pointer
	pha		;#
	lda DataPtr + 1		;
	pha		;##

	tya		; set function address
	pha		;###(save index)
	asl		;
	tay		;
	lda bankswitch_func_ptr_table, Y	;
	sta DataPtr		;
	lda bankswitch_func_ptr_table + 1, Y	;
	sta DataPtr + 1		;
	lda #$07		; swap banks (8K @ $A000)
	sta MMC3_CTRL		;
	lda #$1E	;02	;            (prg15-low)
	sta MMC3_DATA		;
	jsr _func_indirectJump		; do some shit
	pla		;###
	tay
	lda #$07		; swap back
	sta MMC3_CTRL		;
	lda bankswitch_func_ret_bankindex, Y	;
	sta MMC3_DATA		;
	
	pla		;##
	sta DataPtr + 1		;
	pla		;#
	sta DataPtr		;

	rts		; return

_func_indirectJump:	jmp (DataPtr)		; software: JSR ($nnnn)

bankswitch_func_ptr_table:
	.dw SubWriteNewAttTable, SubDecProBowlIndex, SubIncProBowlIndex
	.dw Sub_SwapTeams, Sub_OptionsMenu, Sub_InGamePBeditor
	.dw SubSetRandomWeather, Sub_HalftimeText
bankswitch_func_ret_bankindex:
	.db $11, $07, $07
	.db $07, $11, $0F
	.db $11, $11

; this routine fucks with the team index while the game is looping for data
;     for the "Team Rankings" screen
SubCheckRankingsIndex:	pha
	lda $A9
	cmp #$20
	beq adjustrankingsindex

	pla
	cmp $A9
	bcc looprankings
	jmp rankingsReturnExit

adjustrankingsindex:	lda $91
	cmp #$1C
	bne dontshiftrankingsindex
	lda #$1E
	sta $91
dontshiftrankingsindex:	pla
	cmp #$22
	bcc looprankings
	jmp rankingsReturnExit

looprankings:	jmp rankingsReturnLoop

; this code is just an extension of the code that
; checks if a division champion title can be awarded
; with space for NFC-S and NFC-W. code returns to
; where game was interrupted from when completed.
extendedDivChampCheck:	JSR $AE5D		; original code
	lda #06		; check NFC-S
	jsr $AE5D
	lda #07		; check NFC-W
	jsr $AE5D
	jmp extendedDivCheckReturn	; return to orinal location

; this routine adjust the team index variable when
;     searching for the wild card teams in each conference
SubAdjustWildCardLoopIndex:
	INC $8E		;     inc team index var
	lda $8E
	cmp #$1C
	bne _dont_adjust_wldcrd_index
	lda teamindexLOW
	sta $8E
_dont_adjust_wldcrd_index:
	DEC $8F		;     inc loop var
	jmp subadjustwldcrdindRET

; this routine just an extension of the wild card
;     routine. i just ran out of space so moved some here.
FuncLengthenWildCardRoutine:
	LDA $99		; finish up AFC wildcard selection
	STA $677F
	STA SRAMDivLeadWldCardData + 9

	LDA #$10		; figure out the NFC wildcards
	JSR $B2DF
	LDA $97
	STA $677B
	STA SRAMDivLeadWldCardData + 10
	LDA $99
	STA $6783
	STA SRAMDivLeadWldCardData + 11
	jmp func_lenWldCrd_ret

; this function determines which offensive starter code to use
; #$00 - #$1B && #$1E - #$FF (regular team) or #$1C && #$1D (probowl)
;    A=team index
SubJumpOFstartRoutine:	cmp #$1C
	beq off_start_useProBowl
	cmp #$1D
	beq off_start_useProBowl
off_start_useRegTeam:	jmp $9967
off_start_useProBowl:	jmp $99C0


; the new divisional allignment
Static_DivSetup:	.db $00, $04
	.db $04, $04
	.db $08, $04
	.db $0C, $04
	.db $10, $04
	.db $14, $04
	.db $18, $04
	.db $1E, $04

; this code displays the last 2 division standings
; screens at the end of the season (NFC-S & NFC-W)
SubFinishEndOfSeasonCycle:
	JSR $A64A	; finish A==5
	LDA #$06
	JSR $A64A
	LDA #$07
	JSR $A64A
	rts

; this routine checks if one of the expansion teams
; is being loaded. if it is, then it loads all the
; needed data for the large helmet palette, else it
; exits and resumes as normal
SubGetLHP:	cmp teamindexLOW		; if A > 0x1C then branch for
	bcs LHPisExpansion		;    the expansion teams
LHPisRegular:	asl		; else resume as normal
	asl
	asl
	jmp LHPreturnREG		; and return to original routine

LHPisExpansion:	cmp teamindexHIGH
	bcs LHPisRegular
	tax			; get the low byte
	lda LHPPointers - 30, X			; of the palette's address
	sta LHPaddrLO

	lda #$BF
	sta LHPaddrHI

	lda #00		; set count == 0
	sta $07FF
	sty $07FE		; preserve y-index into vram stack

LHloop:	ldy $07FE
	lda Xindex, Y		; get the index into the
	tax		;     vram stack to write to
	iny		; increase the Xindex varible
	sty $07FE		; perserve Y register

	ldy $07FF
	lda (LHPaddrLO), Y		; load palette value
	sta $031F, X		; and store the value to the stack
	iny		; increase the loop control variable
	sty $07FF		; if 8 bytes have not been
	cpy #08		;     written to the vram stack
	bne LHloop		;     then loop for more

	jmp LHPreturnEXP		; else exit

; Low byte for large helmet palette pointers
LHPPointers:	.db $E0		; SF
	.db $E8		; STL
	.db $F0		; SEA
	.db $F8		; ARZ

; X index for writes to PPU palette memory
; (large helmet palette)
Xindex:	.db $00, $01, $02, $0D, $0E, $10, $11, $12
	.db $08, $09, $0A, $15, $16, $18, $19, $1A

; this routine checks if the expanded menu is being used
; and if so, it redirects where to load the [YX] from
SubCheckExpandedMenu:
	tay		; preserve the Y index
	lda $E4		; if($E4 == #$BB)
	cmp #$BB		;
	beq emEXP		;     branch to check for expansion ("Team Data")
	cmp #$BE		; else if(($E4 == #$BE) || ($E4 == #$88))
	beq emEXP2		;     branch to check for expansion ("Preseason" and "Team Control")
	cmp #$88
	beq emEXP2
	cmp #$BA		; else if($E4 == $BA)
	beq emEXP3		;     branch to check for expansion ("NFL Standings")

emREG:	lda ($E3),Y		; else (no expansion team)
	jmp menuReturnREG		;     resume as normal

;	"Team Data"
emEXP:	lda $E3		; if($E3 != #$39)
	CMP #$39
	BNE emREG		;     branch to resume as normal

	tya		; else
	cmp #$4C		;     if(Y < #$4C)
	bcc emREG		;          branch to resume as normal
	sec		;     else
	sbc #$4C		;          adjust the Y index to load
	tay		;          the expansion coordinates

finEXPmenu:	LDA TeamDataCurCoor, Y		; load the new coordinates
	sta $0200		; for the Pointer
	iny
	LDA TeamDataCurCoor, Y
	STA $0203
	jmp menuReturnEXP		; and resume at expansion resume point

;	"Preseason" and "Team Control"
emEXP2:	lda $E3		; if(($E3 != #$81) && ($E3 != #$DF))
	cmp #$81
	beq emEXP2cont
	cmp #$DF
	bne emREG		;     branch to resume as normal

emEXP2cont:	tya		; else
	cmp #$40		;     if(Y < #$40)
	bcc emREG		;          branch to resume as normal
	sec		;     else
	sbc #$38		;          adjust the Y index
	tay

	lda $E3		; if(menu == Preseason)
	cmp #$81
	beq noadjustYexp2menucoor	;     branch to skip

	tya
	clc		; else increase Y
	adc #$04
	tay

noadjustYexp2menucoor:	jmp finEXPmenu		; and jump to finish routine

;	"NFL Standings"
emEXP3:	lda $E3		; if($E3 != #$C7)
	cmp #$C7
	bne emREG		;     branch to resume as normal

	cpy #$16		; else if(Y < #$16)
	bcc emREG		;          branch to resume as normal

	lda #$02		; else the cursor is on the last
	sta $E1
	lda #$00		; line, set it to the Playoff bracket
	sta $E2
	ldy #$14
	jmp emREG		; choice and resume as normal

TeamDataCurCoor:	.db $C8, $18, $C8, $58, $C8, $98, $C8, $D8
PreseasonCurCoor:	.db $C8, $90, $C8, $D0
TeamCtrlCurCoor:	.db $C8, $A0, $C8, $E0

; this routine loads [offset] from a different
; location if the expanded part of the "Team Data"
; screen is being used
SubCheckExpTDMenu:	cpx #$1E
	bcs expandedTDMenu
	LDA $AC26,X
	rts

expandedTDMenu:	lda tdOffsetValues - 30,X
	rts

tdOffsetValues:	.db $13, $17, $1B, $21

; this routine loads [offset] from a different
; location if the expanded part of the "Team Data"
; screen is being used
SubCheckExpPTCMenu:	cpx #$1E
	bcs expandedPTCMenu
	LDA $AC03, X
	rts

expandedPTCMenu:	lda tdOffsetValues - 28, X
	rts

; this routine loads the correct flashing coordinates
; for the "Preseason" and "Team Control" screens
SubExpMenuFlash:	tay
	cmp #$40
	bcs expMenuFlash

menuFlash:	lda ($E3),Y		; resume as normal
	jmp $AC5D

expMenuFlash:	tax		; load from different location
	lda PreseasonCurCoor - 64, X
	jmp $AC5D

; this routine checks if the end of game screen
; should access a regular team, pro bowl team,
; or expansion team
SubCheckExpTeamAtEndGame:
	cmp teamindexLOW
	bcs EXPendgame

REGendgame:	CMP #$1C
	BCC ret1

ret0:	jmp checkEndGameREG0		; pro-bowl
ret1:	jmp checkEndGameREG1		; orig28

EXPendgame:	cmp teamindexHIGH
	bcs REGendgame
	jmp checkEndGameEXP		; exp4

; this fixes a glitch with correcting the season standings
; screen, where the game would crash on start-up. this
; also implements the alternate offensive dropdown menu.
SubFixStartUpGlitch:	cpx #$82		; P1-dropdown menu
	beq _check_AltDropDownMenu	;
	cpx #$8E		; P2-dropdown menu
	beq _check_AltDropDownMenu	;
_cont_with_SU_glitch:	lda $FF		; fix a glitch if needed
	cmp #00		;
	beq noredirectptrs		;
	jmp SubGetTxtPtrsForDivStandings	;
noredirectptrs:	lda $A000, X		; else return normally
	jmp subGetTxtPtrsRetREG		;

_check_AltDropDownMenu:	lda twoPtAttempted		; make sure a 2PT is being
	beq _cont_with_SU_glitch	;   attempted
	lda <drpDwnMenu_2PT_struct	; set 2PT conv dropdown menu
	sta $C2		;
	lda >drpDwnMenu_2PT_struct	;
	jmp subGetTxtPtrsRetEXP		; exit like hack

; this routine checks whether or not a new team is
; being accessed and loads the appropriate pointers,
; else it just continues as normal. (Large Helmet Data)
SubGetLHAddr:	cpx #02		; if(X != #02)
	bne lhRegular		;     branch to resume as normal
	lda $3F
	cmp teamindexLOW
	bcs lhExpansion

lhRegular:	lda $CC,X
	jmp LHreturnREG

lhExpansion:	cmp teamindexHIGH
	bcs lhRegular

	asl
	tay
	lda HDATAPTR - 60, Y
	sta $C9
	lda HDATAPTR - 59, Y
	sta $CA
	jmp LHreturnEXP

; this routine checks whether or not a new team is
; being accessed and loads the appropriate pointers,
; else it just continues as normal. (Attribute Pointer)
SubGetAttAddr:	lsr		; preserve the team index in A
	cmp teamindexLOW
	bcs attExpansion

attRegular:	LDA $DFAF,Y
	jmp AttReturnREG

attExpansion:	cmp teamindexHIGH		; check if teamIndex < #$22
	bcs attRegular

	sec
	sbc teamindexLOW
	asl
	tax
	lda $DFAF, Y
	clc
	adc EXPAttAddrs, X
	sta ATTaddrLO
	lda #00
	adc EXPAttAddrs + 1, X
	sta ATTaddrHI
	jmp AttReturnEXP

EXPAttAddrs:	.dw SF_ATTS
	.dw STL_ATTS
	.dw SEA_ATTS
	.dw ARZ_ATTS

; this stub gets the defualt KR/PR for expansion teams
SubGet_KR_PR_starterreset:
	cpx teamindexLOW
	bcs _getKRPR_EXP_sr
_getKRPR_REG_sr:	LDA $B9C3, X
	rts
_getKRPR_EXP_sr:	cpx teamindexHIGH
	bcs _getKRPR_REG_sr
	lda Exp_Slot_Def_KR_PR_sr - 30, X
	rts

Exp_Slot_Def_KR_PR_sr:	.hex 44998855

; offensive formation data
Base_off_form:	.hex 00000000
	.hex 00000000
	.hex 00000000
	.hex 00000000
	
	.hex 00000000
	.hex 00000000
	.hex 00000000
	.hex 0000	; probowl
	.hex 00000000

; this gets the quarter length
; when playing a game
Sub_GetQtrLength:	lda QtrLength
	clc
	adc #TIME_MIN_BASE
	sta Time_Minutes
	rts

; refresh the playbook screen after a reset
Sub_Refresh_PBScreen:	cmp teamindexLOW		; FUNC2
	bcs _refreshPB_isRegTeam
	cmp probowlINDEX
	bcs _refreshPB_isProBTeam
_refreshPB_isRegTeam:	jmp $91D5
_refreshPB_isProBTeam:	jmp $91DE

offense_menu_coor_p1:	.db $00, $00, $20, $06, $38, $48, $58, $68, $78, $88
offense_menu_coor_p2:	.db $00, $00, $90, $06, $38, $48, $58, $68, $78, $88
main_menu_coor:	.db $00, $00, $28, $05, $50, $60, $70, $80, $90

; swap in needed bank for player #s/names
Sub_CheckNameBank:	lda $3F	; if (expanded team)
	cmp teamindexLOW	;
	bcc _exitCheckName_Reg	;
_exitCheckName_Exp:	ldx #$1F	;   swap $8000: prg-F high
	.db $2C	; else	[bit trick]
_exitCheckName_Reg:	LDX #$00	;   swap $8000: prg-0 low
	jmp $D8DD	; exit ($D8DD will rts back, saves 1 byte)

; ---------------------------
	.include "\data\playbook_hook.asm"
	.include "\data\options_hook.asm"
	.include "\data\twoPtConv.asm"
	.include "\data\first_down.asm"
; ---------------------------

SwapTeamSides:	JSR $9DFA	; show scoreboard	
	;ldy #PRG15_SWAP_TEAMS	; swap teams
	;jmp SubCallFunc_PRG15	;
	rts	; -DEBUG-
SwapTeamEndOfGame:	JSR $9DFA	; show scoreboard
	;ldy #PRG15_SWAP_TEAMS	; swap teams
	;jsr SubCallFunc_PRG15	;
	JSR $A236	; execute 4th quarter
	;ldy #PRG15_SWAP_TEAMS	; swap teams to original position
	;jmp SubCallFunc_PRG15	;
	rts	; -DEBUG-
; ---------------------------
Sub_SwapJoypadReads:	lda CurrentQuarter		; if (qtr == 2nd) or
	cmp #SECOND_QTR		; (qtr == 4th) then
	beq _swapReads		;
	cmp #FOURTH_QTR		;
	beq _swapReads		; 
	;rts		;   exit
	jmp $C46D		;   for compatibility
			; else
_swapReads:	ldx $35		;   swap pressed buttons
	ldy $36		;
	sty $35		;
	stx $36		;
	ldx $38		;   swap newly pressed
	ldy $39		;
	sty $38		;
	stx $39		;
	;rts		;   exit
	jmp $C46D		;   <-for compatibility

; ---------------------------
; these routines set the weather randomly
			; ===SEASON===
SetWeatherSEASON:	LDA $675A, X		; pull team index from sram
	sta P1Team		; save index
	lda weatherBool		; if (WEATHER == ON)
	beq _setweather_off		;
_setweather_useRand:	ldy #PRG15_SET_WEATHER		;   get random weather
	jmp SubCallFunc_PRG15		;   exit
_setweather_off:	lda #WEATHER_CLEAR		; else
	sta weatherType		;   set weather to clear
	rts		;   exit
			; ===PRESEASON===
SetWeatherPRESEASON:	JSR $ABFE		; get team index from table in rom
	sta P1Team		; save index
	lda preseasonWeather		; if (WEATHER = RAND)
	cmp #WEATHER_RAND		;   branch to get random weather
	bcs _setweather_useRand		; else
	sta weatherType		;   save weather type
	rts		;   exit
	
; skip halftime show if weather is bad
Sub_CheckHalfTimeShow:	lda weatherType
	;cmp #WEATHER_CLEAR
	bne _skip_halftimeshow
	jmp $AE0D
_skip_halftimeshow:	ldy #PRG15_HALFTIME_TEXT
	jmp SubCallFunc_PRG15

Func_swapPRG_low:	lda #6
	sta MMC3_CTRL
	stx MMC3_DATA
	lda #7
	sta MMC3_CTRL
	sty MMC3_DATA
	rts



	.org $FFE8		; insert at 0x3FFF8
RESET:	LDA #$00
	STA MMC3_CTRL
	JMP $C000
	.db "TSBe:v", VERSION, $FF

	.org $FFFA
	.dw $C130
	.dw RESET

;----------------------------------------------------------------------------------------------

	.chrbank 0		; insert at 0x40010 - 0x4200F

;----------------------------------------------------------------------------------------------

	.chrbank 1		; insert at 0x42010 - 0x4400F

	.org $1F10		; insert at 0x43F20
	; Panthers mini-logo
	.hex 00000A151B0E00000000000000000000

;----------------------------------------------------------------------------------------------

	.chrbank 2		; insert at 0x44010 - 0x4600F

;----------------------------------------------------------------------------------------------

	.chrbank 3		; insert at 0x46010 - 0x4800F

	.org $0760		; insert at 0x46770
	; Jaguars mini-helmet
	.hex 0F3F7877EFDE80FF000000070F1E0000
	.hex 00C06060F0F0F0800000000000007080

;----------------------------------------------------------------------------------------------

	.chrbank 4		; insert at 0x48010 - 0x4A00F

;----------------------------------------------------------------------------------------------

	.chrbank 5		; insert at 0x4A010 - 0x4C00F

;----------------------------------------------------------------------------------------------

	.chrbank 6		; insert at 0x4C010 - 0x4E00F

;----------------------------------------------------------------------------------------------

	.chrbank 7		; insert at 0x4E010 - 0x5000F

;----------------------------------------------------------------------------------------------

	.chrbank 8		; insert at 0x50010 - 0x5200F

;----------------------------------------------------------------------------------------------

	.chrbank 9		; insert at 0x52010 - 0x5400F

;----------------------------------------------------------------------------------------------

	.chrbank 10		; insert at 0x54010 - 0x5600F

;----------------------------------------------------------------------------------------------

	.chrbank 11		; insert at 0x56010 - 0x5800F

;----------------------------------------------------------------------------------------------

	.chrbank 12		; insert at 0x58010 - 0x5A00F

;----------------------------------------------------------------------------------------------

	.chrbank 13		; insert at 0x5A010 - 0x5C00F

;----------------------------------------------------------------------------------------------

	.chrbank 14		; insert at 0x5C010 - 0x5E00F
	.org $0000
	.incbin "\data\chr14.bin"

;----------------------------------------------------------------------------------------------

	.chrbank 15		; insert at 0x5E010 - 0x6000F
	.org $0000
	.incbin "\data\chr15.bin"

;----------------------------------------------------------------------------------------------

	.chrbank 16		; insert at 0x60010 - 0x6200F
	.org $0000
	.incbin "\data\chr16.bin"	

;----------------------------------------------------------------------------------------------

	.chrbank 17		; insert at 0x62010 - 0x6400F

;----------------------------------------------------------------------------------------------

	.chrbank 18		; insert at 0x64010 - 0x6600F

;----------------------------------------------------------------------------------------------

	.chrbank 19		; insert at 0x66010 - 0x6800F

;----------------------------------------------------------------------------------------------

	.chrbank 20		; insert at 0x68010 - 0x6A00F

;----------------------------------------------------------------------------------------------

	.chrbank 21		; insert at 0x6A010 - 0x6C00F

;----------------------------------------------------------------------------------------------

	.chrbank 22		; insert at 0x6C010 - 0x6E00F

;----------------------------------------------------------------------------------------------

	.chrbank 23		; insert at 0x6E010 - 0x7000F

;----------------------------------------------------------------------------------------------

	.chrbank 24		; insert at 0x70010 - 0x7200F

;----------------------------------------------------------------------------------------------

	.chrbank 25		; insert at 0x72010 - 0x7400F

;----------------------------------------------------------------------------------------------

	.chrbank 26		; insert at 0x74010 - 0x7600F

;----------------------------------------------------------------------------------------------

	.chrbank 27		; insert at 0x76010 - 0x7800F

;----------------------------------------------------------------------------------------------

	.chrbank 28		; insert at 0x78010 - 0x7A00F

;----------------------------------------------------------------------------------------------

	.chrbank 29		; insert at 0x7A010 - 0x7C00F

;----------------------------------------------------------------------------------------------

	.chrbank 30		; insert at 0x7C010 - 0x7E00F

;----------------------------------------------------------------------------------------------

	.chrbank 31		; insert at 0x7E010 - 0x8000F
