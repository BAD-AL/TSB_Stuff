$A296:A9 01     LDA #$01                   A:01 X:0C Y:4D P:nvUBdizc
$A298:20 9A CC  JSR $CC9A                  A:01 X:0C Y:4D P:nvUBdizc
	$CBBD:60        RTS                        A:01 X:13 Y:17 P:nvUBdizc
$81CF:20 B1 A1  JSR $A1B1                  A:01 X:13 Y:17 P:nvUBdizc
	$A1B1:A5 B7     LDA $00B7 = #$00           A:01 X:13 Y:17 P:nvUBdizc
	$A1B3:F0 03     BEQ $A1B8                  A:00 X:13 Y:17 P:nvUBdiZc
	$A1B8:60        RTS                        A:00 X:13 Y:17 P:nvUBdiZc
$81D2:20 47 A4  JSR $A447                  A:00 X:13 Y:17 P:nvUBdiZc
	$A447:A5 71     LDA $0071 = #$0C           A:00 X:13 Y:17 P:nvUBdiZc
	$A449:29 08     AND #$08                   A:0C X:13 Y:17 P:nvUBdizc
	$A44B:F0 0C     BEQ $A459                  A:08 X:13 Y:17 P:nvUBdizc
	$A44D:60        RTS                        A:08 X:13 Y:17 P:nvUBdizc
$81D5:20 31 90  JSR $9031                  A:08 X:13 Y:17 P:nvUBdizc
	$9031:A0 14     LDY #$14                   A:08 X:13 Y:17 P:nvUBdizc
	$9033:B1 84     LDA ($84),Y @ $03D3 = #$90 A:08 X:13 Y:14 P:nvUBdizc
	$9035:C9 90     CMP #$90                   A:90 X:13 Y:14 P:NvUBdizc
	$9037:C8        INY                        A:90 X:13 Y:14 P:nvUBdiZC
	$9038:B1 84     LDA ($84),Y @ $03D4 = #$09 A:90 X:13 Y:15 P:nvUBdizC
	$903A:E9 09     SBC #$09                   A:09 X:13 Y:15 P:nvUBdizC
	$903C:B0 01     BCS $903F                  A:00 X:13 Y:15 P:nvUBdiZC
	$903F:68        PLA                        A:00 X:13 Y:15 P:nvUBdiZC
	$9040:68        PLA                        A:D7 X:13 Y:15 P:NvUBdizC
	$9041:4C 02 86  JMP $8602                  A:81 X:13 Y:15 P:NvUBdizC


	$8602:A9 F0     LDA #$F0			; crossed the plane of endzone
	$8604:8D 0C 02  STA $020C = #$F0
	$8607:A5 71     LDA $0071 = #$0C
	$8609:09 10     ORA #$10
	$860B:85 71     STA $0071 = #$0C
	$860D:A9 01     LDA #$01
	$860F:85 8B     STA $008B = #$50
	$8611:A9 00     LDA #$00
	$8613:85 69     STA $0069 = #$80
	$8615:20 EA F9  JSR $F9EA			; add 6 to score (or 2 for 2pt conv)
	$8618:EA        NOP				;
	$8619:EA        NOP				;
	$861A:A9 98     LDA #$98
	$861C:20 32 93  JSR $9332
	$861F:A5 70     LDA $0070 = #$00
	$8621:30 21     BMI $8644
	$8623:A0 00     LDY #$00
	$8625:A2 AE     LDX #$AE
	$8627:20 64 97  JSR $9764
	$862A:A0 00     LDY #$00
	$862C:A2 B6     LDX #$B6
	$862E:20 9F 97  JSR $979F
	$8631:20 61 86  JSR $8661
	$8634:A2 38     LDX #$38
	$8636:A5 71     LDA $0071 = #$0C
	$8638:29 20     AND #$20
	$863A:F0 01     BEQ $863D
	$863C:E8        INX
	$863D:8A        TXA
	$863E:20 C5 A1  JSR $A1C5
	$8641:4C F6 F9  JMP $FA1A		; jump to Sub_2ptConversion (normally to PAT code)