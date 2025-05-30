:-lib(fd).

lista_diversi(L):-
    L :: 0..10,
    all_different(L),
    labeling(L).



all_different([_]).
all_different([A,B|T]):-
    A #\= B,
    all_different([A|T]),
    all_different([B|T]).