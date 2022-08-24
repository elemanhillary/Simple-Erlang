-module(guards).
-compile(export_all).

old_enough(X) when X >= 12 -> true;
old_enough(_) -> false.

right_age(X) when X >= 12, X =< 105 ->
    true;
right_age(_) ->
    false.

insert(X, []) ->
    [X];
insert(X, Set) ->
    case lists:member(X, Set) of
        true -> Set;
        false -> [X|Set]
    end.
