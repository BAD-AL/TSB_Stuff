
; NES-> CPU/PPU/CART registers
PPU_CTRL	equ $2000
PPU_MASK	equ $2001
PPU_STATUS	equ $2002
OAM_ADDR	equ $2003
PPU_SCROLL	equ $2005
PPU_ADDR	equ $2006
PPU_DATA	equ $2007
SPR_DAM	equ $4014
PORT1	equ $4016
PORT2	equ $4017
MMC3_CTRL	equ $8000
MMC3_DATA	equ $8001

; TSB variables/constants
CursorY	equ $E1
CursorX	equ $E2
PPU2000_orig	equ $31	; gameplay copy (reload when exiting)
PPU2001_orig	equ $32
SHADOW_OAM	equ $0200
SHADOW_PAGE	equ #$02
P1_INGAME_PBOOK	equ $64F8
P2_INGAME_PBOOK	equ $65FD
P1_INGAME_DECOMP_PB	equ $667E
P2_INGAME_DECOMP_PB	equ $6686
CHR_0800_LEFT	equ $1E
CHR_0800_RIGHT	equ $22

; joypad constants
BUTTON_A	equ #%10000000	; regular masks
BUTTON_B	equ #%01000000
BUTTON_SEL	equ #%00100000
BUTTON_STA	equ #%00010000
BUTTON_UP	equ #%00001000
BUTTON_DOWN	equ #%00000100
BUTTON_LEFT	equ #%00000010
BUTTON_RIGHT	equ #%00000001

; mod constants
SPRITENULL	equ $F8
VRAMBUFFER	equ $0400	; points to bottom of stack
PLAY_LEN	equ $0F	; max len of play name
SPACE	equ $00	; ascii
DASH	equ $3B	; ascii

;----------------------------------------------------------------------------------------------
	.rambank
	.org $00FC
DataPtr:	.db 0	; (word->ZP)

	.org $0200
CURSOR_Y:	.db 0
CURSOR_T:	.db 0
CURSOR_A:	.db 0
CURSOR_X:	.db 0
CURSOR2_Y:	.db 0
CURSOR2_T:	.db 0
CURSOR2_A:	.db 0
CURSOR2_X:	.db 0

	.org $0400
ram_Fx_storage:	.dw 0	; (word) temp storage for $FC/$FD
writeVramBuffer:	.db 0	; (byte) bool
vramBufferPtr:	.db 0	; (byte) points where push/pull
PPU2000:	.db 0	; (byte) mod copy of PPU_CTRL
PPU2001:	.db 0	; (byte)  "   "   "  PPU_MASK
PJoypad:	.db 0	; (byte)
PJoypadOld:	.db 0	; (byte)
PJoypadNewlyPressed:	.db 0	; (byte)
LoopVar:	.db 0	; (byte)
StrLen:	.db 0	; (byte)
temp_Y:	.db 0	; (byte)
player_calling:	.db 0	; (byte) player changing plays (0=P1, 1=P2)
old_CURSOR_ATT:	.db 0	; (byte)
old_E1:	.db 0	; (byte) temp storage for cpu ram: $E1
TempVar:	.db 0	; (byte)
TempPB:	.rs $08	; (array: $08) holds the uncompressed playbook

	.org $67AE	; $D0 per team
Bills_SramPtr:	.rs $D0
Colts_SramPtr:	.rs $D0
Dolphins_SramPtr:	.rs $D0
Patriots_SramPtr:	.rs $D0
Jets_SramPtr:	.rs $D0
Bengals_SramPtr:	.rs $D0
Browns_SramPtr:	.rs $D0
Oilers_SramPtr:	.rs $D0
Steelers_SramPtr:	.rs $D0

	.org $7002
Broncos_SramPtr:	.rs $D0
Chiefs_SramPtr:	.rs $D0
Raiders_SramPtr:	.rs $D0
Chargers_SramPtr:	.rs $D0
Seahawks_SramPtr:	.rs $D0
Redskins_SramPtr:	.rs $D0
Giants_SramPtr:	.rs $D0
Eagles_SramPtr:	.rs $D0
Cardinals_SramPtr:	.rs $D0
Cowboys_SramPtr:	.rs $D0
Bears_SramPtr:	.rs $D0
Lions_SramPtr:	.rs $D0
Packers_SramPtr:	.rs $D0
Vikings_SramPtr:	.rs $D0
Buccaneers_SramPtr:	.rs $D0
SF49ers_SramPtr:	.rs $D0
Rams_SramPtr:	.rs $D0
Saints_SramPtr:	.rs $D0
Falcons_SramPtr:	.rs $D0

;----------------------------------------------------------------------------------------------

	.prgbank 0		; insert at 0x00010 - 0x0400F

;----------------------------------------------------------------------------------------------

	.prgbank 1		; insert at 0x04010 - 0x0800F

;----------------------------------------------------------------------------------------------

	.prgbank 2		; insert at 0x08010 - 0x0C00F

;----------------------------------------------------------------------------------------------

	.prgbank 3		; insert at 0x0C010 - 0x1000F
	.low
	.org $A000

	.high
	.org $A000


	.org $B140		; insert at 0x0F150
Sub_InGamePBeditor:	lda #00		; disable Rendering/NMIs
	sta PPU_CTRL
	sta PPU2000
	sta PPU_MASK
	sta PPU2001

	lda DataPtr		; reserve a zp addr (for indirection)
	sta ram_Fx_storage		;   and save a couple things
	lda DataPtr + 1
	sta ram_Fx_storage + 1
	lda CURSOR_A
	sta old_CURSOR_ATT
	lda $E1
	sta old_E1

	lda #$FF
	sta vramBufferPtr

	ldx #02
_wait_1:	bit PPU_STATUS		;     wait for 2 frames
	bpl _wait_1
	dex
	bne _wait_1
	ldx #$24		; clear NAT/OAM
	jsr SubClearNameTable
	jsr SubClearSpritePage
	lda SHADOW_PAGE
	sta SPR_DAM
	lda #01		; swap in tiles (dir=right)
	sta MMC3_CTRL
	lda #CHR_0800_RIGHT
	sta MMC3_DATA

	lda player_calling		; write the playbook names
	jsr Sub_WritePlaybook		;   and draw RUN #1
	ldx TempPB
	jsr Sub_DrawPlayGraphic
	ldx vramBufferPtr		; write the menu to screen
	ldy #00
_loop_moremenuscreen:	lda pbEd_screen_data, Y
	sta VRAMBUFFER, X
	dex
	iny
	cpy #81
	bcc _loop_moremenuscreen
	stx vramBufferPtr
	lda #01
	sta writeVramBuffer
	jsr SubWriteVramBuffer
	lda #$27
	sta PPU_ADDR
	lda #$C0
	sta PPU_ADDR
	ldx #00
_loop_more_att:	lda pbEd_att_data, X
	sta PPU_DATA
	inx
	cpx #$40
	bcc _loop_more_att

	lda #00		; <---init cursor--->
	sta CursorY
	lda #$19
	sta CURSOR_X
	lda #$00
	sta CURSOR_T
	sta CURSOR_A

_waitToTurnOn:	bit PPU_STATUS		; wait for vblank to enable
	bpl _waitToTurnOn		;   rendering
	lda #%00001001
	sta PPU2000	
	lda #%00011000
	sta PPU2001
	jsr Sub_TurnScreenOn

waitForVBlank:	jsr Sub_HandleKeyPress
	jsr Sub_UpdateCursor
	bit PPU_STATUS		; wait for one frame
	bpl waitForVBlank
	; ____VBlank code____
	lda PPU_STATUS
	lda SHADOW_PAGE
	sta SPR_DAM
	jsr Sub_TurnScreenOn
	jsr SubControllerStrobe
	; ___________________
	jmp waitForVBlank

exit_InGamePBeditor:	lda #00		; disable Rendering/NMIs
	sta PPU_CTRL
	sta PPU_MASK

	ldx #02
_wait_2:	bit PPU_STATUS		;     wait for 2 frames
	bpl _wait_2
	dex
	bne _wait_2

	ldx #$24		; clear NAT/OAM
	jsr SubClearNameTable
	jsr SubClearSpritePage
	lda SHADOW_PAGE
	sta SPR_DAM

	jsr Sub_WritePBtoSRAM

	lda ram_Fx_storage		; restore stuff
	sta DataPtr
	lda ram_Fx_storage + 1
	sta DataPtr + 1
	lda old_CURSOR_ATT
	sta CURSOR_A
	lda old_E1
	sta $E1
	lda #$20
	sta CURSOR_X
	lda #01		;   blank out arrow sprites
	sta CURSOR_T
	sta CURSOR2_T

_waitToTurnOn_Exit:	bit PPU_STATUS		; wait for vblank reset PPU_CTRL
	bpl _waitToTurnOn_Exit
	lda PPU2000_orig
	sta PPU_CTRL
	rts

chr_indexes:	.db CHR_0800_RIGHT, CHR_0800_LEFT

; 12 + 7 + 18 + 44 = 81 
pbEd_screen_data:	.db $24, $45, $09, "PLAY", SPACE, "BOOK"
	.db $27, $24, $04, "EXIT"
	.db $25, $02, $8F, $5C, $2A, "RUN", $2A, $5B, $00, $5C, "PASS", $2A, $5B

pbEd_box_data:	.db $25, $96, $08, $89, $86, $86, $86, $86, $86, $86, $87
	.db $26, $96, $08, $8A, $83, $83, $83, $83, $83, $83, $2D
	.db $25, $B6, $87, $82, $82, $82, $82, $82, $82, $82
	.db $25, $BD, $87, $27, $27, $27, $27, $27, $27, $27

pbEd_att_data:	.incbin "pbEd.att"

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
	eor #$FF
	and PJoypad
	sta PJoypadNewlyPressed

	lda PJoypadNewlyPressed		;     UP
	and BUTTON_UP
	cmp BUTTON_UP
	bne _noPushUp
	dec CursorY
	lda CursorY
	cmp #$80
	bcc _noUnderflow
	lda #08
_noUnderflow:	jmp _refresh_picbox
_noPushUp:

	lda PJoypadNewlyPressed		;     DOWN
	and BUTTON_DOWN
	cmp BUTTON_DOWN
	bne _noPushDown
	inc CursorY
	lda CursorY
	cmp #$09
	bcc _noOverflow
	lda #00
_noOverflow:
_refresh_picbox:	sta CursorY		;         write new picbox
	cmp #08
	beq _no_refresh_picbox
	tax
	lda TempPB, X
	tax
	jsr Sub_DrawPlayGraphic
	jmp _check_A_button
_noPushDown:
_no_refresh_picbox:

	ldx CursorY
	cpx #08
	bcs _check_A_button

	lda PJoypadNewlyPressed		;     LEFT
	and BUTTON_LEFT
	cmp BUTTON_LEFT
	bne _noPushLeft
	dec TempPB, X
	jmp _refreshPlaySlot
_noPushLeft:

	lda PJoypadNewlyPressed		;     RIGHT
	and BUTTON_RIGHT
	cmp BUTTON_RIGHT
	bne _noPushRight
	inc TempPB, X

_refreshPlaySlot:	lda TempPB, X
	and #$07
	clc
	adc pb_offsets, X
	sta TempPB, X

	; A=play index
	pha		;         write new play name
	ldy CursorY		;           and picbox
	jsr Sub_WritePlayname
	pla
	tax
	jsr Sub_DrawPlayGraphic

_noPushRight:

_check_A_button:	lda CursorY		;     A
	cmp #08
	bne _skip_A_button

	lda PJoypadNewlyPressed
	and BUTTON_A
	cmp BUTTON_A
	bne _dont_exit_menu
	pla		;         trash return address
	pla
	jmp exit_InGamePBeditor

_dont_exit_menu:
_skip_A_button:	lda PJoypad
	sta PJoypadOld
	rts



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

;---------------------------------SubWriteVramBuffer---------------------------------
;
;	Description:	Writes all data on the vram buffer stack to the
;		appropriate address in vram. The stack is FIFO
;		and starts at$04FF and grows down.
;
;	Arguments:	PPU2000       - $2000  settings (zp/word)
;		vramBufferPtr - stack pointer (zp/word)
;		VRAMBUFFER    - begining of stack page (word)
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

	lda vramBufferPtr
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
;		Then reads joypad 1 or 2 and stores to
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

;--------------------------------------------------

playname_ptrs:	.dw play_00, play_01, play_02, play_03, play_04, play_05, play_06, play_07
	.dw play_08, play_09, play_10, play_11, play_12, play_13, play_14, play_15
	.dw play_16, play_17, play_18, play_19, play_20, play_21, play_22, play_23
	.dw play_24, play_25, play_26, play_27, play_28, play_29, play_30, play_31
	.dw play_32, play_33, play_34, play_35, play_36, play_37, play_38, play_39
	.dw play_40, play_41, play_42, play_43, play_44, play_45, play_46, play_47
	.dw play_48, play_49, play_50, play_51, play_52, play_53, play_54, play_55
	.dw play_56, play_57, play_58, play_59, play_60, play_61, play_62, play_63
	.dw eof

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
eof:

;----------------------------------------------------------------------------------------------

	.prgbank 4		; insert at 0x10010 - 0x1400F

;----------------------------------------------------------------------------------------------

	.prgbank 5		; insert at 0x14010 - 0x1800F

;----------------------------------------------------------------------------------------------

	.prgbank 6		; insert at 0x18010 - 0x1C00F
	.low
	.org $A000


; [SavData] pointers for regular teams (this is duplicated in the $DFxx page of prg15)
	.org $ACAC		; insert at 0x18CBC
SramPtrs_1:	.dw Bills_SramPtr, Colts_SramPtr, Dolphins_SramPtr, Patriots_SramPtr, Jets_SramPtr
	.dw Bengals_SramPtr, Browns_SramPtr, Oilers_SramPtr, Steelers_SramPtr
	.dw Broncos_SramPtr, Chiefs_SramPtr, Raiders_SramPtr, Chargers_SramPtr, Seahawks_SramPtr
	.dw Redskins_SramPtr, Giants_SramPtr, Eagles_SramPtr, Cardinals_SramPtr, Cowboys_SramPtr
	.dw Bears_SramPtr, Lions_SramPtr, Packers_SramPtr, Vikings_SramPtr, Buccaneers_SramPtr
	.dw SF49ers_SramPtr, Rams_SramPtr, Saints_SramPtr, Falcons_SramPtr


	.high
	.org $A000

;----------------------------------------------------------------------------------------------

	.prgbank 7		; insert at 0x1C010 - 0x2000F
	.low
	.org $A000


	.high
	.org $A000		; insert at 0x1F920

; adjust some pointers for the offense
; drop-down menu on the play select screen
	.org $B498		; insert at 0x1F4A8
	.dw off_dropdown_menu

	.org $B4BA		; insert at 0x1F4CA
	.dw off_dropdown_menu


; this is the new drop-down menu for offense
	.org $B910
off_dropdown_menu:	.hex 0108E4870D0109FEA1010C8B00010EFE
	.hex A10D0C2043414E43454C202020200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C2054494D454F55542020200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C2050554E54204B49434B200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C204649454C4420474F414C0EFE
	.hex A1010C8B00010EFE
	.hex A10D0C204348414E
	.hex 4745202020200EFE
	.hex A1010C8B00010EFE
	.hex A10D0C20504C4159424F4F4B20200EFE
	.hex A1010A8B0F010BFF

;----------------------------------------------------------------------------------------------

	.prgbank 8		; insert at 0x20010 - 0x2400F

;----------------------------------------------------------------------------------------------

	.prgbank 9		; insert at 0x24010 - 0x2800F
	.low
	.org $8000


	.high

; init cursor coordinates for offense menu (P1)
	.org $897D		; insert at 0x2698D
	LDY <offense_menu_coor_p1
	LDX >offense_menu_coor_p1
	LDA #$00
	JSR $D68A



; P1 chose an option from the drop-down offense menu
	.org $899E
	jsr off_menu_p1
	LDA $89AC, X
	PHA
	LDA $89AB, X
	PHA
	RTS

; init cursor coordinates for offense menu (P2)
	.org $8C23
	LDY <offense_menu_coor_p2
	LDX >offense_menu_coor_p2
	LDA #$01
	JSR $D68A

; P2 chose an option from the drop-down offense menu
	.org $8C4D
	jsr off_menu_p2
	LDA $8C5B, X
	PHA
	LDA $8C5A, X
	PHA
	RTS

; this sets the parameters for copying a portion of a
; nametable to sram in order to write it back to vram
; at a later time. (P1 offense)
	.org $8F14
	LDA #$A3		; set vram source
	STA $3E
	LDA #$20
	STA $3F
	LDA #$03		; set sram dest
	STA $40
	LDA #$60
	STA $41
	LDX #$0E		; width
	LDY #$0E		; height
	JSR $D2F1		; copy(src, dest, w, h)

; same as above. (P2 offense)
	.org $9066
	LDA #$B1
	STA $3E
	LDA #$20
	STA $3F
	LDA #$03
	STA $40
	LDA #$62
	STA $41
	LDX #$0E
	LDY #$0E
	JSR $D2F1


	.org $9FB6		; insert at 0x27FC6
offense_menu_coor_p1:	.db $00, $00, $20, $06, $38, $48, $58, $68, $78, $88
offense_menu_coor_p2:	.db $00, $00, $90, $06, $38, $48, $58, $68, $78, $88

;----------------------------------------------------------------------------------------------

	.prgbank 10		; insert at 0x28010 - 0x2C00F

;----------------------------------------------------------------------------------------------

	.prgbank 11		; insert at 0x2C010 - 0x3000F

;----------------------------------------------------------------------------------------------

	.prgbank 12		; insert at 0x30010 - 0x3400F

;----------------------------------------------------------------------------------------------

	.prgbank 13		; insert at 0x34010 - 0x3800F

;----------------------------------------------------------------------------------------------

	.prgbank 14		; insert at 0x38010 - 0x3C00F

;----------------------------------------------------------------------------------------------

	.prgbank 15		; insert at 0x3C010 - 0x4000F



	; [SavData] pointers to data in sram (this is duplicated in the $ACxx page of prg6)
	.org $DF17
SramPtrs_2:	.dw Bills_SramPtr, Colts_SramPtr, Dolphins_SramPtr, Patriots_SramPtr, Jets_SramPtr
	.dw Bengals_SramPtr, Browns_SramPtr, Oilers_SramPtr, Steelers_SramPtr
	.dw Broncos_SramPtr, Chiefs_SramPtr, Raiders_SramPtr, Chargers_SramPtr, Seahawks_SramPtr
	.dw Redskins_SramPtr, Giants_SramPtr, Eagles_SramPtr, Cardinals_SramPtr, Cowboys_SramPtr
	.dw Bears_SramPtr, Lions_SramPtr, Packers_SramPtr, Vikings_SramPtr, Buccaneers_SramPtr
	.dw SF49ers_SramPtr, Rams_SramPtr, Saints_SramPtr, Falcons_SramPtr


	.org $FF80
off_menu_p1:	lda #00
	sta player_calling
	LDA $E1
	jmp _off_menu_cmpVal
	; --------------------
off_menu_p2:	lda #01
	sta player_calling
	LDA $E7
_off_menu_cmpVal:	cmp #05
	bcs _off_menu_pbED
	; --------------------

_off_menu_normal:	ASL		; return as normal for options 0 to 4
	TAX
	rts

_off_menu_pbED:	lda #$07
	sta MMC3_CTRL
	lda #$07
	sta MMC3_DATA

	jsr Sub_InGamePBeditor

	lda #07
	sta MMC3_CTRL
	lda #15
	sta MMC3_DATA

	ldy #00		; clear the ram page used for pb editor
	lda #00
_zeroRam_loop:	sta $0400, Y
	iny
	bne _zeroRam_loop

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