{black(R,C)}:- schema(R,C,V).

:- black(R,C1), black(R,C2), C1 != C2, |C1 - C2| = 1.
:- black(R1,C), black(R2,C), R1 != R2, |R1 - R2| = 1.

:- schema(R,C1,V), schema(R,C2,V), C1 != C2, not black(R,C1), not black(R,C2).
:- schema(R1,C,V), schema(R2,C,V), R1 != R2, not black(R1,C), not black(R2,C).

white(R,C) :- schema(R,C,V), not black(R,C).

root(1,1) :- white(1,1).
root(1,2) :- white(1,2).

reachable(R,C) :- root(R,C).
reachable(R,C1) :- white(R,C1), reachable(R,C2), C1 != C2, |C1 - C2| = 1.
reachable(R1,C) :- white(R1,C), reachable(R2,C), R1 != R2, |R1 - R2| = 1.
:- white(R,C), not reachable(R,C).


#show black/2.