

no_overlap(S1,D1,S2,D2):-
	S1 + D1 #=< S2.
no_overlap(S1,D1,S2,D2):-
	S2 + D2 #=< S2.



no_overlap(S1,D1,S2,D2):-
	#=<(S1+D1,S2,B1),
	#=<(S2+D2,S1,B2),
	B1 + B2 #>=1.
