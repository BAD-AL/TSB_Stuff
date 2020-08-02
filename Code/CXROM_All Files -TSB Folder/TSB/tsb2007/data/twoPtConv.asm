
;
; issues:	[ ] TDs scored when clock runs out at end of half don't get PAT/2PT option
;
;	[ ] failed 2pt (fumble/int rec:def) needs to return to kickoff
;

; this gets the points value for crossing the plane
; of the endzone (6 or 2)
Sub_getEzPts:	ldx twoPtStatus		; get value of "TD"
	lda EZone_pointsvalue, X	;
	JMP $9342		; add points to score
Sub_getEzPts_P2:	ldx twoPtStatus		; get value of "TD"
	lda EZone_pointsvalue, X	;
	JMP $9363		; add points to score
EZone_pointsvalue:	.db $06, $02		;	

; this gets the points value for a FG (3 or 1)
Sub_getKickPts:	ldx twoPtStatus		; get value of "FG"
	lda Kick_pointsvalue, X		;
	JSR $9342		; add points to score
	jmp _finish_KickPts		;  jmp to reset vars and exit
Sub_getKickPts_P2:	ldx twoPtStatus		; get value of "FG"
	lda Kick_pointsvalue, X		;
	JSR $9363		; add points to score
_finish_KickPts:	lda #PTS_USE6		; reset points to default values
	sta twoPtStatus		;
	rts		;
Kick_pointsvalue:	.db $03, $01		;









; determines which touchdown scene should be played (TD or 2PT)
Sub_GetCutSceneValue:	jsr Func_IsIt2PtAttempt		;
	bcc _cutScene_TD		;
_cutScene_2PT:	lda #$13		; -play "SUCCESSFUL TRY" scene
	;jmp $9332		;
	.db $2C	; bit trick	;
_cutScene_TD:	lda #$18		; -play "TOUCHDOWN" scene
	jmp $9332		;
; (same as above except for fumbles)
Sub_GetCutScene_Fumble:	jsr Func_IsIt2PtAttempt		;
	bcc _cutScene_OOB		;
_cutScene_NG:	lda #$14		; -play "NO GOOD" scene
	;jmp $9290		;
	.db $2C	; bit trick	;
_cutScene_OOB:	lda #$27		; -play "OUT OF BOUNDS" scene
	jmp $9290		;
; (same as above except for xpt/fg)
Sub_GetCutScene_XPT:	jsr Func_IsIt2PtAttempt		;
	bcc _cutScene_FG		;
_cutScene_XPT:	lda #$99		; -play "TRY FOR POINT" scene
	;jmp $9332		;
	.db $2C	; bit trick	;
_cutScene_FG:	lda #$92		; -play "FIELD GOAL" scene
	jmp $9332		;









; this determines if a 2pt conversion is possible
;   (called when endzone plane is crossed)
;
;                     these are the important addressess
;	---> $8689 [0x24699](PAT, P1)
;	     $8E11 [0x24E21](PAT, P2)
;	---> $8775 (KICKOFF, P1)	= JMP $87A1 [no stat tracking]
;	     $8EFD (KICKOFF, P2)	= JMP $8019 [no stat tracking]
;	---> $8295 (PLAY SCREEN)
;
Sub_2PtConv_P1:	lda #00		; set P1 as param
	pha		;
	lda $75		; get P1 control (MAN, COA, or COM)
	lsr		;
	lsr		;
	lsr		;
	lsr		;
	jmp Sub_2ptConversion		;   jump to continue with checking
Sub_2PtConv_P2:	lda #01		; set P2 as param
	pha		;
	lda $75		; get P2 control (MAN, COA, or COM)
	
Sub_2ptConversion:	and #$03		; if (control == COM)
	cmp #$02		;
	bcs _conv_exitToPAT		;   exit to PAT
	lda twoPtConv		; if (2pt == OFF)
	beq _conv_exitToPAT		;   exit to PAT
	lda twoPtAttempted		; if 2pt has been attempted,
	bne _conv_exitToKick		;   branch to KICKOFF
	
_conv_exitTo2PT:	lda #PTS_USE2		; --PAT or 2PT (PLAY SCREEN)--
	sta twoPtStatus		;
	lda #01		;
	sta twoPtAttempted		;
	pla		;   (clear calling player param)
	jmp $8295		;   jmp to play select screen
	
_conv_exitToKick:	lda #PTS_USE6		; ---KICKOFF----
	sta twoPtStatus		;
	;lda #00	A=0 (#PTS_USE6)	;
	sta twoPtAttempted		;
	pla		;   determine which routine to call
	cmp #00		;
	bne _conv_useP2_KO		;
_conv_useP1_KO:	JMP $87A1	;jmp $8775	;
_conv_useP2_KO:	JMP $8019	;jmp $8EFD	;
	
_conv_exitToPAT:	lda #PTS_USE6		; -----PAT------
	sta twoPtStatus		;
	;lda #00	A=0 (#PTS_USE6)	;
	sta twoPtAttempted		;
	pla		;   determine which routine to call
	cmp #00		;
	bne _conv_useP2_PAT		;
_conv_useP1_PAT:	jmp $8689		;
_conv_useP2_PAT:	jmp $8E11		;

; determine if game should goto Playchoice screen
;   or set 2Pt conversion params, then goto Playchoice
;   (called whenever play choice screen is used)
Sub_2pt_CheckReturnNorm:
	lda twoPtConv		; if (2PT == OFF)
	beq _chckRetNormExit		;   branch to playselect
	lda twoPtAttempted		; if(2PT != #1)  [able to be attempted]
	cmp #01		;
	bne _chckRetNormExit		;   exit to return normally

	inc twoPtAttempted		; else (set 2PT == ATTEMPTED)
	lda #$80		; set LOS for PAT/2PT
	sta CurrentLOS		;
	sta OriginalLOS		;
	lda $70		; determine who has possesion
	bmi _2pt_P2_LOS		;
_2pt_P1_LOS:	lda #$09		; P1 (R EZone)
	.db $2C		;     BIT $06A9 (skip "lda #$06")
_2pt_P2_LOS:	lda #$06		; P2 (L EZone)  (hex:  $A9  $06 )
	sta CurrentLOS + 1		;
	sta OriginalLOS + 1		;
	lda #$88		; center ball between hashes
	sta OriginalBallPosY		;
	lda #03		; set down = 4th
	sta $77		;
_chckRetNormExit:	JMP $8812		; goto playchoice screen
















; determine if tackle was durring a 2pt conv
;   and if so jump to kickoff. else check for
;   turnover on downs (4th) or keep drive alive
;   then return normally
;   (called whenever ball carrier is tackled)
;
; these call the tackled code when past the LOS
;
Sub_PastLOS_P1:	ldx #00		; set P1 param
	.db $2C		;   BIT trick
Sub_PastLOS_P2:	ldx #01		; set P2 Param
	stx PlayerCalling		;
	jsr Func_IsIt2PtAttempt		;
	bcc _failconv_ConvOff		;

_failconv_gotoKickoff:	lda #$14		; ???
	sta $7C		;  (for compatibility)
	lda #$54		; "NO GOOD!"
	ldx #$0F		;
	JSR $C3AF		;
	LDA #$40	; (time)	;
	JSR $CC9A		;
	lda #PTS_USE6		; clear 2pt status
	sta twoPtStatus		;
	;lda #00	A=0 (#PTS_USE6)	;
	sta twoPtAttempted		;
	ldx PlayerCalling		;
	beq _failconv_P1_Kickoff	;
_failconv_P2_Kickoff:	jmp $8EFD		;
_failconv_P1_Kickoff:	jmp $8775		;

_failconv_ConvOff:	cpx #00		; get calling player param
	bne _failconv_UseP2		;
_failconv_UseP1:	jmp $8F29		; determine TOD (P1)
_failconv_UseP2:	jmp $8F74		; determine TOD (P2)



; same as above except this is for qb sacks
;   and incomplete passes
;
Sub_CheckTOD_sack_P1:
Sub_CheckTOD_P1_incomp:	ldx #00		; set P1 param
	.db $2C		;   BIT trick
Sub_CheckTOD_sack_P2:			;
Sub_CheckTOD_P2_incomp:	ldx #01		; set P2 param
	stx PlayerCalling		;
	jsr Func_IsIt2PtAttempt		;
	bcc _failconv_ConvOff_qb	;
	jmp _failconv_gotoKickoff	; force turnover on downs (kickoff)
			;
_failconv_ConvOff_qb:	jmp $8FBC		; determine TOD, return normally

; same as above, except for interceptions
;
Sub_CheckTOD_P1_intP2:	ldx #01		; P1 int P2 (P2 to kick if int'ed)
	.db $2C		;   bit trick
Sub_CheckTOD_P2_intP1:	ldx #00		; P2 int P1 (P1 to kick if int'ed)
	stx PlayerCalling		;
	jsr Func_IsIt2PtAttempt		;
	bcc _failconv_ConvOff_int	;
	jmp _failconv_gotoKickoff	; force turnover on downs (kickoff)

_failconv_ConvOff_int:	cpx #01
	bne _failconv_int_UseP2
_failconv_int_UseP1:	jmp $9057		; P1 int P2
_failconv_int_UseP2:	jmp $9070		; P2 int P1

























; ----------------------------------------------------------------------
;
; This function determines if a 2pt conversion is being attempted.
; It sets the C flag if it is a 2pt attempt.
;
; out: P.C 0=IS NOT A 2PT ATTEMPT
;          1=IS A 2PT ATTEMPT
;
;	twoPtAttempted = {2}
Func_IsIt2PtAttempt:	lda twoPtConv		; if (2pt == OFF) then
	beq _func_isNot2ptAtt		;   branch to exit false
	lda twoPtAttempted		; if (2pt != ATTEMPTED)
	cmp #02		;   set P.C flag accordingly
	; SEC or CLC	; C already set/clear	;
	rts		; exit

;	same as above, except twoPtAttempted = {1, 2}
Func_IsIt2PtAttempt_1:	lda twoPtConv		; if (2pt == OFF) then
	beq _func_isNot2ptAtt		;   branch to exit, false
	lda twoPtAttempted		; if (2pt != ATTEMPTED) && (2pt != CAN_BE_ATTEMPTED)
	cmp #01		;   set P.C flag accordingly
	; SEC or CLC	; C already set/clear	;
	rts		; exit

_func_isNot2ptAtt:	clc		; exit false
	rts		;

