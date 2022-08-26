-module(recursion).
-compile(export_all).

fac(0) -> 1;
fac(N) when N > 0 -> N*fac(N-1).


len([]) -> 0;
len([_|T]) -> 1 + len(T).

tail_fac(N) -> tail_fac(N, 1).

tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 -> tail_fac(N-1, N * Acc).

tail_len(L) -> tail_len(L, 0).

tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T, Acc + 1).

duplicate(N, Term) ->
    duplicate(N, Term, []).

duplicate(0, _, List) ->
    List;
duplicate(N, Term, List) when N > 0 ->
    duplicate(N - 1, Term, [Term|List]).

tail_reverse(L) -> tail_reverse(L, []).
tail_reverse([], Acc) -> 
    io:format("IO ~p~n",[Acc]),
    Acc;
tail_reverse([H|T], Acc) -> 
    io:format("IO ++ ~p~n",[Acc]),
    tail_reverse(T, [H|Acc]).

tail_sublist(L, N) -> 
    Sublist = tail_sublist(L, N, []),
    tail_reverse(Sublist).

tail_sublist(_, 0, SubList) -> SubList;
tail_sublist([], _, SubList) -> SubList;
tail_sublist([H|T], N, SubList) when N > 0 -> tail_sublist(T, N - 1, [H|SubList]).

tail_zip(L1, L2) -> tail_zip(L1, L2, []).
tail_zip([], _, Acc) -> Acc;
tail_zip(_, [], Acc) -> Acc;
tail_zip([X|X2],[Y|Y2], Acc) -> tail_zip(X2, Y2, [{X, Y} | Acc]).