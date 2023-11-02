%% EXPERIMENTO 03 - LCD
% Luan Fábio Marinho Galindo
% 118 110 382
% Turma 04

%% PRÁTICA 1
% Vide arquivo "parametrosFOPTD.m"

%% PRÁTICA 2
% Definindo os tempos de amostragem
Deltat = 5;
s = tf('s');

% entrada 1
[T1, tempo1] = sthDegrau(4.72e-5, 0, 0, 0);
[G01, T11, L1] = parametrosFOPTD(T1, 4.72e-5, Deltat);

G01

G1 = (G01/(T11*s +1))*exp(-L1*s);
ysim1 = lsim(G1, 4.72e-5*ones(size(tempo1)), tempo1);
ysim1 = ysim1 + T1(1);

% erro médio
erro1 = (1/length(T1))*sum((T1 - ysim1).^2)

figure
plot(tempo1, ysim1, tempo1, T1)
title('Resposta ao degrau: modelo de aquecimento (Saída 1, Entrada 1)')
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Modelo', 'Dados'}, 'Location','best')


% entrada 2
[T2, tempo2] = sthDegrau(0, 4.72e-5, 0, 0);
[G02, T12, L2] = parametrosFOPTD(T2, 4.72e-5, Deltat);

G02

G2 = (G02/(T12*s +1))*exp(-L2*s);
ysim2 = lsim(G2, 4.72e-5*ones(size(tempo2)), tempo2);
ysim2 = ysim2 + T2(1);

% erro médio
erro2 = (1/length(T2))*sum((T2 - ysim2).^2)

figure
plot(tempo2, ysim2, tempo2, T2)
title('Resposta ao degrau: modelo de aquecimento (Saída 1, Entrada 2)')
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Modelo', 'Dados'}, 'Location','best')

% entrada 3
[T3, tempo3] = sthDegrau(0, 0, 1, 0);
[G03, T13, L3] = parametrosFOPTD(T3, 1, Deltat);

G03

G3 = (G03/(T13*s +1))*exp(-L3*s);
ysim3 = lsim(G3, ones(size(tempo3)), tempo3);
ysim3 = ysim3 + T3(1);

% erro médio
erro3 = (1/length(T3))*sum((T3 - ysim3).^2)

figure
plot(tempo3, ysim3, tempo3, T3)
title('Resposta ao degrau: modelo de aquecimento (Saída 1, Entrada 3)')
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Modelo', 'Dados'}, 'Location','best')

% entrada 4
[T4, tempo4] = sthDegrau(0, 0, 0, 1);
[G04, T14, L4] = parametrosFOPTD(T4, 1, Deltat);

G04

G4 = (G04/(T14*s +1))*exp(-L4*s);
ysim4 = lsim(G4, ones(size(tempo3)), tempo4);
ysim4 = ysim4 + T4(1);

% erro médio
erro4 = (1/length(T4))*sum((T4 - ysim4).^2)

figure
plot(tempo4, ysim4, tempo4, T4)
title('Resposta ao degrau: modelo de aquecimento (Saída 1, Entrada 1)')
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Modelo', 'Dados'}, 'Location','best')