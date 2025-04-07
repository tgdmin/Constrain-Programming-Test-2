% Use this editor as a MiniZinc scratch book
include "globals.mzn";

int: N = 105;
int: m = 2;
int: n = 5;

array[1..N] of var 0..1: chips;  % 0 = W, 1 = B

%at least m black chips in n consecutive chips
constraint forall(i in 1..(N - n + 1)) (
    sum([chips[j] | j in i..i+n-1]) >= m
);

% minimize total B ( maximize total W )
solve minimize sum(chips);

output ["Maximum white chips: ", show(N - sum(chips))];