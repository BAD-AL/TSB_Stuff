$86C5:20 B3 9A  JSR $9AB3	; setup PAT
$86C8:20 DF 93  JSR $93DF	;
$86CB:A9 89     LDA #$89	;
$86CD:20 32 93  JSR $9332	;
$86D0:20 40 D1  JSR $D140	;
$86D3:A9 08     LDA #$08	; snap ball
$86D5:20 9A CC  JSR $CC9A	;
$86D8:20 BF 94  JSR $94BF	;
$86DB:A9 00     LDA #$00	; start kick
$86DD:20 D6 95  JSR $95D6	;
$86E0:A9 01     LDA #$01	;
$86E2:20 9A CC  JSR $CC9A	;
$86E5:20 37 91  JSR $9137	;
$86E8:20 EC 90  JSR $90EC	;
$86EB:B0 1D     BCS $870A	;
$86ED:A5 71     LDA $0071 = #$00	;
$86EF:29 02     AND #$02	;
$86F1:F0 ED     BEQ $86E0	;
$86F3:A9 01     LDA #$01	; execute game engine???
$86F5:20 9A CC  JSR $CC9A	;
$86F8:A5 B7     LDA $00B7 = #$00	;
$86FA:F0 F7     BEQ $86F3	;
$86FC:A5 72     LDA $0072 = #$00	;
$86FE:29 02     AND #$02	;
$8700:F0 05     BEQ $8707	;
$8702:A9 01     LDA #$01	; add 1 to score
$8704:20 42 93  JSR $9342	;    "
$8707:20 B1 A1  JSR $A1B1	; kick animation
$870A:4C 75 87  JMP $8775	; goto kickoff

$8775:20 81 87  JSR $8781
	$8781:A5 52     LDA $0052 = #$00
	$8783:F0 03     BEQ $8788
	;$8785:20 F9 98  JSR $98F9	; show turnover on downs
	$8788:A9 00     LDA #$00
	$878A:85 69     STA $0069 = #$00
	$878C:20 01 93  JSR $9301
		$9301:20 23 93  JSR $9323                  A:00 X:09 Y:05 P:nvUBdiZC
			$9323:A2 0C     LDX #$0C                   A:00 X:09 Y:05 P:nvUBdiZC
			$9325:20 DD CC  JSR $CCDD                  A:00 X:0C Y:05 P:nvUBdizC
				$CCDD:A9 00     LDA #$00                   A:00 X:0C Y:05 P:nvUBdizC
				$CCDF:9D 00 00  STA $0000,X @ $000C = #$13 A:00 X:0C Y:05 P:nvUBdiZC
				$CCE2:8A        TXA                        A:00 X:0C Y:05 P:nvUBdiZC
				$CCE3:45 64     EOR $0064 = #$40           A:0C X:0C Y:05 P:nvUBdizC
				$CCE5:29 3F     AND #$3F                   A:4C X:0C Y:05 P:nvUBdizC
				$CCE7:D0 06     BNE $CCEF                  A:0C X:0C Y:05 P:nvUBdizC
				...
				$CCEF:8A        TXA                        A:0C X:0C Y:05 P:nvUBdizC
				$CCF0:4D 7E 03  EOR $037E = #$00           A:0C X:0C Y:05 P:nvUBdizC
				$CCF3:29 3F     AND #$3F                   A:0C X:0C Y:05 P:nvUBdizC
				$CCF5:D0 04     BNE $CCFB                  A:0C X:0C Y:05 P:nvUBdizC
				...
				$CCFB:60        RTS                        A:0C X:0C Y:05 P:nvUBdizC
			$9328:A2 16     LDX #$16                   A:0C X:0C Y:05 P:nvUBdizC
			$932A:20 DD CC  JSR $CCDD	; see above log
			$932D:A9 00     LDA #$00                   A:16 X:16 Y:05 P:nvUBdizC
			$932F:85 B7     STA $00B7 = #$00           A:00 X:16 Y:05 P:nvUBdiZC
			$9331:60        RTS                        A:00 X:16 Y:05 P:nvUBdiZC
		$9304:A5 7C     LDA $007C = #$09           A:00 X:16 Y:05 P:nvUBdiZC
		$9306:F0 09     BEQ $9311                  A:09 X:16 Y:05 P:nvUBdizC
		$9308:A5 52     LDA $0052 = #$00           A:09 X:16 Y:05 P:nvUBdizC
		$930A:F0 08     BEQ $9314                  A:00 X:16 Y:05 P:nvUBdiZC
		...
		$9314:A2 1B     LDX #$1B                   A:00 X:16 Y:05 P:nvUBdiZC
		$9316:20 DD CC  JSR $CCDD	; see above log
		$9319:A2 20     LDX #$20
		$931B:20 DD CC  JSR $CCDD	; see above log
		$931E:A2 25     LDX #$25
		$9320:20 DD CC  JSR $CCDD	; see above log
		$9323:A2 0C     LDX #$0C
		$9325:20 DD CC  JSR $CCDD	; see above log
		$9328:A2 16     LDX #$16
		$932A:20 DD CC  JSR $CCDD	; see above log
		$932D:A9 00     LDA #$00                   A:16 X:16 Y:05 P:nvUBdizC
		$932F:85 B7     STA $00B7 = #$00           A:00 X:16 Y:05 P:nvUBdiZC
		$9331:60        RTS                        A:00 X:16 Y:05 P:nvUBdiZC
	$878F:20 D9 9A  JSR $9AD9		; CRASH AND BURN
	$8792:20 09 90  JSR $9009
	$8795:A9 C3     LDA #$C3
	$8797:85 70     STA $0070 = #$14
	$8799:A9 02     LDA #$02
	$879B:20 9A CC  JSR $CC9A
	$879E:4C AA 92  JMP $92AA
	...
	$92AA:A5 2D     LDA $002D = #$90
	$92AC:29 08     AND #$08
	$92AE:D0 01     BNE $92B1
	$92B0:60        RTS
$8778:4C A1 87  JMP $87A1


;_______________________________________________________________________________________________
;
; kickoff at start: P1 K---> P2
;
$8000:4C 06 80  JMP $8006                  A:12 X:07 Y:02 P:nvUBdizC
$8006:A2 D1     LDX #$D1                   A:12 X:07 Y:02 P:nvUBdizC
$8008:9A        TXS                        A:12 X:D1 Y:02 P:NvUBdizC
$8009:A2 13     LDX #$13                   A:12 X:D1 Y:02 P:NvUBdizC
$800B:20 E3 D8  JSR $D8E3                  A:12 X:13 Y:02 P:nvUBdizC
$D8E3:86 2F     STX $002F = #$12           A:12 X:13 Y:02 P:nvUBdizC
$D8E5:A9 07     LDA #$07                   A:12 X:13 Y:02 P:nvUBdizC
$D8E7:05 33     ORA $0033 = #$00           A:07 X:13 Y:02 P:nvUBdizC
$D8E9:85 34     STA $0034 = #$07           A:07 X:13 Y:02 P:nvUBdizC
$D8EB:38        SEC                        A:07 X:13 Y:02 P:nvUBdizC
$D8EC:66 2C     ROR $002C = #$55           A:07 X:13 Y:02 P:nvUBdizC
$D8EE:8D 00 80  STA $8000 = #$4C           A:07 X:13 Y:02 P:NvUBdizC
$D8F1:8E 01 80  STX $8001 = #$06           A:07 X:13 Y:02 P:NvUBdizC
$D8F4:46 2C     LSR $002C = #$AA           A:07 X:13 Y:02 P:NvUBdizC
$D8F6:60        RTS                        A:07 X:13 Y:02 P:nvUBdizc
$800E:A9 00     LDA #$00                   A:07 X:13 Y:02 P:nvUBdizc
$8010:85 73     STA $0073 = #$00           A:00 X:13 Y:02 P:nvUBdiZc
$8012:A5 72     LDA $0072 = #$01           A:00 X:13 Y:02 P:nvUBdiZc
$8014:F0 03     BEQ $8019                  A:01 X:13 Y:02 P:nvUBdizc
$8016:4C A1 87  JMP $87A1                  A:01 X:13 Y:02 P:nvUBdizc
