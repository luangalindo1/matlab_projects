% Definindo os valores dados
% S1 = 10e3 - Módulo
fp1 = 0.75 % Atrasado
% S2 = 3e3 - Módulo
fp2 = 0.2 % Adiantado

a1 = acos(fp1)
a2 = acos(fp2)

S1 = 10e3*(cos(a1) + j*sin(a1))
S2 = 3e3*(cos(a2) - j*sin(a2))

S = S1 + S2

% Sabendo que S = V*conj(i), com V e i sendo valores RMS

V = 220

I1 = conj(S1)/V
I2 = conj(S2)/V
I = conj(S)/V


figure(1)

subplot(121)

plot([0 real(V)], [0 imag(V)], [0 real(I1)] , [0 imag(I1)], "LineWidth", 2)

title('Diagrama Fasorial - I1')
legend('V', 'I1')


subplot(122)

plot([0 real(S1)], [0 0], [real(S1) real(S1)], [0 imag(S1)], [0 real(S1)], [0 imag(S1)], "LineWidth", 2)

title('Triangulo das potências de S1')
legend('P1', 'Q1', 'S1')

figure(2)

subplot(221)

plot([0 real(V)], [0 imag(V)], [0 real(I2)], [0 imag(I2)], "LineWidth", 2)

title('Diagrama Fasorial - I2')
legend('V', 'I2')

subplot(222)

plot([0 real(S2)], [0 0], [real(S2) real(S2)], [0 imag(S2)], [0 real(S2)] , [0 imag(S2)], "LineWidth", 2)

title('Triangulo das potências de S2')
legend('P2', 'Q2', 'S2')

figure(3)

subplot(321)

plot([0 real(V)], [0 imag(V)], [0 real(I)], [0 imag(I)], "LineWidth", 2)

title('Diagrama Fasorial - I1 + I2')
legend('V', 'I1 + I2')

subplot(322)

plot([0 real(S)] , [0 0], [real(S) real(S)] , [0 imag(S)], [0 real(S)] , [0 imag(S)], "LineWidth", 2)

title('Triangulo das potências de S1 + S2')
legend('P1 + P2', 'Q1 + Q2', 'S')
% Para Rs, Xs, Rp e Xp

% "Paralelo"
Rp1 = V^2/real(S1)
Rp2 = V^2/real(S2)
Rp = 1/(1/Rp1 + 1/Rp2)

Xp1 = V^2/imag(S1)
Xp2 = V^2/imag(S2)
Xp = 1/(1/Xp1 + 1/Xp2)

% "Série"
Rs1 = real(S1)/(abs(I1))^2
Rs2 = real(S2)/(abs(I2))^2
Rs = Rs1 + Rs2

Xs1 = imag(S1)/(abs(I1))^2
Xs2 = imag(S2)/(abs(I2))^2
Xs = Xs1 + Xs2

