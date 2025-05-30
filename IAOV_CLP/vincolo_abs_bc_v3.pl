:- lib(fd).


abs_val(X,A):-
	
	dvar_domain(X, DomX),
	dvar_domain(A, DomA),
	
	dom_range(DomX, MinX, MaxX),
	dom_range(DomA, _, MaxA),
	
	T1 is -MinX,
	max(T1,MaxX, Mx),
	dvar_remove_greater(A,Mx),
	
	T2 is -MaxA,
	dvar_remove_greater(X, MaxA),
	dvar_remove_smaller(X, T2),
	
	dvar_remove_smaller(A,0),
	
	(dom_intersection(DomX, DomA, DomI, _)
		-> dom_range(DomI, MinI, _), dvar_remove_smaller(A, MinI)
		; T3 is -MaxX, dvar_remove_smaller(A, T3)
	),
	
	(var(X), var(A)
		-> suspend(abs_val(X,A), 3, [X->fd:min, X->fd:max, A->fd:max])
		; true
	).
