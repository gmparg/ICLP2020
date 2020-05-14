{true(X,R,Y) : relation(R)} = 1 :- element(X); element(Y); X != Y.
true(X,eq,X) :- element(X).
:- true(X,R1,Y); true(Y,R2,Z); not true(X,Rout,Z) : table(R1,R2,Rout).
:- constraint(X,_,Y); not true(X,R,Y) : constraint(X,R,Y).
relation(eq; po; pp; ppi; dr).
table(eq, eq, (eq)).
table(eq, po, (po)).
table(eq, pp, (pp)).
table(eq, ppi, (ppi)).
table(eq, dr, (dr)).
table(po, eq, (po)).
table(po, po, (eq;po;pp;ppi;dr)).
table(po, pp, (po;pp)).
table(po, ppi, (dr;po;ppi)).
table(po, dr, (dr;po;ppi)).
table(pp, eq, (pp)).
table(pp, po, (dr;po;pp)).
table(pp, pp, (pp)).
table(pp, ppi, (eq;dr;po;pp;ppi)).
table(pp, dr, (dr)).
table(ppi, eq, (ppi)).
table(ppi, po, (po;ppi)).
table(ppi, pp, (eq;po;pp;ppi)).
table(ppi, ppi, (ppi)).
table(ppi, dr, (po;ppi;dr)).
table(dr, eq, (dr)).
table(dr, po, (dr;po;pp)).
table(dr, pp, (dr;po;pp)).
table(dr, ppi, (dr)).
table(dr, dr, (eq;po;pp;ppi;dr)).
constraint(1, ppi, 2).
constraint(3, ppi, 4).
constraint(5, ppi, 6).
constraint(7, ppi, 8).
constraint(9, ppi, 10).
element(1; 2; 3; 4; 5; 6; 7; 8; 9; 10).
color(red; green; blue).
{hasColor(X,C) : color(C)} = 1 :- element(X).
:- arc(V1, V2), hasColor(V1, X), hasColor(V2, Y), X=Y.
arc(V2, V1):- arc(V1, V2).
arc(V1, V2):-true(V1,eq,V2), V1!=V2.
arc(V1, V2):-true(V1,po,V2).
arc(V1, V2):-true(V1,pp,V2).
arc(V1, V2):-true(V1,ppi,V2).
