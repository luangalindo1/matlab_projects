A = [78 -15 -13 -7; 17 68 -16 4; 19 -17 95 20; 15 -14 -16 79];
B = [70; -60; 55; 50];
tol = 0.002;
it_max = 100;

%MÉTODO DE JACOBI
AUX1 = diag(diag(A));
AUX2 = A - AUX1;
it = 1;
Dr(it) = tol + 1;
X = zeros(size(A));
while ((it <= it_max) && (Dr(it) > tol))
    it = it + 1;
    X_prev = X;
    X = AUX1 \ (B - AUX2*X_prev);
    Dr(it) = norm(X - X_prev, inf)/norm(X, inf);
end
X = diag(X);

%MÉTODO DE GAUSS-SEIDEL
AUX3 = tril(A);
AUX4 = A - AUX3;
it2 = 1;
Dr2(it2) = tol + 1;
X2 = zeros(size(4,1));
while ((it2 <= it_max) && (Dr2(it2) > tol))
    it2 = it2 + 1;
    X_prev2 = X2;
    X2 = AUX3 \ (B - AUX4*X_prev2);
    Dr2(it2) = norm(X2 - X_prev2, inf)/norm(X2, inf);
end
X2 = diag(X2);