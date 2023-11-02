%% Tratamento de Dados para Identificação a Partir da Resposta ao Degrau

%%
%
% Carregue os dados do experimento:
%

clear, clc
Tsim = 150; % Tempo de simulação
DeltaT = 3; % Período de amostragem
[y,u,t] = dadosPreparacao(Tsim,DeltaT); % Função geradora de dados

plot(t,y)

%%
%
% Selecione o trecho do experimento a partir do qual se pretende obter um
%   modelo.
% Analise o vetor de entrada e:
%   Identifique o PONTO do vetor (não o tempo) de aplicação do degrau (onde 
%   ocorre variação no valor da entrada) e defina o ponto anterior como 
%   ponto inicial. 
%   Identifique o último ponto em que o valor aplicado na entrada se mantém
%   e o defina como ponto final.
%

figure
plot(u), hold on
title('Entrada')
xlabel('Pontos')
ylabel('Duty Cycle (-)')
grid

%%
% Analisando o gráfico, seleciona-se os seguintes pontos para realizar a
%   identificação do sistema a partir do primeiro de grau (de u = 0,2 para 
%   u = 0,5
%

inicio = 1; % A entrada muda para 0.5 no ponto 2
fim = 24; % O último ponto em que u = 0,5 é o ponto 25
%                                                ponto 

%%
% Visualização dos pontos escolhidos no gráfico:
%

plot(inicio,0.2,'xr')
plot(fim,0.5,'xr')
hold off

%%
%
% Subtraia o valor inicial da entrada e da saída:
%

u = u(inicio:fim) - u(inicio);  % Necessário para simular o sistema 
%                                   posteriormente
y = y(inicio:fim) - y(inicio);  % Necessário para a própria identificação 
%                                   correta do sistema

%%
%
% Defina o valor da ampliude do degrau aplicado na entrada:
%   (Obs: verifique que o degrau aplicado aqui é, de fato, 0.3; utilize a
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
% O trecho selecionado do experimento é o seguinte:
%

figure
subplot(211)
plot(t,y), grid
title({'Trecho selecionado para identificação', ...
            '(Entrada e saída iniciando do zero)'})
ylabel({'Variação de','Temperatura (ºC)'})
subplot(212)
plot(t,u), grid
xlabel('Tempo (s)')
ylabel('Duty Cycle (-)')


%%
%
% Selecione a estimativa inicial do atraso como igual a um período de 
%   amostragem:
%

L_inic = DeltaT;

%%
%
% Utilize a função escrita na Preparação 3 para obter um modelo FOPTD para
%   o processo (lembre-se de que ela já assume um experimento de resposta 
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
ylabel('Variação de Temperatura (ºC)')