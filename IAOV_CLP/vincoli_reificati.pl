:-lib(fd).

somma([], 0).
somma([H|T], S):-
	somma(T,S1), S #= H + S1.

reificati(L):-
	L = [B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16,B17,B18,B19,B20],
	L :: [0,1],
	
	%i
	B6 #= B7 #<=> B1,
	%ii
	B1 #= 0 #<=> B2,
	%iii
	B4 #\= B20 #<=> B3,
	%iv
	B3 #\= B20 #<=> B4,
	%v
	B5 #\= B19 #<=> B5,
	%vi
	B2 #= 1 #<=> B6,
	%vii
	B15 #= 1 #<=> B7,
	%viii
	B11 #= B19 #<=> B8,
	%ix
	B10 #= 1 #<=> B9,
	%x
	B13 #= 0 #<=> B10,
	%xii
	B16 #= 1 #<=> B12,
	%xiii
	B12 #= 1 #<=> B13,
	%xiv
	B14 #= B11 #<=> B14,
	%xv
	somma(L,S1), S1 #=< 10 #<=> B15,
	%xvi
	somma(L,S2), S2 #>= 10 #<=> B16,
	%xvii
	B9 #= B4 #<=> B17,
	%xviii
	B7 #= 1 #<=> B18,
	%xx
	B3 #\= B4 #<=> B20,
	labeling(L).
	
	
	
	
