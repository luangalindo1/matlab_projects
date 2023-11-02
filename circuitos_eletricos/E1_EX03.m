% Para o motor de 1 CV, em 220V
V = 220
f = 60
w = 2*pi*f

Pmec1 = 735.5  % Assumindo que a potência dada na tabela seja a Potência Mecânica
In1   = 6.8
Ip1   = 5*In1
rend1 = 0.66   % para 100% de carga
fp1   = 0.76   % para 100% de carga

P1 = Pmec1/rend1
Q1 = tan(acos(fp1))*P1
S1 = P1 + j*Q1

figure(1)

subplot(121)
plot([0 real(S1)], [0 0], [real(S1) real(S1)], [0 imag(S1)], [0 real(S1)], [0 imag(S1)], "LineWidth", 2)
grid on
title('Triangulo das potências de S1')
legend('P1', 'Q1', 'S1')

% Para o motor de 2CV, em 220V

Pmec2 = 1471  % Assumindo que a potência dada na tabela seja a Potência Mecânica
In2   = 10
Ip2   = 6*In2
rend2 = 0.8   % para 100% de carga
fp2   = 0.86  % para 100% de carga

P2 = Pmec2/rend2
Q2 = tan(acos(fp2))*P2
S2 = P2 + j*Q2

figure(2)

subplot(221)
plot([0 real(S2)], [0 0], [real(S2) real(S2)], [0 imag(S2)], [0 real(S2)], [0 imag(S2)], "LineWidth", 2)
grid on
title('Triangulo das potências de S2')
legend('P2', 'Q2', 'S2')