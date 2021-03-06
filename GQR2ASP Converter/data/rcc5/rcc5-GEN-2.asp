{true(X,R,Y) : relation(R)} = 1 :- element(X); element(Y); X < Y.
true(X,eq,X) :- element(X).
:- true(X,R1,Y); X < Y; true(Y,R2,Z); Y < Z; R1!=eq; R2!=eq; not true(X,Rout,Z) : table(R1,R2,Rout).
true(Y,pp,X) :- true(X,ppi,Y), X < Y.
true(Y,ppi,X) :- true(X,pp,Y), X < Y.
:- true(X,eq,Y); true(Y,R,Z); not true(X,R,Z); Y < Z.
:- true(X,R,Y); true(Y,eq,Z); not true(X,R,Z); X < Y.
:- constraint(X,_,Y); not true(X,R,Y) : constraint(X,R,Y).
table(eq, eq, (eq)).
table(eq, dr, (dr)).
table(eq, po, (po)).
table(eq, pp, (pp)).
table(eq, ppi, (ppi)).
table(dr, eq, (dr)).
table(dr, dr, (eq;dr;po;pp;ppi)).
table(dr, po, (dr;po;pp)).
table(dr, pp, (dr;po;pp)).
table(dr, ppi, (dr)).
table(po, eq, (po)).
table(po, dr, (dr;po;ppi)).
table(po, po, (eq;dr;po;pp;ppi)).
table(po, pp, (po;pp)).
table(po, ppi, (dr;po;ppi)).
table(pp, eq, (pp)).
table(pp, dr, (dr)).
table(pp, po, (dr;po;pp)).
table(pp, pp, (pp)).
table(pp, ppi, (eq;dr;po;pp;ppi)).
table(ppi, eq, (ppi)).
table(ppi, dr, (dr;po;ppi)).
table(ppi, po, (po;ppi)).
table(ppi, pp, (eq;po;pp;ppi)).
table(ppi, ppi, (ppi)).
relation(pp; ppi; eq; dr; po).
