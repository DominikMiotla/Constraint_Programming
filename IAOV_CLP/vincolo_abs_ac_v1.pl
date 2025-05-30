:- lib(fd).

intervalli([H|_],H).


abs_val(X,A):-
	
	dvar_domain(X, DomX),
	intervalli(DomX,A).
	
