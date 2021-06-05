edge(a,b,3).
edge(b,d,5).
edge(d,b,2).
edge(b,c,1).
edge(c,d,2).

search(A,Z,Path,Cost):- search1(A,[Z],Path,Cost).

	
search1(A,[A|Potential],[A|Potential],0).

search1(A,[Node|Potential],Path,Cost):-
	edge(Node1,Node,EdgeCost),
	\+ memberchk(Node1,[Node|Potential]),
	search1(A,[Node1,Node|Potential],Path, PathCost),
	Cost is EdgeCost + PathCost.

search1(Start,Finish):-
	asserta(min(1000)),
	asserta(minPath([])),
	!,
	search(Start,Finish,Path,Cost1),
	(min(Cost),Cost1<Cost,retract(min(Cost)),asserta(min(Cost1))),
	minPath(Q),
	retract(minPath(Q)),
	asserta(minPath([Path])),
	fail.

search(Start,Finish):-
	\+ search1(Start,Finish),
	min(X),
	write('The minimum cost is: '),
	write(X),
	minPath(Y),
	nl,
	write('The minimum path is: '),
	write(Y),
	!.