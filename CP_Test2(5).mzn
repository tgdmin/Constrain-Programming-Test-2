int: N = 6;
int: maxNum = (N*N) div 2;  
int: totalSum = 2 * (maxNum*(maxNum+1) div 2); 
int: lineSum = totalSum div N; 

array[1..N,1..N] of var 1..maxNum: x;

constraint
  forall(v in 1..maxNum)(
    sum([ bool2int(x[i,j] = v) | i in 1..N, j in 1..N ]) = 2
  );

constraint
  forall(i in 1..N)(
    sum(j in 1..N)(x[i,j]) = lineSum
  );

constraint
  forall(j in 1..N)(
    sum(i in 1..N)(x[i,j]) = lineSum
  );

constraint
  sum(i in 1..N)(x[i,i]) = lineSum;
constraint
  sum(i in 1..N)(x[i, N+1-i]) = lineSum;


constraint
  forall(j in 2..N)( x[1,1] <= x[1,j] );

var int: corner_sum = x[1,1] + x[1,N] + x[N,1] + x[N,N];

solve :: int_search([ x[i,j] | i in 1..N, j in 1..N ], first_fail, indomain_min, complete)
  minimize corner_sum;

output [
  "Corner sum = " ++ show(corner_sum) ++ "\n",
  show(x)
];
