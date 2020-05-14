#script (python)

import sys
import clingo
from collections import OrderedDict

class TablePropagator:
    def init(self, init):
        # literals involved in the propagator
        self.lits = OrderedDict()
        for atom in init.symbolic_atoms.by_signature("true", 3):
            lit = init.solver_literal(atom.literal)            
            if lit != 1: init.add_watch(init.solver_literal(atom.literal))
            
            
            # assign negative IDs to already true literals
            if lit == 1: lit = -atom.literal
            
            self.lits[lit] = atom.symbol.arguments

        # reverse map
        self.argToLit = {tuple(v) : k for k, v in self.lits.items()}

        # index first argument
        self.e_lits = OrderedDict()
        for lit, args in self.lits.items():
            key = args[0]
            if key not in self.e_lits: self.e_lits[key] = []
            self.e_lits[key].append(lit)
        
        # rebuild the composition table
        self.table = OrderedDict()
        for atom in init.symbolic_atoms.by_signature("table", 3):
            key = (atom.symbol.arguments[0], atom.symbol.arguments[1])
            if key not in self.table: self.table[key] = []
            self.table[key].append(atom.symbol.arguments[2])

        #init.check_mode = clingo.PropagatorCheckMode.Total

    def propagate(self, control, changes):
        for l in changes:
            x, r1, y = self.lits[l]
            for yz in self.e_lits[y]:
                if yz > 0 and not control.assignment.value(yz): continue    # skip false literals
                _, r2, z = self.lits[yz]
                rout = self.table[(r1, r2)]
                ok = False
                for r in rout:
                    xz = self.argToLit[(x,r,z)]
                    if xz < 0 or control.assignment.value(xz): ok = True; break     # nogood is SAT
                if ok: continue
                nogood = [l, yz]
                nogood.extend([-self.argToLit[(x,r,z)] for r in rout])
                control.add_nogood(nogood, lock=True)
                return


def main(prg):
    prg.register_propagator(TablePropagator())
    prg.ground([("base", [])])
    prg.solve()

#end.
{true(X,R,Y) : relation(R)} = 1 :- element(X); element(Y); X < Y.
true(X,eq,X) :- element(X).
true_conv(Y,ppi,X) :- true(X,pp,Y), X < Y.
true_conv(Y,pp,X) :- true(X,ppi,Y), X < Y.
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
