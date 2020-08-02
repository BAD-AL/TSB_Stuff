	.org $6A
Time_Seconds:	.db 0
Time_Minutes:	.db 0
P1Team:	.db 0
P2Team:	.db 0

	.org $00F0
Data0_Ptr:	.dw 0	; these are preserved prior to use
Data1_Ptr:	.dw 0	;
	
	.org $00FC
DataPtr:	.dw 0	; (word->ZP)

	.org $00FE
MusicEngine_Song:	.db 0
Prev_BankIndex:	.db 0

	.org $0100
PlayerCalling:	.db 0	; 0=p1, 1=p2 (used for 2pt conversion)

	.org $0200
CURSOR_Y:	.db 0
CURSOR_T:	.db 0
CURSOR_A:	.db 0
CURSOR_X:	.db 0
CURSOR2_Y:	.db 0
CURSOR2_T:	.db 0
CURSOR2_A:	.db 0
CURSOR2_X:	.db 0

	.org $0400
writeVramBuffer:	.db 0	; (byte) bool
vramBufferPtr:	.db 0	; (byte) points where push/pull
PPU2000:	.db 0	; (byte) mod copy of PPU_CTRL
PPU2001:	.db 0	; (byte)  "   "   "  PPU_MASK
PJoypad:	.db 0	; (byte)
PJoypadOld:	.db 0	; (byte)
PJoypadNewlyPressed:	.db 0	; (byte)
LoopVar:	.db 0	; (byte)
StrLen:	.db 0	; (byte)
temp_Y:	.db 0	; (byte)
player_calling:	.db 0	; (byte) player changing plays (0=P1, 1=P2)
old_CURSOR_ATT:	.db 0	; (byte)
old_E1:	.db 0	; (byte) temp storage for cpu ram: $E1
TempVar:	.db 0	; (byte)
TempPB:	.rs $08	; (array: $08) holds the uncompressed playbook
;-----------------------------------------------------------
Temp_ZPVars:	.rs $04	; (byte)
TempLOS:	.dw 0	; (word)
Temp_TeamStorage:	.rs $105	; (array)

	; [$6000 - $6003]

	.org $6004
AttTableArray0:	.rs $20

	; [$6025]

	.org $6026
AttTableArray1:	.rs $20

	; [$6047 - $623F]
	.org $6240
TempA:	.db 0
TempX:	.db 0
TempY:	.db 0
SRAMAutoSkipWeekNumber:	.db 0
;-----
opt_vars:
QtrLength:	.db 0
weatherBool:	.db 0		; 0=FALSE,  1=TRUE
preseasonWeather:	.db 0		; 0=CLEAR,  1=SNOW, 2=RAIN, 3=RANDOM
twoPtConv:	.db 0		; 0=OFF,    1=ON
yardsForFirstLen:	.db 0		; 0=10,     1=20
cpuDifficulty:	.db 0		; 0=NORMAL, 1=JUICED
;-----
weatherType:	.db 0		; 0=plain, 1=snow, 2=rain
twoPtStatus:	.db 0		; determines point value
twoPtAttempted:	.db 0
	;.db 0
	;.db 0
	;.db 0

	.org $6250
Seahawks_SramPtr:	.rs $D0
Cardinals_SramPtr:	.rs $D0
SRAMDivLeadWldCardData:	.rs $0C


	.org $6406
Team1InGameStats:	.rs $105
Team2InGameStats:	.rs $105

	; [$6610 - $6699]

	.org $669A
	.db 0
SRAMTeamCtrlSettings:	.rs $1C

	; [$66B7 - $66BD]

	.org $66BE
SRAMChecksum:	.dw 0		; this has been done

	; [$66BF - $6757]

	.org $6758
SRAMSeasonWeekNumber:	.db 0
SRAMSeasonGameNumber:	.db 0
SRAMSeasonCurWeekMatchUps:	.rs $1C

	; [$6776 - $679F]

	.org $67A0	; $D0 per team
Bills_SramPtr:	.rs $D0
Dolphins_SramPtr:	.rs $D0
Patriots_SramPtr:	.rs $D0
Jets_SramPtr:	.rs $D0
Bengals_SramPtr:	.rs $D0
Browns_SramPtr:	.rs $D0
Oilers_SramPtr:	.rs $D0
Steelers_SramPtr:	.rs $D0
Colts_SramPtr:	.rs $D0
Texans_SramPtr:	.rs $D0
Jaguars_SramPtr:	.rs $D0
Titans_SramPtr:	.rs $D0
Broncos_SramPtr:	.rs $D0
Chiefs_SramPtr:	.rs $D0
Raiders_SramPtr:	.rs $D0
Chargers_SramPtr:	.rs $D0
Redskins_SramPtr:	.rs $D0
Giants_SramPtr:	.rs $D0
Eagles_SramPtr:	.rs $D0
Cowboys_SramPtr:	.rs $D0
Bears_SramPtr:	.rs $D0
Lions_SramPtr:	.rs $D0
Packers_SramPtr:	.rs $D0
Vikings_SramPtr:	.rs $D0
Buccaneers_SramPtr:	.rs $D0
Saints_SramPtr:	.rs $D0
Falcons_SramPtr:	.rs $D0
Panthers_SramPtr:	.rs $D0
SF49ers_SramPtr:	.rs $D0
Rams_SramPtr:	.rs $D0