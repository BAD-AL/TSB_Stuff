;======================================
;  $2D     = %.... ..TT
;                    ++-game type  0=preseason
;	           1=probowl
;	           2=season
;	           3=playoff/superbowl
;  $69     = %t?.. ....
;             +---------decrease clock
;  $6A/$6B = clock: [sec][min]
;  $70     = play status/possession
;  $75     = game type  [high=p1, low=p2][0=man, 1=coa, 2=com]
;  $76     = current quarter
;  $7F/$80 = line of scrimmage [LEZ= $80 $06, REZ= $80 $09,]
;  $399    = p1 score
;  $39E    = p2 score
;
; more on $70 (jstout)
;   It appears that RAM $70 is:
;   x00 to x3F is Player 1 has the ball
;   x40 to x7F is Player 1 had the ball and turned it over
;   x80 to xBF is Player 2 had the ball and turned it over
;   xC0 to xFF is Player 2 has the ball
;
;======================
; The fumbles are checked at x286DA (regular players) and x286E4 (QB and PR)
; as $3D is compared to the players BC value. If a fumble occurs it goes to
; x286EA and follows along.
; 
; A recovered fumbled is saved at x2B515 (under $72). If by player 1 it is saved
; as x18, x38 (kickoff and punt return), or x48 (blocked kick) and if by player 2
; it is saved as x1C, x3C, or x4C. If the ball is fumbled out of bounds then the
; play ends normally with $72 remaining as x10, x30, or x40.
;