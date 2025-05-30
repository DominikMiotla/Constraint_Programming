:- [distanze].
:- lib(fd).
:- lib(propia).
:- lib(fd_global).

tsp(TSP,S):-
	ncitta(N),
	length(TSP, N),
	TSP :: [1..N],
	
	imposeStartCity(TSP),
	fd_global:alldifferent(TSP),
	existArc(TSP,Distanza),
	
	sumlist(Distanza,S),
	min_max(labeling(TSP),S).
	


imposeStartCity([H|_]):-
	H #= 1.

existArc([A|[]],[D]):-!,
	dista(A,1,D) infers most.

existArc([A,B|T],[D|R]):-
	dista(A,B,D) infers most,
	existArc([B|T],R).
