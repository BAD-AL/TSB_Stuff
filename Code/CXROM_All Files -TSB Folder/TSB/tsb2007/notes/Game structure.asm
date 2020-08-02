$A0D4:20 A6 AD  JSR $ADA6	; goto coin toss screen/intro
$A0D7:A5 2D     LDA $002D = #$80	;   ???
$A0D9:4A        LSR		;   ???
$A0DA:4A        LSR		;   ???
$A0DB:4A        LSR		;   ???
$A0DC:4A        LSR		;   ???
$A0DD:29 01     AND #$01	;   ???
$A0DF:85 72     STA $0072 = #$00	;   ???
$A0E1:A9 03     LDA #$03	;   ???
$A0E3:85 8C     STA $008C = #$03	;   ???
$A0E5:85 8D     STA $008D = #$03	;   ???
$A0E7:A9 00     LDA #$00	; start off in 1st quarter
$A0E9:85 76     STA $0076 = #$01	;
$A0EB:20 36 A2  JSR $A236	;   execute gameplay (1st qtr)----------------------------
$A0EE:20 95 A3  JSR $A395	;   ???
$A0F1:A9 2C     LDA #$2C	;   ???
$A0F3:20 1F C4  JSR $C41F	;   ???
$A0F6:E6 76     INC $0076 = #$01	;   increase to 2nd quarter
$A0F8:A9 21     LDA #$21	;   show scoreboard
$A0FA:20 FA 9D  JSR $9DFA	;
$A0FD:20 36 A2  JSR $A236	;   execute gameplay (2nd qtr)----------------------------
$A100:E6 76     INC $0076 = #$01	;   increase to 3rd quarter
$A102:A9 22     LDA #$22	;   show scoreboard
$A104:20 FA 9D  JSR $9DFA	;
$A107:20 0D AE  JSR $AE0D	;   goto halftime show
$A10A:20 95 A3  JSR $A395	;   ???
$A10D:A5 2D     LDA $002D = #$80	;   ???
$A10F:4A        LSR		;   ???
$A110:4A        LSR		;   ???
$A111:4A        LSR		;   ???
$A112:4A        LSR		;   ???
$A113:49 01     EOR #$01	;   ???
$A115:29 01     AND #$01	;   ???
$A117:85 72     STA $0072 = #$00	;   ???
$A119:A9 03     LDA #$03	;   ???
$A11B:85 8C     STA $008C = #$03	;   ???
$A11D:85 8D     STA $008D = #$03	;   ???
$A11F:20 36 A2  JSR $A236	;   execute gameplay (3rd qtr)----------------------------
$A122:20 95 A3  JSR $A395	;   ???
$A125:A9 2C     LDA #$2C	;   ???
$A127:20 1F C4  JSR $C41F	;   ???
$A12A:E6 76     INC $0076 = #$01	;   increase to 4th quarter
$A12C:A9 23     LDA #$23	;   show scoreboard
$A12E:20 FA 9D  JSR $9DFA	;
$A131:20 36 A2  JSR $A236   	;   execute gameplay (4th qtr)----------------------------
$A134:AD 99 03  LDA $0399 = #$06	;   if (P1_Score == P2_Score)
$A137:CD 9E 03  CMP $039E = #$00	;
$A13A:F0 05     BEQ $A141	;     goto "Overtime"
$A13C:A9 4E     LDA #$4E	;   else ???
$A13E:4C FA 9D  JMP $9DFA	;     exit to blue screen
;---------------------------------------------------------------------------------------------------------
		; "Overtime"
$A141:A9 1B     LDA #$1B	;   show scoreboard
$A143:20 FA 9D  JSR $9DFA	;
$A146:A9 00     LDA #$00	;   ???
$A148:A0 FC     LDY #$FC	;   ???
$A14A:99 99 02  STA $0299,Y @ $02E6 = #$01	;   ???
$A14D:C8        INY		;   ???
$A14E:D0 FA     BNE $A14A	;   ???
$A150:A9 00     LDA #$00	;   ???
$A152:A0 FC     LDY #$FC	;   ???
$A154:99 9E 02  STA $029E,Y @ $02EB = #$94	;   ???
$A157:C8        INY		;   ???
$A158:D0 FA     BNE $A154	;   ???
$A15A:E6 76     INC $0076 = #$01	;   increase quarter to OT
$A15C:20 DB AD  JSR $ADDB	;   goto OT coin toss
$A15F:A5 2D     LDA $002D = #$80	;   if (gametype == PLAYOFF_or_SUPERBOWL)
$A161:29 03     AND #$03	;   ???
$A163:C9 03     CMP #$03	;   ???
$A165:F0 08     BEQ $A16F	;     goto "Must decide winner Overtime"
$A167:20 36 A2  JSR $A236	;   execute gameplay (OT * 1qtr)--------------------------
$A16A:A9 4F     LDA #$4F	;   ???
$A16C:4C FA 9D  JMP $9DFA	;   exit to blue screen
;---------------------------------------------------------------------------------------------------------
		; "Must decide winner Overtime"
$A16F:A0 85     LDY #$85	;   ???
$A171:A2 BB     LDX #$BB	;   ???
$A173:20 81 C4  JSR $C481	;   ???
$A176:A9 00     LDA #$00	;   ???
$A178:85 8C     STA $008C = #$00	;   ???
$A17A:85 8D     STA $008D = #$03	;   ???
$A17C:20 0E D1  JSR $D10E	;   ???
$A17F:A9 12     LDA #$12	;   ???
$A181:85 0B     STA $000B = #$13	;   ???
$A183:A0 FF     LDY #$FF	;   ???
$A185:A9 7F     LDA #$7F	;   ???
$A187:A2 07     LDX #$07	;   ???
$A189:20 45 CC  JSR $CC45	;   ???
$A18C:A9 16     LDA #$16	;   ???
$A18E:85 15     STA $0015 = #$02	;   ???
$A190:A0 02     LDY #$02	;   ???
$A192:A9 90     LDA #$90	;   ???
$A194:A2 11     LDX #$11	;   ???
$A196:20 45 CC  JSR $CC45	;   ???
$A199:A9 01     LDA #$01	;   gameplay loop
$A19B:20 9A CC  JSR $CC9A	;
$A19E:AD 99 03  LDA $0399 = #$10	;
$A1A1:CD 9E 03  CMP $039E = #$10	;
$A1A4:F0 F3     BEQ $A199	;     loop untill winner is determined
$A1A6:A5 2D     LDA $002D = #$C0	;   ???
$A1A8:09 08     ORA #$08	;   ???
$A1AA:85 2D     STA $002D = #$C0	;   ???
$A1AC:A9 01     LDA #$01	;   ???
$A1AE:20 9A CC  JSR $CC9A	;   ???
$A1B1:A5 2D     LDA $002D = #$C0	;   ???
$A1B3:29 08     AND #$08	;   ???
$A1B5:D0 F5     BNE $A1AC	;   ???
$A1B7:A9 4F     LDA #$4F	;   ???
$A1B9:4C FA 9D  JMP $9DFA	;   exit to blue screen