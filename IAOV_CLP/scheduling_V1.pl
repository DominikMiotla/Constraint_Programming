:-lib(fd).
:-lib(cumulative).

task(j1, 3, [], m1).
task(j2, 8, [], m1).
task(j3, 8, [j4,j5], m1).
task(j4, 6, [], m2).
task(j5, 3, [j1], m2).
task(j6, 4, [j1], m2).

schedule(End,TaskList):-
	findall(task(J,D,P,M),task(J,D,P,M),Data),
	schedule(Data,End,TaskList).

schedule(Data,End,TaskList):-
	makeTaskVariable(Data,End,TaskList),
	precedence(TaskList,TaskList),
	machines(TaskList),
	take_start(TaskList,LStart),
	append(LStart, [End], W),
	min_max(labeling(W),End).




makeTaskVariable([],_,[]).
makeTaskVariable([task(J,D,P,M)|T],End,[task(J,D,P,M,Start)|Var]):-
	Start #>=0,
	Start + D #<= End,
	makeTaskVariable(T,End,Var).

precedence([],_).
precedence([task(_,_,P,_,Start)|T],TaskList):-
	start_after(P,Start,TaskList),
	precedence(T,TaskList).

start_after([],_,_).
start_after([PrecJ|PrecL], StartI, TaskList):-
	take_task(PrecJ, TaskList, task(PrecJ,DJ,_,_,StartJ)),
	StartI #>= StartJ + DJ,
	start_after(PrecL, StartI, TaskList).

take_task(PrecJ, [task(PrecJ,DJ,_,_,StartJ)|_], task(PrecJ,DJ,_,_,StartJ)):-!.
take_task(PrecJ, [_|T], TaskJ):-
	take_task(PrecJ,T,TaskJ).
	
machines(TaskList):-
	findall(M,task(_,_,_,M),LM),
	remove_duplicate(LM,M),
	impose_cumulative(M,TaskList).

impose_cumulative([],_).
impose_cumulative([M|MList],TaskList):-
	select_task_m(M,TaskList,LStart,LD,LRes),
	cumulative(LStart,LD, LRes, 1),
	impose_cumulative(MList,TaskList).

select_task_m(_,[],[],[],[]).
select_task_m(M,[task(_,D,_,M,Start)|TaskList],[Start|LStart],[D|LD],[1|LRes]):-
	!, select_task_m(M,TaskList,LStart,LD,LRes).
select_task_m(M,[_|TaskList],LStart,LD,LRes):-
	select_task_m(M,TaskList,LStart,LD,LRes).



remove_duplicate([],[]).
remove_duplicate([X|T], L):-
	member(X,T),!, remove_duplicate(T,L).
remove_duplicate([X|T],[X|L]):-
	remove_duplicate(T,L).
	
take_start([],[]).
take_start([task(_,_,_,_,Start)|TaskList],[Start|Ls]):-
	take_start(TaskList,Ls).
