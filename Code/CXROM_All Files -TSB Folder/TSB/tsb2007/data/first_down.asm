;======================
; To change the amount of yards needed to gain a first down edit the byte at 0x24FDF.
; The default value is 0x50 (or 80 in decimal, 8 * 10). To change to 20 yards, change
; the value to 0xA0 (160 in decimal, 8 * 20). Each yard is worth 8 "points". Therefore,
; the possible range is 0 to 32 yards. 
;
;Update #1 
; With arithmetic in mind, I found the chain markers. They are at 0x26471 and 0x2649B, 
; using the same yardage system as above. 
;
; Update #2 
; And finally, to update the text '1st and X', change the value at 0x2E495 and 0x2E4C4.
;


; --------------------------------------------------------------------------------
;
;   these replace the normal "CMP #$xx" for determining
;   if 1st down yardarge was gained.
;
;	's' = short
;	'n' = normal
;	'l' = long
;
;       yards < s	= next down
;   s < yards < n	= chains, short of first
;   n < yards < l	= chains, 1st down
;   l < yards	= automatic 1st
;

; this gets the "yards to go" for first (short)
Func_cpx_yardsFirst_s:	ldx yardsForFirstLen
	jmp _func_cpx_yff_s

; this gets the "yards to go" for first (normal)
Func_cpx_yardsFirst_n:	ldx yardsForFirstLen
	jmp _func_cpx_yff_n
	
; this gets the "yards to go" for first (long)
Func_cpx_yardsFirst_l:	ldx yardsForFirstLen
	inx
	inx
_func_cpx_yff_n:	inx
	inx
_func_cpx_yff_s:	lda $44
	cmp _short_first_yards, X
	LDA $3B	; compatibility
	LDX $44	; compatibility
	rts

; --------------------------------------------------------------------------------
;
;   this is a hook to call the short version of CheckYards.
;
Func_checkShort_yardsFirst:
	jsr Func_cpx_yardsFirst_s
	bcc _chkShrt_yff_jmp
	rts
_chkShrt_yff_jmp:	pla
	pla
	LDA $3B	; compatibility
	jmp $9003	; compatibility

; --------------------------------------------------------------------------------
; this adjust the chain markers for new first down length (P1)
Func_adc_yardsForFirst:	jsr _func_get_Yindex		;
	clc		;
	adc _first_yards, Y		;
	jmp _func_restore_Yindex	;
; this adjust the chain markers for new first down length (P2)
Func_sbc_yardsForFirst:	jsr _func_get_Yindex		;
	sec		;
	sbc _first_yards, Y		;
_func_restore_Yindex:	ldy TempY		;
	rts		;


_func_get_Yindex:	sty TempY		; save Y and get 1ST down len
	ldy yardsForFirstLen		;
	rts		;

; --------------------------------------------------------------------------------
_short_first_yards:	.db $48, $98
_first_yards:	.db $50, $A0
_long_first_yards:	.db $58, $A8