:- use_module(library(clpfd)).

% Question 1
% Using CLP, list the variables and constraints and get result

:- use_module(library(clpfd)).

fourSquares(N, [S1, S2, S3, S4]):-
    S1#=<S2, S2#=<S3, S3#=<S4, 
    S1 in 0..N, S2 in 0..N, S3 in 0..N, S4 in 0..N,
    N #= S1*S1 + S2*S2 + S3*S3 + S4*S4,
    label([S1, S2, S3, S4]).


% Question 2 
% Use 2 functions for:
%       1. choose 2 items from A list, 1 item from B list, if working keep going on the recursion
%       2. choose 1 item from A list, 2 items from B list
% Every time we enter the function, firstly sort the list(help for the soring, make it sort of faster)
% The first call for the recursion adds a new parameter: Presum, which is to record the previous sum which should be in the Solutions, and initialize it 0
% Then every time we find a solution, we compare the sum with previous sum to make sure the final Solutions is sorted.

disarm(Adivisions, Bdivisions, Solutions) :- disarm(Adivisions, Bdivisions, Solutions, 0).

disarm([], [] ,[], _).

disarm(Adivisions, Bdivisions, Solutions, Presum) :-
    msort(Adivisions, ASorted), msort(Bdivisions, BSorted),
 	select(X,ASorted,A), select(Y,A,B),select(Z,BSorted,C), 
	X #=< Y, X + Y #= Z, 
	Z #>= Presum,
    disarm(B,C,S,Z),
 	append([[[X,Y],[Z]]],S, Solutions).

disarm(Adivisions, Bdivisions, Solutions, Presum) :-
    msort(Adivisions, ASorted), msort(Bdivisions, BSorted),
 	select(X,Adivisions,A), select(Y,Bdivisions,B), select(Z,B,C),
 	Y #=< Z, Y + Z #= X, 
	X #>= Presum,
    disarm(A,C,S,X), 
	append([[[X],[Y,Z]]],S, Solutions).



