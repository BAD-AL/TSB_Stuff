off_menu_p1:	ldx #00
	LDA $E1
	jmp _off_menu_cmpVal
	; --------------------
off_menu_p2:	ldx #01
	LDA $E7

_off_menu_cmpVal:	stx player_calling
	cmp #05		; branch on playbook editor
	bcs _off_menu_pbED		;
	cmp #02		; branch on Punt kick
	beq _off_menu_CheckPunt		;
	; --------------------

_off_menu_normal:	ASL		; return as normal for options 0,1, and 4
	TAX
	rts

_off_menu_CheckPunt:	ldx twoPtAttempted		; if a 2Pt is being attempted
	cpx #02		;
	bne _off_menu_normal		;
	lda #00		; force a cancel
	jmp _off_menu_normal		;

_off_menu_pbED:	ldy #PRG15_PB_EDITOR
	jsr SubCallFunc_PRG15
	pla		; pop off old return address
	pla
	lda #$8A	; (high: #$8A)	; push new address ($8A03)
	pha
	lda #$02	; (low: #$03 - 1 = #$02)
	pha
	lda #$13	; for compatibility
	tax	;   with re-entry
	jmp $D8DD		; return to play select screen
;	this is the code that the above code
;	is copying in order to re-enter menu
;$C468:68	PLA		; A=$13
;$C469:AA	TAX
;$C46A:4C DD D8	JMP $D8DD
;	...
;	...
;$D8F6:60	RTS		; PC=$8A03






; this code is not used (used to swap PAT banks in)
;	LDX #$06	; $8000-$9000	A2 06
;	STX $8000	;	8E 00 80
;	LDY #$14	; bank9-low	A0 18
;	STY $8001	;	8C 01 80
;	INX	; $A000-$B000	E8
;	STX $8000	;	8E 00 80
;	INY	; bank9-high	C8
;	STY $8001	;	8C 01 80
