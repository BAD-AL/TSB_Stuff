$9A35:90 19     BCC $9A50
$9A37:70 0D     BVS $9A46
$9A39:A9 0F     LDA #$0F
$9A3B:20 B3 AF  JSR $AFB3
$9A3E:20 FD B7  JSR $B7FD
$9A41:A9 00     LDA #$00
$9A43:20 CB DA  JSR $DACB
$9A46:A9 24     LDA #$24
$9A48:20 1F C4  JSR $C41F
$9A4B:A9 00     LDA #$00
$9A4D:20 CB DA  JSR $DACB
$9A50:A9 01     LDA #$01
$9A52:20 CB DA  JSR $DACB
$9A55:4C 1B 80  JMP $801B

;___________________________________________________________________________________________________
;

$828F:A5 72     LDA $0072 = #$80           A:06 X:6C Y:31 P:nVUBdizc
$8291:29 E0     AND #$E0                   A:80 X:6C Y:31 P:NVUBdizc
$8293:D0 DD     BNE $8272                  A:80 X:6C Y:31 P:NVUBdizc
$8272:A5 72     LDA $0072 = #$80           A:80 X:6C Y:31 P:NVUBdizc
$8274:0A        ASL                        A:80 X:6C Y:31 P:NVUBdizc
$8275:90 03     BCC $827A                  A:00 X:6C Y:31 P:nVUBdiZC
$8277:4C 0D 87  JMP $870D                  A:00 X:6C Y:31 P:nVUBdiZC

$870D:A9 F0     LDA #$F0	; P2 intercepted P1 (touchback)
$870F:8D 0C 02  STA $020C = #$F0
$8712:A9 03     LDA #$03
$8714:20 9A CC  JSR $CC9A
$8717:A5 93     LDA $0093 = #$71
$8719:85 7F     STA $007F = #$71
$871B:A5 94     LDA $0094 = #$09
$871D:85 80     STA $0080 = #$09
$871F:A0 18     LDY #$18
$8721:A2 AE     LDX #$AE
$8723:20 64 97  JSR $9764
$8726:A0 18     LDY #$18
$8728:A2 B6     LDX #$B6
$872A:20 A4 97  JSR $97A4
$872D:20 B1 A1  JSR $A1B1
$8730:A9 1D     LDA #$1D
$8732:20 32 93  JSR $9332
$8735:A9 01     LDA #$01
$8737:20 DC 95  JSR $95DC
$873A:8D F3 07  STA $07F3 = #$00
$873D:20 70 90  JSR $9070	;<--CODE HERE (P2)
$8740:B0 39     BCS $877B


$8E95:A9 F0     LDA #$F0	; P1 intercepted P2 (touchback)
$8E97:8D 0C 02  STA $020C = #$F0
$8E9A:A9 03     LDA #$03
$8E9C:20 9A CC  JSR $CC9A
$8E9F:A5 93     LDA $0093 = #$63
$8EA1:85 7F     STA $007F = #$8E
$8EA3:A5 94     LDA $0094 = #$06
$8EA5:85 80     STA $0080 = #$06
$8EA7:A0 18     LDY #$18
$8EA9:A2 AE     LDX #$AE
$8EAB:20 A4 97  JSR $97A4
$8EAE:A0 18     LDY #$18
$8EB0:A2 B6     LDX #$B6
$8EB2:20 64 97  JSR $9764
$8EB5:20 B1 A1  JSR $A1B1
$8EB8:A9 9D     LDA #$9D
$8EBA:20 32 93  JSR $9332
$8EBD:A9 00     LDA #$00
$8EBF:20 DC 95  JSR $95DC
$8EC2:8D F3 07  STA $07F3 = #$00
$8EC5:20 57 90  JSR $9057	;<--CODE HERE (P1)
$8EC8:B0 39     BCS $8F03	