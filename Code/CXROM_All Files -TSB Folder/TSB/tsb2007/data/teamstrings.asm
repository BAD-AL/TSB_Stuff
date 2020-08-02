
; a re-organized string data bank

AbrevPtrs:	.dw BillsAbr,DolphinsAbr, PatriotsAbr, JetsAbr
	.dw BengalsAbr, BrownsAbr, OilersAbr, SteelersAbr
	.dw ColtsAbr, TexansAbr, JaguarsAbr, TitansAbr
	.dw BroncosAbr, ChiefsAbr, RaidersAbr, ChargersAbr
	.dw RedskinsAbr, GiantsAbr, EaglesAbr, CowboysAbr
	.dw BearsAbr, LionsAbr, PackersAbr, VikingsAbr
	.dw BuccaneersAbr, SaintsAbr, FalconsAbr, PanthersAbr
	.dw AFCAbr, NFCAbr
	.dw SF49ersAbr, RamsAbr, SeahawksAbr, CardinalsAbr

CityPtrs:	.dw BillsCity, DolphinsCity, PatriotsCity, JetsCity
	.dw BengalsCity, BrownsCity, OilersCity, SteelersCity
	.dw ColtsCity, TexansCity, JaguarsCity, TitansCity
	.dw BroncosCity, ChiefsCity, RaidersCity, ChargersCity
	.dw RedskinsCity, GiantsCity, EaglesCity, CowboysCity
	.dw BearsCity, LionsCity, PackersCity, VikingsCity,
	.dw BuccaneersCity, SaintsCity, FalconsCity, PanthersCity
	.dw AFCCity, NFCCity		; here for compatibility
	.dw SF49ersCity, RamsCity, SeahawksCity, CardinalsCity

NamePtrs:	.dw BillsName, DolphinsName, PatriotsName, JetsName
	.dw BengalsName, BrownsName, OilersName, SteelersName
	.dw ColtsName, TexansName, JaguarsName, TitansName
	.dw BroncosName, ChiefsName, RaidersName, ChargersName
	.dw RedskinsName, GiantsName, EaglesName, CowboysName
	.dw BearsName, LionsName, PackersName, VikingsName
	.dw BuccaneersName, SaintsName, FalconsName, PanthersName
	.dw AFCName, NFCName
	.dw SF49ersName, RamsName, SeahawksName, CardinalsName

	.dw FirstDown, SecondDown, ThirdDown, FourthDown
	.dw Mode_MAN_TC, Mode_COA_TC, Mode_COM_TC, Mode_SKP_TC
	.dw LblOffense, LblDefense, Lbl_EastDiv, Lbl_CentralDiv, Lbl_WestDiv
	.dw Lbl_NFL, AFCUnknown2, NFCUnknown2
	.dw Mode_MAN, Mode_COA, Mode_COM, Mode_SKP
	.dw Lbl_Exp_SouthDiv, EndOfStringBank

BillsAbr:	.db "BUF."
DolphinsAbr:	.db "MIA."
PatriotsAbr:	.db "N.E."
JetsAbr:	.db "NYJ."
BengalsAbr:	.db "CIN."
BrownsAbr:	.db "CLE."
OilersAbr:	.db "BAL."
SteelersAbr:	.db "PIT."
ColtsAbr:	.db "IND."
TexansAbr:	.db "HOU."
JaguarsAbr:	.db "JAX."
TitansAbr:	.db "TEN."
BroncosAbr:	.db "DEN."
ChiefsAbr:	.db "K.C."
RaidersAbr:	.db "OAK."
ChargersAbr:	.db "S.D."
RedskinsAbr:	.db "WAS."
GiantsAbr:	.db "NYG."
EaglesAbr:	.db "PHI."
CowboysAbr:	.db "DAL."
BearsAbr:	.db "CHI."
LionsAbr:	.db "DET."
PackersAbr:	.db "G.B."
VikingsAbr:	.db "MIN."
BuccaneersAbr:	.db "T.B."
SaintsAbr:	.db "N.O."
FalconsAbr:	.db "ATL."
PanthersAbr:	.db "CAR."
AFCAbr:	.db "AFC", SPACE
NFCAbr:	.db "NFC", SPACE
SF49ersAbr:	.db "S.F."
RamsAbr:	.db "STL."
SeahawksAbr:	.db "SEA."
CardinalsAbr:	.db "ARZ."
BillsCity:	.db "BUFFALO"
DolphinsCity:	.db "MIAMI"
PatriotsCity:	.db "NEW ENGLAND"
JetsCity:	.db "NEW YORK"
BengalsCity:	.db "CINCINNATI"
BrownsCity:	.db "CLEVELAND"
OilersCity:	.db "BALTIMORE"
SteelersCity:	.db "PITTSBURGH"
ColtsCity:	.db "INDIANAPOLIS"
TexansCity:	.db "HOUSTON"
JaguarsCity:	.db "JACKSONVILLE"
TitansCity:	.db "TENNESSEE"
BroncosCity:	.db "DENVER"
ChiefsCity:	.db "KANSAS CITY"
RaidersCity:	.db "OAKLAND"
ChargersCity:	.db "SAN DIEGO"
RedskinsCity:	.db "WASHINGTON"
GiantsCity:	.db "NEW YORK"
EaglesCity:	.db "PHILADELPHIA"
CowboysCity:	.db "DALLAS"
BearsCity:	.db "CHICAGO"
LionsCity:	.db "DETROIT"
PackersCity:	.db "GREEN BAY"
VikingsCity:	.db "MINNESOTA"
BuccaneersCity:	.db "TAMPA BAY"
SaintsCity:	.db "NEW ORLEANS"
FalconsCity:	.db "ATLANTA"
PanthersCity:	.db "CAROLINA"
AFCCity:	.db SPACE
NFCCity:	.db SPACE
SF49ersCity:	.db "SAN FRANCISCO"
RamsCity:	.db "ST LOUIS"
SeahawksCity:	.db "SEATTLE"
CardinalsCity:	.db "ARIZONA"



BillsName:	.db "BILLS"
DolphinsName:	.db "DOLPHINS"
PatriotsName:	.db "PATRIOTS"
JetsName:	.db "JETS"
BengalsName:	.db "BENGALS"
BrownsName:	.db "BROWNS"
OilersName:	.db "RAVENS"
SteelersName:	.db "STEELERS"
ColtsName:	.db "COLTS"
TexansName:	.db "TEXANS"
JaguarsName:	.db "JAGUARS"
TitansName:	.db "TITANS"
BroncosName:	.db "BRONCOS"
ChiefsName:	.db "CHIEFS"
RaidersName:	.db "RAIDERS"
ChargersName:	.db "CHARGERS"
RedskinsName:	.db "REDSKINS"
GiantsName:	.db "GIANTS"
EaglesName:	.db "EAGLES"
CowboysName:	.db "COWBOYS"
BearsName:	.db "BEARS"
LionsName:	.db "LIONS"
PackersName:	.db "PACKERS"
VikingsName:	.db "VIKINGS"
BuccaneersName:	.db "BUCCANEERS"
SaintsName:	.db "SAINTS"
FalconsName:	.db "FALCONS"
PanthersName:	.db "PANTHERS"
AFCName:	.db "AFC"
NFCName:	.db "NFC"
SF49ersName:	.db "49ERS"
RamsName:	.db "RAMS"
SeahawksName:	.db "SEAHAWKS"
CardinalsName:	.db "CARDINALS"

FirstDown:	.db "1ST"
SecondDown:	.db "2ND"
ThirdDown:	.db "3RD"
FourthDown:	.db "4TH"

; these are used on the "Team Control" screen
Mode_MAN_TC:	.db $D6, $D7, $B8	; man
Mode_COA_TC:	.db $D4, $D5, $D7	; coa
Mode_COM_TC:	.db $D4, $D5, $D6	; com
Mode_SKP_TC:	.db $DB, $DC, $DD	; skp

LblOffense:	.db "OFFENSE"
LblDefense:	.db "DEFENSE"
Lbl_EastDiv:	.db "EAST"
Lbl_CentralDiv:	.db "NORTH"
Lbl_WestDiv:	.db "WEST"
Lbl_NFL:	.db "NFL"
AFCUnknown2:	.db "AFC"
NFCUnknown2:	.db "NFC"
Mode_MAN:	.db "MAN"
Mode_COA:	.db "COA"
Mode_COM:	.db "COM"
Mode_SKP:	.db "SKP"
Lbl_Exp_SouthDiv:	.db "SOUTH"
EndOfStringBank:	.db $FF