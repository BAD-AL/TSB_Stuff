; $35 = P1 buttons pressed
; $36 = P2 buttons pressed
; $37 = ($35 | $36)
; $38 = P1 newly pressed buttons
; $39 = P2 newly pressed buttons
; $3A = ($38 | $39)

$C24F:A5 48     LDA $48		; ???
$C251:85 34     STA $34		; ???
$C253:A2 02     LDX #$02	; start on joypad2
$C255:A9 04     LDA #$04	; set joypad loop = 4
$C257:85 47     STA $47		;
$C259:B5 34     LDA $34, X	; set curLoop_buttons == "old" 
$C25B:85 48     STA $48		;   or lastLoop_buttons (depends on loop index)
$C25D:A9 01     LDA #$01	; strobe joypad port
$C25F:8D 16 40  STA $4016	;
$C262:A9 00     LDA #$00	;
$C264:8D 16 40  STA $4016	;
$C267:A0 08     LDY #$08	; set button loop == 8

$C269:BD 15 40  LDA $4015, X	; read joypad port
$C26C:4A        LSR		; shift button bit to C flag
$C26D:26 46     ROL $46		; combine C flag with button var
$C26F:29 01     AND #$01	;
$C271:05 46     ORA $46		;
$C273:85 46     STA $46		;
$C275:88        DEY		;
$C276:D0 F1     BNE $C269	; loop if more buttons to read

$C278:C5 48     CMP $48		; if(curLoop_buttons == lastLoop_buttons)
$C27A:F0 07     BEQ $C283	;   branch to save
$C27C:C6 47     DEC $47		; else, decrease joypad loop counter
$C27E:D0 DB     BNE $C25B	; if (not zero) read current joypad again
$C280:4C 8F C2  JMP $C28F	; else, jump to advance to next joypad

$C283:B5 34     LDA $34, X	; get "old" button presses
$C285:45 46     EOR $46		;
$C287:25 46     AND $46		;
$C289:95 37     STA $37, X	; save "new" buttons for this frame
$C28B:A5 46     LDA $46		;
$C28D:95 34     STA $34, X	; save "new" buttons to "old"
$C28F:CA        DEX		; goto next joypad index
$C290:D0 C7     BNE $C259	; loop if joypad1 not read

$C292:A5 35     LDA $35		; merge both button presses
$C294:05 36     ORA $36		; 
$C296:85 37     STA $37		;
$C298:A5 38     LDA $38		; merge both new button presses
$C29A:05 39     ORA $39		;
$C29C:85 3A     STA $3A		;

; switch:	$35<->$36
;	$38<->$39
