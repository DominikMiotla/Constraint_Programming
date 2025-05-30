:-lib(fd).

righello(L,N,Lmax):-
    length(L,N),
    L :: 0..Lmax,
    ordina(L),
    lista_distanze(L,LD),
    alldifferent(LD),
    labeling(L).

ordina([_]).
ordina([A,B|T]):- A #< B, ordina([B|T]).

lista_distanze([],[]).
lista_distanze([H|T],LD):-
    distanze(H,T,L1),
    lista_distanze(T,L2),
    append(L2,L1,LD).


distanze(_,[],[]).
distanze(X,[H|T],[Z|L]):- Z #= H - X, distanze(X,T,L).     