% John Bemis
% CSCI 305 Prolog Lab 2

%Rule for the mother of a child
mother(M,C) :-
  parent(M,C),
  female(M).

%Rule for the father of a child
father(F,C) :-
  parent(F,C),
  male(F).

%Rule for spouses
spouse(S1, S2) :-
  married(S1, S2);
  married(S2, S1).

%Rule for the child of a parent
child(C, P) :-
  parent(P, C).

%Rule for the son of a parent. Uses the child rule
son(S, P) :-
  child(S, P),
  male(S).

%Rule for the daughter of a parent. Also uses the child rule
daughter(D, P) :-
  child(D, P),
  female(D).

%Rule for siblings. I had to make sure that the parents were not the same as well as the children were not the same
sibling(C1, C2) :-
  parent(S1, C1),
  parent(S2, C2),
  not(C1 = C2),
  (S1 = S2).

%Rule for brothers. Uses the sibling rule
brother(C1, C2) :-
  sibling(C1, C2),
  male(C1).

%Rule for sissters. Also uses the sibling rule
sister(C1, C2) :-
  sibling(C1, C2),
  female(C1).

%Rule for the uncle of a child. I initially added in a rule to make sure that person 1 was a male, but brother took care of that
uncle(U1, C1) :-
  parent(P1, C1),
  brother(U1, P1).
  %male(U1).

%This is the uncle rule but by marriage. This one I had to make sure that person 1 was male
uncle(U1, C1) :-
  parent(P1, C1),
  sibling(P1, S1),
  married(U1, S1),
  male(U1).

%Rule for the aunt of a child. I did the same thing as uncle and added a rule to make sure that person 1 was female, but sister took care of that
aunt(A1, C1) :-
  parent(P1, C1),
  sister(A1, P1).
  %female(A1).

%Rule for aunt by marriage. Again, I had to check that person 1 was female
aunt(A1, C1) :-
  parent(P1, C1),
  sibling(P1, S1),
  married(S1, A1),
  female(A1).

%Rule for grandparents
grandparent(G1, C1) :-
  parent(P1, C1),
  parent(G1, P1).

%Rule for grandfather. Uses the gradparent rule
grandfather(G1, C1) :-
  grandparent(G1, C1),
  male(G1).

%Rule for grandmother. Also uses the grandparent rule
grandmother(G1, C1) :-
  grandparent(G1, C1),
  female(G1).

%Rule for grandchildren. Like the grandparent rule, but in reverse
grandchild(C1, G1) :-
  grandparent(G1, C1).

%Ancestor base case
ancestor(X, Y) :-
  parent(X, Y).

%Ancestor rule. Gets the parent of person 2 and calls ancestor again. Will reach a conclusion at the base case
ancestor(A1, D1) :-
  parent(P1, D1),
  ancestor(A1, P1).

%Descendant base case
descendant(X, Y) :-
  child(X, Y).

%Like ancestor but in reverse. Gets the child of person 2 and calls descendant again
descendant(D1, A1) :-
  child(C1, A1),
  descendant(D1, C1).

%Older rules. These sets of methods are for four cases: Both people are dead, 1 person (or the other) is dead, neither are dead
older(X, Y) :-
  died(X, XDeathYear),
  died(Y, YDeathYear),
  born(X, XBirthYear),
  born(Y, YBirthYear),
  XAge is XDeathYear - XBirthYear,
  YAge is YDeathYear - YBirthYear,
  XAge > YAge.

%1 person is dead
older(X, Y) :-
  died(X, XDeathYear),
  born(X, XBirthYear),
  born(Y, YBirthYear),
  XAge is XDeathYear - XBirthYear,
  YAge is 2018 - YBirthYear,
  XAge > YAge.
%1 person is dead
older(X, Y) :-
  born(X, XBirthYear),
  died(Y, YDeathYear),
  born(Y, YBirthYear),
  XAge is 2018 - XBirthYear,
  YAge is YDeathYear - YBirthYear,
  XAge > YAge.

%Neither are dead
older(X, Y) :-
  born(X, XBirthYear),
  born(Y, YBirthYear),
  XAge is 2018 - XBirthYear,
  YAge is 2018 - YBirthYear,
  XAge > YAge.

%This is the same as the set of older rules, but for the final check, the sign is switched
younger(X, Y) :-
  died(X, XDeathYear),
  died(Y, YDeathYear),
  born(X, XBirthYear),
  born(Y, YBirthYear),
  XAge is XDeathYear - XBirthYear,
  YAge is YDeathYear - YBirthYear,
  XAge < YAge.

%1 is dead
younger(X, Y) :-
  died(X, XDeathYear),
  born(X, XBirthYear),
  born(Y, YBirthYear),
  XAge is XDeathYear - XBirthYear,
  YAge is 2018 - YBirthYear,
  XAge < YAge.

%1 is dead
younger(X, Y) :-
  born(X, XBirthYear),
  died(Y, YDeathYear),
  born(Y, YBirthYear),
  XAge is 2018 - XBirthYear,
  YAge is YDeathYear - YBirthYear,
  XAge < YAge.

%Neither are dead
younger(X, Y) :-
  born(X, XBirthYear),
  born(Y, YBirthYear),
  XAge is 2018 - XBirthYear,
  YAge is 2018 - YBirthYear,
  XAge < YAge.

%Rule for finding who ruled during a certain person's life
regentWhenBorn(X, Y) :-
  born(Y, YBirthYear),
  reigned(X, StartReign, EndReign),
  YBirthYear > StartReign,
  YBirthYear < EndReign.

%Extra credit for finding the cousin of a specific person
cousin(X, Y) :-
  parent(XParent, X),
  parent(YParent, Y),
  sibling(XParent, YParent).
