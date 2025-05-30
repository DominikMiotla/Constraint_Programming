:-lib(fd).

lista_ordinata(L):-
    L :: 0..10,
    ordina(L).


ordina([_]).
ordina([A,B|T]):- A #> B, ordina([B|T]).