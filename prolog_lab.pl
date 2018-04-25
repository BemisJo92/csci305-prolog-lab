% John Bemis
% CSCI 305 Prolog Lab 2

mother(M,C) :-
  parent(M,C),
  female(M).

father(F,C) :-
  parent(F,C),
  male(F).

spouse(S1, S2) :-
  married(S1, S2);
  married(S2, S1).

child(C, P) :-
  parent(P, C).

son(S, P) :-
  child(S, P),
  male(S).

daughter(D, P) :-
  child(D, P),
  female(D).

sibling(C1, C2) :-
  parent(S1, C1),
  parent(S2, C2),
  not(C1 = C2),
  (S1 = S2).

brother(C1, C2) :-
  sibling(C1, C2),
  male(C1).

sister(C1, C2) :-
  sibling(C1, C2),
  female(C1).

uncle(U1, C1) :-
  parent(P1, C1),
  brother(U1, P1),
  male(U1).

uncle(U1, C1) :-
  parent(P1, C1),
  sibling(P1, S1),
  married(U1, S1),
  male(U1).
