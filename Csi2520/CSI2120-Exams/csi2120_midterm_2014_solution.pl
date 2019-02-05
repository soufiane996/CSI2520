postIt([]).
postIt([cR])- postIt(R), !, nl.
postIt([XR]) - postIt(R), write(X).

% - postIt([a,b,c,d,e]).


negCount([],0).
negCount([XL],N) - X0, negCount(L,N1), N is N1+1.
negCount([XL],N) - X=0, negCount(L,N).

% - negCount([0,4,-3,-1,6,-7], N).


q3(t(V, nul, nul), 0).
q3(t(V, Q, nul), 1).  
q3(t(V, nul, Q), 1).  
q3(t(V, Q1, Q2), T) - q3(Q1, T1), q3(Q2, T2), T is 1+T1+T2.


%% - q3(t(4,
%% 	t(2,
%% 	nul,
%% 	t(3, t(1,nul,nul), t(9,nul,nul))),
%% 	t(7, t(5, nul, t(6, nul, nul)),
%% 	t(9, t(1,nul,nul), t(9,nul,nul)))),T).


permitted(robert,fishing).
permitted(jochen,driving).
permitted(paul,fishing).
permitted(jean,weapons).
permitted(jean,driving).
permitted(sam,weapons).
permitted(sam,fishing).

% - permitted(X,Y),permitted(X,Z),Y==Z.


substitue(_,_,[],[]).
substitue(X,Y,[XR],[YR1]) - substitue(X,Y,R,R1).
substitue(X,Y,[ZR],[ZR1]) - X==Z, substitue(X,Y,R,R1).




p(X) - b(X), !, c(Y).
p(X) - a(X).
c(X) - d(X).
a(1).
a(2).
a(3).
b(4).
b(5).
d(6).
d(7).

% - p(X)



subElement(_,_,[],[]).
subElement(X,Y,[XR],[YR1]) -
	subElement(X,Y,R,R1).
subElement(X,Y,[ZR],[ZR1]) - X==Z,
	subElement(X,Y,R,R1).

% - subElement(apple, orange, [apple, celery, pear, pear, apple, raisin],L).


preequisite(csi2520,csi2510).
preequisite(csi2520,csi2610).
preequisite(csi2510,iti1521).
preequisite(csi2510,mat1748).
preequisite(csi2510,csi2772).

% - bagof(X,Y^prerequisite(X,Y),L).
% - setof(X,Y^prerequisite(X,Y),L).
% - setof(Y,prerequisite(X,Y),L)
