declare(X, Y) :- retractall(the_interval_is(_, _)), assertz(the_interval_is(X, Y)).
left(X) :- the_interval_is(Left, Right), Left =< Right, !, X = Left. 
left(X) :- the_interval_is(Left, Right), Right < Left, !, X = Right. 
right(Y) :- the_interval_is(Left, Right), Left >= Right, !, Y = Left. 
right(Y) :- the_interval_is(Left, Right), Right > Left, !, Y = Right.  
is_in_interval(X) :- left(Y), right(Z), X @> Y, X @< Z.
check_interval(X, Y, Z) :- is_in_interval(X), is_in_interval(Y), !, Z = is_contained.
check_interval(X, Y, Z) :- is_in_interval(X), not(is_in_interval(Y)), !, Z = left_contained.
check_interval(X, Y, Z) :- not(is_in_interval(X)), is_in_interval(Y), !, Z = right_contained.
check_interval(X, Y, Z) :- 
    not(is_in_interval(X)),
    not(is_in_interval(Y)),    
    left(L), left(R),
    declare(X, Y),
    is_in_interval(L), is_in_interval(R),
    declare(L, R),
    !,
    Z = contains_the_interval.
check_interval(X, Y, Z) :- not(is_in_interval(X)), not(is_in_interval(Y)), !, Z = disjoint.

update(X, Y) :- declare(X, Y).  


:- begin_tests(intervals).
   %Test 0 interval declared
   % Declare any interval, you can use the statement declare to set a new interval
   test(declare) :- declare(3.1, 12.7), 
        left(X), X = 3.1,
        right(Y), Y = 12.7.

   %Test 1 left
   % left that returns the left endpoint of the interval
   test(left) :- declare(4, 9), left(X), X = 4.
   test(left) :- declare(90, 23), left(X), X = 23.

   %Test 2 right
   % right that returns the right endpoint of the interval
   test(right) :- declare(9, 123), right(X), X = 123.
   test(right) :- declare(90, 23), right(X), X = 90.

   %Test 3
   % in that receives a floating number and determines if the point is in the interval
   test(is_in_interval) :- declare(2, 51), is_in_interval(3).
   test(is_in_interval) :- declare(32, 98), not(is_in_interval(29)).

   % Test 4
   %in that receives an interval an determines whether the interval is contained, leftcontained (only the left endpoint of the parameter is in the interval), right-contained
   %(only the right endpoint of the parameter is in the interval), disjoint, or contains
   %the interval
   test(check_interval) :- declare(14, 19), check_interval(15, 18, X), X = is_contained.
   test(check_interval) :- declare(14, 19), check_interval(15, 28, X), X = left_contained.
   test(check_interval) :- declare(14, 19), check_interval(2, 18, X), X = right_contained.
   test(check_interval) :- declare(14, 19), check_interval(21, 30, X), X = disjoint.
   test(check_interval) :- declare(20, 30), check_interval(10, 40, X), X = contains_the_interval.

   % Test 5
   % update that receives two floating numbers and updates the left and right endpoints of the interval
   test(update) :- declare(3, 5), left(3), right(5), update(8, 14), left(8), right(14).
:- end_tests(intervals).