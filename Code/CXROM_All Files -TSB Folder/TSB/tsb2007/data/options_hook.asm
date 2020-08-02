

Sub_OptionsMenuHook:	LDA $E1
	cmp #04
	bcs _jumpToOptMenu

_retToMainMenu:	ASL
	rts

_jumpToOptMenu:	ldy #PRG15_OPTION_MENU
	jsr SubCallFunc_PRG15
	JSR $D28B		; return to main menu
	lda #04
	jmp $88AA