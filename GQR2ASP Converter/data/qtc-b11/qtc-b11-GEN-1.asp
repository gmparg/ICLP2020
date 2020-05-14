{true(X,R,Y) : relation(R)} = 1 :- element(X); element(Y); X < Y.
true(X,oo,X) :- element(X).
:- true(X,R1,Y); X < Y; true(Y,R2,Z); Y < Z; not true(X,Rout,Z) : table(R1,R2,Rout).
true(Y,mo,X) :- true(X,om,Y), X < Y.
true(Y,mp,X) :- true(X,pm,Y), X < Y.
true(Y,om,X) :- true(X,mo,Y), X < Y.
true(Y,op,X) :- true(X,po,Y), X < Y.
true(Y,pm,X) :- true(X,mp,Y), X < Y.
true(Y,po,X) :- true(X,op,Y), X < Y.
:- constraint(X,_,Y); not true(X,R,Y) : constraint(X,R,Y).
table(mm, mm, (mp;pm)).
table(mm, mo, (mo;po)).
table(mm, mp, (mm;pp)).
table(mm, om, ()).
table(mm, oo, ()).
table(mm, op, ()).
table(mm, pm, (mm)).
table(mm, po, (mo)).
table(mm, pp, (mp)).
table(mo, mm, ()).
table(mo, mo, ()).
table(mo, mp, ()).
table(mo, om, (mm;mp;pm)).
table(mo, oo, (mo;po)).
table(mo, op, (mm;mp;p)).
table(mo, pm, ()).
table(mo, po, ()).
table(mo, pp, ()).
table(mp, mm, (mm)).
table(mp, mo, (mo)).
table(mp, mp, (mp)).
table(mp, om, ()).
table(mp, oo, ()).
table(mp, op, ()).
table(mp, pm, (mp;pm)).
table(mp, po, (mo;po)).
table(mp, pp, (mm;pp)).
table(om, mm, (om;op)).
table(om, mo, (oo)).
table(om, mp, (om;op)).
table(om, om, ()).
table(om, oo, ()).
table(om, op, ()).
table(om, pm, (om)).
table(om, po, (oo)).
table(om, pp, (op)).
table(oo, mm, ()).
table(oo, mo, ()).
table(oo, mp, ()).
table(oo, om, (om;op)).
table(oo, oo, (oo)).
table(oo, op, (om;op)).
table(oo, pm, ()).
table(oo, po, ()).
table(oo, pp, ()).
table(op, mm, (om)).
table(op, mo, (oo)).
table(op, mp, (op)).
table(op, om, ()).
table(op, oo, ()).
table(op, op, ()).
table(op, pm, (om;op)).
table(op, po, (oo)).
table(op, pp, (om;o)).
table(pm, mm, (mm;pp)).
table(pm, mo, (mo;po)).
table(pm, mp, (mp;pm)).
table(pm, om, ()).
table(pm, oo, ()).
table(pm, op, ()).
table(pm, pm, (pm)).
table(pm, po, (po)).
table(pm, pp, (pp)).
table(po, mm, ()).
table(po, mo, ()).
table(po, mp, ()).
table(po, om, (mm;pm;pp)).
table(po, oo, (po;mo)).
table(po, op, (mp;pm;pp)).
table(po, pm, ()).
table(po, po, ()).
table(po, pp, ()).
table(pp, mm, (pm)).
table(pp, mo, (po)).
table(pp, mp, (pp)).
table(pp, om, ()).
table(pp, oo, ()).
table(pp, op, ()).
table(pp, pm, (mm;pp)).
table(pp, po, (mo;po)).
table(pp, pp, (mp;pm)).
relation(mm; oo; pp; op; mo; mp; pm; om; po).
