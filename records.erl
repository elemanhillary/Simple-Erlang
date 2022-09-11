-module(records).
-compile(export_all).
-record(robot, {
    name,
    type=industrial,
    hobbies,
    details=[]
    }).
-include("records.hrl").

included() -> #included{some_field="hey too"}.

first_robot() ->
    #robot{
        name="Bronzzi",
        type="chairs",
        details=["moved by us"]
        }.