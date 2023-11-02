%%%% 2 ESTÁGIO
%%%% ALUNOS: Luan Fábio Marinho Galindo 
%%%%         Ruan Alecssander de Araujo Silva
%%%%         Douglas de Souza Sesion

%%%% QUESTÃO 2: FLUXO DE POTÊNCIA - BÁSICO 
%%%% QUESTAO 2C - Método de Newton-Raphson na forma polar

clc
clear all;
iter = 1; 
E = 1;
V1 = 1;
teta1 = 0;

V2 = 1; % Estimativa inicial para o módulo da tensão na barra 2 
teta2 = 0; % Chute inicial para o ângulo da tensão na barra 2
Y = [1/(i*0.2) -1/(i*0.2); -1/(i*0.2) 1/(i*0.2)+1/(i*20)]; % matriz admitância
B = [-5 5; 5 -5.05]; % matriz com os valores imaginários da matriz admitância


% Aqui instacia-se vetores, para alocar as respostas
Vbarra2(iter) = V2;
ang2(iter) = teta2;
iteracao(iter) = iter;

while abs(E) > 10^-5
  % Potências consumidas e Geradas
  PD2 = 1; QD2 = 0.04*(V2^2) + 0.06;
  PG2 = 0; QG2 = 0;
  % Potência injetada = Potencia Gerada - Potencia Consumida
  PINJ2 = PG2 - PD2;
  QINJ2 = QG2 - QD2;
  
  % Matriz F : F = [ deltaP(teta2, v2) ; deltaQ(teta2, v2)]
  F = [PINJ2-V1*V2*B(2,1)*sin(teta2); QINJ2 + V1*V2*B(2,1)*cos(teta2)+V2^2*B(2,2)];
  % Matriz de Jacobiano
  J = [-V1*V2*B(2,1)*cos(teta2) -B(2,1)*V1*sin(teta2); -V1*V2*B(2,1)*sin(teta2) B(2,1)*V1*cos(teta2)+2*V2*B(2,2)];  
  DX = -inv(J)*F;
  teta2 = teta2+DX(1);
  V2 = V2 + DX(2);
  iter = 1 + iter;
  angle2(iter) = teta2;
  Vbarra2(iter) = V2;
  iteracao(iter) = iter;
  % Cálculo do erro
  E = Vbarra2(iter-1)*exp(angle2(iter-1)) - Vbarra2(iter)*exp(angle2(iter));
end 
iteracao = transpose(iteracao);
Vbarra2 = transpose(Vbarra2);
angle2 = transpose(angle2);

% Exibição dos resultados em forma de tabela
Newton_Raphson_Convencional = table(iteracao, Vbarra2, angle2)

% Corrente e Fluxo de Potencia entre a Barra 1 e 2
I12 = (V1*exp(j*teta1) - V2*exp(j*teta2))/(j*0.2)
S12 = (V1*exp(j*teta1))*conj(I12)