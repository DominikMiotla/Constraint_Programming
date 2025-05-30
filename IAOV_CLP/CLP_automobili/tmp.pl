:- [automobili].
:- lib(fd).

auto(End,ListCerchi,ListAria,ListNav):-
	findall(rich(ID,Deadline),(rich(ID,Deadline,C,A,S),C=1),DataCerchi),
	make_rich_variables(DataCerchi,20,End,ListCerchi),
	
	findall(rich(ID,Deadline),(rich(ID,Deadline,C,A,S),A=1),DataAria),
	make_rich_variables(DataAria,80,End,ListAria),
	
	findall(rich(ID,Deadline),(rich(ID,Deadline,C,A,S),S=1),DataNav),
	make_rich_variables(DataNav,20,End,ListNav).
	
make_rich_variables([],_,_,[]).
make_rich_variables([rich(ID,Deadline)|T],TimeRich,End,[rich(ID,Deadline,Start)|Var]):-
	Start #>=0,
	Start + TimeRich #<= Deadline,
	Start + TimeRich #<= End,
	make_rich_variables(T,TimeRich,End,Var).
	
	
impose_culative(ListR, TimeRich):-
	list_cumulative(ListR, TimeRich, StartList,

list_cumulative([], _, [], [], []).
list_cumulative([rich(ID,Deadline,Start)|T],TimeRich,[Start|LStart],[TimeRich|LTime],[1|LRes]]):-
	list_cumulative(T,TimeRich,LStart,LTime,LRes).
	
