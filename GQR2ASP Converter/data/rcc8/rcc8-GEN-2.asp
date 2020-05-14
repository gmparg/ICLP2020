{true(X,R,Y) : relation(R)} = 1 :- element(X), element(Y), X < Y, #count{R : constraint(X,R,Y)} = 0.
true(X,eq,X) :- element(X).
true(X,R,Y) :- constraint(X,R,Y).
:- true(X,R1,Y), true(Y,R2,Z), not true(X,Rout,Z) : table(R1,R2,Rout).
:- constraint(X,_,Y), not true(X,R,Y) : constraint(X,R,Y).
:- true(X,eq,Y), true(Y,R,Z), not true(X,R,Z).
:- true(X,R,Y), true(Y,eq,Z), not true(X,R,Z).
table(dc, dc, (dc;ec;po;tpp;ntpp;tppi;ntppi;eq)).
table(dc, ec, (dc;ec;po;tpp;ntpp)).
table(dc, po, (dc;ec;po;tpp;ntpp)).
table(dc, tpp, (dc;ec;po;tpp;ntpp)).
table(dc, ntpp, (dc;ec;po;tpp;ntpp)).
table(dc, tppi, (dc)).
table(dc, ntppi, (dc)).
table(ec, dc, (dc;ec;po;tppi;ntppi)).
table(ec, ec, (dc;ec;po;tpp;tppi;eq)).
table(ec, po, (dc;ec;po;tpp;ntpp)).
table(ec, tpp, (ec;po;tpp;ntpp)).
table(ec, ntpp, (po;tpp;ntpp)).
table(ec, tppi, (dc;ec)).
table(ec, ntppi, (dc)).
table(po, dc, (dc;ec;po;tppi;ntppi)).
table(po, ec, (dc;ec;po;tppi;ntppi)).
table(po, po, (dc;ec;po;tpp;ntpp;tppi;ntppi;eq)).
table(po, tpp, (po;tpp;ntpp)).
table(po, ntpp, (po;tpp;ntpp)).
table(po, tppi, (dc;ec;po;tppi;ntppi)).
table(po, ntppi, (dc;ec;po;tppi;ntppi)).
table(tpp, dc, (dc)).
table(tpp, ec, (dc;ec)).
table(tpp, po, (dc;ec;po;tpp;ntpp)).
table(tpp, tpp, (tpp;ntpp)).
table(tpp, ntpp, (ntpp)).
table(tpp, tppi, (dc;ec;po;tpp;tppi;eq)).
table(tpp, ntppi, (dc;ec;po;tppi;ntppi)).
table(ntpp, dc, (dc)).
table(ntpp, ec, (dc)).
table(ntpp, po, (dc;ec;po;tpp;ntpp)).
table(ntpp, tpp, (ntpp)).
table(ntpp, ntpp, (ntpp)).
table(ntpp, tppi, (dc;ec;po;tpp;ntpp)).
table(ntpp, ntppi, (dc;ec;po;tpp;ntpp;tppi;ntppi;eq)).
table(tppi, dc, (dc;ec;po;tppi;ntppi)).
table(tppi, ec, (ec;po;tppi;ntppi)).
table(tppi, po, (po;tppi;ntppi)).
table(tppi, tpp, (po;tpp;tppi;eq)).
table(tppi, ntpp, (po;tpp;ntpp)).
table(tppi, tppi, (tppi;ntppi)).
table(tppi, ntppi, (ntppi)).
table(ntppi, dc, (dc;ec;po;tppi;ntppi)).
table(ntppi, ec, (po;tppi;ntppi)).
table(ntppi, po, (po;tppi;ntppi)).
table(ntppi, tpp, (po;tppi;ntppi)).
table(ntppi, ntpp, (po;tpp;tppi;ntpp;ntppi;eq)).
table(ntppi, tppi, (ntppi)).
table(ntppi, ntppi, (ntppi)).
relation(tppi; tpp; ntpp; ntppi; eq; ec; dc; po).
