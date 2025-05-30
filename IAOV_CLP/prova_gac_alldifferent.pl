:-lib(fd).
:-lib(fd_global_gac).

:-import alldifferent/1 from fd_global_gac.

prova(L):-
	L = [A,B,C,D,E,F],
	L :: [0..10],
	
	alldifferent(L),
	labeling(L).
