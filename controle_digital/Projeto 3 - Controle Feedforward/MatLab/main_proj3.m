%% PROJETO 3 - CONTROLE FEEDFOWARD
% Luan Fábio Marinho Galindo
% 118 110 382
% Turma 04

clear; clc;
s = tf("s");

%% QUESTÃO 1

% dados do experimento STH para Gp = G11
G011 = 1.8934e+04; T111 = 3.0387e+02; L11 = 11.9853;

Gp = tf(G011, [T111, 1]);
Gp.IODelay = L11;

taoc = L11;
kp_simc = (1/G011)*(T111/(taoc + L11))
Ti_simc = min(T111, 4*(taoc + L11))

% parâmetros de conversão: kp = kp; ki = kp/Ti; 
control_simc = kp_simc + kp_simc/(Ti_simc*s);

%contr_simc = pid(kp_simc, (kp_simc/Ti_simc), 0) % mostrar a ft com as
                                                 % constantes em evidência

%% QUESTÃO 2

% com Gfi = -(Gdi/Gp)
% e fazendo as devidas aproximações para obter a causalidade

% dados do experimento STH para Gd1 = G12
G012 = -4.2823e+04; T112 = 2.9241e+02; L12 = 0.5939;

% para Gf1:
Kf1 = -(G012/G011)
tao_pl = T111 + (L11 - L12)
tao_d1 = T112
thetha_1 = L11 - L12

Gf1 = Kf1*((tao_pl*s + 1)/(tao_d1*s + 1))

% dados do experimento STH para Gd2 = G13
G013 = 0.4912; T113 = 3.0781e+02; L13 = 4.9328;

% para Gf2:
Kf2 = -(G013/G011)
tao_p2 = T113 + (L11 - L13)
tao_d2 = T113
thetha_2 = L11 - L13

Gf2 = Kf2*((tao_p2*s + 1)/(tao_d2*s + 1))

% dados do experimento STH para Gd3 = G14
G014 = 0.4830; T114 = 3.1162e+02; L14 = 22.4842;

% para Gf1:
Kf3 = -(G014/G011)
tao_p3 = T114 + (L11 - L14)
tao_d3 = T114
thetha_3 = L11 - L14

Gf3 = Kf3*((tao_p3*s + 1)/(tao_d3*s + 1))

%% QUESTÃO 3

Fs = 4.720e-4;
Fjs = 7.079e-4;
Tis = 10;
Tjis = 93.33;
Tjs = 65.56;
Ts = 51.67;

% Simulação (a)
dF = 4.72e-5; 
dTi = 0; 
dTji = 0;

open('item3_1.slx')
sim("item3_1.slx", 500)

open('item3_2.slx')
sim("item3_2.slx", 500)

RefT = Ts*(ones(size(tout0)));

figure()
plot(tout1, yout1, tout0, yout0, tout0, RefT, "LineWidth", 1)

ylabel("T(ºC)")
xlabel("t(s)")
title("Comparação entre os controladores com dF = 4.72e-5 m³/s")
legend({'Feedback + FeedForward', 'Feedback', 'Referência'}, 'Location', 'Best')

erro_maxfb1 = max(abs(yout0 - Ts))
erro_maxfbff1 = max(abs(yout1 - Ts))
IAE_fb1 = sum(abs(yout0 - Ts))
IAE_fbff1 = sum(abs(yout1 - Ts))

% Simulação (b)
dF = 0; 
dTi = 1; 
dTji = 0;

open('item3_1.slx');
sim("item3_1.slx", 500);

open('item3_2.slx');
sim("item3_2.slx", 500);

RefT = Ts*(ones(size(tout0)));

figure()
plot(tout1, yout1, tout0, yout0, tout0, RefT, "LineWidth", 1)

ylabel("T(ºC)")
xlabel("t(s)")
title("Comparação entre os controladores com dTi = 1ºC")
legend({'Feedback + FeedForward', 'Feedback', 'Referência'}, 'Location','best')

erro_maxfb2 = max(abs(yout0 - Ts))
erro_maxfbff2 = max(abs(yout1 - Ts))
IAE_fb2 = sum(abs(yout0 - Ts))
IAE_fbff2 = sum(abs(yout1 - Ts))

% Simulação (c)
dF = 0; 
dTi = 0; 
dTji = 1;

open('item3_1.slx');
sim("item3_1.slx", 500);

open('item3_2.slx');
sim("item3_2.slx", 500);

RefT = Ts*(ones(size(tout0)));

figure()
plot(tout1, yout1, tout0, yout0, tout0, RefT, "LineWidth", 1)

ylabel("T(ºC)")
xlabel("t(s)")
title("Comparação entre os controladores com dTij = 1ºC")
legend({'Feedback + FeedForward', 'Feedback', 'Referência'}, 'Location','best')

erro_maxfb3 = max(abs(yout0 - Ts))
erro_maxfbff3 = max(abs(yout1 - Ts))
IAE_fb3 = sum(abs(yout0 - Ts))
IAE_fbff3 = sum(abs(yout1 - Ts))

