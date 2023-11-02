%% Experimento 5 - Controle Feedforward 
% Disciplina: Lab. de Controle Digital (Turma 05)  
% Professor: Péricles Barros
% Aluno (a): Ana Rita (118110418)

%% Definindo parâmetros do experimento anterior:

s = tf('s');

% Gp = G11:

G0p = 1.8694e+04;
T1p = 305.9210;
Lp = 16.1246;

Gp = tf(G0p, [T1p 1]);
Gp.IODelay = Lp;

% Gd1 = G12:

G0d1 = -4.2564e+04;
T1d1 = 294.3041;
Ld1 = 2.1237;

% Gd2 = G13:

G0d2 = 0.4972;
T1d2 = 309.2609;
Ld2 = 2.1123;

% Gd3 = G14:

G0d3 = 0.4959;
T1d3 = 313.4362;
Ld3 = 12.9865;

%% Item 1 - Projeto do controle feedback

tau_c = Lp;
Kp_p = (1/G0p)*(T1p/(tau_c + Lp))
Ki_p = Kp_p/(min(T1p, 4*(tau_c + Lp)))

%% Item 2 - Projeto do controle feedforward

% Fazendo Gfi = -(Gdi/Gp), de forma que em todos os casos
% será necessário fazer aproximação para garantir causalidade

% Gf1:
Kf1 = -(G0d1/G0p)
tau_pl = T1p + (Lp - Ld1)
tau_d1 = T1d1
teta_1 = Lp - Ld1

Gf1 = Kf1*((tau_pl*s + 1)/(tau_d1*s + 1))

% Gf2:
Kf2 = -(G0d2/G0p)
tau_p2 = T1p + (Lp - Ld2)
tau_d2 = T1d2
teta_2 = Lp - Ld2

Gf2 = Kf2*((tau_p2*s + 1)/(tau_d2*s + 1))

% Gf3:
Kf3 = -(G0d3/G0p)
tau_p3 = T1p + (Lp - Ld3)
tau_d3 = T1d3
teta_d3 = Lp - Ld3

Gf3 = Kf3*((tau_p3*s + 1)/(tau_d3*s + 1))

%% Item 3 - Simulações

% Parâmetros da Simulação:
V = 283.168e-3;
Vj = 28.319e-3;
pcp = 2.165e3;
pcpj = 2.165e3;
UA = 3.065;

Fs = 4.720e-4;
Fjs = 7.079e-4;
Tis = 10;
Tjis = 93.33;
Tjs = 65.56;
Ts = 51.67;

%% Simulação (a)
dF = 4.72e-5; 
dTi = 0; 
dTji = 0;

open('item3_1.slx');
sim("item3_1.slx", 500);

open('item3_2.slx');
sim("item3_2.slx", 500);

T_ref = Ts*(ones(size(tout0)));

figure();
plot(tout1, yout1, tout0, yout0, tout0, T_ref);

ylabel("T(ºC)");
xlabel("t(s)");
title("Comparação entre os controladores p/ apenas dF = 4.72e-5 m³/s")
legend("Feedback + FeedForward", "Feedback", "Referência");

erro_maxfb1 = max(abs(yout0 - Ts))
erro_maxfbff1 = max(abs(yout1 - Ts))
IAE_fb1 = sum(abs(yout0 - Ts))
IAE_fbff1 = sum(abs(yout1 - Ts))

%% Simulação (b)
dF = 0; 
dTi = 1; 
dTji = 0;

open('item3_1.slx');
sim("item3_1.slx", 500);

open('item3_2.slx');
sim("item3_2.slx", 500);

T_ref = Ts*(ones(size(tout0)));

figure();
plot(tout1, yout1, tout0, yout0, tout0, T_ref);

ylabel("T(ºC)");
xlabel("t(s)");
title("Comparação entre os controladores p/ apenas dTi = 1ºC")
legend("Feedback + FeedForward", "Feedback", "Referência");

erro_maxfb2 = max(abs(yout0 - Ts))
erro_maxfbff2 = max(abs(yout1 - Ts))
IAE_fb2 = sum(abs(yout0 - Ts))
IAE_fbff2 = sum(abs(yout1 - Ts))

%% Simulação (c)
dF = 0; 
dTi = 0; 
dTji = 1;

open('item3_1.slx');
sim("item3_1.slx", 500);

open('item3_2.slx');
sim("item3_2.slx", 500);

T_ref = Ts*(ones(size(tout0)));

figure();
plot(tout1, yout1, tout0, yout0, tout0, T_ref);

ylabel("T(ºC)");
xlabel("t(s)");
title("Comparação entre os controladores p/ apenas dTij = 1ºC")
legend("Feedback + FeedForward", "Feedback", "Referência");

erro_maxfb3 = max(abs(yout0 - Ts))
erro_maxfbff3 = max(abs(yout1 - Ts))
IAE_fb3 = sum(abs(yout0 - Ts))
IAE_fbff3 = sum(abs(yout1 - Ts))