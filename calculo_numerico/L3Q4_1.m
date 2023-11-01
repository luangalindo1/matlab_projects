A = [81 -20 -17 11; -17 77 7 14; 10 18 68 -6; 0 10 -25 56];
B = [35; 40; 30; 33];

%ELIMINAÇÃO DE GAUSS
X1 = A\B;

%DECOMPOSIÇÃO LU
[L, U] = lu(A);
Y = L\B;
X2 = U\Y;