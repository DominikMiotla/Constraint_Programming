:- lib(fd).
:- lib(fd_global).
:- lib(edge_finder3).

end_time_tsks([],[],[]).
end_time_tsks([H1|T1], [H2|T2], [D|R]):- D #= H1 + H2, end_time_tsks(T1, T2, R).



colf(L):-

	L = [Lavatrice, Asciugatrice, Stirare, Lavastoviglie, Impasto, Lievitazione, Preiscaldamento, Cottura, Pulizia],
	L :: [0..200],
	B :: [60..120],
	
	Durata = [45, 60, 60, 40, 15, B, 5, 15, 120],
	Colf = [0, 0, 1, 0, 1, 0, 0, 0, 1],
	Energia = [1700, 1000, 2000, 1800, 0, 0, 2000, 2000, 0],
	
	cumulative(L, Durata, Colf, 1),
	cumulative(L,Durata, Energia, 3000),
	
	end_time_tsks(L, Durata, EndTimeList),
	maxlist(EndTimeList, EndTime),
	EndTime #=< 200,
	
	Asciugatrice #> Lavatrice + 45,
	Stirare #> Asciugatrice + 60,
	
	Lievitazione #> Impasto,
	Preiscaldamento #> Lievitazione - 5,
	Cottura #> Preiscaldamento + 5,
	
	labeling(L).
