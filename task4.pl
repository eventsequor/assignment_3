% Implementation always and sometimes

start :- nb_setval(success, 0), nb_setval(fail, 0).
get_success(V) :- nb_getval(success, V).
get_fail(V) :- nb_getval(fail, V).
inc_success :- get_success(S), NewS is S + 1, nb_setval(success, NewS).
inc_fail :- get_fail(F), NewF is F + 1, nb_setval(fail, NewF).

evaluate(Pred) :- start, clause(Pred, Cl), (Cl -> inc_success ; inc_fail).

always(Func) :- findall(_, evaluate(Func), _), get_success(S), S > 0, get_fail(F), F == 0, !.
sometimes(Func) :- findall(_, evaluate(Func), _), get_success(S), S > 0, !.

% Test with following functions

% Function fun(X) always return a group of true and a group of false answers.
fun(X) :- X > 2.
fun(X) :- X > 4, X < 10.
fun(X) :- X > 12, X < 15.
fun(X) :- X > 22, X < 25.

% Function fun(2) always return success.
fun2(_).