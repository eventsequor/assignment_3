# Assignment 3 

# Preconditions to run the code.

You must have prolog installed on your operating system and you must also have the environment variables configured. To confirm this please execute the following command.

``` shell
swipl --version
```

You must watch something like this.

``` shell
% swipl --version
SWI-Prolog version 9.2.8 for arm64-darwin
``` 

## How to setup the environment variable?
Please go to the directory where is installed prolog (swipl) then you will find a sub folder called bin, use that path to setup the environment variable.

if you are in macos you will see some thing like this: ``/opt/homebrew/Cellar/swi-prolog/9.2.8/bin``

If you are in windows could be something like this path ``C:/Program Files/swipl/bin``

## Test each point

Every point has a group of unit test where you can check that all requirements are completed, to execute it you can you the following command ``swipl -g run_tests -t halt "filePath/fileName.pl"`` 

* The unit test is contained in a block of code like the following example.

``` prolog
:- begin_tests(atom_name).
    test(name_test) :- validation(true).
:- end_tests(matrix).
```

* There is another option, going into your prolog console ``swipl`` then execute the command ``cosult('yourfilepath/nameFile.pl').`` this will allow you to load the program. Finally you can execute the unit test from your console execution the command or query ``run_test.``

Let me show you how to run each programa if you don't want to execute the unit test.

### Task 1
The task 1 has a group of requeriments for each one you have to follow the next points.
* **Generals.** You can always set up a range with the following statement ``declare(2, 45).`` the smallest number will be the leftmost and the largest number will be the rightmost, it is mandatory to declare a range to test the requirements.
  
* **left** that returns the left endpoint of the interval

``` prolog
?- declare(4, 90).
true.

?- left(X).
X = 4.
```
 * right that returns the right endpoint of the interval

``` prolog
?- declare(41, 90).
true.

?- right(X).
X = 90.
```

 * in that receives a floating number and determines if the point is in the interval

``` prolog
?- declare(5, 16).
true.

?- is_in_interval(7.8).
true.

?- is_in_interval(19.3).
false.
``` 

• in that receives an interval an determines whether the interval is contained, leftcontained (only the left endpoint of the parameter is in the interval), right-contained
(only the right endpoint of the parameter is in the interval), disjoint, or contains
the interval

``` prolog
?- declare(14, 19), check_interval(15, 18, X).
X = is_contained.

?- declare(14, 19), check_interval(15, 28, X).
X = left_contained.

?- declare(14, 19), check_interval(2, 18, X).
X = right_contained.

?- declare(14, 19), check_interval(21, 30, X).
X = disjoint.

?- declare(20, 30), check_interval(10, 40, X).
X = contains_the_interval.
``` 

• update that receives two floating numbers and updates the left and right endpoints
of the interval

``` prolog
?- declare(3, 5), left(X), right(Y).
X = 3,
Y = 5.

?- update(8, 15), left(X), right(Y).
X = 8,
Y = 15.
``` 

## Task 2

Write a LP program to operate over square matrices (e.g., [[1 2 3][2 4 6] [7 8 9
]]). The program should have four messages to sum or multiply the elements in a column
or row (i.e., SumCol. SumRow, MultCol, MultRow receiving the matrix and the column/row to
operate on), and two messages to sum or multiply all elements in the matrix (i.e., SumMat
and MultMat receiving a matrix).

* sum row
``` prolog
?- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], sum_row(Matrix, 0, Result).
Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]],
Result = 12.
``` 

* sum column
``` prolog
?- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], sum_column(Matrix, 0, Result).
Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]],
Result = 11.
```

* mult row
``` prolog
?- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], mult_row(Matrix, 0, Result).
Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]],
Result = 18.
```

* mult colum
``` prolog
?- Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]], mult_column(Matrix, 0, Result).
Matrix = [[2, 9, 1], [4, 3, 14], [5, 7, 6]],
Result = 40.
```

* sum all

``` prolog
?- sum_all([[4, 1, 3], [19, 21, 5], [54, 12, 87]], Result).
Result = 206.
``` 

* mult all
``` prolog
?- mult_all([[4, 1, 3], [2, 7, 4], [8, 5, 6]], Result).
Result = 161280.
```

# Task 3
. Implement the quicksort algorithm using a logic algorithm. Given an array it
should return the quick-sorted array

``` prolog
?- quicksort([8, 3, 4, 12, 25, 1, 2], Result).
Result = [1, 2, 3, 4, 8, 12, 25].
```

# Task 4

For always and sometimes you there is example preoloaded, however please check the unit test, there you will find more examples

* **always(Function)**. Evaluate all possible solution count the number of fail and number of success if there is at least one fail the query is going to return fail, if all sentences are true then it will return true.

There is a test with a set of facts for "fun(X)", there is always a problem because when you call the query you will see at least one error, with this test the query will always return an error.

``` prolog
?- always(fun(5)).
false.

?- get_success(S).
S = 2.

?- get_fail(F).
F = 2.
```

if you only want to try with a function with a group of fail that you can watch try with the following example. ``?- always((X = true, X = true, X = fail, X = fail, X = fail)).
false.``

For fail
```
?- always((X = true, X = true, X = fail, X = fail, X = fail)).
false.
```

For success.
```
?- always((X = true, X = true, X = true)).
true.
```

* **sometimes(Function)** this function is going to return true if there is at least one solution for the question.

``` prolog
?- sometimes(fun(14)).
true.

?- get_success(S).
S = 2.

?- get_fail(F).
F = 2.
```

**Important Node**

There is a problem when you want to use native functions, clauses or facts, it is likely that they are restricted as explained in the following paragraph, that is, a restriction from the creator of the language or the libraries, that constrains the libraries. 

> **protect_static_code(bool, changeable)**
If true (default false), clause/2 does not operate on static code, providing some basic protection from hackers that wish to list the static code of your Prolog program. Once the flag is true, it cannot be changed back to false. Protection is default in ISO mode (see Prolog flag iso). Note that many parts of the development environment require clause/2 to work on static code, and enabling this flag should thus only be used for production code.