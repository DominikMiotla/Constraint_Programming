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
	select_rich([1],ListCerchi,ListAria,ListNav).
	%findall(ID,rich(ID,Deadline,C,A,S),ListID).


select_rich([],_,_,_).
select_rich([Id|T],ListCerchi,ListAria,ListNav):-
	take_rich(Id, ListCerchi, StartC),
	take_rich(Id, ListAria, StartA),
	take_rich(Id, ListNav, StartN),
	write(StartC),
	write(StartA),
	write(StartN).
	

take_rich(_,[],_).
take_rich(ID,[rich(ID,Deadline,Start)|_], Start):-!.
take_rich(ID,[_|T], Start):-
	take_rich(ID,T, Start).


	
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
