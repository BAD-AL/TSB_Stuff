; tackled code

$81E3:A9 F0     LDA #$F0		; remove a sprite???
$81E5:8D 0C 02  STA $020C = #$F0
$81E8:20 CC 90  JSR $90CC
$81EB:20 29 8F  JSR $8F29
; insert 2pt attemt chech here
;   if so (jump $8775)
$81EE:B0 0F     BCS $81FF		;   branch if (turnover on downs)
$81F0:20 01 93  JSR $9301		; player still has possession
$81F3:20 D9 9A  JSR $9AD9
$81F6:20 05 90  JSR $9005
$81F9:20 63 9E  JSR $9E63
$81FC:4C 23 81  JMP $8123
$81FF:20 14 93  JSR $9314		; turnover on downs
$8202:20 63 9E  JSR $9E63
$8205:4C 7B 87  JMP $877B