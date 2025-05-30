:-lib(fd).
:-lib(fd_global_gac).

nonna_luisa(L):-
	L = [Task_Nonna, Task_cane, Task_torta, Inizio_task_nonna, Inizio_task_cane, Inizio_task_torta],
    [Task_Nonna, Task_cane, Task_torta] :: 1..3,
    [Inizio_task_nonna, Inizio_task_cane, Inizio_task_torta] :: 0..5,

    fd_global_gac:alldifferent([Task_Nonna,Task_cane,Task_torta]),

    element(Task_Nonna, [5,3,2], Durata_task_nonna),
    element(Task_cane, [4,2,3], Durata_task_cane),
    element(Task_torta, [2,5,4], Durata_task_torta),

    Inizio_task_cane #>= Inizio_task_nonna + 1,
    Inizio_task_cane #<= Inizio_task_nonna + Durata_task_nonna - 1,

    Inizio_task_torta #>= Inizio_task_cane,

    Inizio_task_torta + Durata_task_torta #<= Inizio_task_cane + Durata_task_cane,
    Inizio_task_torta + Durata_task_torta #<= Inizio_task_nonna + Durata_task_nonna,

    labeling(L).
