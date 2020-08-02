; Roster data = 0x0077A0
;   prgbank 1 - high
;
; Mapping:	 REG     EXP
;	prg0-L  prg0-L
;	prg0-H  prg1-H

;Sub_CheckNameBank:	lda $3F	; if (MSB > #$B0)
;	cmp #$B0	;   branch for swap
;	bcs Sub_SwapExpBank	; else, proceed normally
;
;Sub_SwapOrigBank:	ldy #01
;	.db $2C	; BIT $07AC
;Sub_SwapExpBank:	ldy #03	;   (ldy #03 == AC07)
;	lda #07
;	sta MMC3_CTRL
;	sty MMC3_DATA
;	rts


;________________________________________________________________________________________________
;
; loading code
;
$D48E:A6 3E     LDX $003E = #$00	; get player index
$D490:A5 3F     LDA $003F = #$00	; get team index
$D492:0A        ASL
$D493:A8        TAY
$D494:B9 00 80  LDA $8000,Y @ $8025 = #$84	; get team pointers
$D497:85 3E     STA $003E = #$00
$D499:B9 01 80  LDA $8001,Y @ $8026 = #$B8
$D49C:85 3F     STA $003F = #$00
$D49E:8A        ;[TXA]
$D49F:0A        ;[ASL]
$D4A0:A8        ;[TAY]
	jsr Sub_CheckNameBank
$D4A1:B1 3E     LDA ($3E),Y @ $0025 = #$00	; get player pointers
$D4A3:AA        TAX
$D4A4:C8        INY
$D4A5:B1 3E     LDA ($3E),Y @ $0025 = #$00
$D4A7:48        PHA
$D4A8:C8        INY
$D4A9:B1 3E     LDA ($3E),Y @ $0025 = #$00
$D4AB:86 3E     STX $003E = #$00
$D4AD:38        SEC
$D4AE:E5 3E     SBC $003E = #$00
$D4B0:A8        TAY
$D4B1:68        PLA
$D4B2:85 3F     STA $003F = #$00
$D4B4:88        DEY
$D4B5:98        TYA
$D4B6:60        RTS

Sub_CheckNameBank:	lda $3F	; if (not expanded team)
	cmp teamindexLOW	;
	bcc _exit_checkName	;   branch to exit normally
	lda #07	; else swap bank
	sta MMC3_CTRL	;
	lda #03	;
	sta MMC3_DATA	;
_exit_checkName:	txa	; resume as normal
	asl	;
	tay	;
	rts	;


;________________________________________________________________________________________________



; ROSTER LIST
; -----------
$D520:B1 3E     LDA ($3E),Y @ $86D6 = #$05		; [*] 0x03D530
$D522:85 45     STA $0045 = #$00
$D524:20 3E D5  JSR $D53E
$D527:20 D4 D4  JSR $D4D4
SUB_D4D4:	$D4D4:A2 00     LDX #$00	; 0x03D4E4
	$D4D6:A0 01     LDY #$01
	$D4D8:8E 7F 03  STX $037F = #$00
	$D4DB:B1 3E     LDA ($3E),Y @ $86D6 = #$05	; [*]
	$D4DD:C9 20     CMP #$20
	$D4DF:F0 26     BEQ $D507
	$D4E1:C9 2E     CMP #$2E
	$D4E3:F0 1B     BEQ $D500
	$D4E5:C9 61     CMP #$61
	$D4E7:B0 10     BCS $D4F9
	$D4E9:2C 7F 03  BIT $037F = #$00
	$D4EC:30 0B     BMI $D4F9
	$D4EE:A9 20     LDA #$20
	$D4F0:9D 80 03  STA $0380,X @ $0456 = #$00
	$D4F3:E8        INX
	$D4F4:A9 FF     LDA #$FF
	$D4F6:8D 7F 03  STA $037F = #$00
	$D4F9:B1 3E     LDA ($3E),Y @ $86D6 = #$05	;  [*]
	$D4FB:29 DF     AND #$DF
	$D4FD:4C 07 D5  JMP $D507
	$D500:A9 FF     LDA #$FF
	$D502:8D 7F 03  STA $037F = #$00
	$D505:B1 3E     LDA ($3E),Y @ $86D6 = #$05	;  [*]
	$D507:9D 80 03  STA $0380,X @ $0456 = #$00
	$D50A:C8        INY
	$D50B:E8        INX
	$D50C:C6 42     DEC $0042 = #$0C
	$D50E:D0 CB     BNE $D4DB
	$D510:A9 FF     LDA #$FF
	$D512:9D 80 03  STA $0380,X @ $0456 = #$00
	$D515:8E 7F 03  STX $037F = #$00
	$D518:60        RTS

; PLAYER DATA
; -----------
$D3A4:20 B7 D4  JSR $D4B7
	$D4B7:A0 00     LDY #$00
	$D4B9:B1 3E     LDA ($3E),Y @ $86D6 = #$05	; [*]
	$D4BB:4A        LSR
	$D4BC:4A        LSR
	$D4BD:4A        LSR
	$D4BE:4A        LSR
	$D4BF:F0 03     BEQ $D4C4
	$D4C1:18        CLC
	$D4C2:69 30     ADC #$30
	$D4C4:9D 3A 03  STA $033A,X @ $036D = #$46
	$D4C7:E8        INX
	$D4C8:B1 3E     LDA ($3E),Y @ $86D6 = #$05	; [*]
	$D4CA:29 0F     AND #$0F
	$D4CC:18        CLC
	$D4CD:69 30     ADC #$30
	$D4CF:9D 3A 03  STA $033A,X @ $036D = #$46
	$D4D2:E8        INX
	$D4D3:60        RTS
...
...
...see "SUB_D4D4" from above...

; LEADER BOARDS
; -------------
$D3F2:85 41     STA $0041 = #$16		; read name, but only write
$D3F4:B1 3E     LDA ($3E),Y @ $86D8 = #$72		; last name to buffer
$D3F6:C9 41     CMP #$41		;
$D3F8:90 0C     BCC $D406		;
$D3FA:C9 5B     CMP #$5B		;
$D3FC:B0 08     BCS $D406		;
$D3FE:9D 3A 03  STA $033A,X @ $0350 = #$30		;
$D401:E8        INX			;
$D402:C6 41     DEC $0041 = #$0A		;
$D404:F0 0F     BEQ $D415		;
$D406:C8        INY			;
$D407:C6 40     DEC $0040 = #$0B		;
$D409:D0 E9     BNE $D3F4		;
$D40B:A9 00     LDA #$00		; fill rest with blanks
$D40D:9D 3A 03  STA $033A,X @ $0357 = #$C8		;
$D410:E8        INX			;
$D411:C6 41     DEC $0041 = #$03		;
$D413:D0 F8     BNE $D40D		;
