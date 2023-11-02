function [T,time] = sthDegrau(dFj, dF, dTi, dTji)
%STHDEGRAU simula a resposta ao degrau do STH
%   saídas:
%       - T: temperatura do tanque
%       - time: tempo de simulação

% Ponto de operação
Fs = 4.72e-4;
Fjs = 7.079e-4;
Tis = 10; %ºC
Tjis = 93.33; %ºC
Ts = 51.67; %ºC
Tjs = 65.56; %ºC

Fj = dFj + Fjs;
F = dF + Fs;
Ti = dTi + Tis;
Tji = dTji + Tjis;

step = 5;
time = 0:step:1800;
y = zeros(length(time), 2);
y(1,1) = Ts;
y(1,2) = Tjs;

for i = 2:length(time)
    [~,out] = ode45(@(t,y) sth(t,y,Fj,F,Ti,Tji),[time(i-1) time(i)],y(i-1,:));
    y(i,1) = out(end,1);
    y(i,2) = out(end,2);
end

T = y(:,1);
T = T + 0.01*(max(T) - min(T))*randn(size(T));

end

function dydt = sth(t, y, Fj, F, Ti, Tji)
V = 283.168e-3;
Vj = 28.319e-3;
rhoCp = 2.165e3;
rhojCpj = 2.165e3;
UA = 3.065;

T = y(1);
Tj = y(2);

dT = F*(Ti - T)/V + UA*(Tj - T)/(V*rhoCp);
dTj = Fj*(Tji - Tj)/Vj - UA*(Tj - T)/(Vj*rhojCpj);

dydt = [dT; dTj];
end

