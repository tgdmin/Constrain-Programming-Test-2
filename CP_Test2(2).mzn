int: N;
int: max_size;
set of int: Guests = 1..N;

array[int] of tuple(int,int): conflicts;

int: T = N;

array[Guests] of var 1..T: table;

constraint forall(k in index_set(conflicts)) (
    table[conflicts[k].1] != table[conflicts[k].2]
);

constraint forall(t in 1..T) (
    sum(i in Guests)(bool2int(table[i] == t)) <= max_size
);

var int: num_tables = max(table);

solve minimize num_tables;

output [show(num_tables)];