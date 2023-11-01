clc;
clear all;
x = -5 : 0.001: 5;
f1 = 3*exp(x) - 7*sin(3*x);
plot(x, f1, 'b-');
xlabel('eixo das abscissas');
ylabel('eixo das ordenadas');
legend('Gráfico 1: item a)');
grid on;