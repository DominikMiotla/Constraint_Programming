:-lib(fd).

somma_lista(L,S):-
    L :: 1..20,
    somma(L,S),
    labeling(L).

somma([],0).
somma([H|T],S):-
    S #= H + S1,
    somma(T,S1).