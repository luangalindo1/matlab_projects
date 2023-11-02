%% Tratamento de Dados para Identifica��o a Partir da Resposta ao Degrau

%%
%
% Carregue os dados do experimento:
%

clear, clc
Tsim = 150; % Tempo de simula��o
DeltaT = 3; % Per�odo de amostragem
[y,u,t] = dadosPreparacao(Tsim,DeltaT); % Fun��o geradora de dados

plot(t,y)

%%
%
% Selecione o trecho do experimento a partir do qual se pretende obter um
%   modelo.
% Analise o vetor de entrada e:
%   Identifique o PONTO do vetor (n�o o tempo) de aplica��o do degrau (onde 
%   ocorre varia��o no valor da entrada) e defina o ponto anterior como 
%   ponto inicial. 
%   Identifique o �ltimo ponto em que o valor aplicado na entrada se mant�m
%   e o defina como ponto final.
%

figure
plot(u), hold on
title('Entrada')
xlabel('Pontos')
ylabel('Duty Cycle (-)')
grid

%%
% Analisando o gr�fico, seleciona-se os seguintes pontos para realizar a
%   identifica��o do sistema a partir do primeiro de grau (de u = 0,2 para 
%   u = 0,5
%

inicio = 1; % A entrada muda para 0.5 no ponto 2
fim = 24; % O �ltimo ponto em que u = 0,5 � o ponto 25
%                                                ponto 

%%
% Visualiza��o dos pontos escolhidos no gr�fico:
%

plot(inicio,0.2,'xr')
plot(fim,0.5,'xr')
hold off

%%
%
% Subtraia o valor inicial da entrada e da sa�da:
%

u = u(inicio:fim) - u(inicio);  % Necess�rio para simular o sistema 
%                                   posteriormente
y = y(inicio:fim) - y(inicio);  % Necess�rio para a pr�pria identifica��o 
%                                   correta do sistema

%%
%
% Defina o valor da ampliude do degrau aplicado na entrada:
%   (Obs: verifique que o degrau aplicado aqui �, de fato, 0.3; utilize a
%   amplitude do degrau aplicado no seu experimento)
%

h = 0.3;

%%
%
% Sabendo o tempo de amostragem, defina o vetor de tempos t
%   com comprimento igual ao dos vetores de dados:
%

t = (0:length(u)-1)*DeltaT;

%%
%
% O trecho selecionado do experimento � o seguinte:
%

figure
subplot(211)
plot(t,y), grid
title({'Trecho selecionado para identifica��o', ...
            '(Entrada e sa�da iniciando do zero)'})
ylabel({'Varia��o de','Temperatura (�C)'})
subplot(212)
plot(t,u), grid
xlabel('Tempo (s)')
ylabel('Duty Cycle (-)')


%%
%
% Selecione a estimativa inicial do atraso como igual a um per�odo de 
%   amostragem:
%

L_inic = DeltaT;

%%
%
% Utilize a fun��o escrita na Prepara��o 3 para obter um modelo FOPTD para
%   o processo (lembre-se de que ela j� assume um experimento de resposta 
%   ao degrau):
%

[G0,T1,L_est] = parametrosFOPTD(h,y,L_inic,DeltaT);
G = tf(G0,[T1 1],'ioDelay',L_est)


%%
%
% Compare a resposta do processo com o modelo obtido:
%

y_sim = lsim(G,u,t);

figure
plot(t,y), hold on
plot(t,y_sim), grid
title({'Resposta ao Degrau','Modelo de Aquecimento'})
legend('Dados','Modelo','Location','SouthEast')
xlabel('Tempo (s)')
ylabel('Varia��o de Temperatura (�C)')