%% EXPERIMENTO 03 - Linearização e Discretização de Sistemas

% LUAN FÁBIO MARINHO GALINDO
% 118 110 382
% TURMA 04

%% PARÂMETROS E PONTO DE OPERAÇÃO

V = 283.168e-3; Fs = 4.720e-4;
Vj = 28.319e-3; Fjs = 7.079e-4;
pcp = 2.165e3; Tis = 10;
pcpj = 2.165e3; Tjis = 93.33;
UA = 3.065; Tjs = 65.56;
Ts = 51.67;

%% QUESTÃO 1

dFj = 4.72e-5; dF = 0; dTi = 0; dTij = 0; %tsim = 1800;

open("questao1.slx")
sim("questao1.slx")

ts1 = ans.simout1.time;
ys1 = ans.simout1.signals.values(:, 1);
valores1 = stepinfo(ys1, ts1, ys1(end), ys1(1))
ys1final = ys1(end)

%% QUESTÃO 2

A11 = -(Fs/V + UA/(V*pcp));
A12 = UA/(V*pcp);
A21 = UA/(Vj*pcpj);
A22 = -(Fjs/Vj + UA/(Vj*pcpj));

A = [A11 A12; 
    A21 A22];

Bu11 = 0;
Bu21 = (Tjis - Tjs)/Vj;

Bu = [Bu11; Bu21];

Bd11 = (Tis - Ts)/V;
Bd12 = Fs/V;
Bd13 = 0;
Bd21 = 0;
Bd22 = 0;
Bd23 = Fjs/Vj;

Bd = [Bd11 Bd12 Bd13; 
    Bd21 Bd22 Bd23];

B = [Bu Bd];

C = [1 0];

D = zeros(1,4);

open("questao2.slx")
sim("questao2.slx")

ts2 = ans.simout2.time;
ys2 = ans.simout2.signals.values(:, 1);
valores2 = stepinfo(ys2, ts2, ys2(end), ys2(1))
ys2final = ys2(end)

%% QUESTÃO 3

s = tf('s');

p = C*inv(s*eye(size(A)) - A); 

G = p*Bu;

Gd1 = p*[Bd11;
           Bd21];

Gd2 = p*[Bd12;
           Bd22];

Gd3 = p*[Bd13;
           Bd23];

open("questao3.slx")
sim("questao3.slx")

ts3 = ans.simout3.time;
ys3 = ans.simout3.signals.values(:, 1);
valores3 = stepinfo(ys3, ts3, ys3(end), ys3(1))
ys3final = ys3(end)

%% QUESTÃO 4

figure()
plot(ts1, ys1, '--', ts2, ys2, ':', ts3, ys3, "LineWidth", 1)
legend({'questão1', 'questão2', 'questão3'}, 'Location','best')

%% QUESTÃO 5

dFj2 = dFj*10;

open("questao5.slx")
sim("questao5.slx")

ts15 = ans.simout15.time;
ys15 = ans.simout15.signals.values(:, 1);
ts25 = ans.simout25.time;
ys25 = ans.simout25.signals.values(:, 1);
ts35 = ans.simout35.time;
ys35 = ans.simout35.signals.values(:, 1);

figure()
plot(ts15, ys15, '--', ts25, ys25, ':', ts35, ys35, "LineWidth", 1)
legend({'questão1', 'questão2', 'questão3'}, 'Location','best')


%% QUESTÃO 6

ftc = ss(A, B, C, D);
ftd1 = c2d(ftc, 50);
ftd2 = c2d(ftc, 150);
ftd3 = c2d(ftc, 300);

open("questao6.slx")
sim("questao6")
