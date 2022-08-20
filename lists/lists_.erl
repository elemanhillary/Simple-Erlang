-module(lists_).
-export([sum/1, double/1]).

sum([]) -> 0;
sum([H | T]) -> H + sum(T).

double([]) -> 0;
double([H | T]) -> [H * 2 | double(T)].