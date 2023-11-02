Vi = 100
L = 1e-3
C = 10e-9
R = 40
w0 = sqrt(1/(L*C))
f0 = w0/(2*pi)
f = logspace(3, 5, 2000)
w = 2*pi*f
Z = R + j*w*L + 1./(j*w*C)
I = Vi./Z

w1 = -(R/(2*L)) + sqrt((R/(2*L))^2 + 1/(L*C))
w2 = (R/(2*L)) + sqrt((R/(2*L))^2 + 1/(L*C))

f1 = w1/2/pi
f2 = w2/2/pi


figure(1)
semilogx(f, abs(I))
grid on
figure(2)
semilogx(f, abs(I.*(j*w*L)), f, abs(I.*(1./(j*w*C))))
grid on