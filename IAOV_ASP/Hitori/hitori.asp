{black(R,C)} :- schema(R,C,V).


:- black(R,C1), black(R,C2), |C1 - C2| = 1.
:- black(R1,C), black(R2,C), |R1 - R2| = 1.

:- schema(R,C1,V), schema(R,C2,V), C1 != C2, not black(R,C1), not black(R,C2).
:- schema(R1,C,V), schema(R2,C,V), R1 != R2, not black(R1,C), not black(R2,C).

white(R,C) :- schema(R,C,V), not black(R,C).

rechable(R,C) :- white(R,C), {white(R,C+1);white(R,C-1);white(R-1,C);white(R+1,C)} >= 1.

:- white(R,C), not rechable(R,C).


#show black/2.