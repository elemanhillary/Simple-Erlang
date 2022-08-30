-module(tree).
-export([empty/0, insert/3]).

empty() -> {node, 'nil'}.

insert(NKey, NValue, Node) ->
    case Node of
        {node, 'nil'} ->
            {node, {NKey, NValue, {node, 'nil'}, {node, 'nil'}}};
        {node, {Key, Value, Smaller, Larger}} when NKey < Key  ->
            {node, {Key, Value, insert(NKey, NValue, Smaller), Larger}};
        {node, {Key, Value, Smaller, Larger}} when NKey > Key ->
            {node, {Key, Value, Smaller, insert(NKey, NValue, Larger)}};
        {node, {Key, _, Smaller, Larger}} ->
            {node, {Key, NValue, Smaller, Larger}}
    end.

insert(Key, Val, {node, 'nil'}) ->
{node, {Key, Val, {node, 'nil'}, {node, 'nil'}}};
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey < Key -> 
    {node, {Key, Val, insert(NewKey, NewVal, Smaller), Larger}};
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey > Key -> 
    {node, {Key, Val, Smaller, insert(NewKey, NewVal, Larger)}};
insert(Key, Val, {node, {Key, _, Smaller, Larger}}) -> 
    {node, {Key, Val, Smaller, Larger}}.

has_value(Val, Tree) ->
    try has_value1(Val, Tree) of
        false -> false
    catch 
        true -> true
    end.

has_value1(Val, {node, 'nil'}) ->
    false;
has_value1(Val, {node, {_, Val, _, _}}) ->
    throw(true)
has_value1(Val, {node, {_, _, Left, Right}}) ->
    has_value(Val, Left),
    has_value(Val, Right).