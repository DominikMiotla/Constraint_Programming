time(0..MaxTime):- endtime(MaxTime).

1{schedule(ID,Deadline,Start) : time(Start)}1 :- ordine(ID,Deadline).


:- schedule(ID1,_,Start), schedule(ID2,_,Start), ID1 != ID2.

:- schedule(ID1,_,Start1), schedule(ID2,_,Start2), ID1 != ID2, Start1 < Start2, Start2 < Start1 + 1.

:- precedenza(ID1,ID2), schedule(ID1,_,Start1), schedule(ID2,_,Start2), Start2 < Start1.

guadagno(ID) :- schedule(ID,Deadline,Start), Start + 1 < Deadline.

#maximize{1,ID : guadagno(ID)}.


#show schedule/3.