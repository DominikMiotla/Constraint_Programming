:-lib(fd).

somma([], 0).
somma([H|T],S):-
	somma(T,S1), S #= S1 + H.

marmellata(L):-
	L = [Aldo, Bruno, Carlo, Dario, Elio, Franco],
	L :: [0,1],
	
	V = [Aldo_V, Bruno_V, Carlo_V, Dario_V, Elio_V],
	V :: [0,1],
	
	somma(L,S1), S1 #= 2,
	somma(V,S2), S2 #= 4,
	
	Dario + Elio #= Aldo_V,
	Carlo + Franco #= Bruno_V,
	Franco + Elio #= Carlo_V,
	Aldo + Elio #= Dario_V,
	Carlo + Bruno #= Elio_V,

	append(L,V,W),
	labeling(W).
