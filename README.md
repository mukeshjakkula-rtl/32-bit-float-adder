# 32-bit-float-adder
32 bit floating point adder 
### signals 
inputs :  a , b 32 bits.

output :  sum 32 bits.

a[31],b[31] : signed bit.

a[30:23], b[30:23] : exponent 8 bits. 

a[22:0], b[22:0] : mantessa 23 bits.

### design features
**Barely** performs signed addition and substraction 

compares the exponents and aligns the mantessa by right shifting by the difference of both exponents (cause we cannot perfom operation for different exponent values)  and the sum exponent is updated 

depending on the signed bits of a and b and the camparing the mantessa's of a and b the sum signed bit is calculated 

## further improvements 
need to implement the normalization of the sum using explicit or implicit normalization.

need to implemt overflow detection circuit 

for addition :

of = a[31] & b[31] & !sum[31]

of = !a[31] & !b[31] & sum[31]

for substraction :

of = !a[31] & b[31] & !sum[31]

0f = a[31] & !b[31] & sum[31]


