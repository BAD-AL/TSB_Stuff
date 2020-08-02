
$B582:8A        TXA		; 0x19592
$B583:0A        ASL
$B584:A8        TAY
$B585:B9 63 AC  LDA $AC63,Y
$B588:85 3E     STA $3E
$B58A:B9 64 AC  LDA $AC64,Y
$B58D:85 3F     STA $3F
$B58F:A9 80     LDA #$80
$B591:8D 01 A0  STA $A001
$B594:6C 3E 00  JMP ($003E)


$B597:A0 00     LDY #$00	; 0x195A7
$B599:4C 46 B6  JMP $B646
$B59C:A0 01     LDY #$01
$B59E:4C 46 B6  JMP $B646
$B5A1:A0 02     LDY #$02
$B5A3:4C 46 B6  JMP $B646
$B5A6:A0 03     LDY #$03
$B5A8:4C 46 B6  JMP $B646
$B5AB:A0 04     LDY #$04
$B5AD:A5 45     LDA $45
$B5AF:10 01     BPL $B5B2
$B5B1:60        RTS
$B5B2:4C 37 B6  JMP $B637
$B5B5:A0 06     LDY #$06
$B5B7:4C 46 B6  JMP $B646
$B5BA:A0 07     LDY #$07
$B5BC:4C 37 B6  JMP $B637
$B5BF:A0 09     LDY #$09
$B5C1:4C 46 B6  JMP $B646
$B5C4:A0 0D     LDY #$0D	; (rb rush yards?)
$B5C6:4C 37 B6  JMP $B637	;
$B5C9:A0 0C     LDY #$0C	; (rb rush attempts?)
$B5CB:4C 46 B6  JMP $B646	;
$B5CE:A0 0F     LDY #$0F	; (rb td count?)
$B5D0:4C 46 B6  JMP $B646	;
$B5D3:A0 00     LDY #$00
$B5D5:4C 46 B6  JMP $B646
$B5D8:A0 01     LDY #$01
$B5DA:A5 45     LDA $45
$B5DC:10 01     BPL $B5DF
$B5DE:60        RTS
$B5DF:4C 37 B6  JMP $B637
$B5E2:A0 03     LDY #$03
$B5E4:4C 46 B6  JMP $B646
$B5E7:A0 04     LDY #$04
$B5E9:4C 46 B6  JMP $B646
$B5EC:A0 05     LDY #$05
$B5EE:4C 37 B6  JMP $B637
$B5F1:A0 07     LDY #$07
$B5F3:4C 46 B6  JMP $B646
$B5F6:A0 08     LDY #$08
$B5F8:4C 46 B6  JMP $B646
$B5FB:A0 09     LDY #$09
$B5FD:4C 37 B6  JMP $B637
$B600:A0 0B     LDY #$0B
$B602:4C 46 B6  JMP $B646
$B605:A0 00     LDY #$00
$B607:4C 46 B6  JMP $B646
$B60A:A0 01     LDY #$01
$B60C:4C 46 B6  JMP $B646
$B60F:A0 02     LDY #$02
$B611:4C 37 B6  JMP $B637
$B614:A0 04     LDY #$04
$B616:4C 46 B6  JMP $B646
$B619:A0 00     LDY #$00
$B61B:4C 46 B6  JMP $B646
$B61E:A0 01     LDY #$01
$B620:4C 46 B6  JMP $B646
$B623:A0 02     LDY #$02
$B625:4C 46 B6  JMP $B646
$B628:A0 03     LDY #$03
$B628:A0 03     LDY #$03
$B62A:4C 46 B6  JMP $B646
$B62D:A0 00     LDY #$00
$B62F:4C 46 B6  JMP $B646
$B632:A0 01     LDY #$01
$B634:4C 37 B6  JMP $B637

; -------------------------------------------
$B637:B1 40     LDA ($40),Y	; 0x19647
$B639:18        CLC
$B63A:65 44     ADC $44
$B63C:91 40     STA ($40),Y
$B63E:C8        INY
$B63F:B1 40     LDA ($40),Y
$B641:65 45     ADC $45
$B643:91 40     STA ($40),Y
$B645:60        RTS
; -------------------------------------------
$B646:B1 40     LDA ($40),Y	; 0x19656
$B648:18        CLC
$B649:69 01     ADC #$01
$B64B:B0 02     BCS $B64F
$B64D:91 40     STA ($40),Y
$B64F:60        RTS