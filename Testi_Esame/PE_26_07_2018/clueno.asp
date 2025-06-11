arma(1..6).
personaggio(1..6).
player(0..4).

1{carta_arma(A,G):player(G)}1 :- arma(A).
1{carta_personaggio(P,G):player(G)}1 :- personaggio(P).

:- not carta_arma(_,0).
:- not carta_personaggio(_,0).


:- risposta(Ric,Ris,Ass,Arm), Ris != 0, not carta_arma(Arm,Ris), not carta_personaggio(Ass,Ris).

:- risposta(Ric,0,Ass,Arm), not carta_arma(Arm,0), not carta_arma(Arm,Ric).
:- risposta(Ric,0,Ass,Arm), not carta_personaggio(Ass,0), not carta_personaggio(Ass,Ric).

#show carta_arma/2.
#show carta_personaggio/2.