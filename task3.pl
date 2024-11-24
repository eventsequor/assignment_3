quicksort([], []).
quicksort([Head| Tail], Sorted) :- partition(Head, Tail, Left, Right),
    quicksort(Left, SortedLeft),
    quicksort(Right, SortedRight), !,
    append(SortedLeft, [Head| SortedRight], Sorted).

partition(_, [], [], []).
partition(Pivot, [Head| Tail], [Head| Left], Right) :- Head@=< Pivot,
    partition(Pivot, Tail, Left, Right).
partition(Pivot, [Head| Tail], Left, [Head| Right]) :- Head@> Pivot,
    partition(Pivot, Tail, Left, Right).

append([], List, List).
append([Head| List1], List2, [Head| List3]) :- append(List1, List2, List3).

:- begin_tests(matrix).
    % Test
    % With natural numbers
    test(quicksort_naturals) :- quicksort([8, 3, 4, 12, 25, 1, 2], Result), Result = [1, 2, 3, 4, 8, 12, 25].

    %With negative numbers
    test(quicksort) :- quicksort([8, 3, -4, 12, -51, 1, -22], Result), Result = [-51, -22, -4, 1, 3, 8, 12].
:- end_tests(matrix).
