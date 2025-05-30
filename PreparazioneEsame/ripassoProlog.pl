fattoriale(0,1).
fattoriale(N,Y):-
    N > 0, N1 is N - 1, fattoriale(N1,Y1), Y is Y1*N.

modulo(X,X):- X >= 0.
modulo(X,Y):- X < 0, Y is - X.

lunghezza([],0).
lunghezza([_|T],N):-
    lunghezza(T,N1), N is N1 + 1.

lunghezzaT(L,N):-lunghezzaT(L,0,N).
lunghezzaT([],N,N).
lunghezzaT([_|T],Acc,N):-
    Acc1 is Acc + 1, lunghezzaT(T,Acc1,N).

somma([],0).
somma([H|T],S):-
    somma(T,S1), S is H + S1.

sommaT(L,S):- sommaT(L,0,S).
sommaT([],S,S).
sommaT([H|T],Acc,S):-
    Acc1 is Acc + H, sommaT(T,Acc1,S).

conta(_,[],0):-!.
conta(X,[X|T],N):-
    !,conta(X,T,N1), N is N1 + 1.
conta(X,[_|T],N):-
    conta(X,T,N).

fib(0,0):-!.
fib(1,1):-!.
fib(N,Y):-
    N > 0, N1 is N - 1, N2 is N - 2, fib(N1,Y1), fib(N2,Y2), Y is Y1 + Y2.

lista([]).
lista([_|T]):- lista(T).

membro(X,[X|_]):-!.
membro(X,[_|T]):- membro(X,T).

ultimo([X],X).
ultimo([_|T],X):-ultimo(T,X).

myappend([],L2,L2).
myappend([H|T],L2,[H|L]):-
    myappend(T,L2,L).


depth_member(X,[X|_]).
depth_member(X,[H|_]):-
    lista(H), depth_member(X,H).
depth_member(X,[_|T]):-
    depth_member(X,T).

elimina(_,[],[]):-!.
elimina(X,[X|T],L):-
    !,elimina(X,T,L).
elimina(X,[H|T],[H|L]):-
    elimina(X,T,L).

del_rip([],[]).
del_rip([H|T],L):-
    membro(H,T),!,del_rip(T,L).
del_rip([H|T],[H|L]):-
    del_rip(T,L).

no_rip([],[]).
no_rip([H|T],[H|L]):-
    membro(H,T),!,elimina(H,T,T1),no_rip(T1,L).
no_rip([H|T],[H|L]):-
    no_rip(T,L).

no_dup([],[]).
no_dup([H|T],L):-
    membro(H,T),!,no_dup(T,L).
no_dup([H|T],[H|L]):-
    no_dup(T,L).

no_membro(_,[]).
no_membro(X,[H|T]):-
    X \== H, no_membro(X,T).

my_reverse([],[]).
my_reverse([H|T],L):-
    my_reverse(T,L2), myappend(L2,[H],L).

unione([],L,L).
unione([H|T],L2,L):-
    membro(H,L2),!,unione(T,L2,L).
unione([H|T],L2,[H|L]):-
    unione(T,L2,L).

intersezione([],_,[]).
intersezione([H|T],L2,[H|L]):-
    membro(H,L2),!,intersezione(T,L2,L).
intersezione([_|T],L2,L):-
    intersezione(T,L2,L).