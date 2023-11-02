%% EXPERIMENTO 04 - Técnicas de Sintonia para Controladores PID

% LUAN FÁBIO MARINHO GALINDO
% 118 110 382
% TURMA 04

% Dados do processo

clear all;

s = tf('s');

G = (1/(s + 1)^4)*exp(-s);

%% 1a questão - item a)

tao1 = 1 + 1/2;

thetha = 1 + 1/2 + 2*1;

K = 1;

G1a = K*(1/(tao1*s + 1))*exp(-thetha*s)

%% 1a questão - item b)

T = tao1;
L = thetha;

%G1b = K*(1/(T*s + 1))*exp(-L*s);

kp_pi = (T/(K*L))*(0.9 + L/(12*T))
Ti_pi = L*(30*T + 3*L)/(9*T + 20*L)

kp_pid = (T/(K*L))*(4/3 + L/(4*T))
Ti_pid = L*(32*T + 6*L)/(13*T + 8*L)
Td_pid = 4*L*T/(11*T+2*L)

%% 1a questão - item c)

% Kcr e Tcr serão determinado por tentativa e erro, por
% meio da análise de uma função de malha fechada.

kcr = 2.21 % valor mais próximo da estabilidade encontrado no degrau (oscilação sustentada)

mf_aux = feedback(G*kcr,1);
[data_aux, time_aux] = step(mf_aux, 100);

[pks,locs] = findpeaks(data_aux,time_aux); % use findpeaks to identify the peaks and 
Tcr = max(diff(locs))                      % their locations then the location information to calculate the period

kp_pizn = kcr/2.2
Ti_pizn = Tcr/1.2

kp_pidzn = kcr/1.7
Ti_pidzn = 0.5*Tcr
Td_pidzn = 0.125*Tcr

G_novo = pade(G, 5); % adaptação para o uso do rlocus
figure()
rlocus(G_novo)

figure()
bode(G)

figure()
nyquist(G)


%% 1a questão - item d

taoc1 = thetha;
kp_simc1 = tao1/(K*(taoc1 + thetha))
Ti_simc1 = min(tao1, 4*(taoc1 + thetha))

taoc2 = 5*thetha;
kp_simc2 = tao1/(K*(taoc2 + thetha))
Ti_simc2 = min(tao1, 4*(taoc2 + thetha))

%% 1a questão - item e)

%mf1 = feedback(G,1);
%[data1, time1] = step(mf1, 100);
%step1 = stepinfo(data1, time1)

control1 = kp_pi + kp_pi/(Ti_pi*s); % parâmetros de conversão: kp = kp; ki = kp/Ti
mf2 = feedback(G*control1, 1);
[data2, time2] = step(mf2, 100);  % o tempo do degrau foi setado de forma a garantir que
cc_pi = stepinfo(data2, time2)   % todos os controladores atinjam o regime

control2 = kp_pid + kp_pid/(Ti_pid*s) + kp_pid*Td_pid*s; % parâmetros de conversão: kp = kp; ki = kp/Ti; kd = kp*Td
mf3 = feedback(G*control2, 1);
[data3, time3] = step(mf3, 100);
cc_pid = stepinfo(data3, time3)

control3 = kp_pizn + kp_pizn/(Ti_pizn*s);
mf4 = feedback(G*control3, 1);
[data4, time4] = step(mf4, 100);
zn_pi = stepinfo(data4, time4)

control4 = kp_pidzn + kp_pidzn/(Ti_pidzn*s) + kp_pidzn*Td_pidzn*s;
mf5 = feedback(G*control4, 1);
[data5, time5] = step(mf5, 100);
zn_pid = stepinfo(data5, time5)

control5 = kp_simc1 + kp_simc1/(Ti_simc1*s);
mf6 = feedback(G*control5, 1);
[data6, time6] = step(mf6, 100);
simc1 = stepinfo(data6, time6)

control6 = kp_simc2 + kp_simc2/(Ti_simc2*s);
mf7 = feedback(G*control6, 1);
[data7, time7] = step(mf7, 100);
simc5 = stepinfo(data7, time7)

figure()
plot(time2, data2, time3, data3, time4, data4, time5, data5, ...
    time6, data6, time6, data6,"LineWidth", 1)
legend({'PI Cohen-Coon', 'PID Cohen-Coon', 'PI Ziegler-Nichols', 'PID Ziegler-Nichols', ...
    'PI SIMC taoc = thetha', 'PI SIMC taoc = 5*thetha'}, 'Location','best')
% subplot(2, 3, 1)
% plot(time1, data1, "LineWidth", 1)
% legend({'FT sem ganho'}, 'Location','best')
% subplot(2, 3, 2)
% plot(time2, data2, "LineWidth", 1)
% legend({'FT com PI'}, 'Location','best')
% subplot(2, 3, 3)
% plot(time3, data3, "LineWidth", 1)
% legend({'FT com PID'}, 'Location','best')
% subplot(2, 3, 4)
% plot(time4, data4, "LineWidth", 1)
% legend({'FT com PI SIMC1'}, 'Location','best')
% subplot(2, 3, 5)
% plot(time5, data5, "LineWidth", 1)
% legend({'FT com PI SIMC2'}, 'Location','best')


%% 2a questão - item a)

% usando os dados de G11 do experimento 2:
T11 = 3.0387e+02;
L11 = 11.9853;
G011 = 1.8934e+04;

kp_pi2 = (T11/(G011*L11))*(0.9 + L11/(12*T11))
Ti_pi2 = L11*(30*T11 + 3*L11)/(9*T11 + 20*L11)

kp_pid2 = (T11/(G011*L11))*(4/3 + L11/(4*T11))
Ti_pid2 = L11*(32*T11 + 6*L11)/(13*T11 + 8*L11)
Td_pid2 = 4*L11*T11/(11*T11+2*L11)

%% 2a questão - item b)

taoc2b = L11;
kp_simc2b = T11/(G011*(taoc2b + L11))
Ti_simc2b = min(T11, 4*(taoc2b + L11))

%% 2a questão - item c)

% constantes do experimento 3
Fs = 4.720e-4; Fjs = 7.079e-4; Tis = 10; Tjis = 93.33; Ts = 51.67; Tjs = 65.56;

% dados
RefT = 53.67; dF = 0; dTi = 0; dTij = 0;

% parâmetros de conversão: kp = kp; ki = kp/Ti;
% foram usados os dados da questão 2, item b)

open("STH2c1.slx");
sim("STH2c1.slx");

ts1 = ans.simout1.time;
ys1 = ans.simout1.signals.values(:, 1);
cc2c1 = stepinfo(ys1, ts1)

open("STH2c2.slx");
sim("STH2c2.slx");

ts2 = ans.simout1.time;
ys2 = ans.simout1.signals.values(:, 1);
cc2c2 = stepinfo(ys2, ts2)

open("STH2c3.slx");
sim("STH2c3.slx");

ts3 = ans.simout1.time;
ys3 = ans.simout1.signals.values(:, 1);
simc2c1 = stepinfo(ys3, ts3)

%% 2a questão - item d)

figure()
plot(ts1, ys1, ts2, ys2, ts3, ys3, "LineWidth", 1)
legend({'PI Cohen-Coon', 'PID Cohen-Coon', 'PI SIMC'}, 'Location', 'Best')

%% 3a questão - item a)

% usando os valores médios

T11p1 = 1.3222e+02;
L11p1 = 19.5277;
G011p1 = 0.6721;

T22p1 = 1.2157e+02;
L22p1 = 19.8574;
G022p1 = 0.6429;

taoc_3a1 = L11p1;
kp_simc3a1 = T11p1/(G011p1*(taoc_3a1 + L11p1))
Ti_simc3a1 = min(T11p1, 4*(taoc_3a1 + L11p1))

taoc_3a2 = L22p1;
kp_simc3a2 = T22p1/(G022p1*(taoc_3a2 + L22p1))
Ti_simc3a2 = min(T22p1, 4*(taoc_3a2 + L22p1))

%% 3a questão - item b)

open("STH3b1.slx");
sim("STH3b1.slx");

ts3b1 = ans.simout3b1.time;
ys3b1 = ans.simout3b1.signals.values(:, 1);
simc3b1 = stepinfo(ys3b1, ts3b1)

open("STH3b2.slx");
sim("STH3b2.slx");

ts3b2 = ans.simout3b2.time;
ys3b2 = ans.simout3b2.signals.values(:, 1);
simc3b2 = stepinfo(ys3b2, ts3b2)

figure()
plot(ts3b1, ys3b1, ts3b2, ys3b2, "LineWidth", 1)
legend({'FT com PI SIMC G11', 'FT com PI SIMC G22'}, 'Location', 'Best')

