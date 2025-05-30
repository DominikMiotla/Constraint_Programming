:- lib(fd).
:- lib(edge_finder3).
:- lib(fd_global).

endtime([],[],[]).
endtime([H1|T1], [H2|T2], [H|T]):- H #= H1 + H2, endtime(T1, T2, T).

colf(L):-
	% La lista L contiene gli start_time dei job
	L = [Lavatrice, Asciugatrice, Stirare, Lavastoviglie, Impastare, Lievitazione, Preiscaldamento, Cottura, Pulizia],
	L :: [0..200],
	
	DurataLievitazione = 60,
	Durata = [45, 60, 60, 40, 15, DurataLievitazione, 5, 15, 120],
	Energia = [1700, 1000, 2000, 1800, 0, 0, 2000, 2000, 0],
	Colf = [0, 0, 1, 0, 1, 0, 0, 0, 1],
	MaxColf = 1,
	MaxEnergia = 3000,
	
	cumulative(L, Durata, Colf, MaxColf),
	cumulative(L, Durata, Energia, MaxEnergia),
	
	Asciugatrice #> Lavatrice + 45,
	Stirare #> Asciugatrice + 60,
	
	Lievitazione #> Impastare + 15,
	Preiscaldamento #> Lievitazione + DurataLievitazione,
	Cottura #> Preiscaldamento + 5,
	
	endtime(L,Durata, Endtimes),
	maxlist(Endtimes, EndtimeMax),
	EndtimeMax #<= 200,
	
	fd_global:alldifferent(L),
	
	labeling(L).
	
	
