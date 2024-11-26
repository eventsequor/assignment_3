fun(X) :- X > 2.
fun(X) :- X > 4, X < 10.
fun(X) :- X > 12, X < 15.
fun(X) :- X > 22, X < 25.

fun2(X).

start :-  nb_setval(success, 0), nb_setval(fail, 0).
get_success(V) :- nb_getval(success, V).
get_fail(V) :- nb_getval(fail, V).
inc_success :- get_success(S), NewS is S + 1, nb_setval(success, NewS).
inc_fail :- get_fail(F), NewF is F + 1, nb_setval(fail, NewF).

%% function is passed in.
%% call(Foo) succeeds.
check(Cl) :- findall(_, (Cl -> inc_success ; inc_fail), _).
reify_call(Pred, True, False) :-
    clause(Pred, Cl), (call(Cl) -> True = 1, False = 0 ; True = 0, False = 1).

evaluate(Pred) :- start,
    clause(Pred, Cl), (Cl -> inc_success ; inc_fail).

always(Func) :- findall(_, evaluate(Func), _), get_success(S), S > 0, get_fail(F), F == 0, !. 

foo :- true -> false.
foo :- true.