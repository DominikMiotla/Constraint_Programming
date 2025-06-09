:- [pazienti].
:- lib(fd).
:- lib(propia).

tsp_tw(TSP):-
    generate_domain(Domain,Dim),
    length(TSP,Dim),
    TSP :: Domain,

    impose_start_route(TSP),
    alldifferent(TSP),
    exist_arc(TSP,0,FinalCost),
    append(TSP,[FinalCost],Vars),
    minimize(labeling(TSP),Vars).


exist_arc([A],ActualCost,FinalCost):-!,
    distanza(A,0,C) infers most,
    FinalCost #= ActualCost + C.
exist_arc([A,B|ListNode],ActualCost,FinalCost):-
    distanza(A,B,C) infers most,
    Cost #= ActualCost + C,
    paziente(B,Min,Max) infers most,
    Cost #>= Min,
    Cost #<= Max,
    exist_arc([B|ListNode],Cost,FinalCost).


impose_start_route([H|_]):-
    H #= 0.

generate_domain(Domain,Dim):-
    findall(ID,paziente(ID,_,_),ListID),
    append(ListID,[0],Domain),
    length(Domain,Dim).