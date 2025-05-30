:- lib(fd).

leq(A,B):-
	dvar_domain(A, DomA),
	dvar_domain(B, DomB),
	dom_range(DomA, MinA, MaxA),
	dom_range(DomB, MinB, MaxB),
	dvar_remove_smaller(B, MinA),
	dvar_remove_greater(A, MaxB),
	( var(A), var(B)
		->	suspend(leq(A,B),3,[A->fd:min, B->fd:max])
		;	true
	).
