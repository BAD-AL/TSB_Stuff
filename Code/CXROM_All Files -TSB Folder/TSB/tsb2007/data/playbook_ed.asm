Sub_InGamePBeditor:	lda #00		; disable Rendering/NMIs
	sta PPU_CTRL
	sta PPU2000
	sta PPU_MASK
	sta PPU2001
	sta pAPU_CTRL		; disable sound channels
	sta MusicEngine_Song		; stop any song that was playing

	lda CURSOR_A
	sta old_CURSOR_ATT
	lda $E1
	sta old_E1

	lda #$FF
	sta vramBufferPtr

	ldx #2		; wait for some frames
	jsr Func_Poll_PPU_STATUS	;

	ldx #$24		; clear NAT/OAM
	jsr SubClearNameTable
	jsr SubClearSpritePage
	lda SHADOW_PAGE
	sta SPR_OAM
	lda #01		; swap in tiles (dir=right)
	sta MMC3_CTRL
	lda #CHR_0800_RIGHT
	sta MMC3_DATA

	lda player_calling		; write the playbook names
	jsr Sub_WritePlaybook		;   and draw RUN #1
	ldx TempPB
	jsr Sub_DrawPlayGraphic


	lda #79		; write "HALF TIME"
	ldx >pbEd_screen_data		;
	ldy <pbEd_screen_data		;
	jsr Func_PushToVramBuffer	;
	lda #67		; write att table
	ldx >pbEd_att_data		;
	ldy <pbEd_att_data		;
	jsr Func_PushToVramBuffer	;
	jsr SubFlushVramBuffer		;

	lda #00		; <---init cursor--->
	sta CursorY
	lda #$19
	sta CURSOR_X
	lda #$00
	sta CURSOR_T
	sta CURSOR_A

	LDA #$80		; enable sram writes
	STA MMC3_PRGRAM_CTRL		;

_waitToTurnOn:	bit PPU_STATUS		; wait for vblank to enable
	bpl _waitToTurnOn		;   rendering
	lda #%00001001
	sta PPU2000	
	lda #%00011000
	sta PPU2001
	jsr Sub_TurnScreenOn

waitForVBlank:	jsr Sub_HandleKeyPress
	jsr Sub_UpdateCursor
	bit PPU_STATUS		; wait for vblank
	bpl waitForVBlank
	; ____VBlank code____
	lda PPU_STATUS
	lda SHADOW_PAGE
	sta SPR_OAM
	jsr Sub_TurnScreenOn
	jsr SubControllerStrobe
	; ___________________
	jmp waitForVBlank

exit_InGamePBeditor:	lda #00		; disable Rendering/NMIs
	sta PPU_CTRL
	sta PPU_MASK

	ldx #2		; wait for some frames
	jsr Func_Poll_PPU_STATUS	;

	ldx #$24		; clear NAT/OAM
	jsr SubClearNameTable
	jsr SubClearSpritePage
	lda SHADOW_PAGE
	sta SPR_OAM

	jsr Sub_WritePBtoSRAM		; write changes to sram

	lda old_CURSOR_ATT
	sta CURSOR_A
	lda old_E1
	sta $E1
	lda #$20
	sta CURSOR_X
	lda #01		;   blank out arrow sprites
	sta CURSOR_T
	sta CURSOR2_T

	lda #$C0		; disable sram writes
	sta MMC3_PRGRAM_CTRL		;

	jsr Sub_ZeroRam
	
	lda #$0F		; enable sound channels
	sta pAPU_CTRL

_waitToTurnOn_Exit:	bit PPU_STATUS		; wait for vblank reset PPU_CTRL
	bpl _waitToTurnOn_Exit
	lda PPU2000_orig
	sta PPU_CTRL
	rts

chr_indexes:	.db CHR_0800_RIGHT, CHR_0800_LEFT

; 12 + 7 + 18 + 42 = 79 
pbEd_screen_data:	.db $24, $45, $09, "PLAY", SPACE, "BOOK"
	.db $27, $24, $04, "EXIT"
	.db $25, $02, $8F, $5C, $2A, "RUN", $2A, $5B, $00, $5C, "PASS", $2A, $5B
pbEd_box_data:	.db $25, $96, $08, $89, $86, $86, $86, $86, $86, $86, $87
	.db $26, $96, $08, $8A, $83, $83, $83, $83, $83, $83, $2D
	.db $25, $B6, $87, $82, $82, $82, $82, $82, $82, $82
	.db $25, $BD, $87, $27, $27, $27, $27, $27, $27, $27
	;----------
; 3 + 64 = 67
pbEd_att_data:	.db $27, $C0, $40
	.incbin "\data\pbEd.att"

; ----Sub_DrawPlayGraphic----
;
; args:  X=play index	
; ret:   (none)
;
;	start of designs: $9536 = 0x27546 (prg09: high)
;	start of vram dest: $21B7
;
Sub_DrawPlayGraphic:	lda #$36		; calculate address of data
	sta DataPtr
	lda #$95
	sta DataPtr + 1

_drwGrphc_addrLoop:	cpx #00
	beq _drwGrphc_addrExit
	lda DataPtr
	clc
	adc #$2A
	sta DataPtr
	lda DataPtr + 1
	adc #00
	sta DataPtr + 1
	dex
	jmp _drwGrphc_addrLoop
_drwGrphc_addrExit:

	lda #00		; init the loop and vram buffer
	sta LoopVar
	sta writeVramBuffer
_drwGrphc_moreRows:	ldx vramBufferPtr
	lda LoopVar
	asl
	tay
	lda pic_vram_addrs, Y		;   write vram adder
	sta VRAMBUFFER, X
	iny
	dex
	lda pic_vram_addrs, Y
	sta VRAMBUFFER, X
	dex
	lda #06		;   write ctrl byte
	sta VRAMBUFFER, X
	dex
	ldy #00		;   write data
_drwGrphc_dataLoop:	lda (DataPtr), Y
	iny
	sta VRAMBUFFER, X
	dex
	cpy #06
	bcc _drwGrphc_dataLoop
	inc LoopVar		;   check if loop is done (exit if is)
	lda LoopVar
	cmp #08
	bcs _drwGrphc_dataExit
	stx vramBufferPtr		;   else
	lda #01
	sta writeVramBuffer
_drwGrphc_waitVblank:	bit PPU_STATUS		;     write data next vblank
	bpl _drwGrphc_waitVblank
	jsr SubWriteVramBuffer
	jsr Sub_TurnScreenOn
	lda DataPtr		;     adjust data pointer
	clc
	adc #06
	sta DataPtr
	lda DataPtr + 1
	adc #00
	sta DataPtr + 1
	jmp _drwGrphc_moreRows		;     and loop another line
_drwGrphc_dataExit:
	rts

pic_vram_addrs:	.hex 25B725D725F72617263726572677


; ----Sub_WritePlaybook----
;
; args:  A=team (0:P1; 1:P2)
; ret:   (none)
;
Sub_WritePlaybook:	asl		; get PB address
	tax
	lda sram_pb_ptrs, X
	sta DataPtr
	lda sram_pb_ptrs + 1, X
	sta DataPtr + 1

	ldy #00		; decompress the playbook
	ldx #00
_decomp_PB_loop:	lda (DataPtr), Y	; upper nibble
	and #$F0
	jsr _func_divide8
	clc
	adc pb_offsets, X
	sta TempPB, X
	inx
	lda (DataPtr), Y	; lower nibble
	and #$0F
	clc
	adc pb_offsets, X
	sta TempPB, X
	inx
	iny
	cpy #04
	bcc _decomp_PB_loop

	ldy #00		; write names of all 8 plays
_loop_moreinit:	sty temp_Y		;   to the screen
	lda TempPB, Y
	jsr Sub_WritePlayname
	ldy temp_Y
	iny
	cpy #08
	bcc _loop_moreinit

	rts

sram_pb_ptrs:	.dw P1_INGAME_PBOOK, P2_INGAME_PBOOK
pb_offsets:	.db $00, $08, $10, $18, $20, $28, $30, $38

; ----------------------------------
; args:  A=value to shift
; ret:   A=value shifted right x4
;
_func_divide8:	lsr
	lsr
	lsr
	lsr
	rts

; ----------------------------------
; args:  A=value to shift
; ret:   A=value shifted left x4
;
_func_multiply8:	asl
	asl
	asl
	asl
	rts

; ----Sub_WritePlayname----
;
; args:  A=play index
;        Y=vram index
; ret:   (none)
;
Sub_WritePlayname:	asl		; get string data addr
	tax
	lda playname_ptrs, X
	sta DataPtr
	lda playname_ptrs + 1, X
	sta DataPtr + 1
	lda playname_ptrs + 2, X
	sec
	sbc DataPtr
	sta StrLen

	ldx vramBufferPtr
	tya
	asl
	tay
	lda str_vram_addrs, Y		; set vram addr
	sta VRAMBUFFER, X
	dex
	lda str_vram_addrs + 1, Y
	sta VRAMBUFFER, X
	dex
	lda #PLAY_LEN		; set ctrl byte
	sta VRAMBUFFER, X
	dex

	ldy #00		; write string
_wrtName_loop:	cpy StrLen
	bcs _wrtName_useSpace
	lda (DataPtr), Y		; use string data (index < len) && (index < max)
	jmp _wrtName_writeToBuffer
_wrtName_useSpace:	lda #SPACE		; use blank space (index > len) && (index < max)
_wrtName_writeToBuffer:	sta VRAMBUFFER, X
	dex
	iny
	cpy #PLAY_LEN
	bcc _wrtName_loop
	stx vramBufferPtr

	lda #01
	sta writeVramBuffer
_wrtName_waitVblank:	bit PPU_STATUS		;     write data next vblank
	bpl _wrtName_waitVblank
	jsr SubWriteVramBuffer
	jsr Sub_TurnScreenOn

	rts

str_vram_addrs:	.hex 25042544258425C426042644268426C4


; ----Sub_WritePBtoSRAM----
;
; args:  (none)
; ret:   (none)
;
Sub_WritePBtoSRAM:	lda player_calling		; get the destination address
	asl
	tax
	lda sram_pb_ptrs, X
	sta DataPtr
	lda sram_pb_ptrs + 1, X
	sta DataPtr + 1

	ldy #00		; re-compress the playbook
	ldx #00
_recomp_PB_loop:	lda TempPB, X
	and #$07
	jsr _func_multiply8
	sta TempVar
	inx
	lda TempPB, X
	and #$07
	ora TempVar
	sta (DataPtr), Y
	inx
	iny
	cpy #04
	bcc _recomp_PB_loop

	ldx player_calling		; write the uncompressed form
	lda decomp_sramAddr_off, X
	tay
	ldx #00
_wrt_decompPB_loop:	lda TempPB, X
	sta P1_INGAME_DECOMP_PB, Y
	inx
	iny
	cpx #08
	bcc _wrt_decompPB_loop

	rts

decomp_sramAddr_off:	.db $00, $08

; ----Sub_HandleKeyPress----
;
; args:  (none)
; ret:   (none)
;
Sub_HandleKeyPress:	lda PJoypadOld		; get the newly pressed buttons
	eor #$FF		;
	and PJoypad		;
	sta PJoypadNewlyPressed		;

	lda PJoypadNewlyPressed		;   UP
	and BUTTON_UP		;
	beq _noPushUp		;
	dec CursorY		;     decrease cursor index
	lda CursorY		;     adjust for underflow
	cmp #$80		;
	bcc _noUnderflow		;
	lda #08		;
_noUnderflow:	jmp _refresh_picbox		;     jump to refresh picbox
_noPushUp:

	lda PJoypadNewlyPressed		; DOWN
	and BUTTON_DOWN		;
	beq _noPushDown		;
	inc CursorY		;     increase cursor index
	lda CursorY		;     adjust for overflow
	cmp #$09		;
	bcc _noOverflow		;
	lda #00		;
_noOverflow:
_refresh_picbox:	sta CursorY		; write new picbox
	cmp #08		; if changed play slot index
	beq _no_refresh_picbox		;
	tax		;
	lda TempPB, X		;
	tax		;
	jsr Sub_DrawPlayGraphic		;   draw selected play
	jmp _check_A_button		;
_noPushDown:
_no_refresh_picbox:

	ldx CursorY		; if (play slot index >= #8)
	cpx #08		;   skip left and right buttons
	bcs _pbEd_skip_L_R		;

	lda PJoypadNewlyPressed		; LEFT
	and BUTTON_LEFT		;
	beq _noPushLeft		;
	dec TempPB, X		;   decrease play index
	jmp _refreshPlaySlot		;
_noPushLeft:

	lda PJoypadNewlyPressed		; RIGHT
	and BUTTON_RIGHT		;
	beq _noPushRight		;
	inc TempPB, X		;   increase play index

_refreshPlaySlot:	lda TempPB, X		;    keep index between 0-7
	and #$07		;
	clc		;
	adc pb_offsets, X		;    adjust for play slot
	sta TempPB, X		;    save new play index

	; A=play index
	pha		;    write new play name
	ldy CursorY		;    and picbox
	jsr Sub_WritePlayname		;
	pla		;
	tax		;
	jsr Sub_DrawPlayGraphic		;

_noPushRight:

_pbEd_skip_L_R:
_check_A_button:	lda CursorY		; A
	cmp #08		;   if(play index < #8)
	bcc _skip_A_button		;     branch to skip A button
	lda PJoypadNewlyPressed		;   if(A != PUSHED)
	and BUTTON_A		;     branch to skip A button
	beq _skip_A_button		;   else
	jmp _do_exit_menu		;     jump to exit pb editor

_skip_A_button:	lda PJoypadNewlyPressed		; B
	and BUTTON_B		;   if(B != PUSHED)
	beq _dont_exit_menu		;     exit to main pbED loop

_do_exit_menu:	pla		;   else
	pla		;     trash return address
	jmp exit_InGamePBeditor		;      exit back to gameplay

_dont_exit_menu:	lda PJoypad		; return to editor loop
	sta PJoypadOld		;
	rts		;


; ----Sub_UpdateCursor----
;
; args:  (none)
; ret:   (none)
;
Sub_UpdateCursor:	ldx CursorY
	lda cursor_coor, X
	sta CURSOR_Y
	rts
	
cursor_coor:	.db $40, $50, $60, $70, $80, $90, $A0, $B0, $C8

;--------------------------------------------------

playname_ptrs:	.dw play_00, play_01, play_02, play_03, play_04, play_05, play_06, play_07
	.dw play_08, play_09, play_10, play_11, play_12, play_13, play_14, play_15
	.dw play_16, play_17, play_18, play_19, play_20, play_21, play_22, play_23
	.dw play_24, play_25, play_26, play_27, play_28, play_29, play_30, play_31
	.dw play_32, play_33, play_34, play_35, play_36, play_37, play_38, play_39
	.dw play_40, play_41, play_42, play_43, play_44, play_45, play_46, play_47
	.dw play_48, play_49, play_50, play_51, play_52, play_53, play_54, play_55
	.dw play_56, play_57, play_58, play_59, play_60, play_61, play_62, play_63
	.dw play_eof

;	RUN #1
play_00:	.db "T", SPACE, "FAKE", SPACE, "SWEEP", SPACE, "R"
play_01:	.db "T", SPACE, "POWER", SPACE, "SWEEP", SPACE, "R"
play_02:	.db "WTE", SPACE, "OFFTACKLE", SPACE, "R"
play_03:	.db "ONESETBACK", SPACE, "L"
play_04:	.db "R", SPACE, "S", SPACE, "SWEEP", SPACE, "L"
play_05:	.db "FB", SPACE, "OFFTACKLE", SPACE, "R"
play_06:	.db "FB", SPACE, "OPEN", SPACE, "L"
play_07:	.db "TOSS", SPACE, "SWEEP", SPACE, "R"
;	RUN #2
play_08:	.db "T", SPACE, "POWER", SPACE, "DIVE"
play_09:	.db "FB", SPACE, "OFFTACKLE", SPACE, "L"
play_10:	.db "R", SPACE, "S", SPACE, "DRAW"
play_11:	.db "PITCH", SPACE, "L", SPACE, "FAKE"
play_12:	.db "ONEBACK", SPACE, "SWEEP", SPACE, "R"
play_13:	.db "WEAKSIDE", SPACE, "OPEN"
play_14:	.db "T", SPACE, "OFFTACKLE", SPACE, "R"
play_15:	.db "T", SPACE, "SWEEP", SPACE, "STRONG"
;	RUN #3
play_16:	.db "SHOTGUN", SPACE, "DRAW"
play_17:	.db "R", SPACE, "AND", SPACE, "S", SPACE, "SWEEP", SPACE, "R"
play_18:	.db "T", SPACE, "CROSS", SPACE, "RUN", SPACE, "L"
play_19:	.db "SLOT", SPACE, "OFFTACKLE"
play_20:	.db "CROSS", SPACE, "OFFTACKLE"
play_21:	.db "PITCH", SPACE, "L", SPACE, "OPEN"
play_22:	.db "WR", SPACE, "REVERSE", SPACE, "R"
play_23:	.db "WR", SPACE, "REVERSE", SPACE, "L"
;	RUN #4
play_24:	.db "R", SPACE, "AND", SPACE, "S", SPACE, "QB", SPACE, "RUN"
play_25:	.db "SHOTGUN", SPACE, "SWEEP", SPACE, "L"
play_26:	.db "R", SPACE, "AND", SPACE, "S", SPACE, "QBSNEAK"
play_27:	.db "ONESETBACK", SPACE, "DIVE"
play_28:	.db "PRO", SPACE, "T", SPACE, "DIVE"
play_29:	.db "FB", SPACE, "POWER", SPACE, "DIVE"
play_30:	.db "SHOTGUN", SPACE, "C", SPACE, "DRAW"
play_31:	.db "REVERSE", SPACE, "PITCH", SPACE, "R"
;	PASS #1
play_32:	.db "PRO", SPACE, "T", SPACE, "WAGGLE", SPACE, "L"
play_33:	.db "R", SPACE, "AND", SPACE, "S", SPACE, "FLARE", SPACE, "C"
play_34:	.db "PRO", SPACE, "T", SPACE, "WAGGLE", SPACE, "R"
play_35:	.db "ROLL", SPACE, "OUT", SPACE, "R"
play_36:	.db "ROLL", SPACE, "OUT", SPACE, "L"
play_37:	.db "T", SPACE, "PLAY", SPACE, "ACTION", SPACE, "D"
play_38:	.db "PRO", SPACE, "T", SPACE, "SCREEN", SPACE, "L"
play_39:	.db "PLAY", SPACE, "ACTION"
;	PASS #2
play_40:	.db "PWR", SPACE, "FAKE", SPACE, "Z", SPACE, "POST"
play_41:	.db "WTE", SPACE, "F", DASH, "FLICKER"
play_42:	.db "SHOTGUN", SPACE, "X", SPACE, "CURL"
play_43:	.db "R", SPACE, "AND", SPACE, "S", SPACE, "Z", SPACE, "FLY"
play_44:	.db "PRO", SPACE, "T", SPACE, "FLARE", SPACE, "D"
play_45:	.db "OFFSET", SPACE, "FLARE", SPACE, "E"
play_46:	.db "ONEBACK", SPACE, "Z", SPACE, "CROSS"
play_47:	.db "ONEBACK", SPACE, "FLARE", SPACE, "A"
;	PASS #3
play_48:	.db "T", SPACE, "FLEA", SPACE, "FLICKER"
play_49:	.db "PWR", SPACE, "FAKE", SPACE, "X", SPACE, "FLY"
play_50:	.db "SHOTGUN", SPACE, "X", SPACE, "DRIVE"
play_51:	.db "R", SPACE, "AND", SPACE, "S", SPACE, "3", DASH, "WING"
play_52:	.db "PLAYACTION", SPACE, "Z", SPACE, "IN"
play_53:	.db "FLEA", SPACE, "FLICKER"
play_54:	.db "PRO", SPACE, "T", SPACE, "FLARE", SPACE, "C"
play_55:	.db "SHOTGUN", SPACE, "3", DASH, "WING"
;	PASS #4
play_56:	.db "SHOTGUN", SPACE, "XY", SPACE, "BOMB"
play_57:	.db "R", SPACE, "AND", SPACE, "S", SPACE, "Y", SPACE, "UP"
play_58:	.db "X", SPACE, "OUT", SPACE, "AND", SPACE, "FLY"
play_59:	.db "REV", DASH, "FAKE", SPACE, "Z", SPACE, "POST"
play_60:	.db "SLOT", SPACE, "L", SPACE, "Z", SPACE, "DRIVE"
play_61:	.db "NO", SPACE, "BACK", SPACE, "X", SPACE, "DEEP"
play_62:	.db "SHOTGUN", SPACE, "Z", SPACE, "S", DASH, "IN"
play_63:	.db "REDGUN", SPACE, "Z", SPACE, "SLANT"
play_eof:	.db $FF