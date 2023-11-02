R = 220;
fc = 1000;
f = [100:20:100000];
%  Wcl = R/L;
%  Wcc = 1/(R*C);
W = 2*pi*f;
L = R./(2*pi*fc);
C = 1./(R*2*pi*fc); 


% Tensão em L / Tensão de entrada
HL =  (i*W*L) ./(R + i*W*L); 


% Tensão em C / Tensão de entrada 
HC =  (1./(i*W*C))./(R + (1./(i*W*C)));



figure(1)
subplot(211)
semilogx(f,20*log10(abs(HL)))
grid on
xlabel('Frequência (Hz)')
ylabel('Módulo (dB)')
title('Diagrama de Bode HL')

subplot(212)
semilogx(f,rad2deg(angle(HL)))
grid on
xlabel('Frequência (Hz)')
ylabel('Angulo (º)')

figure(2)
subplot(211)
semilogx(fc,-3,'o',f,20*log10(abs(HC)))
grid on
xlabel('Frequência (Hz)')
ylabel('Módulo (dB)')
title('Diagrama de Bode HC')

subplot(212)
semilogx(fc,-45,'o',f,rad2deg(angle(HC)))
grid on
xlabel('Frequência (Hz)')
ylabel('Angulo (º)')