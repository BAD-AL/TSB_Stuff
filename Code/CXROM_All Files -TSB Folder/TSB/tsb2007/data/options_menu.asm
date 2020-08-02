

Sub_OptionsMenu:	lda #00		; disable Rendering/NMIs
	sta PPU_CTRL		;
	sta PPU2000		;
	sta PPU_MASK		;
	sta PPU2001		;
	sta pAPU_CTRL		; disable sound channels

	lda #$FF		; init vars
	sta vramBufferPtr		;
	lda #00		;
	sta player_calling		;

	jsr Func_SetPlainFontPalette	; write palette
	jsr Func_ClearSomeVram		; clear vram being used	
	ldx #10		; wait for 10 frames
	jsr Func_Poll_PPU_STATUS	;

	lda #122		; write bkg data
	ldx #>optmenu_screen_data	;
	ldy #<optmenu_screen_data	;
	jsr Func_PushToVramBuffer	;
	jsr Sub_UpdateOptionChoices	; write menu choices to screen
	jsr SubWriteVramBuffer		;
	lda #$43		; write att table
	ldx #>optmenu_att_data		;
	ldy #<optmenu_att_data		;
	jsr Func_PushToVramBuffer	;
	jsr SubFlushVramBuffer		;

	lda #00		; <---init cursor--->
	sta CursorY		;
	lda #$21		;
	sta CURSOR_X		;
	lda #$00		;
	sta CURSOR_T		;
	sta CURSOR_A		;

	LDA #$80		; allow writes to sram
	STA MMC3_PRGRAM_CTRL		;

_waitToTurnOn_optMenu:	bit PPU_STATUS		; wait for vblank to enable
	bpl _waitToTurnOn_optMenu	;   rendering
	lda #%00001000		;
	sta PPU2000		;
	lda #%00011000		;
	sta PPU2001		;
	jsr Sub_TurnScreenOn		;
	
opt_waitForVBlank:	jsr Sub_HandleOptKeyPress	; handle player input
	jsr Sub_UpdateOptCursor		; update menu cursor position
	bit PPU_STATUS		; wait for vblank
	bpl opt_waitForVBlank		;
	; ____VBlank code____		;
	lda PPU_STATUS		;
	jsr SubWriteVramBuffer		;   write vram buffer
	lda SHADOW_PAGE		;   dma oam page
	sta SPR_OAM		;
	jsr Sub_TurnScreenOn		;   reset ppu vars
	jsr SubControllerStrobe		;   read joypad input
	; ___________________		;
	jmp opt_waitForVBlank		;   loop

exit_optionMenu:	lda #00		; disable Rendering/NMIs
	sta PPU_CTRL		;
	sta PPU_MASK		;
	
	ldx #02		; wait for 2 frames
	jsr Func_Poll_PPU_STATUS	;

	jsr Func_ClearSomeVram		; clear vram used
	jsr Sub_ZeroRam		; clear page #4 of ram

_waitToTurnOn_OptExit:	bit PPU_STATUS		; wait for vblank reset PPU_CTRL
	bpl _waitToTurnOn_OptExit	;
	lda PPU2000_orig		;
	sta PPU_CTRL		;
	rts		; return to main menu

; 17 + 17 + 13 + 10 + 12 + 17 + 11 + 13 + 06 + 06 = 122
optmenu_screen_data:	.db $20, $84, $0E		;   17   OPTIONS (big letters)
	.hex 909194A9D8D9C4C590918C99CC9D
	.db $20, $A4, $0E		;   17
	.hex 929386ABDADBC6C792938E9B9ECF
	.db $21, $45, $0A		;   13
	.db "QTR", SPACE, "LENGTH"
	.db $21, $85, $07		;   10
	.db "WEATHER"
	.db $21, $C5, $09		;   12
	.db "PRESEASON"
	.db $22, $05, $0E		;   17
	.db "2PT", SPACE, "CONVERSION"
	.db $22, $45, $08		;   11
	.db "1ST", SPACE, "DOWN"
	.db $22, $85, $0A		;   13
	.db "DIFFICULTY"
	.db $21, $5A, $03		;   6
	.db "MIN"
	.db $22, $5A, $03		;   6
	.db "YDS"
	;----------
optmenu_att_data:	.db $23, $C0, $40
	.incbin "\data\opt_menu.att"

; --------------------
Sub_HandleOptKeyPress:	lda PJoypadOld		; get the newly pressed buttons
	eor #$FF
	and PJoypad
	sta PJoypadNewlyPressed

	lda PJoypadNewlyPressed		;     UP
	and BUTTON_UP
	cmp BUTTON_UP
	bne _optMenu_noPushUp
	dec CursorY
	bpl _exit_HandleKeyPress
	lda #$05
	jmp _exit_hKeyPress_saveY

_optMenu_noPushUp:	lda PJoypadNewlyPressed		;     DOWN
	and BUTTON_DOWN
	cmp BUTTON_DOWN
	bne _optMenu_noPushDown
	inc CursorY
	lda CursorY
	cmp #$06
	bcc _exit_HandleKeyPress
	lda #$00
_exit_hKeyPress_saveY:	sta CursorY
	jmp _exit_HandleKeyPress

_optMenu_noPushDown:

	ldx CursorY		; only "QTR LEN" (0), "WEATHER" (1), "PRESEASON" (2),
	cpx #$06		;   "2PT" (3), "1ST DOWN" (4), and "DIFFICULTY" (5)
	bcs _optMenu_Skip_LR		;   can use left or right buttons

	lda PJoypadNewlyPressed		;     LEFT
	and BUTTON_LEFT
	cmp BUTTON_LEFT
	bne _optMenu_noPushLeft
	dec opt_vars, X
	jmp _optMenu_MaskVars
_optMenu_noPushLeft:	lda PJoypadNewlyPressed		;     RIGHT
	and BUTTON_RIGHT
	cmp BUTTON_RIGHT
	bne _optMenu_noPushRight
	inc opt_vars, X
	jmp _optMenu_MaskVars

_optMenu_noPushRight:
_optMenu_Skip_LR:	lda PJoypadNewlyPressed		;     B
	and BUTTON_B
	cmp BUTTON_B
	bne _optMenu_noPushB
_optMenu_exitToMain:	pla		;         trash return address
	pla
	jmp exit_optionMenu

_optMenu_MaskVars:	lda opt_vars, X
	and optVars_mask, X
	sta opt_vars, X
	jsr func_updWeathStatus
	jsr Sub_UpdateOptionChoices
_optMenu_noPushB:
_exit_HandleKeyPress:
	lda PJoypad
	sta PJoypadOld
	rts

	;   QTR LEN, WEATHER, P WEATHER, 2PT, 1ST DOWN, DIFFICULTY
optVars_mask:	.db $03,     $01,     $03,       $01, $01,      $01

;------
; if preseason is anything except CLEAR, turn
; weather ON.
func_updWeathStatus:	cpx #01
	bne _updWeathStatus_notWEATHER
	lda weatherBool
	bne _optMenu_leavePRESEASON
	lda #WEATHER_CLEAR
	sta preseasonWeather
_optMenu_leavePRESEASON:	
	rts
_updWeathStatus_notWEATHER:
	cpx #02
	bne _updWeathStatus_notPRESEASON
	lda preseasonWeather
	beq _optMenu_leaveWEATHER
	lda #TRUE
	sta weatherBool
_optMenu_leaveWEATHER:
_updWeathStatus_notPRESEASON:
	rts




	
; ----------------------------------------
Sub_UpdateOptCursor:	ldx CursorY
	lda _opt_curCoor, X
	sta CURSOR_Y
	rts
	
_opt_curCoor:	.db $50, $60, $70, $80, $90, $A0


; ----------------------------------------
Sub_UpdateOptionChoices:	
	lda QtrLength		; write QTR LEN
	clc		;
	adc #TIME_MIN_BASE		;
	ldx #$21		;
	ldy #$57		;
	jsr _func_println_int		;

	ldx weatherBool		; write WEATHER
	lda #$21		;
	ldy #$99		;
	jsr _func_println		;
	
	ldx preseasonWeather		; write PRESEASON WEATHER
	inx		;
	inx		;
	lda #$21		;
	ldy #$D7		;
	jsr _func_println		;
	
	ldx twoPtConv		; write 2PT CONVERSION
	lda #$22		;
	ldy #$19		;
	jsr _func_println		;
	
	ldx yardsForFirstLen		; write 1ST DOWN
	lda _BCD_firstYardLen, X	;
	ldx #$22		;
	ldy #$57		;
	jsr _func_println_int		;
	
	lda cpuDifficulty		; write DIFFICULTY
	clc		;
	adc #06		;
	tax		;
	lda #$22		;
	ldy #$97		;
	jsr _func_println		;

	lda #TRUE		; set vram buffer to be
	sta writeVramBuffer		;   written next VBlank

	rts		; exit



; ----------------------------------------
; in:  X=String index
;      A=VRAM dest MSB
;      Y=VRAM dest LSB
_func_println:	pha		;#
	txa		;
	asl		;
	tax		; get data pointer
	lda _optmenu_str_ptrtbl, X	;
	sta DataPtr		;
	lda _optmenu_str_ptrtbl + 1, X	;
	sta DataPtr + 1		;
	lda _optmenu_str_ptrtbl + 2, X	; get len of str
	sec		;
	sbc DataPtr		;
	sta StrLen		;
	
	lda #FALSE		;
	sta writeVramBuffer		;
	
	ldx vramBufferPtr		;
	pla		;#write VRAM MSB
	sta VRAMBUFFER, X		;
	dex		;
	tya		; write VRAM LSB
	sta VRAMBUFFER, X		;
	dex		;
	lda StrLen		; write data len
	sta VRAMBUFFER, X		;
	dex		;
	ldy #00		; write string
_func_println_loop:	lda (DataPtr), Y		;
	iny		;
	sta VRAMBUFFER, X		;
	dex		;
	dec StrLen		;
	bne _func_println_loop		;
	stx vramBufferPtr		;

	rts		;

; ----------------------------------------
; in:  A=Integer
;      X=VRAM dest MSB
;      Y=VRAM dest LSB
_func_println_int:	pha		;#
	pha		;##
	txa		;
	pha		;###

	lda #FALSE		;
	sta writeVramBuffer		;
	
	ldx vramBufferPtr		;
	pla		;###write VRAM MSB
	sta VRAMBUFFER, X		;
	dex		;
	tya		; write VRAM LSB
	sta VRAMBUFFER, X		;
	dex		;
	lda #$02		; write VRAM length
	sta VRAMBUFFER, X		;
	dex		;
	pla		;##write integer
	lsr		;
	lsr		;
	lsr		;
	lsr		;
	ora #NUMBER_MASK		;
	sta VRAMBUFFER, X		;
	dex		;
	pla		;#
	and #$0F		;
	ora #NUMBER_MASK		;
	sta VRAMBUFFER, X		;
	dex		;
	stx vramBufferPtr		;

	rts		;



; ----------------------------------------
_optmenu_str_ptrtbl:	.dw str_OFF, str_ON
	.dw str_CLEAR, str_SNOW, str_RAIN, str_RANDOM
	.dw str_NORMAL, str_JUICED
	.dw str_END
str_OFF:	.db "OFF"
str_ON:	.db "ON", SPACE
str_CLEAR:	.db "CLEAR", SPACE
str_SNOW:	.db SPACE, "SNOW", SPACE
str_RAIN:	.db SPACE, "RAIN", SPACE
str_RANDOM:	.db "RANDOM"
str_NORMAL:	.db "NORMAL"
str_JUICED:	.db "JUICED"
str_END:	.db $FF

_BCD_firstYardLen:	.db $10, $20

