VERSION	equ "119"


; variables
PPU2000_orig	equ $31	; gameplay copy (reload when exiting)
PPU2001_orig	equ $32	;
ATTaddrLO	equ $3E	; for attribute data
ATTaddrHI	equ $3F	;
lenofname	equ $40	; string processing
lenofcity	equ $41	; string processing
STRaddrLO	equ $65	; for string data
STRaddrHI	equ $66	;
lenofstring	equ $68	; string processing
CurrentQuarter	equ $76	; gameplay: quarter var
CurrentLOS	equ $7F	; ball position vars
OriginalBallPosY	equ $81	;
OriginalLOS	equ $82	;
LHPaddrLO	equ $A0	; for large helmet palette
LHPaddrHI	equ $A1	;
CursorY	equ $E1	; menu cursor
CursorX	equ $E2	;

; addresses
SHADOW_OAM	equ $0200	; sprite oam page
VRAMBUFFER	equ $0400	; points to bottom of stack
P1_INGAME_PBOOK	equ $64F8
P2_INGAME_PBOOK	equ $65FD
P1_INGAME_DECOMP_PB	equ $667E
P2_INGAME_DECOMP_PB	equ $6686
AFC_PLAYBOOK	equ $6748
NFC_PLAYBOOK	equ $6750
SF_ATTS	equ $BCCC
STL_ATTS	equ $BD41
SEA_ATTS	equ $BDB6
ARZ_ATTS	equ $BE2B

random1	equ $30
random2	equ $3B
random3	equ $3C
random4	equ $3D

; mod constants
YEAR	equ "2007"
FALSE	equ $00
TRUE	equ $01
SHADOW_PAGE	equ #$02
SPRITENULL	equ $F8

SPACE	equ $00	; ascii
DASH	equ $3B	; ascii
NUMBER_MASK	equ $30
PLAY_LEN	equ $0F	; max len of play name

probowlINDEX	equ #$1C
teamindexLOW	equ #$1E
teamindexHIGH	equ #$22
CHR_0800_LEFT	equ $1E
CHR_0800_RIGHT	equ $22
PTS_USE6	equ $00	; for 2pt conversion
PTS_USE2	equ $01	; for 2pt conversion
TIME_MIN_BASE	equ $04

; NES-> CPU/PPU/APU/CART registers
PPU_CTRL	equ $2000
PPU_MASK	equ $2001
PPU_STATUS	equ $2002
OAM_ADDR	equ $2003
PPU_SCROLL	equ $2005
PPU_ADDR	equ $2006
PPU_DATA	equ $2007
SPR_OAM	equ $4014
PORT1	equ $4016
PORT2	equ $4017
MMC3_CTRL	equ $8000
MMC3_DATA	equ $8001
MMC3_MIR	equ $A000
MMC3_PRGRAM_CTRL	equ $A001
MMC3_IRQ_LATCH	equ $C000
MMC3_IRQ_RELOAD	equ $C001
MMC3_IRQ_DISABLE	equ $E000
MMC3_IRQ_ENABLE	equ $E001
MIR_VERT	equ #$00
MIR_HORIZ	equ #$01
pAPU_CTRL	equ $4015	; APU register


; joypad constants
BUTTON_A	equ #%10000000	; regular masks
BUTTON_B	equ #%01000000
BUTTON_SEL	equ #%00100000
BUTTON_STA	equ #%00010000
BUTTON_UP	equ #%00001000
BUTTON_DOWN	equ #%00000100
BUTTON_LEFT	equ #%00000010
BUTTON_RIGHT	equ #%00000001

; team constants
BUF	equ $00
MIA	equ $01
NE	equ $02
JETS	equ $03
CIN	equ $04
CLE	equ $05
BAL	equ $06
PIT	equ $07
IND	equ $08
HOU	equ $09
JAX	equ $0A
TEN	equ $0B
DEN	equ $0C
KC	equ $0D
OAK	equ $0E
SD	equ $0F
WAS	equ $10
GIA	equ $11
PHI	equ $12
DAL	equ $13
CHI	equ $14
DET	equ $15
GB	equ $16
MIN	equ $17
TB	equ $18
NO	equ $19
ATL	equ $1A
CAR	equ $1B
AFC	equ $1C
NFC	equ $1D
SF	equ $1E
RAMS	equ $1F
SEA	equ $20
ARZ	equ $21

; position constants
QB1	equ $00
QB2	equ $01
RB1	equ $02
RB2	equ $03
RB3	equ $04
RB4	equ $05
WR1	equ $06
WR2	equ $07
WR3	equ $08
WR4	equ $09
TE1	equ $0A
TE2	equ $0B
OL_C	equ $0C
OL_LG	equ $0D
OL_RG	equ $0E
OL_LT	equ $0F
OL_RT	equ $10
DL_RE	equ $11
DL_NT	equ $12
DL_LE	equ $13
ROLB	equ $14
RILB	equ $15
LILB	equ $16
LOLB	equ $17
RCB	equ $18
LCB	equ $19
FS	equ $1A
SS	equ $1B
ST_K	equ $1C
ST_P	equ $1D

; function indexes for PRG15 anchor
PRG15_NEW_ATT	equ $00
PRG15_DEC_PROBWL_INDEX	equ $01
PRG15_INC_PROBWL_INDEX	equ $02
PRG15_SWAP_TEAMS	equ $03
PRG15_OPTION_MENU	equ $04
PRG15_PB_EDITOR	equ $05
PRG15_SET_WEATHER	equ $06
PRG15_HALFTIME_TEXT	equ $07

; weather constants
WEATHER_CLEAR	equ $00
WEATHER_SNOW	equ $01
WEATHER_RAIN	equ $02
WEATHER_RAND	equ $03

CLEAR_PAL	equ $1A
CLEAR_DARK_PAL	equ $09
RAIN_PAL	equ $18
RAIN_DARK_PAL	equ $08
SNOW_PAL	equ $22	; $21
SNOW_DARK_PAL	equ $12	; $11

; quarter constants
FIRST_QTR	equ $00
SECOND_QTR	equ $01
THIRD_QTR	equ $02
FOURTH_QTR	equ $03
