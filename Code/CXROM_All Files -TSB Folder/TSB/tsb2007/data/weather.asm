
; this chooses the weather
SubSetRandomWeather:	stx TempX		; preserve shit
	sty TempY
	lda random1
	pha
	lda random2
	pha
	lda random3
	pha
	lda random4
	pha
	
	ldy #00		; check for snow, rain, or clear
	jsr Sub_GetRAND
	ldx P1Team
	cmp chanceOfSnow, X
	bcc setweathertosnow
	jsr Sub_GetRAND
	ldx P1Team
	cmp chanceOfRain, X
	bcc setweathertorain
	jmp setweathertoclear
setweathertosnow:	iny
setweathertorain:	iny
setweathertoclear:	sty weatherType

	pla		; retrieve shit
	sta random4
	pla
	sta random3
	pla
	sta random2
	pla
	sta random1
	ldy TempY
	ldx TempX

	rts

chanceOfSnow:	.db $20, $00, $20, $20	; AFC
	.db $20, $20, $10, $20
	.db $00, $00, $00, $00
	.db $20, $08, $00, $00
	.db $08, $20, $20, $00	; NFC
	.db $20, $00, $20, $00
	.db $00, $00, $00, $00
	.db $00, $00	; [pro-bowl]
	.db $00, $00, $10, $00
	
chanceOfRain:	.db $10, $20, $08, $10	; AFC
	.db $08, $08, $08, $10
	.db $00, $00, $18, $00
	.db $08, $08, $10, $10
	.db $10, $10, $10, $00	; NFC
	.db $10, $00, $08, $00
	.db $20, $00, $00, $08
	.db $00, $00	; [pro-bowl]
	.db $10, $00, $18, $00

; ----------------------------------------------------------------------------------------
;
; random number generator.
;
; in: (none)
;
; out: A=rand value
;
Sub_GetRAND:	ldx #32
_randomGen_loop:	lda random4	; random bit generator 
	rol	; written by kevtis 
	rol
	rol 
	eor random4	; this will XOR two bits together 
	rol 
	rol 
	rol	; and put the answer in bit 7 of the acc 
	rol	; this puts the answer into the carry 
	ror random1
	ror random2
	ror random3
	ror random4
	dex
	bne _randomGen_loop
	rts

; ----------------------------------------------------------------------------------------
;
;  replacement halftime screen when weather is bad.
;
Sub_HalftimeText:	lda #00		; disable Rendering/NMIs
	sta PPU_CTRL		;
	sta PPU2000		;
	sta PPU_MASK		;
	sta PPU2001		;
	sta pAPU_CTRL		; disable sound channels
	sta MusicEngine_Song		; stop any song that was playing

	lda #$FF		; init vars
	sta vramBufferPtr		;
	
	jsr Func_SetPlainFontPalette	; write palette
	
	ldx #8		; wait for some frames
	jsr Func_Poll_PPU_STATUS	;

	jsr Func_ClearSomeVram		; clear vram being used
	
	lda #$01		; swap in chr-bank
	sta MMC3_CTRL		; that has large letters
	lda #$1A		;
	sta MMC3_DATA		;
	
	lda #42		; write "HALF TIME"
	ldx >_halftime_textdata		;
	ldy <_halftime_textdata		;
	jsr Func_PushToVramBuffer	;
	jsr SubFlushVramBuffer		;

_waitToTurnOn_httDisp:	bit PPU_STATUS		; wait for vblank to enable
	bpl _waitToTurnOn_httDisp	;   rendering
	lda #%00001000		;
	sta PPU2000		;
	lda #%00011000		;
	sta PPU2001		;
	jsr Sub_TurnScreenOn		;
	
	ldx #120		; wait for some frames
	jsr Func_Poll_PPU_STATUS	;

_exit_halftimeText:	lda #00		; disable Rendering/NMIs
	sta PPU_CTRL		;
	sta PPU_MASK		;

	jsr Func_ClearSomeVram		; clear vram used
	jsr Sub_ZeroRam		; clear page #4 of ram
	lda #00		;
	jsr Func_SetPalette		; clear palette vram

	ldx #8		; wait for some frames
	jsr Func_Poll_PPU_STATUS	;

	lda #$0F		; enable sound channels
	sta pAPU_CTRL

_waitToTurnOn_httExit:	bit PPU_STATUS		; wait for vblank reset PPU_CTRL
	bpl _waitToTurnOn_httExit	;
	lda PPU2000_orig		;
	sta PPU_CTRL		;

	rts		; return to main menu


_halftime_textdata:	.db $21, $C7, $12
	.hex C8C990918400C0C10000D8D9C4C58C8DC0C1
	.db $21, $E7, $12
	.hex CACB868796AACAA40000DADBC6C78E8FC2C3
