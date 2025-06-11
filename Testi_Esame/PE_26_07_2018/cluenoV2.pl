:- [risposte].
:- lib(fd).
:- lib(fd_global).
:- lib(listut).

clueno(Arma,Personaggio):-
    findall(risposta(Richiedente,Rispondente,Assassino,Arma),risposta(Richiedente,Rispondente,Assassino,Arma),Risposte),

    length(Arma,6),
    length(Personaggio,6),
    Arma :: [0..4],
    Personaggio :: [0..4],

    impose_constraint_call(Risposte,Arma,Personaggio,ListB),
    impose_occurrences(4,Arma,Personaggio,Carte),

    append(Arma,Personaggio,Tmp1),
    append(Tmp1,ListB,Tmp2),
    append(Tmp2,Carte,Vars),
    labeling(Vars).

impose_occurrences(0,Arma,Personaggio,[]):-!,
    occurrences(0,Arma,1),
    occurrences(0,Personaggio,1).
impose_occurrences(N,Arma,Personaggio,[C|Carte]):-
    append(Arma,Personaggio,List),
    C :: [2,3],
    occurrences(N,List,C),
    N1 is N - 1,
    impose_occurrences(N1,Arma,Personaggio,Carte).



impose_constraint_call([],_,_,[]).
impose_constraint_call([risposta(Richiedente,0,Assassino,Arma)|ListC],ListArma,ListPersonaggio,[B1,B2,B3,B4|B]):- !,
    nth1(Assassino,ListPersonaggio,P),
    nth1(Arma,ListArma,A),
    #=(P,0,B1),
    #=(P,Richiedente,B2),
    B1 + B2 #= 1,
    #=(A,0,B3),
    #=(A,Richiedente,B4),
    B3 + B4 #= 1,
    impose_constraint_call(ListC,ListArma,ListPersonaggio,B).
impose_constraint_call([risposta(_,Rispondente,Assassino,Arma)|ListC],ListArma,ListPersonaggio,[B1,B2|B]):-
    nth1(Assassino,ListPersonaggio,P),
    nth1(Arma,ListArma,A),
    #=(P,Rispondente,B1),
    #=(A,Rispondente,B2),
    B1 + B2 #>= 1,
    impose_constraint_call(ListC,ListArma,ListPersonaggio,B).