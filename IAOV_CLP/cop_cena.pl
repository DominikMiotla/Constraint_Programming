:- lib(fd).
:- lib(fd_global).

cena(L):-
	L = [Bp, Bs, Cp, Cs, Fp, Fs, Ap, As, Dp, Ds],
	L :: [1..5],
	
	%Bizzi riceve il primo piatto di Dotti
	Bp #= 5,
	
	%Costa ha ricevuto esattamente uno dei piatti di Dotti
	(Cp #= 5 #/\ Cs #\= 5) #\/ (Cp #\= 5 #/\ Cs #= 5),
	
	%Dotti non riceve alcun piatto da Costa
	Dp #\= 2, Ds #\=2,
	
	%Fantini ha ricevuto due piatti ordinati da due persone diverse
	Fp #\= Fs,
	
	%Aldini ha ricevuto almeno un piatto ordinato da Bizzi
	Ap #= 1 #\/ As #= 1,
	
	alldifferent(L, 2).


funzione_obiettivo([],[],[]).
funzione_obiettivo([X,Y|T], [A|R], [B1,B2|C]):-
	#\=(X,A,B1),
	#\=(Y,A,B2),
	funzione_obiettivo(T, R, C).


cop_cena(L):-
	cena(L),
	funzione_obiettivo(L, [1,2,3,4,5], D),
	sumlist(D,C),
	minimize(labeling(L), C).
