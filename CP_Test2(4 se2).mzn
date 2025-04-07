var -1000..1000: x;
var -1000..1000: y;
var -1000..1000: z;

constraint 2*x + y*y = z*z - 2*y*z + 5;
constraint x*y = 2*y + 5*z;
constraint x + 5*z = -2*y;
constraint 6*y*z = x + 10;

solve satisfy;
output ["x = \(x), y = \(y), z = \(z)"];