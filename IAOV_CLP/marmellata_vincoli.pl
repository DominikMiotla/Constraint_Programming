:-lib(fd).

somma([], 0).
somma([H|T],S):-
	somma(T,S1), S #= S1 + H.

marmellata(L):-
	L = [Aldo, Bruno, Carlo, Dario, Elio, Franco],
	L :: [0,1],
	
	M = [Aldo_M, Bruno_M, Carlo_M, Dario_M, Elio_M],
	M :: [0,1],
	
	somma(L,S1), S1 #= 2,
	somma(M,S2), S2 #= 1,
	
	Dario + Elio #= 1 #<=>  Aldo_M #= 0,
	Carlo + Franco #= 1 #<=> Bruno_M #= 0,
	Franco + Elio #= 1 #<=> Carlo_M #= 0,
	Aldo + Elio #= 1 #<=> Dario_M #= 0,
	Carlo + Bruno #= 1 #<=> Elio_M #=0,

	append(L,M,W),
	labeling(W).
