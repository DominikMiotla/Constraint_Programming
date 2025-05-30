:-lib(fd).

p(X,Y):-
    X :: 1..5,
    Y :: 1..5,
    X #> Y,
    membro(1,[X,Y]).


membro(X,[X|_]).
membro(X,[_|T]) :- membro(X,T)
