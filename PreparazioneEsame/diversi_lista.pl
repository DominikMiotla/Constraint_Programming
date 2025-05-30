:-lib(fd).

lista_diversi(L):-
    L :: 1..20,
    diversi(L),
    labeling(L).


diversi([_]):-!.
diversi([H|T]):-
    diversi_loop(H,T),
    diversi(T).

diversi_loop(_,[]).
diversi_loop(X,[H|T]):-
    X #\= H,
    diversi_loop(X,T).