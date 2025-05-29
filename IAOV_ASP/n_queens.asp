#const costanteN = 8.

scacchiera(1..costanteN).

{queen(R,C)} :- scacchiera(R), scacchiera(C).

:- queen(R,C1), queen(R,C2), C1 != C2. 
:- queen(R1,C), queen(R2,C), R1 != R2.

:- queen(R1,C1), queen(R2,C2), R1 != R2, C1 != C2, R1 + C1 = R2 + C2.
:- queen(R1,C1), queen(R2,C2), R1 != R2, C1 != C2, R1 - C1 = R2 - C2.

:- scacchiera(R), not queen(R,_).

#show queen/2.
