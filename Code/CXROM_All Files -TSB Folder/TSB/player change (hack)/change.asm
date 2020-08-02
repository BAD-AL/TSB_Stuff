; JN6502A.JN6502A $File $BaseName.nes -patch !-tsb.nes


BUTTON_RELOAD equ #10
BUTTON_MAX equ #11

TempA equ $7FF0
TempX equ $7FF1
TempY equ $7FF2
Temp0044 equ $7FF3
ButtonTimer equ $7FF4

MMC3_CTRL equ $8000
MMC3_DATA equ $8001

SubIncPlayerIndex equ $9497
SubUnknownFunc equ $951B


P1_PlayPicked	equ #$78
P2_PlayPicked	equ #$79

;
; this code causes a fumble
;
;$86DA:A0 01     LDY #$01
;$86DC:B1 AE     LDA ($AE),Y @ $0546 = #$81
;$86DE:29 DF     AND #$DF
;$86E0:91 AE     STA ($AE),Y @ $0546 = #$81
;$86E2:20 47 BA  JSR $BA47
;	$BA47:A5 72     LDA $0072 = #$00
;	$BA49:09 10     ORA #$10
;	$BA4B:85 72     STA $0072 = #$00
;	$BA4D:A9 16     LDA #$16
;	$BA4F:85 1A     STA $001A = #$16
;	$BA51:A0 0E     LDY #$0E
;	$BA53:A9 90     LDA #$90
;	$BA55:A2 16     LDX #$16
;	$BA57:20 45 CC  JSR $CC45
;		$CC45:94 02     STY $02,X @ $0018 = #$5D
;		$CC47:95 03     STA $03,X @ $0019 = #$16
;		$CC49:A9 14     LDA #$14
;		$CC4B:95 00     STA $00,X @ $0016 = #$00
;		$CC4D:4C E2 CC  JMP $CCE2
;		...             ...
;		$CCE2:8A        TXA
;		$CCE3:45 64     EOR $0064 = #$00
;		$CCE5:29 3F     AND #$3F
;		$CCE7:D0 06     BNE $CCEF
;		$CCE9:A5 64     LDA $0064 = #$00
;		$CCEB:29 40     AND #$40
;		$CCED:85 64     STA $0064 = #$00
;		$CCEF:8A        TXA
;		$CCF0:4D 7E 03  EOR $037E = #$00
;		$CCF3:29 3F     AND #$3F
;		$CCF5:D0 04     BNE $CCFB
;		$CCF7:A9 00     LDA #$00
;		$CCF9:85 64     STA $0064 = #$00
;		$CCFB:60        RTS
;	$BA5A:60        RTS
;$86E5:4C A6 85  JMP $85A6
;...             ...
;$85A6:20 23 B1  JSR $B123
;	$B123:A0 05     LDY #$05
;	$B125:A9 00     LDA #$00
;	$B127:91 AE     STA ($AE),Y @ $054D = #$00
;	$B129:A0 00     LDY #$00
;	$B12B:B1 AE     LDA ($AE),Y @ $054D = #$00
;	$B12D:29 DF     AND #$DF
;	$B12F:09 10     ORA #$10
;	$B131:91 AE     STA ($AE),Y @ $054D = #$00
;	$B133:4C 03 B8  JMP $B803
;	...             ...
;	$B803:A9 00     LDA #$00
;	$B805:A0 18     LDY #$18
;	$B807:91 AE     STA ($AE),Y @ $053F = #$50
;	$B809:C8        INY
;	$B80A:91 AE     STA ($AE),Y @ $053F = #$50
;	$B80C:C8        INY
;	$B80D:91 AE     STA ($AE),Y @ $053F = #$50
;	$B80F:C8        INY
;	$B810:91 AE     STA ($AE),Y @ $053F = #$50
;	$B812:A0 01     LDY #$01
;	$B814:B1 AE     LDA ($AE),Y @ $053F = #$50
;	$B816:29 7F     AND #$7F
;	$B818:91 AE     STA ($AE),Y @ $053F = #$50
;	$B81A:60        RTS
;$85A9:A0 1C     LDY #$1C
;$85AB:A2 BB     LDX #$BB
;$85AD:20 57 B6  JSR $B657
;	$B657:84 B2     STY $00B2 = #$40
;	$B659:86 B3     STX $00B3 = #$BA
;	$B65B:A0 0E     LDY #$0E
;	$B65D:B1 AE     LDA ($AE),Y @ $055B = #$10
;	$B65F:18        CLC
;	$B660:69 10     ADC #$10
;	$B662:4A        LSR
;	$B663:4A        LSR
;	$B664:4A        LSR
;	$B665:29 3C     AND #$3C
;	$B667:4C A4 B6  JMP $B6A4
;	...             ...
;	$B6A4:18        CLC
;	$B6A5:65 B2     ADC $00B2 = #$1C
;	$B6A7:85 B2     STA $00B2 = #$1C
;	$B6A9:A5 B3     LDA $00B3 = #$BB
;	$B6AB:69 00     ADC #$00
;	$B6AD:85 B3     STA $00B3 = #$BB
;	$B6AF:A0 03     LDY #$03
;	$B6B1:B1 B2     LDA ($B2),Y @ $BB2A = #$67
;	$B6B3:A8        TAY
;	$B6B4:29 78     AND #$78
;	$B6B6:4A        LSR
;	$B6B7:4A        LSR
;	$B6B8:AA        TAX
;	$B6B9:BD 7F BA  LDA $BA7F,X @ $BB3A = #$C5
;	$B6BC:F0 0C     BEQ $B6CA
;	$B6BE:85 4C     STA $004C = #$09
;	$B6C0:A5 71     LDA $0071 = #$0C
;	$B6C2:29 04     AND #$04
;	$B6C4:D0 04     BNE $B6CA

;----------------------------------------------------------------------------------------------

	.prgbank 0		; insert at 0x00010 - 0x0400F

;----------------------------------------------------------------------------------------------

	.prgbank 1		; insert at 0x04010 - 0x0800F

;----------------------------------------------------------------------------------------------

	.prgbank 2		; insert at 0x08010 - 0x0C00F

;----------------------------------------------------------------------------------------------

	.prgbank 3		; insert at 0x0C010 - 0x1000F

;----------------------------------------------------------------------------------------------

	.prgbank 4		; insert at 0x10010 - 0x1400F

;----------------------------------------------------------------------------------------------

	.prgbank 5		; insert at 0x14010 - 0x1800F

;----------------------------------------------------------------------------------------------

	.prgbank 6		; insert at 0x18010 - 0x1C00F

;----------------------------------------------------------------------------------------------

	.prgbank 7		; insert at 0x1C010 - 0x2000F

;----------------------------------------------------------------------------------------------

	.prgbank 8		; insert at 0x20010 - 0x2400F

;----------------------------------------------------------------------------------------------

	.prgbank 9		; insert at 0x24010 - 0x2800F

;
; this code writes the defense pointers to player objects in ram
;$9661:A6 79     LDX $0079 = #$07	; get P2_PlayPicked
;$9663:BD 86 66  LDA $6686,X @ $6694 = #$00	; ???
;$9666:A2 18     LDX #$18
;$9668:20 A0 D7  JSR $D7A0	; multiply number by 24
;$966B:A5 44     LDA $0044 = #$F0	; adjust pointer to be in correct address range
;$966D:18        CLC
;$966E:69 00     ADC #$00
;$9670:85 44     STA $0044 = #$F0
;$9672:A5 45     LDA $0045 = #$BD
;$9674:69 B4     ADC #$B4
;$9676:85 45     STA $0045 = #$BD
;$9678:A2 0E     LDX #$0E	; jump to bank swapping code
;$967A:20 E3 D8  JSR $D8E3
$967D:A5 78     LDA $0078 = #$00	; get P1_PlayPicked
$967F:18        CLC
$9680:69 10     ADC #$10
$9682:A8        TAY
$9683:B1 44     LDA ($44),Y @ $BDF7 = #$22
$9685:85 7A     STA $007A = #$4E
$9687:A0 0F     LDY #$0F
$9689:B1 44     LDA ($44),Y @ $BDF7 = #$22
$968B:AA        TAX
$968C:20 DE 96  JSR $96DE
$968F:A9 00     LDA #$00                   A:07 X:13 Y:0A P:nvUBdizc
$9691:85 45     STA $0045 = #$A1           A:00 X:13 Y:0A P:nvUBdiZc
$9693:A4 79     LDY $0079 = #$07           A:00 X:13 Y:0A P:nvUBdiZc
$9695:B9 86 66  LDA $6686,Y @ $668D = #$3E A:00 X:13 Y:07 P:nvUBdizc
$9698:0A        ASL                        A:3E X:13 Y:07 P:nvUBdizc
$9699:26 45     ROL $0045 = #$00           A:7C X:13 Y:07 P:nvUBdizc
$969B:0A        ASL
$969C:26 45     ROL $0045 = #$00           A:F8 X:13 Y:07 P:NvUBdizc
$969E:0A        ASL                        A:F8 X:13 Y:07 P:nvUBdiZc
$969F:26 45     ROL $0045 = #$00           A:F0 X:13 Y:07 P:NvUBdizC
$96A1:18        CLC                        A:F0 X:13 Y:07 P:nvUBdizc
$96A2:69 00     ADC #$00                   A:F0 X:13 Y:07 P:nvUBdizc
$96A4:85 44     STA $0044 = #$4A           A:F0 X:13 Y:07 P:NvUBdizc
$96A6:A5 45     LDA $0045 = #$01           A:F0 X:13 Y:07 P:NvUBdizc
$96A8:69 BC     ADC #$BC                   A:01 X:13 Y:07 P:nvUBdizc
$96AA:85 45     STA $0045 = #$01           A:BD X:13 Y:07 P:NvUBdizc
$96AC:A2 0E     LDX #$0E                   A:BD X:13 Y:07 P:NvUBdizc
$96AE:20 E3 D8  JSR $D8E3
;$96B1:A4 78     LDY $0078 = #$07           A:07 X:0E Y:00 P:nvUBdizc
;$96B3:B1 44     LDA ($44),Y @ $BC3F = #$6C A:07 X:0E Y:07 P:nvUBdizc
;$96B5:AA        TAX                        A:6C X:0E Y:07 P:nvUBdizc
;$96B6:20 00 97  JSR $9700                  A:6C X:6C Y:07 P:nvUBdizc
;---------------------------------
$96DE:A9 FF     LDA #$FF
$96E0:85 AE     STA $00AE = #$5F
$96E2:A9 04     LDA #$04
$96E4:85 AF     STA $00AF = #$06
$96E6:A9 16     LDA #$16
$96E8:20 A0 D7  JSR $D7A0
$96EB:A5 44     LDA $0044 = #$F0
$96ED:18        CLC
$96EE:69 00     ADC #$00
$96F0:85 44     STA $0044 = #$F0
$96F2:A5 45     LDA $0045 = #$BD
$96F4:69 A0     ADC #$A0
$96F6:85 45     STA $0045 = #$BD
$96F8:A2 02     LDX #$02
$96FA:20 E3 D8  JSR $D8E3
$96FD:4C 2A 97  JMP $972A
;---------------------------------




;$9700:A9 9F     LDA #$9F                   A:6C X:6C Y:07 P:nvUBdizc
;$9702:85 AE     STA $00AE = #$5F           A:9F X:6C Y:07 P:NvUBdizc
;$9704:A9 03     LDA #$03                   A:9F X:6C Y:07 P:NvUBdizc
;$9706:85 AF     STA $00AF = #$06           A:03 X:6C Y:07 P:nvUBdizc
;$9708:4C 13 97  JMP $9713                  A:03 X:6C Y:07 P:nvUBdizc
;
;$9713:A9 16     LDA #$16
;$9715:20 A0 D7  JSR $D7A0
;$9718:A5 44     LDA $0044 = #$48
;$971A:18        CLC
;$971B:69 00     ADC #$00
;$971D:85 44     STA $0044 = #$48
;$971F:A5 45     LDA $0045 = #$A9
;$9721:69 A0     ADC #$A0
;$9723:85 45     STA $0045 = #$A9
;$9725:A2 03     LDX #$03
;$9727:20 E3 D8  JSR $D8E3

;$972A:A2 0B     LDX #$0B
;$972C:A0 00     LDY #$00
;$972E:B1 44     LDA ($44),Y @ $A951 = #$A7
;$9730:A0 09     LDY #$09
;$9732:91 AE     STA ($AE),Y @ $03A8 = #$00
;$9734:A0 01     LDY #$01
;$9736:B1 44     LDA ($44),Y @ $A951 = #$A7
;$9738:A0 0A     LDY #$0A
;$973A:91 AE     STA ($AE),Y @ $03A8 = #$00
;$973C:A5 44     LDA $0044 = #$48
;$973E:18        CLC
;$973F:69 02     ADC #$02
;$9741:85 44     STA $0044 = #$48
;$9743:A5 45     LDA $0045 = #$A9
;$9745:69 00     ADC #$00
;$9747:85 45     STA $0045 = #$A9
;$9749:A5 AE     LDA $00AE = #$9F
;$974B:18        CLC
;$974C:69 20     ADC #$20
;$974E:85 AE     STA $00AE = #$9F
;$9750:A5 AF     LDA $00AF = #$03
;$9752:69 00     ADC #$00
;$9754:85 AF     STA $00AF = #$03
;$9756:CA        DEX
;$9757:D0 D3     BNE $972C
;$9759:A2 13     LDX #$13
;$975B:20 E3 D8  JSR $D8E3
;$975E:60        RTS




;----------------------------------------------------------------------------------------------

	.prgbank 10		; insert at 0x28010 - 0x2C00F

; this code handles button presses durring gameplay
	.org $A114	; 0x02A124
;$A114:20 FC A0  JSR $A0FC   	; get either p1 or p2 button status
	jsr SubAllowDefenseChange
;$A117:29 0F     AND #$0F	; this part masks out the uneeded buttons
;$A119:A0 1F     LDY #$1F
;$A11B:D1 AE     CMP ($AE),Y @ $03A7 = #$00
;$A11D:F0 27     BEQ $A146
;$A11F:91 AE     STA ($AE),Y @ $03A7 = #$00
;$A121:AA        TAX
;$A122:F0 0C     BEQ $A130
;$A124:BD 33 AF  LDA $AF33,X @ $AF3C = #$60
;$A127:20 8B B9  JSR $B98B
;$A12A:20 1B B8  JSR $B81B
;$A12D:4C 38 B6  JMP $B638
;$A130:A0 01     LDY #$01
;$A132:B1 AE     LDA ($AE),Y @ $03A7 = #$00
;$A134:29 20     AND #$20
;$A136:F0 0B     BEQ $A143
;$A138:A5 70     LDA $0070 = #$C3
;$A13A:49 FF     EOR #$FF
;$A13C:0A        ASL
;$A13D:29 80     AND #$80
;$A13F:A0 0E     LDY #$0E
;$A141:91 AE     STA ($AE),Y @ $03A7 = #$00
;$A143:4C FD B7  JMP $B7FD
;$A146:60        RTS

	.org $B123	; 0x02B133

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

;
; this sub multiplies two bytes and returns a word
;
;    args: A=multiplier
;          X=multiplicand
;
;    ret:  $44=quotient (low)
;          $45=quotient (high)
;
Sub_prg15_multiply:
;$D7A0:85 45     STA $0045 = #$A9
;$D7A2:A9 00     LDA #$00
;$D7A4:85 44     STA $0044 = #$48
;$D7A6:A0 08     LDY #$08
;$D7A8:06 44     ASL $0044 = #$48
;$D7AA:26 45     ROL $0045 = #$A9
;$D7AC:90 0C     BCC $D7BA
;$D7AE:8A        TXA
;$D7AF:18        CLC
;$D7B0:65 44     ADC $0044 = #$48
;$D7B2:85 44     STA $0044 = #$48
;$D7B4:A5 45     LDA $0045 = #$A9
;$D7B6:69 00     ADC #$00
;$D7B8:85 45     STA $0045 = #$A9
;$D7BA:88        DEY
;$D7BB:D0 EB     BNE $D7A8
;$D7BD:60        RTS

;
; this sub is bank switching code for PRG @ $A000
;
;     args: X=bank index
;
;     ret:  (none)
;
;$D8E3:86 2F     STX $2F	; save PRG @ $A000 index
;$D8E5:A9 07     LDA #$07                  	; set $A000 to be swap on next write
;$D8E7:05 33     ORA $33	;
;$D8E9:85 34     STA $34	;     save
;$D8EB:38        SEC                        A:07 X:13 Y:0A P:nvUBdizc
;$D8EC:66 2C     ROR $002C = #$55           A:07 X:13 Y:0A P:nvUBdizC
;$D8EE:8D 00 80  STA $8000 = #$4C           A:07 X:13 Y:0A P:NvUBdizC
;$D8F1:8E 01 80  STX $8001 = #$06           A:07 X:13 Y:0A P:NvUBdizC
;$D8F4:46 2C     LSR $002C = #$AA           A:07 X:13 Y:0A P:NvUBdizC
;$D8F6:60        RTS

	.org $FE20

; this is my routine to allow defensive player changing
; with the select button after the snap
SubAllowDefenseChange:	lda ButtonTimer	; if (timer==0) or (timer==INVALID)
	beq _reset_timer
	cmp BUTTON_MAX
	bcs _reset_timer	;     branch to reload
	jmp defchng_ret_reg	; else exit

_reset_timer:	lda BUTTON_RELOAD	; reload timer
	sta ButtonTimer

	JSR $A0FC	; determine if player pressed select
	and #$20
	cmp #$20
	beq _pushed_select	;     branch if true
	jmp defchng_ret_reg	; else exit

_pushed_select:	sty TempY	; switch players
	stx TempX
	lda $45
	sta TempA
	lda $44
	sta Temp0044

	lda #06		; swap banks
	sta MMC3_CTRL
	lda #18
	sta MMC3_DATA
	lda #07
	sta MMC3_CTRL
	lda #19
	sta MMC3_DATA

	lda $88		; cycle to next player
	sec
	sbc #$0B
	sta $45
	jsr SubIncPlayerIndex

	lda #06		; swap banks back
	sta MMC3_CTRL
	lda #20
	sta MMC3_DATA
	lda #07
	sta MMC3_CTRL
	lda #21
	sta MMC3_DATA

	lda $88		; compatibility code
	and #$1F
	sta $88

	lda $84		; switch control to new player
	sta $AE
	lda $85
	sta $AF
	JSR $B123
	LDY #$1C
	LDX #$BB
	JSR $B657

	lda TempA
	sta $45
	lda Temp0044
	sta $44
	ldy TempY
	ldx TempX

	lda #00		; clear buttons
	rts

defchng_ret_reg:	dec ButtonTimer
	JSR $A0FC
	rts	; didn't press select so resume as normal

;----------------------------------------------------------------------------------------------

	.chrbank 0		; insert at 0x40010 - 0x4200F

;----------------------------------------------------------------------------------------------

	.chrbank 1		; insert at 0x42010 - 0x4400F

;----------------------------------------------------------------------------------------------

	.chrbank 2		; insert at 0x44010 - 0x4600F

;----------------------------------------------------------------------------------------------

	.chrbank 3		; insert at 0x46010 - 0x4800F

;----------------------------------------------------------------------------------------------

	.chrbank 4		; insert at 0x48010 - 0x4A00F

;----------------------------------------------------------------------------------------------

	.chrbank 5		; insert at 0x4A010 - 0x4C00F

;----------------------------------------------------------------------------------------------

	.chrbank 6		; insert at 0x4C010 - 0x4E00F

;----------------------------------------------------------------------------------------------

	.chrbank 7		; insert at 0x4E010 - 0x5000F

;----------------------------------------------------------------------------------------------

	.chrbank 8		; insert at 0x50010 - 0x5200F

;----------------------------------------------------------------------------------------------

	.chrbank 9		; insert at 0x52010 - 0x5400F

;----------------------------------------------------------------------------------------------

	.chrbank 10		; insert at 0x54010 - 0x5600F

;----------------------------------------------------------------------------------------------

	.chrbank 11		; insert at 0x56010 - 0x5800F

;----------------------------------------------------------------------------------------------

	.chrbank 12		; insert at 0x58010 - 0x5A00F

;----------------------------------------------------------------------------------------------

	.chrbank 13		; insert at 0x5A010 - 0x5C00F

;----------------------------------------------------------------------------------------------

	.chrbank 14		; insert at 0x5C010 - 0x5E00F

;----------------------------------------------------------------------------------------------

	.chrbank 15		; insert at 0x5E010 - 0x6000F
