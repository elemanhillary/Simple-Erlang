-module(dolphins).
-compile(export_all).

dolphin1() ->
    receive
        {From, do_a_flip} ->
            From ! "I did a flip";
        {From, fish} ->
            From ! "lets go fishing";
        _ ->
            io:format("default case~n")
    end.