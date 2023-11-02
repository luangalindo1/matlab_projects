function [G0,T1,L] = parametrosFOPTD(h,y,L,Ts)
% Programa para estimação dos parâmetros de um modelo de primeira ordem com
%   atraso por meio do método dos mínimos quadrados
% Os vetores de entrada u e y precisam ter o mesmo comprimento
% O tempo de amostragem é assumido como unitário

% yt = [h*k -h y(k)] * [G0 G0*L T1]'

R = zeros(3);
f = zeros(3,1);
N = length(y);

deltat = Ts; inicio = L/deltat;
for k = inicio:N
    phi = [h*(deltat*k) -h -y(k)]';
    R = R + phi*phi';
    A = sum(y(1:k))*deltat;
    f = f + phi*A;
end

theta = R\f;
G0 = theta(1);
L = theta(2)/G0;
T1 = theta(3);

% num = G0;
% den = [T1 1];
