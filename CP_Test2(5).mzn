int: N = 6;
int: maxNum = (N*N) div 2;  % maxNum = 18
int: totalSum = 2 * (maxNum*(maxNum+1) div 2); % totalSum = 342
int: lineSum = totalSum div N;  % lineSum = 57

% Decision variables: a 6x6 matrix with values in 1..18.
array[1..N,1..N] of var 1..maxNum: x;

% Each number from 1 to 18 must appear exactly twice.
constraint
  forall(v in 1..maxNum)(
    sum([ bool2int(x[i,j] = v) | i in 1..N, j in 1..N ]) = 2
  );

% Row sums must equal lineSum.
constraint
  forall(i in 1..N)(
    sum(j in 1..N)(x[i,j]) = lineSum
  );

% Column sums must equal lineSum.
constraint
  forall(j in 1..N)(
    sum(i in 1..N)(x[i,j]) = lineSum
  );

% Both main diagonals sum to lineSum.
constraint
  sum(i in 1..N)(x[i,i]) = lineSum;
constraint
  sum(i in 1..N)(x[i, N+1-i]) = lineSum;

% Simple symmetry breaking:
% Force the top-left corner to be the smallest in the first row.
constraint
  forall(j in 2..N)( x[1,1] <= x[1,j] );

% Define the sum of the four corner cells.
var int: corner_sum = x[1,1] + x[1,N] + x[N,1] + x[N,N];

% Use an explicit search strategy to help find the true optimum.
solve :: int_search([ x[i,j] | i in 1..N, j in 1..N ], first_fail, indomain_min, complete)
  minimize corner_sum;

output [
  "Corner sum = " ++ show(corner_sum) ++ "\n",
  show(x)
];
