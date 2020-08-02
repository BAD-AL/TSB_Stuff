;---------------------------------SubWriteVramBuffer---------------------------------
;
;	Description:	Writes all data on the vram buffer stack to the
;		appropriate address in vram. The stack is FIFO
;		and starts at$04FF and grows down.
;
;	Arguments:	PPU2000         - $2000  settings 
;		vramBufferPtr   - stack pointer
;		VRAMBUFFER      - begining of stack page
;		writeVramBuffer - buffer ready to be written
;	Return:	(none)
;
;	Routines Called:	(none)
;	Registers Affected:	A,X,Y
;	Variables Affected:	vramBufferPtr
;
;	DataStruct:	<-+
;		  |
;		  +----byte0: VRAM addrHI
;		  +----byte1: VRAM addrLO
;		  +----byte2: Dlll llll
;		  |           |||| ||||
;		  |           |+++-++++-length of data stream
;		  |           +---------(0 = vram++, 1 = vram+32)
;		  |
;		  +----byteN: data
;
SubWriteVramBuffer:	lda writeVramBuffer
	beq _sub_dont_write_vram_buffer

SubFlushVramBuffer:	lda vramBufferPtr
	cmp #$FF
	beq _sub_exit_vrambuffer

	ldy #$FF
_sub_check_more_writes:	cpy vramBufferPtr
	bcc _sub_exit_vrambuffer
	beq _sub_exit_vrambuffer

	lda VRAMBUFFER, Y		; set the address in VRAM
	sta PPU_ADDR
	dey
	lda VRAMBUFFER, Y
	sta PPU_ADDR
	dey

	; load the data structure and write it to vram
	lda VRAMBUFFER, Y		; length of data stream
	clc
	rol		; rotate the upper bit to C flag
	bcc _sub_vram_inc_01		; if(C==0) jump to inc vram addr by 1

_sub_vram_inc_32:	ldx #%00001101		; make vram increment by 32
	jmp _sub_write_to_vram
_sub_vram_inc_01:	ldx #%00001001		; make vram increment by 1
_sub_write_to_vram:	stx PPU_CTRL
	lsr		; shift the bits back
	tax

_sub_write_vram_loop:	dey		; write all data to vram
	lda VRAMBUFFER, Y
	sta PPU_DATA
	dex
	cpx #00
	bne _sub_write_vram_loop
	dey
	jmp _sub_check_more_writes	; jump back to top of routine and
			; check for more VRAM writes in the buffer
_sub_exit_vrambuffer:	lda #00
	sta writeVramBuffer
_sub_dont_write_vram_buffer:
	ldy #$FF
	sty vramBufferPtr
	lda PPU2000		; restore the prior PPU state
	sta PPU_CTRL
	rts

;---------------------------------SubClearNameTable----------------------------------
;	Description:	Clears a name table
;
;	Arguments:	X - high byte nametable address
;		    (20xx, 24xx, 28xx, 2Cxx)
;	Return Values:	(none)
;
;	Routines Called:	(none)
;	Registers Affected:	A,X,Y
;	Variables Affected:	(none)
;
SubClearNameTable:	stx PPU_ADDR
	lda #$00
	sta PPU_ADDR

	ldy #04
	ldx #00
_sub_clrnat_loop:	sta PPU_DATA
	inx
	bne _sub_clrnat_loop
	dey
	bne _sub_clrnat_loop
	rts

;---------------------------------SubClearSpritePage----------------------------------
;	Description:	...
;
;	Arguments:	(none)
;	Return Values:	PJoypad
;
;	Routines Called:	(none)
;	Registers Affected:	A,X
;	Variables Affected:	(none)
;
SubClearSpritePage:	ldx #00
	lda #SPRITENULL
_sub_clrspr_loop:	sta SHADOW_OAM, X
	inx
	inx
	inx
	inx
	bne _sub_clrspr_loop
	rts

;---------------------------------SubControllerStrobe----------------------------------
;	Description:	First transfers PJoypad to PJoypadOld.
;		Then reads joypads 1 or 2 and stores to
;		PJoypad in this format:
;
;		7  6   5     4    3  2  1  0
;		A, B, Sel, Start, U, D, L, R
;
;	Arguments:	player_calling
;	Return Values:	PJoypad
;
;	Routines Called:	(none)
;	Registers Affected:	A,Y,X
;	Variables Affected:	PJoypad
;		PJoypadOld
;
SubControllerStrobe:	lda PJoypad		; preserve the old joypad status
	sta PJoypadOld

	ldx player_calling
	lda port_index, X
	tax

	lda #01		; these
	sta PORT1		; lines
	lda #00		; strobe the
	sta PORT1		; keypad

	sta PJoypad 		; reset the button variable

	ldy #8		; 7 buttons to load
nextbutton:	lda PORT1, X
	and #01
	lsr A
	rol PJoypad
	dey
	bne nextbutton
	rts

port_index:	.db $00, $01

; ----Sub_TurnScreenOn----
Sub_TurnScreenOn:	lda PPU_STATUS
	lda #00
	sta OAM_ADDR		; reset SPR ctrl register
	sta PPU_ADDR		; reset PPU
	sta PPU_ADDR
	lda PPU2000
	sta PPU_CTRL
	lda PPU2001
	sta PPU_MASK
	lda #00		; reset scroll
	sta PPU_SCROLL
	sta PPU_SCROLL
	rts

; ----Sub_ZeroRam---
Sub_ZeroRam:	ldy #00		; clear the ram page used for pb editor
	lda #00
_zeroRam_loop:	sta $0400, Y
	iny
	bne _zeroRam_loop
	rts

Func_ClearSomeVram:	ldx #$20		; clear NAT/OAM
	jsr SubClearNameTable		;
	jsr SubClearSpritePage		;
	lda SHADOW_PAGE		; clear sprites from screen
	sta SPR_OAM		;
	rts


; --------------------
; in:  (none)
; out: (none)
; WARNING: assumes that rendering has been disabled!
;	
Func_SetPlainFontPalette:
	lda #01
; in:  A=pal index
; out: (none)
; WARNING: assumes that rendering has been disabled!
;
Func_SetPalette:	asl
	tay
	lda _mod_paldata_ptrs, Y
	sta DataPtr
	lda _mod_paldata_ptrs + 1, Y
	sta DataPtr + 1
	lda #$3F		; write palette
	sta PPU_ADDR		;
	lda #$00		;
	sta PPU_ADDR		;
	ldy #00		;
_setPlainFontPal_loop:	lda (DataPtr), Y		;
	sta PPU_DATA		;
	iny		;
	cpy #$20		;
	bcc _setPlainFontPal_loop	;
	rts		;

_mod_paldata_ptrs:	.dw clear_pal_data, text_pal_data

clear_pal_data:	.hex 0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
	.hex 0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F
text_pal_data:	.hex 0F0000300F00002D0F0000000F000000
	.hex 0F0000300F0000000F0000000F000000

; --------------------
; in:  X=num of frames
; out: (none)
;
Func_Poll_PPU_STATUS:
_poll_ppuStatus_wait:	bit PPU_STATUS		;
	bpl _poll_ppuStatus_wait	;
	dex		;
	bne _poll_ppuStatus_wait	;
	rts		;




; --------------------
;
; in:  A=len
;      X=src addr msb
;      Y=src addr lsb
;
Func_PushToVramBuffer:	sta LoopVar
	stx DataPtr + 1
	sty DataPtr
	lda #FALSE
	sta writeVramBuffer
	ldx vramBufferPtr
	ldy #00
_loop_pushToBuffer:	lda (DataPtr), Y
	sta VRAMBUFFER, X
	dex
	iny
	dec LoopVar
	bne _loop_pushToBuffer
	stx vramBufferPtr
	rts




