:- [graph].
:- lib(fd).
:- lib(fd_global).

clique(L):-
    length(L,5),
    L :: [0,1],
    clique_loop(L,1),
    sumlist(L,Somma),
    C #= - Somma,
    min_max(labeling(L),C).

clique_loop([],_).
clique_loop([H|T],N):-
    N1 is N + 1,
    exist_arc(H,N,T,N1),
    clique_loop(T,N1).


exist_arc(_,_,[],_).
exist_arc(A,N,[H|T],N1):-
    (edge(N,N1)
        ->true
        ; A + H #<= 1    
    ),
    N1_new is N1 + 1,
    exist_arc(A,N,T,N1_new).

