		; 0x034106
$80F6:A0 B2     LDY #$B2	;
$80F8:B1 3E     LDA ($3E), Y	; wins
$80FA:A0 B3     LDY #$B3	;
$80FC:38        SEC		;
$80FD:F1 3E     SBC ($3E), Y	; losses
$80FF:B0 10     BCS $8111	; if (wins - losses >= 0) goto $8111
$8101:4C 0F 81  JMP $810F
$8104:20 58 81  JSR $8158
$8107:C9 30     CMP #$30
$8109:F0 04     BEQ $810F
$810B:C9 03     CMP #$03
$810D:D0 2D     BNE $813C
$810F:A9 00     LDA #$00	; else, set difference to zero
$8111:8D 7D 66  STA $667D	; save difference


		; 0x028B3F
$8B2F:AD 7D 66  LDA $667D	;
$8B32:C5 DE     CMP $DE
$8B34:90 03     BCC $8B39
$8B36:4C C5 97  JMP $97C5	; <---harder ai
$8B39:4C 1B 80  JMP $801B	; <---softer ai
