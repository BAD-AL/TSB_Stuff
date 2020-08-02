; JN6502A.JN6502A $File $BaseName.nes -patch test.nes
;
;	[ ] skip halftime show on bad weather
;

; I think dropping BC by 4-5 notches would be a good start
; especially for rain It depends on how exaggerated you want
; the effects to be. 
;
; Mild snow: I would probably drop the rs rp and ms of all
; defenders by one notch or something along those lines.
;
; Extreme snow: Multiple notch drop on PC, PS and REC and KA
;
; Rain: Sometimes the effect is mild other times it leads to
; the offense not being able to do anything. I'm thinking of
; the PIT game awhile ago where the final was 3-0
;
; Possibilities: Reduced MS, Reduced RP, Reduced RS, Reduced
; REC, Reduced PC. Reduced rs and RP for defense

; =======================================================================
; 0x2be74: Rushing Power (RP) 	$BE64	*
;   $8150:B9 64 BE	LDA $BE64,Y @ $BE6C = #$05
;   $8180:BD 64 BE	LDA $BE64,X @ $BEEA = #$28
;   $B9C2:B9 64 BE	LDA $BE64,Y @ $BE6E = #$03
; ---------------------------
; 0x2be84: Running Speed (RS) 	$BE74	*
;   $815B:B9 74 BE	LDA $BE74,Y @ $BE7C = #$16
;   $B9CD:B9 74 BE	LDA $BE74,Y @ $BE7E = #$18
; ---------------------------
; 0x2bee4: Pass Block (APB)	$BED4	-
; ---------------------------
; 0x2bef4: Kick Block (AKB) 	$BEE4	-
; ---------------------------
; 0x2bf04: Fumbles (BC)		$BEF4	*
;   $BF4E:D9 F4 BE	CMP $BEF4,Y @ $BEFB = #$0B
; ---------------------------
; 0x2bf14: Interceptions (PC)	$BF04	*
;   $9E48:B9 04 BF	LDA $BF04,Y @ $BF10 = #$55
; ---------------------------
; 0x2bf24: Receptions (REC)	$BF14	*
;   $9E6D:B9 14 BF  LDA $BF14,Y @ $BF20 = #$55
; =======================================================================





WEATHER_CLEAR	equ $00
WEATHER_SNOW	equ $01
WEATHER_RAIN	equ $02

CLEAR_PAL	equ $1A
CLEAR_DARK_PAL	equ $09
RAIN_PAL	equ $18
RAIN_DARK_PAL	equ $08
SNOW_PAL	equ $22	;$21
SNOW_DARK_PAL	equ $12	;$11

;----------------------------------------------------------------------------------------------

	.rambank
	.org $6C
P1Team:	.db 0
P2Team:	.db 0

	.org $7FF0
weatherBool:	.db 0		; 0=false, else=true
weatherType:	.db 0		; 0=plain, 1=snow, 2=rain
TempX:	.db 0
TempY:	.db 0
TempA:	.db 0

;----------------------------------------------------------------------------------------------

	.prgbank 0		; insert at 0x00010 - 0x0400F

;----------------------------------------------------------------------------------------------

	.prgbank 1		; insert at 0x04010 - 0x0800F

;----------------------------------------------------------------------------------------------

	.prgbank 2		; insert at 0x08010 - 0x0C00F

;----------------------------------------------------------------------------------------------

	.prgbank 3		; insert at 0x0C010 - 0x1000F

;----------------------------------------------------------------------------------------------

	.prgbank 4		; insert at 0x10010 - 0x1400F

;----------------------------------------------------------------------------------------------

	.prgbank 5		; insert at 0x14010 - 0x1800F

;----------------------------------------------------------------------------------------------

	.prgbank 6		; insert at 0x18010 - 0x1C00F

	.org $A000		; insert at 0x1A010
	; #$00: Gameplay
_pal_00_wCLEAR:	.db $0F, $21, $31, $30, $0F, CLEAR_PAL, CLEAR_PAL, $2A, $0F, $21, $31, $30, $0F, $00, $00, $00

	.org $A0F0
	; #$0F: Play select screen
_pal_0F_wCLEAR:	.db $0F, $21, $25, $30, $0F, CLEAR_PAL, $25, $30, $0F, $0F, $00, $30, $0F, CLEAR_PAL, $00, $30

	.org $A160
	; #$16: RUSH TD [slam]
	; #$17: FG - close kick
_pal_16_wCLEAR:	.db $0F, CLEAR_DARK_PAL, $10, $30, $0F, $22, $28, $30, $0F, $22, $31, $30, $0F, $27, $15, $30
_pal_17_wCLEAR:	.db $0F, $23, $35, $26, $0F, $30, $10, CLEAR_PAL, $0F, $10, $11, $30, $0F, $10, $15, $30
	
	.org $A320
	; #$32: XPT, SUCCESSFUL TRY, REC TD [run], SACK
_pal_32_wCLEAR:	.db $0F, $21, CLEAR_PAL, $30, $0F, CLEAR_PAL, $00, $10, $0F, $21, $10, $30, $0F, $38, $25, $30


	.org $BEE0
Sub_GetPalPtrs:	LDA $0050, Y
	ldy #00
	cmp #$00
	beq _chk_weath_is00
	cmp #$0F
	beq _chk_weath_is0F
	cmp #$16
	beq _chk_weath_is16
	cmp #$17
	beq _chk_weath_is17
	cmp #$32
	beq _chk_weath_is32
	rts

_chk_weath_is32:	iny
_chk_weath_is17:	iny
_chk_weath_is16:	iny
_chk_weath_is0F:	iny
_chk_weath_is00:	sty TempY		; save offset
	pla		; pop return addr
	pla		;
	ldy weatherType		; get offset to palette pointer
	lda _weatherPal_Offs, Y		;
	clc		;
	adc TempY		;
	asl		; get pointer to data
	tay		;
	lda _weatherPal_Ptrs, Y		;
	sta $3E		;
	lda _weatherPal_Ptrs + 1, Y	;
	;sta $3F	; (saved after jmp)	;
	ldy #00		;
	jmp _getCoinTossPal_weatherRet	;

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

;----------------------------------------------------------------------------------------------

	.prgbank 8		; insert at 0x20010 - 0x2400F

; set the weather for season
; (when current game is read from sram)
	.org $9497		; 0x214A7
	jsr SetWeatherSEASON
	nop
	nop

; set the weather for preseason (1-human)
; (when home team [p1] selects a team)
	.org $AA0D		; 0x22A1D
	jsr SetWeatherPRESEASON
	nop
	nop

; set the weather for preseason (2-humans)
; (when home team [p1] selects a team)
	.org $AADA		; 0x22AEA
	jsr SetWeatherPRESEASON
	nop
	nop


; these routines set the weather randomly (see: prgbank15)
	.org $BFD4		; 0x23FE4
SetWeatherSEASON:	LDA $675A,X		; pull team index from sram
	STA P1Team
	jsr SubSetRandomWeather
	rts

SetWeatherPRESEASON:	JSR $ABFE		; get team index from table in rom
	sta P1Team
	jsr SubSetRandomWeather
	rts

;----------------------------------------------------------------------------------------------

	.prgbank 9		; insert at 0x24010 - 0x2800F

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


	.org $BF34		; 0x2BF44
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


; default palette
	.org $8409		; 0x2C419
weatherCLEARpalette:	.db $0F, $02, $16, $30, $0F, $02, $16, $30, $0F, CLEAR_PAL, $02, $30, $0F, $37, $16, $30




	.org $8F32		; 0x2CF42
; this routine sets the correct palette
; for when the camera is in the middle
; of the field (possibly left endzone too)
SubGetFieldPalette:	lda weatherBool
	beq useplainPAL

	lda weatherType
	beq useplainPAL
	stx TempX
	cmp #WEATHER_SNOW
	beq usesnowPAL
userainPAL:	ldx #16
	.db $2C
usesnowPAL:	ldx #00
_setFieldPal_loopData:	lda weatherSNOWpalette, X
	sta $022A, Y
	inx
	iny
	bne _setFieldPal_loopData
	ldx TempX
	rts

useplainPAL:	LDA $8319,Y
	STA $022A,Y
	INY
	BNE useplainPAL
	rts

; alternate palette (snow)
weatherSNOWpalette:	.db $0F, $02, $16, $30, $0F, $02, $16, $30, $0F, SNOW_PAL, $02, $30, $0F, $37, $16, $30
weatherRAINpalette:	.db $0F, $02, $16, $30, $0F, $02, $16, $30, $0F, RAIN_PAL, $02, $30, $0F, $37, $16, $30


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

	
	.high

;----------------------------------------------------------------------------------------------

	.prgbank 12		; insert at 0x30010 - 0x3400F

;----------------------------------------------------------------------------------------------

	.prgbank 13		; insert at 0x34010 - 0x3800F

;----------------------------------------------------------------------------------------------

	.prgbank 14		; insert at 0x38010 - 0x3C00F

;----------------------------------------------------------------------------------------------

	.prgbank 15		; insert at 0x3C010 - 0x4000F

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
_getCoinTossPal_weatherRet:
;$D26A:85 3F	STA $003F = #$B5



	.org $FE20

; this chooses the weather
SubSetRandomWeather:	pha		; preserve machine state
	txa
	pha
	tya
	pha
	lda $30		; generate a "random" number
	asl
	asl
	asl
	clc
	adc $3C
	clc
	adc $3D
	ldy #00		; check for snow, rain, or clear
	ldx P1Team
	cmp chanceOfSnow, X
	bcc setweathertosnow
	cmp chanceOfRain, X
	bcc setweathertorain
	lda #00
	jmp setweathervars
setweathertosnow:	iny
setweathertorain:	iny
	lda #01
setweathervars:	sta weatherBool
	sty weatherType
	pla		; restore machine state
	tay
	pla
	tax
	pla
	rts

chanceOfSnow:	.db $20, $00, $00, $20, $20	; AFC
	.db $20, $20, $00, $20
	.db $20, $00, $00, $00, $20
	.db $00, $20, $20, $00, $00	; NFC
	.db $20, $20, $20, $20, $00
	.db $00, $20, $00, $00
	.db $00, $00		; Pro-bowl
chanceOfRain:	.db $40, $20, $20, $40, $40	; AFC
	.db $40, $40, $20, $40
	.db $40, $20, $20, $20, $40
	.db $20, $40, $40, $20, $20	; NFC
	.db $40, $40, $40, $40, $20
	.db $20, $40, $20, $20
	.db $20, $20		; Pro-bowl




;----------------------------------------------------------------------------------------------

	.chrbank 0		; insert at 0x40010 - 0x4200F

;----------------------------------------------------------------------------------------------

	.chrbank 1		; insert at 0x42010 - 0x4400F

;----------------------------------------------------------------------------------------------

	.chrbank 2		; insert at 0x44010 - 0x4600F

;----------------------------------------------------------------------------------------------

	.chrbank 3		; insert at 0x46010 - 0x4800F
	
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

;----------------------------------------------------------------------------------------------

	.chrbank 15		; insert at 0x5E010 - 0x6000F

;----------------------------------------------------------------------------------------------

	.chrbank 16		; insert at 0x60010 - 0x6200F

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