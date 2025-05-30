:-lib(fd).
:-lib(fd_global_gac).

turni(L):-
	L = [Peter, Paul, Mary, John, Bob, Mike, Julia],
	[Peter, Paul, Mary, John] :: 1..2,
	Bob :: 2..3,
	Mike :: [2,4,5],
	Julia :: [3,5],
	gcc([gcc(1,2,1),gcc(1,2,2),gcc(1,1,3),gcc(0,2,4),gcc(0,2,5)],L),
	labeling(L).
