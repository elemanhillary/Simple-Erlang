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
