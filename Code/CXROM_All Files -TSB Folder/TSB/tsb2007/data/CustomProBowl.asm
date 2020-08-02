
PLYR_NULL	equ $FF


DataPtr:	.dw 0
IndJmp:	.dw 0

PositionIndex:	.db 0
PlayerIndex:	.db 0
PlayerMax:	.db 0

CurPlyr_Team:	.db 0
CurPlyr_Index:	.db 0
CurPlyr_Score:	.dw 0

; ----------Math-----------
TQ:	.db 0
B:	.db 0
TLQ:	.db 0
TH:	.db 0
F:	.db 0
S:	.db 0
PH:	.db 0
FPL:	.db 0

SH:	.db 0
SL:	.db 0


; ----------Stats----------
Plyr_Stats:
RushAtt:	.db 0	; 4
RushYards:	.dw 0
RushTDs:	.db 0

RecNum:	.db 0	; 4
RecYards:	.dw 0
RecTDs:	.db 0

PassAtt:	.dw 0	; 8
PassComp:	.dw 0
PassYards:	.dw 0
PassTDs:	.db 0
PassINTs:	.db 0

KRetNum:	.db 0	; 4
KRetYards:	.dw 0
KRetTDs:	.db 0

PRetNum:	.db 0	; 4
PRetYards:	.dw 0
PRetTDs:	.db 0

D_Sacks:	.db 0	; 5
D_INTs:	.db 0
D_TDs:	.db 0
D_Yards:	.dw 0

K_XP_Att:	.db 0	; 4
K_XP_Made:	.db 0
K_FG_Att:	.db 0
K_FG_Made:	.db 0

P_PuntNo:	.db 0	; 3
P_PuntYards:	.dw 0

; ----------Player---------
PB_Plyrs:
PB0_Team:	.db 0
PB0_Plyr:	.db 0
PB0_Score:	.dw 0
PB1_Team:	.db 0
PB1_Plyr:	.db 0
PB1_Score:	.dw 0
PB2_Team:	.db 0
PB2_Plyr:	.db 0
PB2_Score:	.dw 0
PB3_Team:	.db 0
PB3_Plyr:	.db 0
PB3_Score:	.dw 0


; ----------------------------------------------------------------------------------------------------
;
Sub_GenerateProBowl:	lda #00		; start on QBs
	sta PositionIndex		;

_loop_genPB_nextPos:	asl		;   get start index and len
	tax		;   of current position
	lda _positionRange, X		;
	sta PlayerIndex		;
	clc		;
	adc _positionRange + 1, X	;
	sta PlayerMax		;
	jsr Func_ClearProBowl		;   clear pro-bowl selections (cur pos)
	lda #00		;   start at team0
	sta CurPlyr_Team		;

_loop_genPB_nextTeam:	lda PlayerIndex		;     set start of loop (player)
	sta CurPlyr_Index

_loop_genPB_nextPlyr:	lda CurPlyr_Team		;       seek to current player
	ldy CurPlyr_Index		;
	jsr Func_SeekPlayer		;
	jsr Func_ClearStats		;       clear stat vars
	lda PositionIndex		;       load stats into ram
	jsr Func_LoadPlayer		;
	lda PositionIndex		;       calculate rating
	jsr Func_CalcPlayer		;
	; save rating		;
	; update PB list		;
	inc CurPlyr_Index		;       loop all players (of
	lda CurPlyr_Index		;       current position) for
	cmp PlayerMax		;       current team
	bcc _loop_genPB_nextPlyr	;
	
	inc CurPlyr_Team		;     loop all teams for current
	lda CurPlyr_Team		;     position
	cmp #32		;
	bcc _loop_genPB_nextTeam	;
	; save pro-bowl players (cur position)	;
	
	inc PositionIndex		;   loop all positions
	lda PositionIndex		;
	cmp #10		;
	bcc _loop_genPB_nextPos		;

	rts		; exit

_positionRange:	.db $00, $02	; QBs [start] [len]	0
	.db $02, $04	; RBs	1
	.db $06, $04	; WRs	2
	.db $0A, $02	; TEs	3
	.db $0C, $05	; OL	4
	.db $11, $03	; DL	5
	.db $14, $04	; LBs	6
	.db $18, $04	; DBs	7
	.db $1C, $01	; K	8
	.db $1D, $01	; P	9
	
; ----------------------------------------------------------------------------------------------------
;
Func_ClearStats:	ldy #00		; clear out stats
	lda #00		;
_loop_clrStats:	sta Plyr_Stats, Y		;
	iny		;
	cpy #36		;
	bcc _loop_clrStats		;

Func_ClearProBowl:	ldx #04
	ldy #00
_loop_clrPB:	lda #PLYR_NULL
	sta PB_Plyrs, Y
	iny
	sta PB_Plyrs, Y
	iny
	lda #00
	sta PB_Plyrs, Y
	iny
	sta PB_Plyrs, Y
	iny
	dex
	bne _loop_clrPB


















; ----------------------------------------------------------------------------------------------------
;
; in:  A=Team
;      Y=player
;
; out: DataPtr (word)
;
Func_SeekPlayer:	asl		; get team base pointer
	tax		;
	lda _seek_SRAMPtrs, X		;
	sta DataPtr		;
	lda _seek_SRAMPtrs + 1, X	;
	sta DataPtr + 1		;
	
	lda DataPtr		; seek to current player
	clc		;
	adc _seek_PlyrOffsets, Y	;
	sta DataPtr		;
	lda DataPtr + 1		;
	adc #00		;
	sta DataPtr + 1		;

	rts		; exit

_seek_SRAMPtrs:	.dw Bills_SramPtr, Dolphins_SramPtr, Patriots_SramPtr, Jets_SramPtr
	.dw Bengals_SramPtr, Browns_SramPtr, Oilers_SramPtr, Steelers_SramPtr
	.dw Colts_SramPtr, Texans_SramPtr, Jaguars_SramPtr, Titans_SramPtr
	.dw Broncos_SramPtr, Chiefs_SramPtr, Raiders_SramPtr, Chargers_SramPtr, 
	.dw Redskins_SramPtr, Giants_SramPtr, Eagles_SramPtr, Cowboys_SramPtr
	.dw Bears_SramPtr, Lions_SramPtr, Packers_SramPtr, Vikings_SramPtr,
	.dw Buccaneers_SramPtr, Saints_SramPtr, Falcons_SramPtr, Panthers_SramPtr
	.dw SF49ers_SramPtr, Rams_SramPtr, Seahawks_SramPtr, Cardinals_SramPtr
	
	; QB=$09;  RB/WR/TE=$0C;  OL=$00;  DL/LB/DB=$03;  K=$04;  P=$03
	;   QB1  QB2  RB1  RB2  RB3  RB4  WR1  WR2  WR3  WR4  TE1  TE2
	;   OL   OL   OL   OL   OL   DL   DL   DL   LB   LB   LB   LB
	;   DB   DB   DB   DB   K    P
_seek_PlyrOffsets:	.db $00, $09, $12, $1E, $2A, $36, $42, $4E, $5A, $66, $72, $7E
	.db $8A, $8A, $8A, $8A, $8A, $8A, $8D, $90, $93, $96, $99, $9C
	.db $9F, $A2, $A5, $A8, $AB, $AF


















; ----------------------------------------------------------------------------------------------------
;
; in:  A=player type
Func_CalcPlayer:	asl		; set calc function pointer
	tax		;
	lda _calcFunc_ptrs, X		;
	sta IndJmp		;
	lda _calcFunc_ptrs + 1, X	;
	sta IndJmp		;

	lda #00		; zero out score
	sta CurPlyr_Score + 0		;
	sta CurPlyr_Score + 1		;
	
	jmp (IndJmp)		; goto calc function

_calcFunc_ptrs:	.dw Func_CalcQB, Func_CalcRB, Func_CalcWRTE


; QB    = (Comp%) + (PassYds / 2) + ((PassYds / PassAtt) * 2) + (PassTDs) - (INTs * 2) +
;	(RushYds) + (RushYds / RushAtt) + (RushTDs * 3)
Func_CalcQB:	ldx PassComp + 1		; Comp%
	ldy PassComp		;
	lda PassAtt		;
	jsr Func_16bit_Divide		;
	ldx #00	; + (msb)	;
	lda TLQ	; + (lsb)	;
	jsr Func_16bit_Addition		;
	
	ldx PassYards + 1		; (PassYds / 2)
	ldy PassYards		;
	lda #02		;
	jsr Func_16bit_Divide		;
	ldx #00	; + (msb)	;
	lda TLQ	; + (lsb)	;
	jsr Func_16bit_Addition		;
	
	ldx PassYards + 1		; ((PassYds / PassAtt) * 2)
	ldy PassYards		;
	lda PassAtt		;
	jsr Func_16bit_Divide		;
	lda TLQ		;
	ldx #02		;
	jsr Func_16bit_Multiply		;
	ldx PH	; + (msb)	;
	lda FPL	; + (lsb)	;
	jsr Func_16bit_Addition		;
	
	ldx #00	; + (msb)	; (PassTDs)
	lda PassTDs	; + (lsb)	;
	jsr Func_16bit_Addition		;
	
	lda PassINTs		; -(INTs * 2)
	ldx #02		;
	jsr Func_8bit_Multiply		;
	ldx #00	; - (msb)	;
	; A=value	; - (lsb)	;
	jsr Func_16bit_Subtraction	;
	
	ldx RushYards + 1	; + (msb)	; (RushYds)
	lda RushYards	; + (lsb)	;
	jsr Func_16bit_Addition		;
	
	ldx RushYards		; (RushYds / RushAtt)
	ldy RushYards + 1		;
	lda RushAtt		;
	jsr Func_16bit_Divide		;
	ldx #00	; + (msb)	;
	lda TLQ	; + (lsb)	;
	jsr Func_16bit_Addition		;
	
	lda RushTDs		; (RushTDs * 3)
	ldx #03		;
	jsr Func_8bit_Multiply		;
	ldx #00	; + (msb)	;
	; A=value	; + (lsb)	;
	jsr Func_16bit_Addition		;
	
	rts

; RB    = (RushYds / 2) + (RushYds / RushAtt) + (RushTDs) + (RecYds) + (RecYds / RecNo) + (RecTDs * 2) + 
;	(KYds) + (KTDs * 4) + (PYds) + (PTDs * 6)
Func_CalcRB:
	rts

; WR/TE = (RecYds / 2) + (RecYds / RecNo) + (RecTDs) + (RushYds) + (RushYds / RushAtt) + (RushTDs * 2) +
;	(KYds) + (KTDs * 4) + (PYds) + (PTDs * 6)
Func_CalcWRTE:
	rts



















; ----------------------------------------------------------------------------------------------------
;
; in:  A=player type
;
Func_LoadPlayer:	asl		; set calc function pointer
	tax		;
	lda _loadingFunc_Ptrs, X		;
	sta IndJmp		;
	lda _loadingFunc_Ptrs + 1, X	;
	sta IndJmp		;
	jmp (IndJmp)		; goto calc function

_loadingFunc_Ptrs:	.dw Func_Load_QB, Func_Load_RB_WR_TE, Func_Load_DL_LB_DB
	.dw Func_Load_K, Func_Load_P

; ----------------------------------------------------------------------------------------------------
;
; in:  DataPtr (word) = start of player stats
;
; out: (none)
;
Func_Load_QB:	ldy #00		; Pass Att (LSB)
	lda (DataPtr), Y		;   %aaaaaaaa
	sta PassAtt		;
	
	iny		; Pass Comp (LSB)
	lda (DataPtr), Y		;   %cccccccc
	sta PassComp		;
	
	iny		; Pass TDs/Pass Att (MSB)
	lda (DataPtr), Y		;   %ttttttaa
	and #%11111100		;
	lsr		;
	lsr		;
	sta PassTDs		;
	lda (DataPtr), Y		;
	and #%00000011		;
	sta PassAtt + 1		;

	iny		; INTs/Pass Comp (MSB)
	lda (DataPtr), Y		;   %iiiiiicc
	and #%11111100		;
	lsr		;
	lsr		;
	sta PassINTs		;
	lda (DataPtr), Y		;
	and #%00000011		;
	sta PassComp + 1		;

	iny		; Pass Yards (LSB)
	lda (DataPtr), Y		;   %yyyyyyyy
	sta PassYards		;
	
	iny		; Rush Att (LSB)
	lda (DataPtr), Y		;   %aaaaaaaa
	sta RushAtt		;
	
	iny		; Rush Yards (LSB)
	lda (DataPtr), Y		;   %yyyyyyyy
	sta RushYards		;
	
	iny		; Pass Yds (MSB)/Rush Yds (MSB)
	lda (DataPtr), Y		;   %..ppprrr
	and #%00111000		;
	lsr		;
	lsr		;
	lsr		;
	sta PassYards + 1		;
	lda (DataPtr), Y		;
	and #%00000111		;
	sta RushYards + 1		;
	
	iny		; Rush TDs (LSB)
	lda (DataPtr), Y		;   %tttttt..
	and #%11111100		;
	lsr		;
	lsr		;
	sta RushTDs		;

	rts		; Exit

; ----------------------------------------------------------------------------------------------------
;
; in:  DataPtr (word) = start of player stats
;
; out: (none)
;
Func_Load_RB_WR_TE:	ldy #00		; Receptions (LSB)
	lda (DataPtr), Y		;   %rrrrrrrr
	sta RecNum		;
	
	iny		; Rec Yards (LSB)
	lda (DataPtr), Y		;   %yyyyyyyy
	sta RecYards		;

	iny		; Rec TDs/PR Yards (MSB)
	lda (DataPtr), Y		;   %ttttttyy
	and #%11111100		;
	lsr		;
	lsr		;
	sta RecTDs		;
	lda (DataPtr), Y		;
	and #%00000011		;
	sta PRetYards + 1		;
	
	iny		; KR No. (LSB)
	lda (DataPtr), Y		;   %rrrrrrrr
	sta KRetNum		;

	iny		; KR Yards (LSB)
	lda (DataPtr), Y		;   %yyyyyyyy
	sta KRetYards		;
	
	iny		; KR TDs/KR Yards (MSB)
	lda (DataPtr), Y		;   %ttttttyy
	and #%11111100		;
	lsr		;
	lsr		;
	sta KRetTDs		;
	lda (DataPtr), Y		;
	and #%00000011		;
	sta KRetYards + 1		;
	
	iny		; PR No. (LSB)/Rush Yds (MSB)
	lda (DataPtr), Y		;   %rrrrrryy
	and #%11111100		;
	lsr		;     yy=bit4-3 of %3210
	lsr		;
	sta PRetNum		;
	lda (DataPtr), Y		;
	and #%00000011		;
	asl		;
	asl		;
	sta RushYards + 1		;
	
	iny		; PR Yards (LSB)
	lda (DataPtr), Y		;   %yyyyyyyy
	sta PRetYards		;
	
	iny		; PR TDs/Rec Yards (MSB)
	lda (DataPtr), Y		;   %ttttyyyy
	and #%11110000		;
	lsr		;
	lsr		;
	lsr		;
	lsr		;
	sta PRetTDs		;
	lda (DataPtr), Y		;
	and #%00001111		;
	sta RecYards + 1		;
	
	iny		; Rush Att (LSB)
	lda (DataPtr), Y		;   %aaaaaaaa
	sta RushAtt		;
	
	iny		; Rush Yards (LSB)
	lda (DataPtr), Y		;   %yyyyyyyy
	sta RushYards		;
	
	iny		; Rush TDs/Rush Yards (MSB)
	lda (DataPtr), Y		;   %ttttttyy
	and #%11111100		;
	lsr		;     yy=bit1-0 of %3210
	lsr		;
	sta RushTDs		;
	lda (DataPtr), Y		;
	and #%00000011		;
	ora RushYards + 1		;
	sta RushYards + 1		;
	
	rts		; Exit

; ----------------------------------------------------------------------------------------------------
;
; in:  DataPtr (word) = start of player stats
;
; out: (none)
;
Func_Load_DL_LB_DB:	ldy #00		; Sacks/INTs
	lda (DataPtr), Y		;   %sssssssi
	clc		;
	ror		;
	sta D_Sacks		;
	rol D_INTs		;
	
	iny		; INTs/TDs/INT Yards
	lda (DataPtr), Y		;   %iiiittty
	and #%00001111		;
	clc		;	
	ror		;
	sta D_TDs		;
	rol D_Yards + 1		;
	lda (DataPtr), Y		;
	and #%11110000		;
	clc		;
	rol		;
	rol D_INTs		;
	rol		;
	rol D_INTs		;
	rol		;
	rol D_INTs		;
	rol		;
	rol D_INTs		;
	
	iny		; INT Yards
	lda (DataPtr), Y		;
	sta D_Yards		;
	
	rts		; Exit

; ----------------------------------------------------------------------------------------------------
;
; in:  DataPtr (word) = start of player stats
;
; out: (none)
;
Func_Load_K:	ldy #00		; read in 4 stat values
_loadK_loop:	lda (DataPtr), Y		;
	sta K_XP_Att, Y		;
	iny		;
	cpy #04		;
	bcc _loadK_loop		;
	rts		; Exit

Func_Load_P:	ldy #00		; read in 3 stat values
_loadP_loop:	lda (DataPtr), Y		;
	sta P_PuntNo, Y		;
	iny		;
	cpy #03		;
	bcc _loadP_loop		;
	rts		; Exit

























; ----------------------------------------------------------------------------------------------------
;
; 8-bit / 8-bit = 8-bit quotient, 8-bit remainder (unsigned)
;   Inputs: 
;     TQ = 8-bit numerator  (A)
;     B = 8-bit denominator (X)
;   Outputs: 
;     TQ = 8-bit quotient of TQ / B 
;     accumulator = remainder of TQ / B 
;
Func_8bit_Divide:	sta TQ		; save parameters
	stx B		;

	lda #00		;
	ldx #08		;
	asl TQ		;
_8bitD_L1:	rol		;
	cmp B		;
	bcc _8bitD_L2		;
	sbc B		;
_8bitD_L2:	rol TQ		;
	dex		;
	bne _8bitD_L1		;
	rts		;

; 16-bit / 8-bit = 8-bit quotient, 8-bit remainder (unsigned)
;   Inputs: 
;     TH = bits 15 to 8 of the numerator  (X)
;     TLQ = bits 7 to 0 of the numerator  (Y)
;     B = 8-bit denominator               (A)
;   Outputs: 
;     TLQ = 8-bit quotient of T / B 
;     accumulator = remainder of T / B 
;
Func_16bit_Divide:	sta B		; save parameters
	stx TH		;
	sty TLQ		;

	lda TH		;
	ldx #08		;
	asl TLQ		;
_16bitD_L1:	rol		;
	bcs _16bitD_L2		;
	cmp B		;
	bcc _16bitD_L3		;
_16bitD_L2:	sbc B		;
	sec		; The SEC is needed when  the
_16bitD_L3:	rol TLQ		; BCS L2 branch above was taken
	dex		;
	bne _16bitD_L1		;
	rts		;


; ----------------------------------------------------------------------------------------------------
;
; 8-bit * 8-bit = 8-bit product (signed or unsigned)
;   Inputs: 
;     F = 8-bit integer (A)
;     S = 8-bit integer (X)
;   Output: 
;     accumulator = product of F * S 
;   Note: that it is not necessary to initialize the accumulator!
;
Func_8bit_Multiply:	sta F		; save parameters
	stx S		;

	ldx #08		;
_8bitM_L1:	asl		;
	asl F		;
	bcc _8bitM_L2		;
	clc		;
	adc S		;
_8bitM_L2:	dex		;
	bne _8bitM_L1		;
	rts		;



; 8-bit * 8-bit = 16-bit product (unsigned)
;   Inputs: 
;     FPL = 8-bit integer (A)
;     S = 8-bit integer   (X)
;   Output: 
;     PH = bits 15 to 8 of the product of FPL * S 
;     FPL = bits 7 to 0 of the product of FPL * S 
;
Func_16bit_Multiply:	sta FPL		; save parameters
	stx S		;

	lda #00		;
	ldx #08		;
	lsr FPL		;
_16bitM_L1:	bcc _16bitM_L2		;
	clc		;
	adc S		;
_16bitM_L2:	ror		;
	ror FPL		;
	dex		;
	bne _16bitM_L1		;
	sta PH		;
	rts		;


; ----------------------------------------------------------------------------------------------------
;
; in:  X=msb
;      A=lsb
;
; out: (none)
;
Func_16bit_Addition:	clc
	adc CurPlyr_Score
	sta CurPlyr_Score
	txa
	adc CurPlyr_Score + 1
	sta CurPlyr_Score + 1
	rts

; in:  X=msb
;      A=lsb
Func_16bit_Subtraction:	sta SL
	stx SH

	sec
	lda CurPlyr_Score
	sbc SL
	sta CurPlyr_Score
	lda CurPlyr_Score + 1
	sbc SH
	sta CurPlyr_Score + 1
	rts
	