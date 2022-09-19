-module(event).
-compile(export_all).
-record(state, {
    server, name="",
    to_go = 0
    }).

start(ServerName, DateTime) ->
    spawn(?MODULE, init, [self(), ServerName, DateTime]).

start_link(ServerName, DateTime) ->
    spawn_link(?MODULE, init, [self(), ServerName, DateTime]).

init(Server, ServerName, DateTime) ->
    loop(#state{
        server=Server, 
        name=ServerName, 
        to_go=time_to_go(DateTime)
    }).

loop(S = #state{server = Server, to_go=[T|Next]}) ->
    receive
        {Server, Ref, cancel} ->
            Server ! {Ref, ok}
    after T*1000 ->
        if Next =:= [] ->
            Server ! {done, S#state.name};
           Next =/= [] ->
            loop(#state{to_go=Next})
        end
    end.

cancel(Pid) ->
    Ref = erlang:monitor(process, Pid),
    Pid ! {self(), Ref, cancel},
    receive 
        {Ref, cancel} ->
            erlang:demonitor(Ref, [flush]),
            ok;
        {'DOWN', Ref, process, Pid, _Reason} ->
            ok
    end.

time_to_go(Timeout={{_,_,_},{_,_,_}}) ->
    Now = calendar:local_time(),
    Togo = calendar:datetime_to_gregorian_seconds(Timeout) -
           calendar:datetime_to_gregorian_seconds(Now),
    Secs = if Togo > 0 -> 
               Togo;
              Togo =< 0 -> 0 end,
    normalize(Secs).

%% Because Erlang is limited to about 49 days (49*24*60*60*1000) in
%% milliseconds, the following function is used.
normalize(N) ->
    Limit = 49*24*60*60,
    [ N rem Limit |  lists:duplicate(N div Limit, Limit)].