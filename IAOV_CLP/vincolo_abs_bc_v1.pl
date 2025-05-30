:- lib(fd).


abs_val(X,A):-

	dvar_remove_smaller(A,0),
	
	dvar_domain(X, DomX),
	dvar_domain(A, DomA),
	
	%Modifico il minimo di A, X potrebbe avere solo valori positivi.
	dom_intersection(DomX, DomA, DomI, _),
	dom_range(DomI, MinI, _),
	dvar_remove_smaller(A, MinI),
	
	%Propagazione massimo di A
	dom_range(DomX, MinX, MaxX),
	W is -MinX,
	max(W, MaxX, M),
	dvar_remove_greater(A,M),
	
	%Propagazione Minimo e massimo di X
	dom_range(DomA,_, MaxA),
	dvar_remove_greater(X, MaxA),
	Min is -MaxA,
	dvar_remove_smaller(X, Min).
	
	
