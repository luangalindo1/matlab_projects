%%%% 2 EST�GIO
%%%% ALUNOS: Luan F�bio Marinho Galindo 
%%%%         Ruan Alecssander de Araujo Silva
%%%%         Douglas de Souza Sesion

%%%% QUEST�O 2: FLUXO DE POT�NCIA - B�SICO
%%%% QUESTAO 2F - Metodo de Newton - barra 2 controlada em 1pu

clc
clear all;
iter = 1; 
E = 1;
V1 = 1;
teta1 = 0;

V2 = 1; % Estimativa inicial para o m�dulo da tens�o na barra 2 
teta2 = 0; % Estimativa inicial para o �ngulo da tens�o na barra 2
Y = [1/(i*0.2) -1/(i*0.2); -1/(i*0.2) 1/(i*0.2)+1/(i*20)]; % matriz admit�ncia
B = [-5 5; 5 -5.05]; % matriz com os valores imagin�rios da matriz admit�ncia


% Aqui instancia-se vetores, para alocar os resultados
Vbarra2(iter) = V2;
ang2(iter) = teta2;
iteracao(iter) = iter;

while abs(E) > 10^-5
  % Pot�ncias consumidas e Geradas
  PD2 = 1; QD2 = 0.04*(V2^2) + 0.06;
  PG2 = 0; QG2 = 0;
  % Pot�ncia injetada = Pot�ncia Gerada - Pot�ncia Consumida
  PINJ2 = PG2 - PD2;
  %Q2inj = -V2*V1*B(2,1)*cos(teta2-teta1) -V2^2*B(2,2)*cos(teta2-teta2)
  % Matriz F : F = [ deltaP(teta2, v2]
  F = [PINJ2-V1*V2*B(2,1)*sin(teta2)];
  % A Matriz do Jacobiano
  J = [-V1*V2*B(2,1)*cos(teta2)];  
  DX = -inv(J)*F;
  teta2 = teta2+DX(1);
  Q2inj = -V2*V1*B(2,1)*cos(teta2-teta1) -V2^2*B(2,2)*cos(teta2-teta2);
  
  iter = 1 + iter;
  angle2(iter) = teta2;
  Vbarra2(iter) = V2;
  iteracao(iter) = iter;
  % C�lculo do erro
  E = Vbarra2(iter-1)*exp(angle2(iter-1)) - Vbarra2(iter)*exp(angle2(iter));
end 
iteracao = transpose(iteracao);
Vbarra2 = transpose(Vbarra2);
angle2 = transpose(angle2);

% Exibi��o dos resultados em forma de tabela
Newton_Raphson_Convencional = table(iteracao, Vbarra2, angle2)

% Corrente e Fluxo de Pot�ncia entre a Barra 1 e 2
I12 = (V1*exp(j*teta1) - V2*exp(j*teta2))/(j*0.2)
S12 = (V1*exp(j*teta1))*conj(I12)

%Quantidade de reativos injetados
Q2inj