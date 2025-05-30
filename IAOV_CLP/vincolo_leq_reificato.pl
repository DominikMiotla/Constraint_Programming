:-lib(fd).

% X #<= Y #<=> B
leq(X,Y,B):-
	ground(B), B = 0, !, X #> Y.
	
leq(X,Y,B):-
	ground(B), B = 1, !, X #<= Y.

leq(X,Y,B):-
	dvar_domain(X, DomX),
	dvar_domain(Y, DomY),
	
	dom_range(DomX, MinX, MaxX),
	dom_range(DomY, MinY, MaxY),
	
	(MaxX =< MinY
		-> B #= 1
		; (MinX > MaxY
			-> B #=0
			; suspend(leq(X,Y,B),4,[[X,Y,B]->fd:min, [X,Y,B]->fd:max])
		  )
	)
