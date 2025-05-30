:- [automobili].
:- lib(fd).
:- lib(cumulative).

auto(End,ListCerchi,ListAria,ListNav):-
	findall(rich(ID,Deadline),(rich(ID,Deadline,C,A,S),C=1),DataCerchi),
	make_rich_variables(DataCerchi,20,End,ListCerchi),
	
	findall(rich(ID,Deadline),(rich(ID,Deadline,C,A,S),A=1),DataAria),
	make_rich_variables(DataAria,80,End,ListAria),
	
	findall(rich(ID,Deadline),(rich(ID,Deadline,C,A,S),S=1),DataNav),
	make_rich_variables(DataNav,50,End,ListNav),
	
	impose_culative(ListCerchi, 20),
	impose_culative(ListAria, 80),
	impose_culative(ListNav, 50),
	
	extract_start_time(ListCerchi,Sc),
	extract_start_time(ListAria,Sa),
	extract_start_time(ListNav,Sn),
	
	append(Sc,Sa,W),
	append(W,Sn,U),
	labeling(U).
	

	
make_rich_variables([],_,_,[]).
make_rich_variables([rich(ID,Deadline)|T],TimeRich,End,[rich(ID,Deadline,Start)|Var]):-
	Start #>=0,
	Start + TimeRich #<= Deadline,
	Start + TimeRich #<= End,
	make_rich_variables(T,TimeRich,End,Var).
	
	
impose_culative(ListR, TimeRich):-
	list_cumulative(ListR, TimeRich, StartList, DurList,ResList),
	cumulative(StartList,DurList,ResList,1).

list_cumulative([], _, [], [], []).
list_cumulative([rich(ID,Deadline,Start)|T],TimeRich,[Start|LStart],[TimeRich|LTime],[1|LRes]):-
	list_cumulative(T,TimeRich,LStart,LTime,LRes).


extract_start_time([],[]).
extract_start_time([rich(_,_,Start)|T], [Start|S]):-
	extract_start_time(T,S).
