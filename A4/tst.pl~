:- use_module(library(clpfd)).

%% Q1

%tc1
tc1(Var) :- fourSquares(20, Var).
%Var = [0, 0, 2, 4] ;
%Var = [1, 1, 3, 3] ;
%false.

%tc2
tc2(Var) :- fourSquares(-20, Var).
%false.

%tc3
tc3(Var) :- fourSquares(1, Var).
%Var = [0, 0, 0, 1].

p1T(N,V) :- statistics(runtime,[T0|_]),
	fourSquares(N,V),
	statistics(runtime, [T1|_]),
	T is T1 - T0,
	format('fourSqaures/2 takes ~3d sec.~n', [T]).
%% Q2

%tc4
p1(S) :- disarm([1,3,3,4,6,10,12],[3,4,7,9,16],S).
%S = [[[1, 3], [4]], [[3, 6], [9]], [[10], [3, 7]], [[4, 12], [16]]].

p2 :- disarm([],[],[]).
%true.

p3(S) :- disarm([1,2,3,3,8,5,5],[3,6,4,4,10],S).
%S = [[[1, 2], [3]], [[3, 3], [6]], [[8], [4, 4]], [[5, 5], [10]]].


p4(S) :- disarm([1,2,2,3,3,8,5],[3,2,6,4,4,10],S).
%false.

p5(S) :- disarm([1,2,2,3,3,8,5,5,6,7],[3,2,6,4,4,10,1,5,2],S).
%false.

p6(S) :- disarm([1,2,2,116,3,3,5,2,5,8,5,6,6,8,32,2],[3,5,11,4,37,1,4,121,3,3,14],S).
%S = [[[1, 2], [3]], [[2, 2], [4]], [[2, 3], [5]], [[5], [4, 1]], [[6], [3, 3]], [[3, 8], [11]], [[6|...], [...]], [[...|...]|...], [...|...]].


p2T(S) :- statistics(runtime,[T0|_]),
	p6(S),
	statistics(runtime, [T1|_]),
	T is T1 - T0,
	format('p6/1 takes ~3d sec.~n', [T]).
%p6/1 takes 10.532 sec.
%S = [[[1, 2], [3]], [[2, 2], [4]], [[2, 3], [5]], [[5], [4, 1]], [[6], [3, 3]], [[3, 8], [11]], [[6|...], [...]], [[...|...]|...], [...|...]].


:- use_module(library(clpfd)).

% Question 1

:- use_module(library(clpfd)).

fourSquares(N, [S1, S2, S3, S4]):-
    S1#=<S2, S2#=<S3, S3#=<S4, 
    S1 in 0..N, S2 in 0..N, S3 in 0..N, S4 in 0..N,
    N #= S1*S1 + S2*S2 + S3*S3 + S4*S4,
    label([S1, S2, S3, S4]).


% Question 2 

disarm(Adivisions, Bdivisions, Solutions) :- disarm(Adivisions, Bdivisions, Solutions, 0).

disarm([], [] ,[], _).

disarm(Adivisions, Bdivisions, Solutions, Presum) :-
    msort(Adivisions, ASorted), msort(Bdivisions, BSorted),
 	select(X,ASorted,A), select(Y,A,B),select(Z,BSorted,C), 
	X #=< Y, X + Y #= Z, 
    disarm(B,C,S,Z),
 	append([[[X,Y],[Z]]],S, Solutions),
	Z #>= Presum.

disarm(Adivisions, Bdivisions, Solutions, Presum) :-
    msort(Adivisions, ASorted), msort(Bdivisions, BSorted),
 	select(X,Adivisions,A), select(Y,Bdivisions,B), select(Z,B,C),
 	Y #=< Z, Y + Z #= X, 
	
    disarm(A,C,S,X), 
	append([[[X],[Y,Z]]],S, Solutions),
	X #>= Presum.



