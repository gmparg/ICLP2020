{true(X,R,Y) : relation(R)} = 1 :- element(X); element(Y); X < Y.
true(X,eq,X) :- element(X).
:- true(X,R1,Y); X < Y; true(Y,R2,Z); Y < Z; R1!=eq; R2!=eq; not true(X,Rout,Z) : table(R1,R2,Rout).
true(Y,b,X) :- true(X,bi,Y), X < Y.
true(Y,bi,X) :- true(X,b,Y), X < Y.
true(Y,d,X) :- true(X,di,Y), X < Y.
true(Y,di,X) :- true(X,d,Y), X < Y.
true(Y,o,X) :- true(X,oi,Y), X < Y.
true(Y,oi,X) :- true(X,o,Y), X < Y.
true(Y,m,X) :- true(X,mi,Y), X < Y.
true(Y,mi,X) :- true(X,m,Y), X < Y.
true(Y,s,X) :- true(X,si,Y), X < Y.
true(Y,si,X) :- true(X,s,Y), X < Y.
true(Y,f,X) :- true(X,fi,Y), X < Y.
true(Y,fi,X) :- true(X,f,Y), X < Y.
:- true(X,eq,Y); true(Y,R,Z); not true(X,R,Z); Y < Z.
:- true(X,R,Y); true(Y,eq,Z); not true(X,R,Z); X < Y.
:- constraint(X,_,Y); not true(X,R,Y) : constraint(X,R,Y).
table(eq, eq, (eq)).
table(eq, b, (b)).
table(eq, bi, (bi)).
table(eq, d, (d)).
table(eq, di, (di)).
table(eq, s, (s)).
table(eq, si, (si)).
table(eq, f, (f)).
table(eq, fi, (fi)).
table(eq, m, (m)).
table(eq, mi, (mi)).
table(eq, o, (o)).
table(eq, oi, (oi)).
table(b, eq, (b)).
table(b, b, (b)).
table(b, bi, (eq;b;bi;d;di;s;si;f;fi;m;mi;o;oi)).
table(b, d, (b;d;s;m;o)).
table(b, di, (b)).
table(b, s, (b)).
table(b, si, (b)).
table(b, f, (b;d;s;m;o)).
table(b, fi, (b)).
table(b, m, (b)).
table(b, mi, (b;d;s;m;o)).
table(b, o, (b)).
table(b, oi, (b;d;s;m;o)).
table(bi, eq, (bi)).
table(bi, b, (eq;b;bi;d;di;s;si;f;fi;m;mi;o;oi)).
table(bi, bi, (bi)).
table(bi, d, (bi;d;f;mi;oi)).
table(bi, di, (bi)).
table(bi, s, (bi;d;f;mi;oi)).
table(bi, si, (bi)).
table(bi, f, (bi)).
table(bi, fi, (bi)).
table(bi, m, (bi;d;f;mi;oi)).
table(bi, mi, (bi)).
table(bi, o, (bi;d;f;mi;oi)).
table(bi, oi, (bi)).
table(d, eq, (d)).
table(d, b, (b)).
table(d, bi, (bi)).
table(d, d, (d)).
table(d, di, (eq;b;bi;d;di;s;si;f;fi;m;mi;o;oi)).
table(d, s, (d)).
table(d, si, (bi;d;f;mi;oi)).
table(d, f, (d)).
table(d, fi, (b;d;s;m;o)).
table(d, m, (b)).
table(d, mi, (bi)).
table(d, o, (b;d;s;m;o)).
table(d, oi, (bi;d;f;mi;oi)).
table(di, eq, (di)).
table(di, b, (b;di;fi;m;o)).
table(di, bi, (bi;di;si;mi;oi)).
table(di, d, (eq;d;di;s;si;f;fi;o;oi)).
table(di, di, (di)).
table(di, s, (di;fi;o)).
table(di, si, (di)).
table(di, f, (di;si;oi)).
table(di, fi, (di)).
table(di, m, (di;fi;o)).
table(di, mi, (di;si;oi)).
table(di, o, (di;fi;o)).
table(di, oi, (di;si;oi)).
table(s, eq, (s)).
table(s, b, (b)).
table(s, bi, (bi)).
table(s, d, (d)).
table(s, di, (b;di;fi;m;o)).
table(s, s, (s)).
table(s, si, (eq;s;si)).
table(s, f, (d)).
table(s, fi, (b;m;o)).
table(s, m, (b)).
table(s, mi, (mi)).
table(s, o, (b;m;o)).
table(s, oi, (d;f;oi)).
table(si, eq, (si)).
table(si, b, (b;di;fi;m;o)).
table(si, bi, (bi)).
table(si, d, (d;f;oi)).
table(si, di, (di)).
table(si, s, (eq;s;si)).
table(si, si, (si)).
table(si, f, (oi)).
table(si, fi, (di)).
table(si, m, (di;fi;o)).
table(si, mi, (mi)).
table(si, o, (di;fi;o)).
table(si, oi, (oi)).
table(f, eq, (f)).
table(f, b, (b)).
table(f, bi, (bi)).
table(f, d, (d)).
table(f, di, (bi;di;si;mi;oi)).
table(f, s, (d)).
table(f, si, (bi;mi;oi)).
table(f, f, (f)).
table(f, fi, (eq;f;fi)).
table(f, m, (m)).
table(f, mi, (bi)).
table(f, o, (d;s;o)).
table(f, oi, (bi;mi;oi)).
table(fi, eq, (fi)).
table(fi, b, (b)).
table(fi, bi, (bi;di;si;mi;oi)).
table(fi, d, (d;s;o)).
table(fi, di, (di)).
table(fi, s, (o)).
table(fi, si, (di)).
table(fi, f, (eq;f;fi)).
table(fi, fi, (fi)).
table(fi, m, (m)).
table(fi, mi, (di;si;oi)).
table(fi, o, (o)).
table(fi, oi, (di;si;oi)).
table(m, eq, (m)).
table(m, b, (b)).
table(m, bi, (bi;di;si;mi;oi)).
table(m, d, (d;s;o)).
table(m, di, (b)).
table(m, s, (m)).
table(m, si, (m)).
table(m, f, (d;s;o)).
table(m, fi, (b)).
table(m, m, (b)).
table(m, mi, (eq;f;fi)).
table(m, o, (b)).
table(m, oi, (d;s;o)).
table(mi, eq, (mi)).
table(mi, b, (b;di;fi;m;o)).
table(mi, bi, (bi)).
table(mi, d, (d;f;oi)).
table(mi, di, (bi)).
table(mi, s, (d;f;oi)).
table(mi, si, (bi)).
table(mi, f, (mi)).
table(mi, fi, (mi)).
table(mi, m, (eq;s;si)).
table(mi, mi, (bi)).
table(mi, o, (d;f;oi)).
table(mi, oi, (bi)).
table(o, eq, (o)).
table(o, b, (b)).
table(o, bi, (bi;di;si;mi;oi)).
table(o, d, (d;s;o)).
table(o, di, (b;di;fi;m;o)).
table(o, s, (o)).
table(o, si, (di;fi;o)).
table(o, f, (d;s;o)).
table(o, fi, (b;m;o)).
table(o, m, (b)).
table(o, mi, (di;si;oi)).
table(o, o, (b;m;o)).
table(o, oi, (eq;d;di;s;si;f;fi;o;oi)).
table(oi, eq, (oi)).
table(oi, b, (b;di;fi;m;o)).
table(oi, bi, (bi)).
table(oi, d, (d;f;oi)).
table(oi, di, (bi;di;si;mi;oi)).
table(oi, s, (d;f;oi)).
table(oi, si, (bi;mi;oi)).
table(oi, f, (oi)).
table(oi, fi, (di;si;oi)).
table(oi, m, (di;fi;o)).
table(oi, mi, (bi)).
table(oi, o, (eq;d;di;s;si;f;fi;o;oi)).
table(oi, oi, (bi;mi;oi)).
relation(b; fi; d; di; f; bi; eq; m; o; s; si; oi; mi).
