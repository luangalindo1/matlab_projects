function [G0, T1, L] = parametrosFOPTD(y, h, dt)

% definindo valores iniciais
G0 = 0; L = 0; T1 = 0;

% remoção de condições iniciais
y = y - y(1);

% questão 1
thetha = [G0 G0*L T1];

% questão 2
[Lthetha, Cthetha] = size(thetha);
R = zeros(Cthetha);
f = zeros(Cthetha, 1);

% questão 3
N = length(y);

for k = 1:N
    Phi = transpose([h*k*dt -h -y(k)]);
    R = R + Phi*transpose(Phi);
    A = sum(y(1:k))*dt;
    f = f + Phi*A;
end

% questão 4

thetha = inv(R)*f;
G0 = thetha(1);
L = thetha(2)/G0;
T1 = thetha(3);
end
