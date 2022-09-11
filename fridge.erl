-module(fridge).
-compile(export_all).

start(FoodList) ->
    spawn(?MODULE, kitchen, [FoodList]).

kitchen(FoodList) ->
    receive
        {From, {store, Food}} -> 
            From ! {self(), ok},
            kitchen([Food | FoodList]);
        {From, {take, Food}} ->
            case lists:member(Food, FoodList) of
                true ->
                    From ! {self(), {ok, Food}},
                    kitchen(lists:delete(Food, FoodList));
                false ->
                    From ! {self(), not_found},
                    kitchen(FoodList)
            end;
        terminate -> 
            ok
    end.

store(Pid, Food) ->
    Pid ! {self(), {store, Food}},
    receive
        {Pid, Msg} -> Msg
    after 3000 ->
        timeout
    end.
take(Pid, Food) ->
    Pid ! {self(), {take, Food}},
    receive
        {Pid, Msg} -> Msg
    after 3000 ->
        timeout
    end.