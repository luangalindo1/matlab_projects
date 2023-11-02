% Para praticar (1)e (2)

V1 = 50*exp(j*36.87*pi/180)
V2 = 81.65*exp(j*pi/3 -pi/2) % -pi/2 é para defasar para cosseno
V3 = -1.41 + j*18.75

Veq = V1 + V2 + V3

I1 = 15*exp(j*143.13*pi/180)
I2 = 30*exp(-j*pi/4)
I3 = 15.79-j*0.84

Ieq = I1 + I2 + I3

% Foi assumido que os valores das amplitudes já são RMS

% Representação gráfica, no domínio fasorial, das grandezas elétricas

figure(1)
plot([0 real(V1)],[0 imag(V1)], [0 real(V2)],[0 imag(V2)], [0 real(V3)],[0 imag(V3)], [0 real(Veq)],[0 imag(Veq)],...
    "LineWidth", 2)
grid on
title('Diagrama Fasorial das Correntes')

% Definição das grandezas no domínio do tempo

freq = 60
t = linspace(0,1.0/freq,101) % 1.0/freq - definindo para 1 período, com espaçamento de (1/freq - 0) / (101 - 1)
w = 2*pi*freq

V1t = abs(V1)*cos(w*t+angle(V1))
V2t = abs(V2)*cos(w*t+angle(V2))
V3t = abs(V3)*cos(w*t+angle(V3))

Veqt = V1t+V2t+V3t

% Representação gráfica no domínio do tempo

figure(2)
plot(t, V1t, t, V2t, t, V3t, t, Veqt, "LineWidth", 1.5)
grid on
title('Tensões no Domínio do Tempo')

% para praticar (3) - plotar os gráficos e analisar em função do angulo?

%thetha = linspace(0, 6*pi, 101)
%V22 = 81.65*exp(j*thetha -pi/2)
%Veq2 = V1 + V22 + V3
%figure(3)
%plot(thetha, V22, thetha, Veq2)