

;========================================================================================
;
; 	CALLING CONVENTIONS
;
;========================================================================================
;
; in:  A=Event#
;      X=Group#
;
; out: ???
;
; called:
;     JSR $C390 (through $C3A2)
;        or
;     JSR $C3AF (***)
;
; notes:
;      [->], [<-]	= direction of drive
;      -UNUSED-	= not used in normal game

$C390:85 C2     STA $C2		; <-ENTER HERE
$C392:86 C3     STX $C3
$C394:A9 17     LDA #$17
$C396:85 10     STA $10
$C398:A0 02     LDY #$02
$C39A:A9 80     LDA #$80
$C39C:A2 0C     LDX #$0C
$C39E:20 45 CC  JSR $CC45
$C3A1:60        RTS
; ------------------------------
$C3A2:20 90 C3  JSR $C390	; <-ENTER HERE
$C3A5:A9 01     LDA #$01
$C3A7:20 9A CC  JSR $CC9A
$C3AA:A5 0C     LDA $0C
$C3AC:D0 F7     BNE $C3A5
$C3AE:60        RTS
; ------------------------------
$C3AF:85 C2     STA $C2		; <-ENTER HERE
$C3B1:86 C3     STX $C3		;
$C3B3:A5 2E     LDA $2E		;
$C3B5:48        PHA		;
$C3B6:A2 17     LDX #$17	;
$C3B8:20 DD D8  JSR $D8DD	; bank swap?
$C3BB:A5 C2     LDA $C2		;
$C3BD:A6 C3     LDX $C3		;
$C3BF:20 00 80  JSR $8000	;
$C3C2:68        PLA		;
$C3C3:AA        TAX		;
$C3C4:4C DD D8  JMP $D8DD	;




















;========================================================================================
;
;	CUT-SCENES DATA FORMAT
;
;========================================================================================


; SCRIPT
;	CTRL [ARGS], [CTRL [ARGS]], EOS
;
;	$FB immediate.b	pause(byte time)
;	$FD pointer.w	runScript(word pointer)
;	$FF	EOS: "end of script"
;


; example:	X=$06 A=$26 ("QB Sack")
0x00C919	FD12A9 FD1FA9 FB3C FF		; main struct
	
0x00C922	C8 F1 F729 C00188181A F9010E FE
0x00C92F	F6 8A68 5142205341434B21 8AE0 FA1D D8B2 F336 FB3C FE


; MINI SCRIPT
;	CTRL [ARGS], [CTRL [ARGS]], EOMS
;
;	$C0 unk.b unk.b unk.b unk.b	-UNKNOWN-
;			   FFFF.UUU  ........ ........ ........
;			   |||| +++-unknown use
;			   ++++------function index
;
;	$C8 void		clear some vars
;	$F1 void		set NAT mir->H
;	$F6 void		-UNKNOWN-
;	$F7 unk.b unk.b		-UNKNOWN-
;	$F9 void		clear oam, clear ram $683-$6E2
;	$FE void		EOMS: "end of mini-script"





; [FROM]
;$C39E:20 45 CC	JSR $CC45
; ......

$8003:4C 15 80	JMP $8015		;
; ......

$8015:A2 AB	LDX #$AB		; ???
$8017:9A	TXS		; ???
$8018:A2 1B	LDX #$1B		; ???
$801A:20 DD CC	JSR $CCDD		; ???
$801D:A2 16	LDX #$16		; ???
$801F:20 DD CC	JSR $CCDD		; ???
$8022:A2 11	LDX #$11		; ???
$8024:20 DD CC	JSR $CCDD		; ???
$8027:A5 C2	LDA $C2	; event #	;
$8029:A6 C3	LDX $C3	; group #	; 
$802B:20 40 80	JSR $8040		;
; ......


$8040:85 C2	STA $C2	; event #	;
$8042:20 E3 D8	JSR $D8E3
$8045:A5 2D	LDA $2D
$8047:29 DF	AND #$DF
$8049:85 2D	STA $2D
$804B:A5 C2	LDA $C2	; event #	;
$804D:0A	ASL
$804E:AA	TAX
$804F:BD 00 A0	LDA $A000,X		; set event struct ptr
$8052:85 C2	STA $C2
$8054:BD 01 A0	LDA $A001,X
$8057:85 C3	STA $C3
$8059:A9 82	LDA #$82
$805B:85 C6	STA $C6
$805D:A9 20	LDA #$20
$805F:85 C7	STA $C7
$8061:A5 64	LDA $64
$8063:29 BF	AND #$BF
$8065:85 64	STA $64
$8067:A9 00	LDA #$00
$8069:8D E3 06	STA $06E3
$806C:8D E4 06	STA $06E4
$806F:8D E5 06	STA $06E5
$8072:8D E6 06	STA $06E6
$8075:85 C8	STA $C8
;           ----------START OF SCRIPT INTERPRETER----------	;
$8077:A0 00	LDY #$00		; start at first byte
$8079:B1 C2	LDA ($C2),Y		; get next ctrl byte
$807B:30 03	BMI $8080		;
;                  ---ctrl code <$7F---
$807D:4C 31 81	JMP $8131
;                  ---ctrl code >=$80---
$8080:C9 C0	CMP #$C0
$8082:B0 0E	BCS $8092
;                    -ctrl code >=$80 && <$C0-
$8084:29 78	AND #$78
$8086:4A	LSR
$8087:4A	LSR
$8088:AA	TAX
$8089:BD A2 80	LDA $80A2,X
$808C:48	PHA
$808D:BD A1 80	LDA $80A1,X
$8090:48	PHA
$8091:60	RTS
;                    -ctrl code > $C0-
$8092:C8	INY		; adv to next byte
$8093:38	SEC		; adjust index for ptr table
$8094:E9 C0	SBC #$C0		;
$8096:0A	ASL		;
$8097:AA	TAX		;
$8098:BD B2 80	LDA $80B2,X		;
$809B:48	PHA		;
$809C:BD B1 80	LDA $80B1,X		;
$809F:48	PHA		;
$80A0:60	RTS		; jump to func (technically RTS...)

$80A1:64 81	.dw $8164
$80A3:7C 81	.dw $817C
$80A5:84 81	.dw $8184
$80A7:9E 81	.dw $819E
$80A9:B8 81	.dw $81B8
$80AB:D3 81	.dw $81D3
$80AD:EA 81	.dw $81EA
$80AF:0C 82	.dw $820C
$80B1:24 82	.dw $8224
FB82
1283
1B83
2383
3F83
448C
4D83
5B83
6C83
7983
8183
8983
9483
448C
448C
2384
3384
4F84
7C84
0F85
1485
2285
3085
3585
6385
9985
B585
D185
ED85
F785
1086
2386
4786
5086
6486
6E86
7886
9486
9F86
AA86
B586
BF86
C986
D986
E186
EC86
1687
2787
4187
4987
5187
448C
5B87
6687
7187
7D87
8987
8F87
0D8C
178C
248C
2F8C
3F8C

$8131:C8        INY
$8132:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$8134:10 FB     BPL $8131
$8136:A5 C2     LDA $00C2 = #$09
$8138:85 3E     STA $003E = #$20
$813A:A5 C3     LDA $00C3 = #$A9
$813C:85 3F     STA $003F = #$00
$813E:98        TYA
$813F:85 45     STA $0045 = #$A9
$8141:24 64     BIT $0064 = #$00
$8143:70 0A     BVS $814F
$8145:A4 C6     LDY $00C6 = #$82
$8147:A6 C7     LDX $00C7 = #$20
$8149:20 7F D5  JSR $D57F
$814C:4C 60 81  JMP $8160
$814F:A4 C6     LDY $00C6 = #$82
$8151:A6 C7     LDX $00C7 = #$20
$8153:A5 C2     LDA $00C2 = #$09
$8155:85 3E     STA $003E = #$20
$8157:A5 C3     LDA $00C3 = #$A9
$8159:85 3F     STA $003F = #$00
$815B:A5 45     LDA $0045 = #$A9
$815D:20 03 CF  JSR $CF03
$8160:A5 45     LDA $0045 = #$A9
$8162:4C 48 8C  JMP $8C48
; ----------------------------------
$8165:20 56 8C  JSR $8C56
$8168:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$816A:85 3E     STA $003E = #$20
$816C:C8        INY
$816D:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$816F:85 3F     STA $003F = #$00
$8171:A4 C6     LDY $00C6 = #$82
$8173:A6 C7     LDX $00C7 = #$20
$8175:20 FC CC  JSR $CCFC
$8178:A9 04     LDA #$04
$817A:4C 48 8C  JMP $8C48
; ----------------------------------
$817D:20 56 8C  JSR $8C56
$8180:A9 02     LDA #$02
$8182:4C 48 8C  JMP $8C48
; ----------------------------------
$8185:20 56 8C  JSR $8C56
$8188:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$818A:85 3F     STA $003F = #$00
$818C:A9 01     LDA #$01
$818E:85 3E     STA $003E = #$20
$8190:C8        INY
$8191:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$8193:A4 C6     LDY $00C6 = #$82
$8195:A6 C7     LDX $00C7 = #$20
$8197:20 9D D0  JSR $D09D
$819A:A9 04     LDA #$04
$819C:4C 48 8C  JMP $8C48
; ----------------------------------
$819F:20 56 8C  JSR $8C56
$81A2:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$81A4:85 3E     STA $003E = #$20
$81A6:A9 01     LDA #$01
$81A8:85 3F     STA $003F = #$00
$81AA:C8        INY
$81AB:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$81AD:A4 C6     LDY $00C6 = #$82
$81AF:A6 C7     LDX $00C7 = #$20
$81B1:20 9D D0  JSR $D09D
$81B4:A9 04     LDA #$04
$81B6:4C 48 8C  JMP $8C48
; ----------------------------------
$81B9:20 56 8C  JSR $8C56
$81BC:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$81BE:85 3F     STA $003F = #$00
$81C0:C8        INY
$81C1:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$81C3:85 3E     STA $003E = #$20
$81C5:C8        INY
$81C6:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$81C8:A4 C6     LDY $00C6 = #$82
$81CA:A6 C7     LDX $00C7 = #$20
$81CC:20 9D D0  JSR $D09D
$81CF:A9 05     LDA #$05
$81D1:4C 48 8C  JMP $8C48
; ----------------------------------
$81D4:20 56 8C  JSR $8C56
$81D7:A9 01     LDA #$01
$81D9:85 3F     STA $003F = #$00
$81DB:85 3E     STA $003E = #$20
$81DD:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$81DF:A4 C6     LDY $00C6 = #$82
$81E1:A6 C7     LDX $00C7 = #$20
$81E3:20 9D D0  JSR $D09D
$81E6:A9 03     LDA #$03
$81E8:4C 48 8C  JMP $8C48
; ----------------------------------
$81EB:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$81ED:38        SEC
$81EE:E9 AF     SBC #$AF
$81F0:85 45     STA $0045 = #$A9
$81F2:A9 00     LDA #$00
$81F4:46 45     LSR $0045 = #$A9
$81F6:6A        ROR
$81F7:46 45     LSR $0045 = #$A9
$81F9:6A        ROR
$81FA:46 45     LSR $0045 = #$A9
$81FC:6A        ROR
$81FD:18        CLC
$81FE:65 C6     ADC $00C6 = #$82
$8200:85 C6     STA $00C6 = #$82
$8202:A5 45     LDA $0045 = #$A9
$8204:65 C7     ADC $00C7 = #$20
$8206:85 C7     STA $00C7 = #$20
$8208:A9 01     LDA #$01
$820A:4C 48 8C  JMP $8C48
; ----------------------------------
$820D:20 56 8C  JSR $8C56
$8210:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$8212:85 3E     STA $003E = #$20
$8214:C8        INY
$8215:B1 C2     LDA ($C2),Y @ $A910 = #$3C
$8217:85 3F     STA $003F = #$00
$8219:A4 C6     LDY $00C6 = #$82
$821B:A6 C7     LDX $00C7 = #$20
$821D:20 B9 CE  JSR $CEB9
$8220:A9 04     LDA #$04
$8222:4C 48 8C  JMP $8C48
; ----------------------------------
$8225:B1 C2     LDA ($C2),Y @ $A917 = #$01
$8227:29 07     AND #$07
$8229:85 3F     STA $003F = #$00
$822B:0A        ASL
$822C:0A        ASL
$822D:65 3F     ADC $003F = #$00
$822F:AA        TAX
$8230:B1 C2     LDA ($C2),Y @ $A917 = #$01
$8232:29 F0     AND #$F0
$8234:4A        LSR
$8235:4A        LSR
$8236:4A        LSR
$8237:A8        TAY
$8238:B9 42 82  LDA $8242,Y @ $8243 = #$5D
$823B:48        PHA
$823C:B9 41 82  LDA $8241,Y @ $8242 = #$82
$823F:48        PHA
$8240:60        RTS
$8041:50 82	.dw $8250
$8043:5D 82	.dw $825D
$8045:6D 82	.dw $826D
$8047:7D 82	.dw $827D
$8049:8A 82	.dw $828A
$804B:A2 82	.dw $82A2
$804D:DF 82	.dw $82DF
$804F:E9 82	.dw $82E9
; ----------------------------------
$8251:A0 03     LDY #$03
$8253:20 BD 8C  JSR $8CBD
$8256:20 E1 8C  JSR $8CE1
$8259:A9 05     LDA #$05
$825B:4C 95 82  JMP $8295
; ----------------------------------










; ----------------------------------
$835C:A9 00	LDA #$00		; clear some vars (not sure for what?)
$835E:8D 07 03	STA $0307		;
$8361:8D 08 03	STA $0308		;
$8364:85 57	STA $57		;
$8366:85 58	STA $58		;
$8368:A9 01	LDA #$01		;   [add 1]
$836A:4C 48 8C	JMP $8C48		;   jmp to add "A" to struct ptr ($C2)
; ----------------------------------


















; ----------------------------------
$8742:20 65 D5	JSR $D565		; set NAT mir->H, and ???
$8745:A9 01	LDA #$01		;   [add 1]
$8747:4C 48 8C	JMP $8C48		;   jmp to add "A" to struct ptr ($C2)
; ----------------------------------


; ----------------------------------
$8767:A5 64	LDA $64		;???
$8769:09 40	ORA #$40		;???
$876B:85 64	STA $64		;???
$876D:A9 01	LDA #$01		;   [add 1]
$876F:4C 48 8C	JMP $8C48		;   jmp to add "A" to struct ptr ($C2)
; ----------------------------------
$8772:B1 C2	LDA ($C2),Y		; read next byte from struct
$8774:A2 00	LDX #$00
$8776:20 D3 92	JSR $92D3
$8779:A9 02	LDA #$02		;   [add 1]
$877B:4C 48 8C	JMP $8C48		;   jmp to add "A" to struct ptr ($C2)
; ----------------------------------


; ----------------------------------
$878A:20 1C 96  JSR $961C
$878D:4C 77 80  JMP $8077
; ----------------------------------














; ----------------------------------
$8C18:B1 C2	LDA ($C2),Y		; read new struct pointer
$8C1A:AA	TAX		;
$8C1B:C8	INY		;
$8C1C:B1 C2	LDA ($C2),Y		;
$8C1E:85 C3	STA $C3		;
$8C20:86 C2	STX $C2		;
$8C22:4C 77 80	JMP $8077		;   jmp to start of interpreter
; ----------------------------------
$8C25:A5 C2	LDA $C2		; move struct ptr ($C2) -> ($C4)
$8C27:85 C4	STA $C4		;
$8C29:A5 C3	LDA $C3		;
$8C2B:85 C5	STA $C5		;
$8C2D:4C 18 8C	JMP $8C18		;   jmp to read new struct pointer
; ----------------------------------
$8C30:A5 C4	LDA $C4		; restore struct ptr ($C4) -> ($C2) 
$8C32:18	CLC		;
$8C33:69 03	ADC #$03		;   [adjust for "ctrl ptr.w" ...3 bytes]
$8C35:85 C2	STA $C2		;
$8C37:A5 C5	LDA $C5		;
$8C39:69 00	ADC #$00		;
$8C3B:85 C3	STA $C3		;
$8C3D:4C 77 80	JMP $8077		;   jmp to start of interpreter
; ----------------------------------



; ----------------------------------
$8C48:18	CLC		; add "A" to struct ptr ($C2)
$8C49:65 C2	ADC $C2		;
$8C4B:85 C2	STA $C2		;
$8C4D:A5 C3	LDA $C3		;
$8C4F:69 00	ADC #$00		;
$8C51:85 C3	STA $C3		;
$8C53:4C 77 80	JMP $8077		;   jmp to start of interpreter
; ----------------------------------













; ----------------------------------
$92D3:85 D4     STA $00D4 = #$00
$92D5:86 D7     STX $00D7 = #$24
$92D7:A9 17     LDA #$17
$92D9:85 15     STA $0015 = #$01
$92DB:A0 E9     LDY #$E9
$92DD:A9 92     LDA #$92
$92DF:A2 11     LDX #$11
$92E1:20 45 CC  JSR $CC45
$92E4:A9 04     LDA #$04
$92E6:20 9A CC  JSR $CC9A
$92E9:60        RTS
; ----------------------------------








;========================================================================================
;
;    Helper functions
;


; ----------------------------------
$D565:A9 01	LDA #$01		; set NAT mirroring -> Horizontal
$D567:8D 00 A0	STA $A000		;
$D56A:A5 2D	LDA $2D		;
$D56C:09 40	ORA #$40		;
$D56E:85 2D	STA $2D		;
$D570:60	RTS		;

; ----------------------------------
$D8E3:86 2F     STX $002F = #$17
$D8E5:A9 07     LDA #$07
$D8E7:05 33     ORA $0033 = #$00
$D8E9:85 34     STA $0034 = #$07
$D8EB:38        SEC
$D8EC:66 2C     ROR $002C = #$55
$D8EE:8D 00 80  STA $8000 = #$4C
$D8F1:8E 01 80  STX $8001 = #$40
$D8F4:46 2C     LSR $002C = #$55
$D8F6:60        RTS




	
;----------------------------------------------------------------------------------------------

X=6	 A =
	-----
	00: Opening
	01: Title Screen
	02: Kickoff
	03: Punt
	04: Field Goal
	05: JJ Incomplete (missed)
	06: JJ Incomplete (tipped)
	07: Incomplete (bounced)
	08: Incomplete Dive (missed)
	09: Attempted Blocked Punt/FG/Pass
	0A: Blocked Punt
	0B: Blocked FG
	0C: Blocked PAT
	0D: Blocked Pass
	0E: Long FG Attempt
	0F: FG Through Uprights [->]
	10: FG Through Uprights [<-]
	11: FG Good
	12:
	13:
	14: Doink Left Upright, Good [->]
	15: Doink Right Upright, Good [->]
	16: Doink Left Upright, Missed [->]
	17: Doink Right Upright, Missed [->]
	18: Missed Left [->]
	19: Missed Right [->]
	1A: Short FG [->]
	1B: Referee - No Good
	1C: Doink Right Upright, Good [<-]
	1D: Doink Left Upright, Good [<-]
	1E: Doink Right Upright, Missed [<-]
	1F: Doink Left Upright, Missed [<-]
	20: Missed Right [<-]
	21: Missed Left [<-]
	22: Short FG [<-]
	23: Successful Try
	24:
	25:
	26: QB Sack
	27: QB Sack + Side Change
	28: Safety
	29: Bullet Pass
	2A:
	2B: JJ Catch
	2C: JJ Incomplete (missed)
	2D: JJ Incomplete (tipped)
	2E:
	2F: Catch
	30: Incomplete (bounced)
	31: Incomplete Pass
	32: Complete Dive
	33: Incomplete Dive (missed)
	34: Incomplete Dive (tipped)
	35:
	36:
	37: Injury
	38: Rushing TD
	39: Receiving TD
	3A: AFC Champion
	3B: Super Champion
	3C:
	3D:
	3E: First Down (Ref. faces left)
	3F: First Down (Ref. faces forward)
	40: Second Down
	41: Third Down
	42: Fourth Down
	43: JJ Interception
	44: Super JJ
	45: Super JJ (missed)
	46: Super JJ (missed)
	47: Super JJ, Int (missed)
	48: Interception
	49: Halftime - Blimp
	4A: Halftime - Wink
	4B: Halftime - Band
	4C: Halftime - Toss Cheerleader
	4D: Halftime - Parachute
	4E: QB Stats			-UNUSED-
	4F: Halftime - Cheerleaders x2
	50: Halftime - Kiss
	51: Catch, Dive Int
	52: Catch, JJ Int
	53: Incomp, Dive Int
	54: Incomp, JJ Int
	55: Dive Int
	56: Division Champs
	57: Flashing "Press Start" at title
	58: Special Halftime Show
	59: Halftime Show (Blimp, Wink, Band, Kiss)
	5A: Halftime Show (Parachute, The Wave, Cheerleaders x2, Toss Cheerleader)
	5B: Halftime Show (Cheerleaders x2, Band, Blimp, Wink)
	5C: Halftime Show (Wink, Cheerleaders x2, Toss Cheerleader, Kiss)
	5D: Yards Rushed			-UNUSED-
	5E: Yards Returned			-UNUSED-
	5F: Yards Received			-UNUSED-
	60: Interception TD			-UNUSED-
	61: Defensive TD			-UNUSED-
	62: Rush Yards Today			-UNUSED-
	63: Rec Yards Today			-UNUSED-
	64: Sacks Today			-UNUSED-
	65: Int Today			-UNUSED-
	66: 000Yards Rusher			-UNUSED-
	67: 000Yards Receiver			-UNUSED-
	68: 000Yards Passer			-UNUSED-
	69: Yellow Flag-False Start		-UNUSED-
	6A: Yellow Flag-Offsides		-UNUSED-
	6B: NFC Champion
	6C:
	6D:
	6E: Credits
	6F: Sound Test
	70: Chains + 1st Down [->]
	71: Chains + 2nd Down [->]
	72: Chains + 3rd Down [->]
	73: Chains + 4th Down [->]
	74: Chains + Change Sides [->]
	75: Chains + First Down [<-]
	76:
	77:
	78:
	79:
	7A:
	7B:
	7C:
	7D:
	7E: Incomp (bounced), Dive
	7F:


;----------------------------------------------------------------------------------------------
X=7	 A =
	-----
	00: NFL Leaders
	01: Leading Passers
	02:
	03:
	04: Leading Receiving
	05: Leading Rushing
	06: Scoring
	07: Leading Punting
	08: Interceptions
	09: Leading Sacks
	0A: Punt Returns
	0B: Kickoff Returns
	0C:
	0D:
	0E:
	0F:
	10:
	11:
	12:
	13:
	14:
	15:
	16:
	17:
	18:
	19:
	1A:
	1B:
	1C:
	1D:
	1E:
	1F:
	20:
	21: Scoreboard (1->2)
	22: Scoreboard (2->3)
	23: Scoreboard (3->4)
	24:
	25:
	26: Injury Recovery
	27: ?Opening Coin Toss
	28:
	29:
	2A: ?Choose Kick -or- Receive (P1)
	2B: ?Choose Kick -or- Receive (P2)
	2C: Opening Coin Toss/Choose Kick -or- Receive (P1 wins)
	2D: Opening Coin Toss/Choose Kick -or- Receive (P2 wins)
	2E:
	2F:
	30:
	31: Overtime Coin Toss/Choose Kick -or- Receive (P1 wins)
	32: Overtime Coin Toss/Choose Kick -or- Receive (P2 wins)
	33:
	34: Black intro screen - "PRESEASON"
	35: Black intro screen - "PROBOWL"
	36: Black intro screen - "REGULAR SEASON 1ST WEEK"
	37: Black intro screen - "REGULAR SEASON 2ND WEEK"
	38: Black intro screen - "REGULAR SEASON 3RD WEEK"
	39: Black intro screen - "REGULAR SEASON 4TH WEEK"
	3A: Black intro screen - "REGULAR SEASON 5TH WEEK"
	3B: Black intro screen - "REGULAR SEASON 6TH WEEK"
	3C: Black intro screen - "REGULAR SEASON 7TH WEEK"
	3D: Black intro screen - "REGULAR SEASON 8TH WEEK"
	3E: Black intro screen - "REGULAR SEASON 9TH WEEK"
	3F: Black intro screen - "REGULAR SEASON 10TH WEEK"
	40: Black intro screen - "REGULAR SEASON 11TH WEEK"
	41: Black intro screen - "REGULAR SEASON 12TH WEEK"
	42: Black intro screen - "REGULAR SEASON 13TH WEEK"
	43: Black intro screen - "REGULAR SEASON 14TH WEEK"
	44: Black intro screen - "REGULAR SEASON 15TH WEEK"
	45: Black intro screen - "REGULAR SEASON 16TH WEEK"
	46: Black intro screen - "REGULAR SEASON 17TH WEEK"
	47: Black intro screen - "REGULAR SEASON 18TH WEEK"
	48: Black intro screen - "REGULAR SEASON WEEK" (small letters)	-UNUSED-
	49:
	4A:
	4B:
	4C:
	4D:
	4E: Final Scoreboard (No O.T.)
	4F: Final Scoreboard (O.T.)
	50:
	51:
	52:
	53:
	54:
	55:
	56:
	57:
	58:
	59:
	5A:
	5B:
	5C:
	5D:
	5E:
	5F:
	60:
	61:
	62:
	63:
	64:
	65:
	66:
	67:
	68:
	69:
	6A:
	6B:
	6C:
	6D:
	6E:
	6F:
	70:
	71:
	72:
	73:
	74:
	75:
	76:
	77:
	78:
	79:
	7A:
	7B:
	7C:
	7D:
	7E:
	7F:

;----------------------------------------------------------------------------------------------
X=0F	 A =
	-----
	00: Main Menu
	01: Main Menu - Preseason Dropdown
	02: Preaeason - Team Select
	03: Season Menu
	04: Team Control
	05: NFL Schedule
	06: NFL Schedule - Dropdown {Auto Skip, Playoffs, Reset}
	07: NFL Schedule - Reset Warning
	08: NFL Schedule - Reset Final Warning
	09: NFL Schedule - Auto Skip #
	0A: Season - NFL Standings
	0B:
	0C: Season - Team Rankings
	0D: Playoff Bracket
	0E:
	0F:
	10: Playoff Bracket
	11:
	12:
	13:
	14:
	15:
	16:
	17: Main Menu - Probowl Dropdown
	18: Probowl - Team Select
	19: Team Data
	1A: Team Roster
	1B:
	1C:
	1D: DF Starters
	1E: Play Book
	1F: Play Chooser
	20:
	21: AFC/NFC All Stars
	22:
	23:
	24: ***Player Data Screen QB
	25: ***Player Data Screen RB,WR,TE
	26: ***Player Data Screen OL
	27: ***Player Data Screen Defense
	28: ***Player Data Screen K
	29: ***Player Data Screen P
	2A: AFC East Standings
	2B: AFC Central Standings
	2C: AFC West Standings
	2D: NFC East Standings
	2E: NFC Central Standings
	2F: NFC West Standings
	30: Standings Screen
	31:
	32: ***OF Starters
	38: ***OF Starters - Starter Reset
	39:
	3A: Team Rankings - Offense NFL
	3B: Team Rankings - Offense AFC
	3C: Team Rankings - Offense NFC
	3D: Team Rankings - Defense NFL
	3E: Team Rankings - Defense AFC
	3F: Team Rankings - Defense NFC
	40: Play Select Screen
	41: ***P1, Off Dropdown Menu
	42: ***P1, Off "Call Timeout"
	43:
	44: ***P1, Def Dropdown Menu
	45: ***P1, Def "Call Timeout"
	46:
	47: ***P2, Off Dropdown Menu
	48: ***P2, Off "Call Timeout"
	49:
	4A: ***P2, Def Dropdown Menu
	4B: ***P2, Def "Call Timeout"
	4C:
	4D:
	4E: ***??? Clock Bkg
	4F: ***??? "#th Down ##" slidebar
	50: ***"\\\Fumble///" slidebar
	51: ***"Punt Kick" slidebar
	52: ***"Field Goal" slidebar
	53: ***"Successful Try" slidebar
	54: ***"No Good" slidebar
	55: ***"First Down" slidebar
	56: ***"Side Change" + "Next Offense ... Next Defense" slidebar
	57: ***"Side Change" + "Next Defense ... Next Offense" slidebar
	58: ***"TOUCHDOWN" slidebar
	59: ***"Try For Point" slidebar
	5A: ***"SAFETY" slidebar
	5B: ***"Incomplete Pass" slidebar
	5C: ***"Touchback" slidebar
	5D: ***"Interception" slidebar
	5E: ***"Field Goal" slidebar
	5F: ***"Recover" slidebar
	60: ***"QB Sack" slidebar
	61: ***"\\\Kick Block///" slidebar
	62: ***"\\\Blocked Punt///" slidebar
	63: ***"\\\Pass Block///" slidebar
	64: ***"\\\Onside Kick///" slidebar
	65: ***"\\\Penalty///" slidebar
	66: ***"Out of Bounds" slidebar
	