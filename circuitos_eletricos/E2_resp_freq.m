f=[1:20:10000];
I = 20e-3;
Zc = -1i*(1./(2*pi*f*220e-9));
Zr = 150;

Zeq = (Zc*Zr)./(Zc + Zr);

Ir = I*Zeq./Zr; 
Ic = I*Zeq./Zc;

HIc = Ic/I; 

figure(1)
plot(f,Ir)
title('Frequência vs Ir')

figure(2)
plot(f,Ic)
title('Frequência vs Ic')

figure(3)
plot(f,Ir,f,Ic)