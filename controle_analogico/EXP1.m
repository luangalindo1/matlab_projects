L = 100*10^(-3)
R = 280
C = 0.4*10^(-6)

num = 1
den = [(L*C) (R*L) 1]

H = tf(num, den)

[res, pol, k] = residue(num, den)

R = roots(den)

figure(1)
step(H)
grid on

%% 

% UTILIZAÇÃO DO MÉTODO DE EULER
tempf = 0.005
yi = [0 0]    % Condições Iniciais
h = 0.01*10^(-3)

% CALCULO DA SAíDA 
n = int16(tempf/h)
    
y1 = zeros(1,n)
y2 = zeros(1,n)
t = zeros(1,n)
    
y1(1) = yi(1)
y2(1) = y1(1)
t(1) = 0
    
for i = 1 : n
    y2(i + 1) = ((-R/L)*y2(i) + (-1/(L*C))*y1(i) + 1/(L*C))*h + y2(i)
    y1(i + 1) = y1(i) + y2(i)*h
    t(i + 1) = t(i) + h
end

% PLOT DO GRÁFICO
figure(2)
plot(t, y1)
grid on