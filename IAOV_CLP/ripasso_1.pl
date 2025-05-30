:-lib(fd).

lista_decrescente(L):-
    L :: [0..10],
    ordina(L).

lista_diversi(L):-
    L :: [0..10],
    diversi(L),
    labeling(L).

lista_somma(L,S):-
    L :: [0..10],
    S :: [0..100],
    somma(L,S).

somma([],0).
somma([H|T],S) :- somma(T,S1), S #= S1 + H.


ordina([_]).
ordina([A,B|T]):-
    A #> B,
    ordina([B|T]).

diversi([_]).
diversi([A,B|T]):-
    A #\= B,
    diversi([A|T]),
    diversi([B|T]).

ordina_d([_]).
ordina_d([A,B|T]):-
    A #< B,
    ordina_d([B|T]).

righello(L,N,Lmax):-
    length(L,N),
    L :: [0..Lmax],
    ordina_d(L),
    lista_distanze(L,LD),
    alldifferent(LD),
    labeling(L).

lista_distanze([],[]).
lista_distanze([H|T],LD):-
    distanza(H,T,L1),
    lista_distanze(T,L2),
    append(L1,L2,LD).

distanza(_,[],[]).
distanza(X,[H|T],[Z|L]):-
    Z #= H - X,
    distanza(X,T,L).