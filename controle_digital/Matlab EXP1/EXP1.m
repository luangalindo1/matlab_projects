%% INFORMAÇÕES

% LUAN FÁBIO MARINHO GALINDO
% 118 110 382
% TURMA 04

%% EXERCÍCIO 1

Ts = 0.1;
s = tf('s');
z = tf('z', Ts);
G = (s + 5)/(s^4 + 4.5*s^3 + 7*s^2 + 4.5*s + 1)
H = (6*z^2 - 0.6*z - 0.12)/(z^4 - z^3 + 0.25*z^2 + 0.25*z - 0.125)

numG = [1, 5];
denG = [1, 4.5, 7, 4.5, 1];
tfG = tf(numG, denG); % Para a função H, basta inserir Ts e.g. tf(numH, denH, Ts)

%% EXERCÍCIO 2

zpkH = zpk(H)
zpkG = zpk(tfG)

%% EXERCÍCIO 3

pzG = eig(G)
figure()
pzmap(G)

% O sistema contínuo é estável apenas se todos os polos tiverem
% parte real negativa, ou seja, todos os polos estão no semiplano esquerdo.
% Assim, verificando-se a figura 1, vê-se que isso acontece, por isso o sistema é estável.

pzH = eig(H)
figure()
pzmap(H)

% se H é um sistema discreto, o sistema será instável se abs(eig(H)) ou abs(pole(H)) forem menor
% que 1, ou seja, se os polos estiverem localizados no círculo unitário.
% Dessa forma, verificando-se a figura 2, percebe-se que isso ocorre. Ou
% seja o sistema é estável.

%% EXERCÍCIO 4

figure()
step(G)
stepinfoG = stepinfo(G)
figure()
step(H)
stepinfoH = stepinfo(H)

%% EXERCÍCIO 5

figure()
rlocus(G)

figure()
bode(G)

figure()
nyquist(G)
% 
% figure()
% rlocus(H)
% 
% figure()
% bode(H)
% 
% figure()
% nyquist(H)

%% EXERCÍCIO 6

[gmG, pmG, wgG, wpG] = margin(G)
% [gmH, pmH, wgH, wpH] = margin(H)

%% EXERCÍCIO 7

G.ioDelay = 5
H.ioDelay = 5

%% EXERCÍCIO 8

u = [0; ones(100,1); zeros(100,1)];
t = (0:1:200);

y = lsim(G, u, t);
figure(11)
plot(t, y, t, u)

%% EXERCÍCIO 9

T = feedback(G, 1, -1);

figure()
step(T)

%% EXERCÍCIO 10

g11 = tf(0.1134, [1.78 4.48 1], 'ioDelay', 0.72);
g12 = tf(0.924, [2.07 1]);
g21 = tf(0.3378, [0.361 1.09 1], 'ioDelay', 0.3);
g22 = tf(-0.318, [2.93 1], 'ioDelay', 1.29);
Gm = [g11, g12; g21, g22]

%% EXERCÍCIO 11

Gss = ss(Gm)

%% EXERCÍCIO 12

kp = eye(2);

open("EXP1_EX12.slx")
sim("EXP1_EX12.slx")
ts12 = ans.simout.time;
ys121 = ans.simout.signals.values(:,1);
ys122 = ans.simout.signals.values(:,2);
figure()
plot(ts12, ys121, ts12, ys122)

%% EXERCÍCIO 13

% u1 = 1; u2 = 0; [tt1, x1, yy1] = sim("EXP1_EX12.slx", 15);
% u1 = 0; u2 = 1; [tt2, x2, yy2] = sim("EXP1_EX12.slx", 15);
% figure()
% subplot(221), plot(t1, y1(:, 1), ':', tt1, yy1(:, 1))
% subplot(222), plot(t1, y1(:, 2), ':', tt1, yy1(:, 2))
% subplot(223), plot(t2, y2(:, 1), ':', tt2, yy2(:, 1))
% subplot(224), plot(t2, y2(:, 2), ':', tt2, yy2(:, 2))

u1 = 1; u2 = 0;
sim("EXP1_EX13.slx")
t = ans.simout.time;
y11 = ans.simout.signals.values(:,1);
y21 = ans.simout.signals.values(:,2);
figure()
plot(t, y11, t, y21)

u1 = 0; u2 = 1; 
sim("EXP1_EX13.slx")
t = ans.simout.time;
y31 = ans.simout.signals.values(:,1);
y41 = ans.simout.signals.values(:,2);
figure()
plot(t,y31, t, y41)

%% EXERCÍCIO 14

a = 0.1;
Tx = 0.2;
GainDx = (1-exp(-Tx))/(1-exp(-0.1*Tx));
z1 = exp(-0.1*Tx);
p1 = exp(-Tx);
open("EXP1_EX14.slx")
sim("EXP1_EX14.slx")
ts14 = ans.simout.time;
ys141 = ans.simout.signals.values(:, 1);
ys142 = ans.simout.signals.values(:, 2);
figure()
plot(ts14, ys141, ts14, ys142)