:-lib(fd).

ordina(L):-
    L :: 1..20,
    descrescente(L).

descrescente([_]):-!.
descrescente([A,B|T]):-
    A #> B,
    descrescente([B|T]).
