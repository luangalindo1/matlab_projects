clc;
clear all;
x = -5 : 0.001: 5;
f2 = 2*x.^3+3*x.^2-8*x-27;
plot(x, f2, 'b-');
xlabel('eixo das abscissas');
ylabel('eixo das ordenadas');
legend('Gráfico 2: item b)');
grid on;