f=[100:20:100000];
I = 20e-3;
Zc = -1i*(1./(2*pi*f*220e-9));
Zr = 150;

Zeq = (Zc*Zr)./(Zc + Zr);

Ir = I*Zeq./Zr; 
Ic = I*Zeq./Zc;

HIc = Ic/I; 


figure(1)
subplot(211)
semilogx(f,20*log10(abs(HIc)))
grid on
xlabel('Frequência (Hz)')
ylabel('Módulo (dB)')
title('Diagrama de Bode')
subplot(212)
semilogx(f,rad2deg(angle(HIc)))
grid on
xlabel('Frequência (Hz)')
ylabel('Angulo (º)')