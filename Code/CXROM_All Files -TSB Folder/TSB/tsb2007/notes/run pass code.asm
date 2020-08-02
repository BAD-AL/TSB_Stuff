; 0 = Little more rushing
; 1 = Heavy Rushing
; 2 = little more passing
; 3 = Heavy Passing


$AA84:A5 A2     LDA $00A2 = #$00	; get run/pass ratio
$AA86:0A        ASL		;
$AA87:AA        TAX		;
$AA88:BD 4E AA  LDA $AA4E,X @ $AA4F = #$AA	; set jump address
$AA8B:85 3E     STA $003E = #$00	;
$AA8D:BD 4F AA  LDA $AA4F,X @ $AA50 = #$9E	;
$AA90:85 3F     STA $003F = #$00					;
$AA92:6C 3E 00  JMP ($003E) = $0000				; jump to code


;-----------------------------------------------;-#00--------------------------
$AA95:A5 40     LDA $0040 = #$7C	; keep play index from 0 to 7
$AA97:29 07     AND #$07	;
$AA99:85 40     STA $0040 = #$7C	; save play index
$AA9B:4C 2A A7  JMP $A72A	; continue...
;-----------------------------------------------;-#01--------------------------
$AA9E:A5 40     LDA $0040 = #$7C	; if ( RAND > #$99 )
$AAA0:C9 99     CMP #$99	;
$AAA2:90 0C     BCC $AAB0	;
$AAA4:A5 41     LDA $0041 = #$81	;   get PLAY_RAND
$AAA6:29 03     AND #$03	;   keep play index from 0 to 3
$AAA8:18        CLC		;
$AAA9:69 04     ADC #$04	;   adjust index into pass plays
$AAAB:85 40     STA $0040 = #$7C	;   save play index
$AAAD:4C 2A A7  JMP $A72A	;   continue...
		; else
$AAB0:A5 41     LDA $0041 = #$81	;   get PLAY_RAND
$AAB2:29 03     AND #$03	;   mask play index to run plays
$AAB4:85 40     STA $0040 = #$7C	;   save play index
$AAB6:4C 2A A7  JMP $A72A	;   continue...
;-----------------------------------------------;-#02--------------------------
$AAB9:A5 40     LDA $0040 = #$7C	; if ( RAND > #$99 )
$AABB:C9 99     CMP #$99	;
$AABD:90 09     BCC $AAC8	;
$AABF:A5 41     LDA $0041 = #$81	;   get PLAY_RAND
$AAC1:29 03     AND #$03	;   mask play index to run plays
$AAC3:85 40     STA $0040 = #$7C	;   save play index
$AAC5:4C 2A A7  JMP $A72A	;   continue...
		; else
$AAC8:A5 41     LDA $0041 = #$81	;   get PLAY_RAND
$AACA:29 03     AND #$03	;   keep play index from 0 to 3
$AACC:18        CLC		;
$AACD:69 04     ADC #$04	;   adjust index into pass plays
$AACF:85 40     STA $0040 = #$7C	;   save play index
$AAD1:4C 2A A7  JMP $A72A	;   continue...
;-----------------------------------------------;-#03--------------------------
$AAD4:A5 40     LDA $0040 = #$7C	; if ( RAND > #$B3 )
$AAD6:C9 B3     CMP #$B3	;
$AAD8:90 09     BCC $AAE3	;
$AADA:A5 41     LDA $0041 = #$81	;   get PLAY_RAND
$AADC:29 03     AND #$03	;   mask play index to run plays
$AADE:85 40     STA $0040 = #$7C	;   save play index
$AAE0:4C 2A A7  JMP $A72A	;   continue...
		; else
$AAE3:A5 41     LDA $0041 = #$81	;   get PLAY_RAND
$AAE5:29 03     AND #$03	;   keep play index from 0 to 3
$AAE7:18        CLC		;
$AAE8:69 04     ADC #$04	;   adjust index into pass plays
$AAEA:85 40     STA $0040 = #$7C	;   save play index
$AAEC:4C 2A A7  JMP $A72A	;   continue...