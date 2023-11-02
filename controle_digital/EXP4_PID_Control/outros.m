%% LIXO

% Será usada uma função baixada na internet;
% os coeficientes do polinômio característico são as entradas para a função.

syms kp;
[M, L] = routh_hurwitz([1 4 6 4 1+kp])
% da matriz M, 3.2 - 0.8kp = 0 daí kp = kcr = 4
kcr = 2.21

% x = 2*j*pi/Tx;
% p = x^4 + 4*x^3 + 6*x^2 + 4*x + 5 == 0;
% 
% Tcr = solve(p)