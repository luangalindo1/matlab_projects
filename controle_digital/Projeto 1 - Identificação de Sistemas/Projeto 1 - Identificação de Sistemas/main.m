%% PROJETO 1 - LCD
% Luan Fábio Marinho Galindo
% 118 110 382
% Turma 04
% Módulo utilizado: 13

clear all, clc

% Definindo o tempo de amostragem
Deltat = 2;
s = tf('s');

load("dados_concatenados.mat");
% É importante mencionar que durante a medição houve um problema com o
% controlador, que travou. Acontecido isso, após o problema ter sido
% resolvido, foram obtidas duas fontes de dados, as quais foram
% concatenadas para uma após a conclusão das medições.

%% ENTRADA 1 SAÍDA 1

figure("Name", 'Dados do degrau 1')
plot(MV1) % será determinado, por inspeção, os intervalos de aquecimento e resfriamento.

ts1 = 1:2:length(MV1(249:494))*2; td1 = 1:2:length(MV1(673:937))*2; % tempos de subida e descida

Y11s = PV1(249:494);
[G011s, T11s, L11s] = parametrosFOPTD(Y11s, 10, Deltat); % Aquecimento ou Subida
Y11d = PV1(673:937);
[G011d, T11d, L11d] = parametrosFOPTD(Y11d, -10, Deltat); % Resfriamento ou Descida

G011 = (G011s + G011d)/2;
T11 = (T11s + T11d)/2;
L11 = (L11s + L11d)/2;

G11 = (G011/(T11*s + 1))*exp(-L11*s);
ysim11s = lsim(G11, MV1(249:494) - MV1(249), ts1);
ysim11d = lsim(G11, MV1(673:937) - MV1(673), td1);

figure("Name", 'Resposta ao Degrau: Entrada 1 Saída 1')
subplot(1,2,1)
plot(ts1, ysim11s, ts1, Y11s - Y11s(1))
title("Aquecimento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
subplot(1,2,2)
plot(td1, ysim11d, td1, Y11d - Y11d(1))
title("Resfriamento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Modelo', 'Dados'}, 'Location','best')

% erro médio
erro_s11 = (1/length(ysim11s))*sum((ysim11s' - (Y11s - Y11s(1))).^2);
erro_d11 = (1/length(ysim11d))*sum((ysim11d' - (Y11d - Y11d(1))).^2);
erro11 = erro_s11 + erro_d11

%% ENTRADA 1 SAÍDA 2

Y21s = PV2(249:494);
[G021s, T21s, L21s] = parametrosFOPTD(Y21s, 10, Deltat);
Y21d = PV2(673:937);
[G021d, T21d, L21d] = parametrosFOPTD(Y21d, -10, Deltat);

G021 = (G021s + G021d)/2;
T21 = (T21s + T21d)/2;
L21 = (L21s + L21d)/2;

G21 = (G021/(T21*s +1))*exp(-L21*s);
ysim21s = lsim(G21, MV1(249:494)-MV1(249), ts1); % para a mesma entrada, os tempos de resfriamento
ysim21d = lsim(G21, MV1(673:937)-MV1(673), td1); % e aquecimento são iguais

figure("Name", 'Resposta ao Degrau: Entrada 1 Saída 2')
subplot(1,2,1)
plot(ts1, ysim21s, ts1, Y21s - Y21s(1))
title("Aquecimento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
subplot(1,2,2)
plot(td1, ysim21d, td1, Y21d - Y21d(1))
title("Resfriamento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Modelo', 'Dados'}, 'Location','best')

% erro médio
erro_s21 = (1/length(ysim21s))*sum((ysim21s' - (Y21s - Y21s(1))).^2);
erro_d21 = (1/length(ysim21d))*sum((ysim21d' - (Y21d - Y21d(1))).^2);
erro21 = erro_s21 + erro_d21

%% ENTRADA 2 SAÍDA 1

figure("Name", 'Dados do degrau 2')
plot(MV2)

ts2 = 1:2:length(MV2(1544:1797))*2; td2 = 1:2:length(MV2(1797:2018))*2; 

Y12s = PV1(1544:1797);
[G012s, T12s, L12s] = parametrosFOPTD(Y12s, 10, Deltat); 
Y12d = PV1(1797:2018);
[G012d, T12d, L12d] = parametrosFOPTD(Y12d, -10, Deltat);

G012 = (G012s + G012d)/2;
T12 = (T12s + T12d)/2;
L12 = (L12s + L12d)/2;

G12 = (G012/(T12*s + 1))*exp(-L12*s);
ysim12s = lsim(G12, MV2(1544:1797) - MV2(1544), ts2);
ysim12d = lsim(G12, MV2(1797:2018) - MV2(1797), td2);

figure("Name", 'Resposta ao Degrau: Entrada 2 Saída 1')
subplot(1,2,1)
plot(ts2, ysim12s, ts2, Y12s - Y12s(1))
title("Aquecimento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
subplot(1,2,2)
plot(td2, ysim12d, td2, Y12d - Y12d(1))
title("Resfriamento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Modelo', 'Dados'}, 'Location','best')

% erro médio
erro_s12 = (1/length(ysim12s))*sum((ysim12s' - (Y12s - Y12s(1))).^2);
erro_d12 = (1/length(ysim12d))*sum((ysim12d' - (Y12d - Y12d(1))).^2);
erro12 = erro_s12 + erro_d12

%% ENTRADA 2 SAÍDA 2

Y22s = PV2(1544:1797);
[G022s, T22s, L22s] = parametrosFOPTD(Y22s, 10, Deltat); 
Y22d = PV2(1797:2018);
[G022d, T22d, L22d] = parametrosFOPTD(Y22d, -10, Deltat);

G022 = (G022s + G022d)/2;
T22 = (T22s + T22d)/2;
L22 = (L22s + L22d)/2;

G22 = (G022/(T22*s + 1))*exp(-L22*s);
ysim22s = lsim(G22, MV2(1544:1797) - MV2(1544), ts2);
ysim22d = lsim(G22, MV2(1797:2018) - MV2(1797), td2);

figure("Name", 'Resposta ao Degrau: Entrada 2 Saída 2')
subplot(1,2,1)
plot(ts2, ysim22s, ts2, Y22s - Y22s(1))
title("Aquecimento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
subplot(1,2,2)
plot(td2, ysim22d, td2, Y22d - Y22d(1))
title("Resfriamento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Modelo', 'Dados'}, 'Location','best')

% erro médio
erro_s22 = (1/length(ysim22s))*sum((ysim22s' - (Y22s - Y22s(1))).^2);
erro_d22 = (1/length(ysim22d))*sum((ysim22d' - (Y22d - Y22d(1))).^2);
erro22 = erro_s22 + erro_d22
