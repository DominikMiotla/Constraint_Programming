:-lib(fd).

somma_lista(L,S):-
    L :: 0..10,
    S :: 0..100,
    somma(L,S),
    labeling([S|L]).

somma_lista2(L,S):-
    L :: 0..10,
    S :: 0..100,
    somma(L,S),
    append(L,[S],Z),
    labeling(Z).

somma_lista3(L,S):-
    L :: [0..10],
    S :: [0..100],
    somma(L,S),
    labelingff([S|L]).

labelingff([]).
labelingff(L):-
    deleteff(X,L,R),
    indomain(X),
    labelingff(R).


somma([],0).
somma([A|T],S) :- somma(T,S1), S #= S1 + A.