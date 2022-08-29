-module(hhfuns).
-compile(export_all).

addOne() -> 1.
addTwo() -> 2.

addTwos(X, Y) -> X() + Y().


map(F, L) -> map(F, L, []).
map(_, [], Acc) -> Acc;
map(F, [H|T], Acc) -> map(F, T, [F(H) | Acc]).

dec(X) -> X - 1.
inc(X) -> X + 1.


fold(_, Start, []) -> Start;
fold(F, Start, [H|T]) -> fold(F, F(H, Start), T).