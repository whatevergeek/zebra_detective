/* 	File: 	bibmm.pl
   	Author: Mihaela Malita
	Title: 	Library for Logic Puzzles
 	WinProlog Predicates: member/2 	append/3  remove/3
	Predicates:
	flat/3  count/3 count_prop/3  	all_prop/2 nth/3	place/3
	mem/2 (=subset)	mem1/2		rest/3
	all/3 		list_all/3 	count_list_all/3
	arange/3 	list_arrange/3 	count_list_arange/3
	comb/3		list_comb/3	count_list_comb/3
	set/1  (=no_duplicates,=alldifferent)	set_equal/2 (=permutations)
	intersection/3	intersection_n/3
	next/3 		right/3		before/3
	neighbor/5	diagonal/1 	not_diagonal/1
	generate_sol/2(=length/2) 	make_list/2
	sum/2 		last/2 f	first/2
	write_list/1
*/
/* flat(L,R). Flatten a list.
	?- flat([a,[b,[c],a],i],L).
	L = [a,b,c,a,i]
*/
flat([],[]).
flat([X|T],[X|L]):- atomic(X),flat(T,L),!.
flat([X|T],S):- flat(X,R),append(R,K,S),flat(T,K).

/* count(A,L,N). Counts occurrences
	?- count(a,[b,a,c,d,a],N).
	N = 2
*/
count(_,[],0).
count(A,[A|L],N):- count(A,L,N1), N is N1+1,!.
count(A,[_|L],N):- count(A,L,N).

/* count_prop(P,L,N). Count elements with a certain property
	?-count_prop(integer,[1,2,a,b,3,4],N).
	N=4
	?- count_prop(atomic,[b,[a,c],d,a],N).
	N = 3
*/
count_prop(P,[],0).
count_prop(P,[A|L],N):- P(A),count_prop(P,L,N1), N is N1+1,!.
count_prop(P,[_|L],N):- count_prop(P,L,N).

/* all_prop(P,L). All elements from a list (first level) have property Prop
*/
all_prop(P,[]).
all_prop(P,[H|T]):- P(H),all_prop(P,T),!.

/* nth(N,L,R). The nth element of a list. Counting starts from 0.
	?- nth(2,[a,b,c,d,e],R).
	R = b
Be careful nth/3 starts from 0. Some problems might start from 1!
*/
nth(0,[X|_],X).
nth(N,[_|T],R):- nth(M,T,R), N is M + 1.

/* place(M,X,L). Place starts from 1 */
place(M,X,L):- N is M-1,nth(N,X,L).

/* mem(Lr,L). Elements from Lr are all members in L. Same as subset(Lr,L).
	?- mem([X,Y],[a,b,c]).
	X = Y = a ;
	X = a ,Y = b ;
	X = a ,Y = c ;
	X = b ,Y = a ;
	X = Y = b ;
	X = b ,Y = c ;
	X = c ,Y = a ;
	X = c ,Y = b ;
	X = Y = c ;
*/
mem([],Y).
mem([H|T],Y):-member(H,Y),mem(T,Y).

subset(X,Y):-mem(X,Y).

/* all(N,L,X). All possible pairs with elements from [a,b,c,d]:
	| ?- all(2,[a,b,c],I).
	I = [a,a] ;
	I = [a,b] ;
	I = [a,c] ;
	I = [b,a] ;
	I = [b,b] ;
	I = [b,c] ;
	I = [c,a] ;
	I = [c,b] ;
	I = [c,c] ;
*/
all(N,L,X):-length(X,N),mem(X,L).

/* list_all(N,L,R).
	?- list_all(2,[a,b,c],R).
	R = [[a,a],[a,b],[a,c],[b,a],[b,b],[b,c],[c,a],[c,b],[c,c]]
*/
list_all(N,L,Res):-findall(X,all(N,L,X),Res).

/* count_list_all(N,L,M).   k list has N = number is N^K
	?- count_list_all(2,[a,b,c,d],Many).
	Many = 16
*/
count_list_all(N,L,Many):-findall(X,all(N,L,X),Res),length(Res,Many).

/* arange(N,L,R). Lists have to be sets! That is: elements do not repeat.
	?- arange(2,[a,b,c],R).
	R = [a,b] ;
	R = [a,c] ;
	R = [b,a] ;
	R = [b,c] ;
	R = [c,a] ;
	R = [c,b] ;
*/
arange(N,L,X):-length(X,N),mem(X,L),no_duplicates(X).

/* set(L). Tests if a list has no duplicates.
alias no_duplicates/1, alldifferent/1*/
set([]).
set([H|T]):- not member(H,T),set(T).

no_duplicates(M):- set(M).
alldifferent(M):-  set(L).

/* list_arange(N,L,Res).
	?- list_arange(2,[a,b,c,d],R).
	R = [[a,b],[a,c],[a,d],[b,a],[b,c],[b,d],[c,a],[c,b],[c,d],[d,a],[d,b],[d,c]]
*/
list_arange(N,L,Res):- findall(X,arange(N,L,X),Res).

/* count_list_arange/3. A(k,n)= n!/(n-k)!
	?- count_list_arange(2,[a,b,c,d],R).
	R = 12
*/
count_list_arange(N,L,Many):- list_arange(N,L,Res),length(Res,Many).
/* permutations(L,X). Generates permutations.
*/
permutations(L,X):-length(L,N),arange(N,L,X).
list_permutations(L,R):-findall(X,permutations(L,X),Res).
/* count_list_permutations(L,N). N=length(L)!
*/
count_list_permutations(L,N):-list_permutations(L,R),length(R,N).

/* mem1(Lr,L). For comb/3. Same as mem/2 but does not generate [a,b] and [b,a].
	?- mem1([X,Y],[a,b,c]),write([X,Y]),fail.
	[a,b][a,c][b,a][b,c][c,a][c,b]no
*/
mem1([],Y).
mem1([H|T],Y):-member(H,Y),rest(H,Y,New),mem1(T,New).

/* rest(A,L,R). For comb/3. Return the rest of the list after the first occurrence of A.
	| ?- rest(a,[a,b,c,d],I).
	I = [b,c,d]
	| ?- rest(a,[b,c,a,d],I).
	I = [d]
	| ?- rest(a,[b,c,d],I).
	I = []
*/
rest(X,[],[]):-!.
rest(X,[X|T],T):-!.
rest(X,[_|T],R):-rest(X,T,R).

/* comb(N,L,Res). Combinations. Arangements without " order".
	| ?- comb(2,[a,b,c],I).
	I = [a,b] ;
	I = [a,c] ;
	I = [b,c] ;
*/
comb(N,L,X):-length(X,N),mem1(X,L).

/* list_comb(N,L,Res).
	?-  list_comb(2,[a,b,c,d],L).
	L = [[a,b],[a,c],[a,d],[b,c],[b,d],[c,d]]
*/
list_comb(N,L,Res):- findall(X,comb(N,L,X),Res).

/* count_list_comb(N,L,Many). Formula is: C(k,n) = n!/ k! (n-k)!
	or Pascal's formula:	C(k,n)=C(k,n-1) + C(k-1,n-1)
	?-  count_list_comb(2,[a,b,c,d],L).
	L = 6
*/
count_list_comb(N,L,Many):- list_comb(N,L,Res),length(Res,Many).

/* before (X,Y,List). Checks if X is before Y in the List.
	Starts from Left to right (normal order..).
	?-before(a,c,[m,a,v,c,d]).
	yes
*/
before(X,Y,L):-append(_,[X|T],L),member(Y,T).

/* set_equal(L1,L2). Test if two sets are equal. Generates all the sets equal to L2.
   Actually generates all PERMUTATIONS of L2.
	?- set_equal(I,[a,b,c]).
	I = [a,b,c] ;
	I = [a,c,b] ;
	I = [b,a,c] ;
	I = [b,c,a] ;
	I = [c,a,b] ;
	I = [c,b,a] ;
We can define permutations with set_equal/2.
permutations(R,L):- set_equal(R,L).
*/
set_equal([],[]).
set_equal([H|T],R):- member(H,R),remove(H,R,Rez),set_equal(T,Rez).

/* remove/3 is a WinProlog predicate. Removes the first occurrence of an element.
	?- remove(a,[a,b,a,d,a],I).
	I = [b,a,d,a] ;
	I = [a,b,d,a] ;
	I = [a,b,a,d] ;
	no
	?- remove(X,[a,b,c],I).
	X = a ,
	I = [b,c] ;
	X = b ,
	I = [a,c] ;
	X = c ,
	I = [a,b] ;
	no
	?- remove(m,[a,b,c,d],I).
	no
	?- remove(m,I,[b]).
	I = [m,b] ;
	I = [b,m] ;
We can write myremove/3 as follows, with same effect as follows:
myremove(X,[X|T],T).
myremove(X,[H|T],[H|R]):-myremove(X,T,R).
*/

/* intersection(L1,L2,R). Intersection of 2 sets.
	?- intersection([a,c],[m,a,b,c],R).
	R = [a,c]
	?- intersection([p,r],[a,b,c],R).
	R = []
*/
intersection([],_,[]).
intersection([H|T],L,[H|R]):- 	member(H,L),intersection(T,L,R),!.
intersection([H|T],L,R):- 	intersection(T,L,R).

/* intersection_n(L1,L2,N). Sets have in common just N elements
	?- intersection_n([p,r,t],[a,b,c],0).
	yes
	?- intersection_n([p,r,a],[a,b,c],1).
	yes
	?- intersection_n([p,r,a],[a,b,c],N).
	N = 1
*/
intersection_n(L1,L2,N):-intersection(L1,L2,R),length(R,N).

/* Order in a list:
	List= ....X,Y,... means: Y is in the right of X
	?- right(a,b,[c,a,b,m,n]).
	yes
	?- right(a,X,[c,a,b,m,n]).
	X = b ;
	?- right(a,m,[c,a,b,m,n]).
	no
*/
right(X,Y,L):- 	append(_,[X,Y|_],L).

/* next(X,Y,L). If X and Y are next to each other in the list.
	?- next(X,Y,[a,b,c]).
	X = a ,Y = b ;
	X = b ,Y = c ;
	X = b ,Y = a ;
	X = c ,Y = b ;
	?- next(a,b,[m,a,b,c]).
	yes
	?- next(a,c,[m,a,b,c,d]).
	yes
	?- next(a,c,[m,a,b,c,d]).
	no
	?- next(a,X,[m,a,b,c]).
	X = b ;
	X = m ;
*/
next(X,Y,L):- 	right(X,Y,L) ; right(Y,X,L).

/* neighbor(+X,+Y,X1,Y1,+S). Two cells are neighbors in an array size S
- starts from 0. Assume X and Y are in the range 0 - S.
integer_bound(0,I,5) means 0 <= I <= 5
	?-neighbor(1,1,2,2,3).
	yes
	?-neighbor(1,2,I,J,2).
	I = J = 2 ;
	I = 0 ,J = 2 ;
	I = J = 1 ;
	I = 2 ,	J = 1 ;
	I = 0 ,	J = 1 ;
*/
neighbor(X,Y,X1,Y1,S):- ((X1 is X+1, Y=Y1);
                      (X1 is X-1, Y=Y1);
		      (X1=X, Y1 is Y+1);
                      (X1=X, Y1 is Y-1);
		      (X1 is X+1, Y1 is Y-1);
		      (X1 is X-1, Y1 is Y-1);
		      (X1 is X+1, Y1 is Y+1);
		      (X1 is X-1, Y1 is Y+1)),
		      integer_bound(0,X1,S),integer_bound(0,Y1,S).
/*  	Chessboard (any SIZE!). Are on a the same diagonal.
*/
diagonal(X/Y,X1/Y1):-   A is abs(X-X1),A is abs(Y-Y1).
/*	Not on the same diagonal
*/
not_diagonal([X/Y,X1/Y1]):- A is abs(X-X1),B is abs(Y-Y1),A \= B.
/* write_list(L). Format predicates.
*/
write_list([]):-!.
write_list([H|T]):-write(H),nl,write_list(T).

/* generate_sol(S,N). Generate solution list - size N
*/
generate_sol(S,N):- length(S,N).
/* Make a list of integers.
	?- make_list(6,L).
	L = [1,2,3,4,5,6]
*/
make_list(N,L):- findall(I,integer_bound(1,I,N),L).
/* sum(L,N).  Adds a list of numbers.
	?- sum([3,4,5,8],I).
	I = 20
*/
sum([],0):-!.
sum([H|T],N):- sum(T,M), N is M + H.
% last(List,Last).
last(List,Last):-append(_,[Last],List).

% first(List,First).
first(List,F):- List=[F|_].
