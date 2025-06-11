pos(N) :- car(N,_).
1{schedule(N,C,P) : pos(P)}1 :- car(N,C).

:- schedule(N1,_,P), schedule(N2,_,P), N1 != N2.

costo(P1,P2):- schedule(N1,C1,P1), schedule(N2,C2,P2), P2 = P1 + 1, C1 != C2.

#minimize{1,P1,P2 : costo(P1,P2)}.


#show schedule/3.