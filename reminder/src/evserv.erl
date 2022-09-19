-module(evserv).
-compile(export_all).
-record(state, {
    event,
    clients
    }).
-record(event, {
    name="",
    description="",
    pid,
    timeout={{1970,1,1},{0,0,0}}
    }).

init() ->
    loop(#state{event=orddict:new(), clients=orddict:new()}).

loop(S = #state{}) ->
    receive
        {Pid, MsgRef, {subscribe, Client}} ->
            Ref = erlang:monitor(process, Pid),
            NewClient = orddict:new(Ref, Client, S#state.clients),
            Pid ! {MsgRef, ok},
            loop(S#state{clients=NewClient});
        {Pid, MsgRef, {add, Name, Description, TimeOut}} ->
        {Pid, MsgRef, {cancel, Name}} ->
        {done, Name} ->
        shutdown ->
        {'DOWN', Ref, process, _Pid, _Reason} ->
        code_change ->
        Unknown ->
            io:format("Unknown message: ~p~n",[Unknown]),
            loop(S)
    end.
