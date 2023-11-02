function [y,u,t] = dadosPreparacao(Tsim,DeltaT)

L = 10;
Npts = ceil(Tsim/DeltaT/2)*2;
L_amostras = ceil(L/DeltaT/2)*2;

h = 0.3;
u = [zeros(1,1) ; h*ones((Npts-L_amostras)/2,1) ; zeros((Npts+L_amostras)/2-1,1)];
t = (0:Npts-1)'*DeltaT;

num = 25;
den = [10 1];
G = tf(num,den,'ioDelay',L);
y = lsim(G,u,t) + 0.4*randn(Npts,1);

u = 0.2 + u;
y = 20  + y;

