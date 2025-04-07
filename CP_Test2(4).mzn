var -1000..1000: x;
var -1000..1000: y;
var -1000..1000: z;

constraint 2*x + pow(y, 3) = pow(z, 2) - y - 17;
constraint pow(x, 2) - y + 3*z = 11;
constraint x*y = 2*y + 5*z;

solve satisfy;

output ["x = \(x), y = \(y), z = \(z)"];