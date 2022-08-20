-module(employee).
-export([new/2]).
-record(person, { name, age, employer=alexa}).

new(Name, Age) -> #person{name = Name, age = Age}.