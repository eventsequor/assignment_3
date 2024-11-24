sum_array([], 0).
sum_array([X| Ts], Acu) :- sum_array(Ts, Acu2), Acu is Acu2 + X.

mult_array([], 1).
mult_array([X| Ts], Acu) :- mult_array(Ts, Acu2), Acu is Acu2 * X.

get_column([], _, _).
get_column([H| Xs], Index, Result) :- nth0(Index, H, Value), get_column(Xs, Index, Result2), !, append(Result2, [Value], Result).

sum_row(List, Index, Result) :- is_list(List), nth0(Index, List, Row), sum_array(Row, Result).
sum_column(List, Index, Result) :- is_list(List), get_column(List, Index, Colum), sum_array(Colum, Result).

mult_row(List, Index, Result) :- is_list(List), nth0(Index, List, Row), mult_array(Row, Result).
mult_column(List, Index, Result) :- is_list(List), get_column(List, Index, Colum), mult_array(Colum, Result).

sum_all([], 0).
sum_all([H| Ts], Acu) :- sum_array(H, R), sum_all(Ts, Acu2), Acu is Acu2 + R.

mult_all([], 1).
mult_all([H| Ts], Acu) :- mult_array(H, R), mult_all(Ts, Acu2), Acu is Acu2 * R.

:- begin_tests(matrix).
    % Test group 1
    % Sum a given row: Row = 1, that is [2, 9, 1], the result is. 12
    test(sum_row_test_1) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], sum_row(Matrix, 0, Result), Result = 12.
    % Sum a given row: Row = 0, that is [4, 3, 14], the result is. 21
    test(sum_row_test_2) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], sum_row(Matrix, 1, Result), Result = 21.
    % Sum a given row: Row = 2, that is [5, 7, 6], the result is. 19
    test(sum_row_test_3) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], sum_row(Matrix, 2, Result), Result = 18.
    % Sum a given missing row then the test should fail: Row = 4
    test(sum_row_test_4) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], not(sum_row(Matrix, 4, _)).

    % Test group 2
    % Sum a given colum: Colum = 0, that is [2, 4, 5], the result is. 21
    test(sum_column_test_1) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], sum_column(Matrix, 0, Result), Result = 11.
    % Sum a given colum: colum = 1, that is [9, 3, 7], the result is. 19
    test(sum_column_test_2) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], sum_column(Matrix, 1, Result), Result = 19.
    % Sum a given colum: colum = 2, that is [1, 14, 6], the result is. 21
    test(sum_column_test_3) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], sum_column(Matrix, 2, Result), Result = 21.
    % Sum a given missing colum then the test should fail: Row = 4, that is why we use not.
    test(sum_colum_test_4) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], not(sum_column(Matrix, 4, _)).

    % Test group 3
    % Multiply a given row: Row = 0, that is [2, 9, 1], the result is. 18
    test(mult_row_test_1) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], mult_row(Matrix, 0, Result), Result = 18.
    % Multiply a given row: Row = 1, that is [4, 3, 14], the result is. 168
    test(mult_row_test_2) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], mult_row(Matrix, 1, Result), Result = 168.
    % Multiply a given row: Row = 2, that is [5, 7, 6], the result is. 210
    test(mult_row_test_3) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], mult_row(Matrix, 2, Result), Result = 210.
    % Multiply a given missing row then the test should fail: Row = 4
    test(mult_row_test_4) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], not(mult_row(Matrix, 4, _)).
    % Multiply a given row with zero. row 1. expected result 0
    test(mult_row_test_5) :- Matrix = [[2, 9, 1], [4, 0, 14], [5, 7, 6]], mult_row(Matrix, 1, Result), Result = 0.


    % Test group 4
    % Multiply a given colum: Colum = 0, that is [2, 4, 5], the result is. 40
    test(mult_column_test_1) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], mult_column(Matrix, 0, Result), Result = 40.
    % Multiply a given colum: colum = 1, that is [9, 3, 7], the result is. 189
    test(mult_column_test_2) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], mult_column(Matrix, 1, Result), Result = 189.
    % Multiply a given colum: colum = 2, that is [1, 14, 6], the result is. 84
    test(mult_column_test_3) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], mult_column(Matrix, 2, Result), Result = 84.
    % Multiply a given missing colum then the test should fail: Row = 4, that is why we use not.
    test(mult_colum_test_4) :- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], not(mult_column(Matrix, 4, _)).
    % Multiply a given colum with zero. colum 1. expected result 0
    test(mult_row_test_5) :- Matrix = [[2, 9, 1], [4, 0, 14], [5, 7, 6]], mult_row(Matrix, 1, Result), Result = 0.

    %Sum all
    % Expected result: 206
    test(sum_all_test_1) :- sum_all([[4, 1, 3], [19, 21, 5], [54, 12, 87]], Result), Result = 206.
    % Expected with values in zero: 191
    test(sum_all_test_2) :- sum_all([[4, 1, 0], [19, 21, 5], [54, 0, 87]], Result), Result = 191.

    %Multiply all
    % Expected result: 206
    test(mult_all_test_1) :- mult_all([[4, 1, 3], [2, 7, 4], [8, 5, 6]], Result), Result = 161280.
    % Expected result: 0 - there a zero
    test(mult_all_test_2) :- mult_all([[4, 1, 0], [19, 21, 5], [54, 2, 87]], Result), Result = 0.
:- end_tests(matrix).