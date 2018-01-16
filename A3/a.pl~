% Question 1
% Use Append to check if R is the reverse list of L (R is given)
% Or create the reverse list of L and put it ino R
xreverse([], []).
xreverse([X|L], R):- xreverse(L, Y), append(Y, [X], R).


% Question 2
% Use a helper function to delete the same atoms in the L 
% Then go to the next recursion with the new list without any atom X

xunique([],[]).
xunique([X|L], [Y|O]) :- X = Y, deleteDup(L, X, L1), xunique(L1, O).

deleteDup([],_,[]).
deleteDup([A|L], B, [A|L1]) :- A\==B, deleteDup(L, B, L1).
deleteDup([A|L], B, L1) :- A==B, deleteDup(L, A, L1).

% Question 3
% Use the predicate substract to get the difference
% Then use xunique in Q2 to remove the duplicate atoms

xdiff(L1, L2, L) :- subtract(L1, L2, L3), xunique(L3, L).


% Quesiton 4 
% When the we travel all the atoms, give last the value of the last atom in the list 
% Then when doing the backtrack, the L1 will get its value

removeLast([X], [], X) :- Last = X.
removeLast([X|L], [X|L1], Last) :- removeLast(L, L1, Last).   

% Quesiton 5 

node(a).
node(b).
node(c).
node(d).
node(e).

edge(a,b).
edge(b,c).
edge(c,a).
edge(d,a).
edge(a,e).

% Provided Predicates
% =============================================================================
clique(L) :- findall(X,node(X),Nodes), xsubset(L,Nodes), allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :- xappend(_, [X|Set1], Set), xsubset(Xs, Set1).

xappend([], L, L).
xappend([H|T], L, [H|R]) :- xappend(T, L, R).

% ==============================================================================

% 5.1
% Check from the first node, if it is connected with all the rest nodes

allConnected([]).
allConnected([A|L]) :- connect(A, L), allConnected(L).

% Check if A is connected with all the nodes in L
connect(_, []).
connect(A, [B|L]) :- (edge(A,B); edge(B,A)), connect(A,L).

% 5.2
% Firstly, we find all the cliques with length greater than N and equal to N, using findLenGTN and findLenEQN
% Then we need to filter the cliques with length = N, because they may have a bigger clique
% So, we find all the subsets for cliques with length greater than N
% and check if there is any in the cliques with length equal to N, using xdiff(in Q3)

maxclique(N, Cliques) :- findall(L1, findLenGTN(N, L1), C1),
                         findall(L2, findLenEQN(N, L2), C2),
                         getResult(C1, C2, Cliques).

findLenGTN(N, L1) :- clique(L1), length(L1,Len), Len > N.

findLenEQN(N, L2) :- clique(L2), length(L2,N).

getResult([], C2, C2).
getResult([S|C1], C2, Cliques) :- findall(X, xsubset(X, S), Notmaxclique), 
                                  xdiff(C2, Notmaxclique, C),
                                  getResult(C1, C, Cliques).

