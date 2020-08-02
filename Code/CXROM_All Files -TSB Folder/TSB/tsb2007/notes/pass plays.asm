I can give you the "compare" numbers and the branches should be right there with them:

QB vs DB:
DB whiff threshold: x29C9A default: x0F
DB INT threshold: x29C9E default: x03

QB+WR: x29D7A DEFAULT: x4F

QB+WR vs DB comparison:
INT threshold x29D8C, x29D9F, x29DB2 DEFAULT: x33
CATCH threhold x29D90, x29DA4, x29DB6 DEFAULT: x50

------

The QB+WR vs DB Code is like this:

Code:
; Section to determine outcome
LDA $45
SEC
BCC $9D96
LDY $E7
CMP #$33
BCC $9DF1 ; Interception
CMP #$50
BCC $9DEE ; Deflection
;Else it becomes a Reception:
LDX $DD ; <- $9D96
LDA $E8
JSR $9E76