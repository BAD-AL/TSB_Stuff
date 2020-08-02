
;--------------------------------------------------------------------
;
; in:  (none)
;
; out: (none)
;
Sub_SwapTeams:	sty TempY		; preserve registers
	stx TempX		;
	
	lda #00
	sta pAPU_CTRL		; disable sound channels (fixes "bleep" sound)
	
	ldx #03		; preserve ZP vars
_preserveZPVars:	lda Data0_Ptr, X		;
	sta Temp_ZPVars, X		;
	dex		;
	bpl _preserveZPVars		;
	
	lda #0		; Copy Slot1 to Temp
	ldx #2		;
	jsr Sub_CopyData		;
	lda #1		; Copy Slot2 to Slot1
	ldx #0		;
	jsr Sub_CopyData		;
	lda #2		; Copy Temp To Slot2
	ldx #1		;
	jsr Sub_CopyData		;
	ldx $6C		; swap team numbers
	ldy $6D		;
	stx $6D		;
	sty $6C		;
	sty $6E		;
	ldx $0399		; swap scores
	ldy $039E		;
	stx $039E		;
	sty $0399		;
	lda $2D		; toggle kick/receive
	eor #%00010000		;
	sta $2D		;
	lda $6C		; change player indexes
	ldx #00		; (P1)
_loop_swapIndex_P1:	sta $6610, X		;
	inx		;
	inx		;
	cpx #$34		;
	bcc _loop_swapIndex_P1		;
	lda $6D		; (P2)
	ldx #00		;
_loop_swapIndex_P2:	sta $6644, X		;
	inx		;
	inx		;
	cpx #$34		;
	bcc _loop_swapIndex_P2		;
	ldx #07		; swap playbooks
_loop_savePB1:	lda P1_INGAME_DECOMP_PB, X	;   copy PB1->Temp
	sta Temp_TeamStorage, X		;
	dex		;
	bpl _loop_savePB1		;
	ldx #07		;   copy PB2->PB1
_loop_copyPB2toPB1:	lda P2_INGAME_DECOMP_PB, X	;
	sta P1_INGAME_DECOMP_PB, X	;
	dex		;
	bpl _loop_copyPB2toPB1		;
	ldx #07		;   copy Temp->PB2
_loop_popPB1toPB2:	lda Temp_TeamStorage, X		;
	sta P2_INGAME_DECOMP_PB, X	;
	dex		;
	bpl _loop_popPB1toPB2		;
	lda $75		; swap P1/P2 MAN, COA, COM, SKP
	and #$F0		; status
	lsr		;
	lsr		;
	lsr		;
	lsr		;
	tax		;
	lda $75		;
	and #$0F		;
	asl		;
	asl		;
	asl		;
	asl		;
	sta $75		;
	txa		;
	ora $75		;
	sta $75		;
	lda $70		; toggle possesion (P1<->P2)
	eor #%10000000		;
	sta $70		;
	ldx CurrentLOS + 1		; adjust LOS vars
	ldy CurrentLOS		;
	jsr Func_InvertYardline		;
	stx CurrentLOS + 1		;
	sty CurrentLOS		;
	ldx OriginalLOS + 1		;
	ldy OriginalLOS		;
	jsr Func_InvertYardline		;
	stx OriginalLOS + 1		;
	sty OriginalLOS		;

	ldx #03		; retrieve ZP vars
_retrieveZPVars:	lda Temp_ZPVars, X		;
	sta Data0_Ptr, X		;
	dex		;
	bpl _retrieveZPVars		;
	ldy TempY		; retrieve registers
	ldx TempX		;
	rts		;



; invert current and original LOS
;     |    <-03B0->    |
;     0628  (01D8)  09D7
;
; in:  X=Yardline MSB
;      Y=Yardline LSB
;
; out: X=Yardline MSB
;      Y=Yardline LSB


;Left: 1648 + ( YardLine * 8 ) [Then convert to hex]
;       $0670
;Right: 2448 - ( YardLine * 8 ) [Then convert to hex]
;       $0990

Func_InvertYardline:	stx TempLOS + 1		; save parameters
	sty TempLOS		;
	
	cpx #08		; if (Yardline >= #$0800)
	bcc _ydline_isOnLeft		;
_ydline_isOnRight:	sec		;   get distance from back
	lda #$D7		;   of right endzone to the
	sbc TempLOS		;   yardline
	sta TempLOS		;
	lda #$09		;
	sbc TempLOS + 1		;
	sta TempLOS + 1		;
	clc		;   add that distance to
	lda TempLOS		;   the back of the left
	adc #$28		;   endzone
	sta TempLOS		;
	lda TempLOS + 1		;
	adc #$06		;
	sta TempLOS + 1		;
	jmp _invYardline_exit		;
			; else
_ydline_isOnLeft:	sec		;   get distance from back
	lda TempLOS		;   of left endzone to the
	sbc #$28		;   yardline
	sta TempLOS		;
	lda TempLOS + 1		;
	sbc #$06		;
	sta TempLOS + 1		;
	sec		;   subtract that distance
	lda #$D7		;   from the back of the
	sbc TempLOS		;   right endzone
	sta TempLOS		;
	lda #$09		;
	sbc TempLOS + 1		;
	sta TempLOS + 1		;
	
_invYardline_exit:	ldx TempLOS + 1		; get return vars
	ldy TempLOS		;
	rts		;

;--------------------------------------------------------------------
;
; setup block transfer parameters
;
;   args:    A=source index
;            X=dest index
;
;   ret:     (none)
;
Sub_CopyData:	asl		; set source pointer
	tay		;
	lda transBlock_Ptrs, Y		;
	sta Data0_Ptr		;
	lda transBlock_Ptrs + 1, Y	;
	sta Data0_Ptr + 1		;
	txa		; set dest pointer
	asl		;
	tax		;
	lda transBlock_Ptrs, X		;
	sta Data1_Ptr		;
	lda transBlock_Ptrs + 1, X	;
	sta Data1_Ptr + 1		;
	ldx #$01		; set length parameters
	lda #$05		;
	jmp Sub_TransferDataBlock	; transfer away...

transBlock_Ptrs:	.dw Team1InGameStats, Team2InGameStats, Temp_TeamStorage

;--------------------------------------------------------------------
;
; block move code
;
;   args:   Data0_Ptr (word)  = source
;           Data1_Ptr (word)  = dest
;           X         (reg)   = len (MSB)
;           A         (reg)   = len (LSB)
;
;   ret:    (none)
;
Sub_TransferDataBlock:	pha		; save len(LSB)
	ldy #00		;
	cpx #00		; determine if a full page
	beq _exitPages_Loop		;   needs to be written
_loop_MorePages:	lda (Data0_Ptr), Y		; write all the full pages
	sta (Data1_Ptr), Y		;
	iny		;
	bne _loop_MorePages		;   loop 'til full page written
	inc Data0_Ptr + 1		;   increase to next page
	inc Data1_Ptr + 1		;
	dex		;
	bne _loop_MorePages		;   loop 'til no more pages
_exitPages_Loop:	pla		; get len (MSB)
	beq _exit_TransDatBlock		;   exit if no more data to write
	tax		; else
_loop_MoreLooseData:	lda (Data0_Ptr), Y		;   write remaining data
	sta (Data1_Ptr), Y		;
	iny		;
	dex		;
	bne _loop_MoreLooseData		;   loop
_exit_TransDatBlock:	rts		; exit function