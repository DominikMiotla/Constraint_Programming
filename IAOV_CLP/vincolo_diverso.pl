:- lib(fd).

diverso(A,B):-

	(var(A), var(B)
		->	suspend(diverso(A,B), 3, [A->suspend:inst, B->suspend:inst])
		;	true
	),
	
	(ground(A)
		->	dvar_remove_element(B,A)
		;	true
	),
	
	(ground(B)
		->	dvar_remove_element(A,B)
		;	true
	).
	
