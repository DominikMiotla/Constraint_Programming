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
	
	findall(ID,rich(ID,Deadline,C,A,S),ListID),
	select_rich(ListID,ListCerchi,ListAria,ListNav),
	
	extract_start_time(ListCerchi,A),
	extract_start_time(ListAria,B),
	extract_start_time(ListNav,C),
	append([End],B,W),
	append(W,C,Z),
	append(Z,A,P),
	min_max(labeling(P),End).


select_rich([],_,_,_).
select_rich([Id|T],ListCerchi,ListAria,ListNav):-
	take_rich(Id, ListCerchi, StartC),
	take_rich(Id, ListAria, StartA),
	take_rich(Id, ListNav, StartN),
	generate_list_cum([StartC,StartA,StartN],[20,80,50], ListaStart, ListaDurate, ListaRisorse),
	cumulative(ListaStart,ListaDurate,ListaRisorse,1),
	select_rich(T,ListCerchi,ListAria,ListNav).
	
generate_list_cum([],_, [], [], []).
generate_list_cum([S|St],[Dr|Ds], [S|StartList], [Dr|DurList], [1|ResList]):-
	var(S),!,generate_list_cum(St,Ds,StartList,DurList,ResList).
generate_list_cum([_|St],[_|Ds], StartList, DurList, ResList):-
	generate_list_cum(St,Ds,StartList,DurList,ResList).
	

take_rich(_,[],[]).
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
