%QUESTÃO 2

%ITEM a)- RAÍZ
ra = fzero(@fa, [2 3]);

%ITEM b)- RAÍZ
rb = fzero(@fb, [0 1]);

%ITEM c)- RAÍZ
rc = fzero(@fc, [-1 0]);

%Os intervalos foram escolhidos de acordo com os gráficos dados.

%ITEM a)- FUNÇÃO
function y1 = fa(x)
y1 = exp(1/x) - 2*sin(x);
end

%ITEM b)- FUNÇÃO
function y2 = fb(x)
y2 = 4*cos(x) - 3*exp(x);
end

%ITEM c)- FUNÇÃO
function y3 = fc(x)
y3 = 2*cosh(x) - 3*exp(2*x) - 0.7;
end