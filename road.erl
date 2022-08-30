-module(road).
-compile(export_all).

main() ->
    File = "road.txt",
    try file:read_file(File) of
        {ok, Binary} -> 
            Steps = parse_map(Binary),
            optimal_path(Steps);
        {error, Error} -> {error, read_failed, Error}
    catch
        error:Reason -> {"Error reading", File, Reason};
        _:_ -> all_exception
    after
        file:close(File)
    end.

parse_map(Binary) when is_binary(Binary) ->
    parse_map(binary_to_list(Binary));
parse_map(Str) when is_list(Str) ->
    Values = [list_to_integer(X) || X <- string:tokens(Str, "\n\r\t")],
    triple(Values).

% use tail call optimisation
triple(L) -> triple(L, []).
triple([], Acc) -> lists:reverse(Acc);
triple([A, B, C | Rest], Acc) ->
    triple(Rest, [{A, B, C} | Acc]).

shortest_step({A,B,X}, {{DistA, PathA}, {DistB, PathB}}) ->
    OptA1 = {DistA + A, [{a, A} | PathA]},
    OptA2 = {DistB + B + X, [{x, X}, {b, B} | PathB]},
    OptB1 = {DistB + B, [{b, B} | PathB]},
    OptB2 = {DistA + A + X, [{x, X}, {a, A} | PathA]},
    {erlang:min(OptA1, OptA2), erlang:min(OptB1, OptB2)}.

optimal_path(Map) -> 
    {A, B} = lists:foldl(fun shortest_step/2, {{0, []}, {0, []}}, Map),
    {_Dist, Path} = if hd(element(2, A)) =/= {x, 0} -> A;
                    hd(element(2, B)) =/= {x, 0} -> B
                end,
    lists:reverse(Path).