-module(exceptions).
-compile(export_all).

throws(F) ->
    try F() of
        _ -> ok
    catch
        Throw -> {throw, caught, Throw}
    end.

exits(F) ->
    try F() of
        _ -> ok
    catch
        exits:Exit -> {exit, caught, Exit}
    end.

errors(F) ->
    try F() of
        _ -> ok
    catch
        error:Error -> {error, caught, Error}
    end.

sword(1) -> throw(slice);
sword(2) -> erlang:error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge).

black_knight(Attack) when is_function(Attack, 0) ->
    try Attack() of
        _ -> "None shall pass"
    catch
        throw:slice -> "its just a scratch";
        error:cut_arm -> "i have had worse";
        exit:cut_leg -> "come on you pancy";
        _:_ -> "just a flesh wound"
    end. 

talk() -> "blah blah blah".