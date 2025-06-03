:- [pazienti15b].
:- lib(fd).
:- lib(propia).
:- lib(fd_global).

tsp(L):-
    generate_variables(Domain,Dim),
    length(L,Dim),
    L :: Domain,

    impose_start(L),
    fd_global:alldifferent(L),

    route(L,0,Cost),

    append(L,[Cost],Vars),
    minimize(labeling(Vars),Cost).



route([A],Acc,Cost):-!,
    distanza(A,0,C) infers most,
    Cost #= Acc + C.
route([A,B|T],Acc,Cost):-
    distanza(A,B,C) infers most,
    paziente(B,Min,Max) infers most,
    Time #= Acc + C,
    Time #>= Min,
    Time #<= Max,
    route([B|T],Time,Cost).


impose_start([H|_]):-
    H #= 0.


generate_variables(Domain,Dim):-
    findall(ID, paziente(ID,_,_),ListID),
    append(ListID,[0],Domain),
    length(Domain,Dim).