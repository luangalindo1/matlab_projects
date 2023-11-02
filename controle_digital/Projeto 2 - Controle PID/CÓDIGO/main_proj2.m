%% PROJETO 2 - CONTROLE PID
% Luan Fábio Marinho Galindo
% 118 110 382
% Turma 04
% Módulo utilizado: 13

clear; clc;

% Definindo o tempo de amostragem, modelo da ft e valor do degrau
Deltat = 2;
s = tf('s');
h = 10;

load("exp29072022090103.mat");
% carregar dados experimentais

%% ENTRADA 1 SAÍDA 1

figure("Name", 'Dados do degrau 1')
plot(sp1) % será determinado, por inspeção, os intervalos de aquecimento e resfriamento.

tsi_sp1 = 257; tsf_sp1 = 380; tdi_sp1 = 381; tdf_sp1 = 522; % tempos de subida e descida iniciais e finais

ts1 = 1:Deltat:length(sp1(tsi_sp1:tsf_sp1))*2; 
td1 = 1:Deltat:length(sp1(tdi_sp1:tdf_sp1))*2; % tempos de subida e descida

Y11s = pv1(tsi_sp1:tsf_sp1); % Aquecimento ou Subida 
Y11d = pv1(tdi_sp1:tdf_sp1); % Resfriamento ou Descida 

% dados do projeto 1
G011 = 0.6721; T11 = 1.3222e+02; L11 = 19.5277;

G11 = (G011/(T11*s + 1))*exp(-L11*s);

% dados do experimento 4
Kp11 = 5.0371; Ti11 = 132.22;

G11_simc = Kp11 + Kp11/(Ti11*s);

% Simulação de Malha Fechada

FTMF11 = feedback(G11*G11_simc, 1);
ysim11s = lsim(FTMF11, pv1(tsi_sp1:tsf_sp1) - pv1(tsi_sp1), ts1);
ysim11d = lsim(FTMF11, pv1(tdi_sp1:tdf_sp1) - pv1(tdi_sp1), td1);

% Concatenação das saídas real e simulada
ysim11 = horzcat(transpose(ysim11s), transpose(ysim11d));
ysim11 = transpose(ysim11);
yre11 = horzcat(Y11s, Y11d);
yre11 = transpose(yre11);

stepinfo(ysim11)
stepinfo(yre11)

% Integral do erro absoluto
IAE_sim11 = sum(abs(transpose(pv1(tsi_sp1:tdf_sp1)) - ysim11))*Deltat
IAE_re11 = sum(abs(transpose(pv1(tsi_sp1:tdf_sp1)) - yre11))*Deltat

figure("Name", 'Resposta ao Degrau: Entrada 1 Saída 1')
subplot(2,1,1)
plot(ts1, ysim11s, ts1, Y11s - Y11s(1), "LineWidth", 1)
title("Aquecimento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Controlador', 'Dados'}, 'Location','best')
subplot(2,1,2)
plot(td1, ysim11d, td1, Y11d - Y11d(1), "LineWidth", 1)
title("Resfriamento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Controlador', 'Dados'}, 'Location','best')

%% ENTRADA 1 SAÍDA 2

Y21s = pv2(tsi_sp1:tsf_sp1);  
Y21d = pv2(tdi_sp1:tdf_sp1); 

% dados do projeto 1
G021 = 0.4465; T21 = 1.9576e+02; L21 = 34.2828;

G21 = (G021/(T21*s + 1))*exp(-L21*s);

% Simulação de Malha Fechada

FTMF21 = feedback(G21*G11_simc, 1);
ysim21s = lsim(FTMF21, pv2(tsi_sp1:tsf_sp1) - pv2(tsi_sp1), ts1);
ysim21d = lsim(FTMF21, pv2(tdi_sp1:tdf_sp1) - pv2(tdi_sp1), td1);

figure("Name", 'Resposta ao Degrau: Entrada 1 Saída 1')
subplot(2,1,1)
plot(ts1, ysim21s, ts1, Y21s - Y21s(1), "LineWidth", 1)
title("Aquecimento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Controlador', 'Dados'}, 'Location','best')
subplot(2,1,2)
plot(td1, ysim21d, td1, Y21d - Y21d(1), "LineWidth", 1)
title("Resfriamento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Controlador', 'Dados'}, 'Location','best')

%% ENTRADA 2 SAÍDA 1

figure("Name", 'Dados do degrau 2')
plot(sp2) 

tsi_sp2 = 755; tsf_sp2 = 903; tdi_sp2 = 904; tdf_sp2 = 1085;

ts2 = 1:Deltat:length(sp2(tsi_sp2:tsf_sp2))*2; 
td2 = 1:Deltat:length(sp2(tdi_sp2:tdf_sp2))*2;

Y12s = pv1(tsi_sp2:tsf_sp2);  
Y12d = pv1(tdi_sp2:tdf_sp2);  

% dados do projeto 1
G012 = 0.4193; T12 = 1.6842e+02; L12 = 32.6217;

G12 = (G012/(T12*s + 1))*exp(-L12*s);

% dados do experimento 4
Kp22 = 4.7614; Ti22 = 121.57;

G22_simc = Kp22 + Kp22/(Ti22*s);

% Simulação de Malha Fechada

FTMF12 = feedback(G12*G22_simc, 1);
ysim12s = lsim(FTMF12, pv2(tsi_sp2:tsf_sp2) - pv2(tsi_sp2), ts2);
ysim12d = lsim(FTMF12, pv2(tdi_sp2:tdf_sp2) - pv2(tdi_sp2), td2);

figure("Name", 'Resposta ao Degrau: Entrada 2 Saída 1')
subplot(2,1,1)
plot(ts2, ysim12s, ts2, Y12s - Y12s(1), "LineWidth", 1)
title("Aquecimento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Controlador', 'Dados'}, 'Location','best')
subplot(2,1,2)
plot(td2, ysim12d, td2, Y12d - Y12d(1), "LineWidth", 1)
title("Resfriamento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Controlador', 'Dados'}, 'Location','best')

%% ENTRADA 2 SAÍDA 2

Y22s = pv2(tsi_sp2:tsf_sp2);  
Y22d = pv2(tdi_sp2:tdf_sp2);  

% dados do projeto 1
G022 = 0.6429; T22 = 1.2157e+02; L22 = 19.8574;

G22 = (G022/(T22*s + 1))*exp(-L22*s);

% Simulação de Malha Fechada

FTMF22 = feedback(G22*G22_simc, 1);
ysim22s = lsim(FTMF22, pv2(tsi_sp2:tsf_sp2) - pv2(tsi_sp2), ts2);
ysim22d = lsim(FTMF22, pv2(tdi_sp2:tdf_sp2) - pv2(tdi_sp2), td2);

% Concatenação das saídas real e simulada
ysim22 = horzcat(transpose(ysim22s), transpose(ysim22d));
ysim22 = transpose(ysim22);
yre22 = horzcat(Y22s, Y22d);
yre22 = transpose(yre22);

stepinfo(ysim22)
stepinfo(yre22)

% Integral do erro absoluto
IAE_sim22 = sum(abs(transpose(pv2(tsi_sp2:tdf_sp2)) - ysim22))*Deltat
IAE_re22 = sum(abs(transpose(pv2(tsi_sp2:tdf_sp2)) - yre22))*Deltat

figure("Name", 'Resposta ao Degrau: Entrada 2 Saída 1')
subplot(2,1,1)
plot(ts2, ysim12s, ts2, Y12s - Y12s(1), "LineWidth", 1)
title("Aquecimento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Controlador', 'Dados'}, 'Location','best')
subplot(2,1,2)
plot(td2, ysim12d, td2, Y12d - Y12d(1), "LineWidth", 1)
title("Resfriamento")
xlabel('Tempo (s)')
ylabel('Variação de Temperatura (°C)')
legend({'Controlador', 'Dados'}, 'Location','best')
