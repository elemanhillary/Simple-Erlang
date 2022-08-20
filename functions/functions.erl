-module(functions).
-export([area/1, is_greater_than/2, fact/ 1, fac/1]).

area({circle, Radius}) -> math:pi() * Radius;
area({square, Side}) -> Side * Side;
area({triangle, A, B, C}) ->
    S = (A + B + C) / 2,
    math:sqrt(S*(S-A) * (S-B) * (S-C)).

is_greater_than(X, Y) ->
    if 
        X > Y ->
            true;
        true ->
            false
    end.

fact(N) when N > 0 ->
    N * fact(N - 1);
fact(0) ->
    1.

fac(N) when N > 1 -> fac(N, N - 1);
fac(N) when N == 0; N == 1 -> 1.

fac(F, 0) -> F;
fac(F, N) -> fac(F * N, N - 1).