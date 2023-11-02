%%%% 2 ESTÁGIO
%%%% ALUNOS: Luan Fábio Marinho Galindo 
%%%%         Ruan Alecssander de Araujo Silva
%%%%         Douglas de Souza Sesion

% QUESTÃO 3: MATRIZES DE REDE E FLUXO DE POTÊNCIA: Método de Newton na forma 
           % polar  modificada PD4
           
clc
clear all 
%Inpedancia de linha
Z12=0.02+i*0.06;
Z13=0.08+i*0.24;
Z23=0.06+i*0.18;
Z24=0.06+i*0.18;
Z25=0.04+i*0.12;
Z34=0.01+i*0.03;
Z45=0.08+i*0.24;

% Elementos da diagonal principal da matriz de inpedancio 
Z11 = ((1/Z12)+(1/Z13))^-1;
Z22 = ((1/Z12)+(1/Z23)+(1/Z24)+(1/Z25))^-1;
Z33 = ((1/Z13)+(1/Z23)+(1/Z34))^-1;
Z44 = ((1/Z24)+(1/Z34)+(1/Z45))^-1;
Z55 = ((1/Z25)+(1/Z45))^-1;

% Calculo dos elementos da Matriz admitância
% Linha 1
Y12 = 1/Z12;  
Y13 = 1/Z13; 
Y14 = 0; 
Y15 = 0;
Y11 = Y12 + Y13; 
% Linha 2
Y21 = Y12; 
Y23 = 1/Z23; 
Y24 = 1/Z24; 
Y25 = 1/Z25; 
Y22 = Y21 + Y23 + Y24 + Y25;
% Linha 3
Y31 = Y13; 
Y32 = Y23; 
Y34 = 1/Z34; 
Y35 = 0; 
Y33 = Y31 + Y32 + Y34; 
% Linha 4
Y41 = Y14; 
Y42 = Y24; 
Y43 = Y34; 
Y45 = 1/Z45; 
Y44 = Y42 + Y43 + Y45; 
% Linha 5
Y51 = Y15; 
Y52 = Y25; 
Y53 = Y35; 
Y54 = Y45; 
Y55 = Y52 + Y54; 

% Matriz admitância
Y = [ Y11  -Y12  -Y13  -Y14  -Y15;
     -Y21   Y22  -Y23  -Y24  -Y25;
     -Y31  -Y32   Y33  -Y34  -Y35;  
     -Y41  -Y42  -Y43   Y44  -Y45;
     -Y51  -Y52  -Y53  -Y54   Y55;];
 
 G = real(Y);
 B = imag(Y);

% Dados da barra: 
Sbase=100e6; %Potencia  base

%Barra 1: Barra de balanço
V1=1.06; teta1 = 0; 
PG1 = 0; PD1 = 0; P1 = PG1 - PD1;
QG1 = 0; QD1 = 0; Q1 = QG1 - QD1;

%Barras 2 e 3: Barras de tensão controlada 
V2 = 1.0;
PG2 = 40e6; PD2 = 20e6; P2 = PG2 - PD2; 
QG2 = 0; QD2 = 10e6; Q2 = QG2 - QD2; 

V3 = 1.0; 
PG3 = 30e6; PD3 = 20e6; P3 = PG3 - PD3; 
QG3 = 0; QD3 = 15e6; Q3 = QG3 - QD3; 

% Barras 4 e 5: Barra de carga
V4 = 1.0;
PG4=0; PD4=(0.3*(V4^2)+0.2)*100e6; P4 =PG4-PD4;
QG4=0; QD4=30e6; Q4 =QG4-QD4;

PG5=0; PD5=60e6; P5=PG5-PD5;
QG5=0; QD5=40e6; Q5=QG5-QD5;

%Potencias injetadas em Pu
P = [P1 P2 P3 P4 P5]*1/Sbase;
Q = [Q1 Q2 Q3 Q4 Q5]*1/Sbase;

%Criação de variáveis simbólicas:
syms teta2 teta3 teta4 teta5 V4 V5

n = 5; %Número de barras
V = [V1 V2 V3 V4 V5]; %Vetor das tensoes nas barras 
teta = [teta1 teta2  teta3 teta4 teta5]; %Fase das tensoes 

%Definição  de DeltaP e DeltaQ
for j=2:n %Considera apenas as barras de carga e de tensão controlada
    P_soma = 0;
    Q_soma = 0;
    for k=1:n
        P_soma = P_soma + V(j)*V(k)*(G(j,k)*cos(teta(j)-teta(k)) + B(j,k)*sin(teta(j)-teta(k))); 
        Q_soma = Q_soma + V(j)*V(k)*(G(j,k)*sin(teta(j)-teta(k)) - B(j,k)*cos(teta(j)-teta(k)));
    end
    delta_P(j) = P(j) - P_soma;
    delta_Q(j) = Q(j) - Q_soma;
end

%Como as barras 2 e 3 são do tipo tensão controlada, tem-se V1, teta1, V2 e
%V3 conhecidos.
%Matriz_F = [deltaP2, deltaP3, deltaP4, deltaP5, deltaQ4, deltaQ5] 
Matriz_F = [delta_P(2);delta_P(3);delta_P(4);delta_P(5);delta_Q(4);delta_Q(5)];
%Cálculo do jacobiano 
J = jacobian(Matriz_F, [teta2 teta3 teta4 teta5 V4 V5]);   

% Chutes iniciais para tensoses nas barras
V1 = 1.06;     teta1 = 0;
V2 = 1.0;      teta2 = 0;
V3 = 1.0;      teta3 = 0;
V4 = 1.0;      teta4 = 0;
V5 = 1.0;      teta5 = 0;

V = [V1 V2 V3 V4 V5];
teta = [teta1 teta2  teta3 teta4 teta5]; 

% Informações iniciais para a rotina 
error = double(subs(Matriz_F))'*double(subs(Matriz_F));%Definição do erro
iter=1;
tol = 1e-05;

while error>=tol
    PD4=(0.3*(V4^2)+0.2)*100e6; 
    P4 =PG4-PD4;
    P(4) = P4/Sbase;
    
    for j=2:n %Considera apenas as barras de carga e de tensão controlada
        P_soma = 0;
        Q_soma = 0;
        for k=1:n
            P_soma = P_soma + V(j)*V(k)*(G(j,k)*cos(teta(j)-teta(k)) + B(j,k)*sin(teta(j)-teta(k))); 
            Q_soma = Q_soma + V(j)*V(k)*(G(j,k)*sin(teta(j)-teta(k)) - B(j,k)*cos(teta(j)-teta(k)));
        end
        delta_P(j) = P(j) - P_soma;
        delta_Q(j) = Q(j) - Q_soma;
    end
    %Matriz_F = [deltaP2, deltaP3, deltaP4, deltaP5, deltaQ4, deltaQ5] 
    Matriz_F = [delta_P(2);delta_P(3);delta_P(4);delta_P(5);delta_Q(4);delta_Q(5)]; 

    F = double(subs(Matriz_F)); 
    F_linha = double(subs(J));
    x = [teta2 teta3 teta4 teta5 V4 V5];
    inv_J = inv(F_linha);
    dX = -round(transpose(F)*inv(F_linha),10);
    X =  x+dX;
    teta2 = double(subs(X(1)));
    teta3 = double(subs(X(2)));
    teta4 = double(subs(X(3)));
    teta5 = double(subs(X(4)));
    V4    = double(subs(X(5)));
    V5    = double(subs(X(6)));
    
    %Valores calculados
    V = [V1 V2 V3 V4 V5];
    teta = [teta1 teta2 teta3 teta4 teta5];
    iter_vec(iter) = iter;
    V_barra(iter,:) = [V2 V3 V4 V5];
    teta_barra(iter,:) = [teta2 teta3 teta4 teta5];

    %Método dos mínimos quadrados
    error(iter) = F'*F;
    iter = iter+1;
end 

%Organizando os vetores para apresentação
iter_vec = [0 iter_vec]; %Colunas das interaçãos 
V_barra = [1.0 1.0 1.0 1.0; V_barra]; % Matriz dos modulas das tenções 
teta_barra = [0 0 0 0; teta_barra]*180/pi; %Matriz das fases em graus

%Exibição dos resultados em forma de tabela
TENSOES = table(iter_vec', V_barra(:,1), teta_barra(:,1), V_barra(:,2),  teta_barra(:,2),...
           V_barra(:,3),teta_barra(:,3),V_barra(:,4),teta_barra(:,4));    
TENSOES.Properties.VariableNames = {'Iteracao', 'V2', 'Teta2','V3', 'Teta3',...
                               'V4', 'Teta4', 'V5', 'Teta5'}

%% Cálculo do fluxo de potência em cada barra
V = [V1 V2 V3 V4 V5];  % Módulo das tensões
teta = [teta1 teta2 teta3 teta4 teta5]; % Angulos em radiano

%Cálculo de I:
I = zeros(5,5);
for j = 1:n
    for k=1:n
        I(j,k) = ((V(j)*exp(i*teta(j)) - V(k)*exp(i*teta(k))))*(-Y(j,k));
    end 
end

%Cálculo das potências:
S = zeros(5,5);
for j = 1:n
    for k=1:n
        S(j,k) = V(j)*exp(i*teta(j))*conj(I(j,k));
    end 
end

%Apresentação do Fluxo de potência 
Potencia = {'s12','s13','s21','s23','s24','s25','s31',...
           's32','s34','s42','s43','s45','s52','s54'}';
FP = table(Potencia,transpose([S(1,2),S(1,3),S(2,1),S(2,3),S(2,4), S(2,5), S(3,1),S(3,2), S(3,4),S(4,2),S(4,3),S(4,5),S(5,2), S(5,4)]));    
FP.Properties.VariableNames = {'Linha','Potencia'}

%% Calculo das perdas na linhas de transmisão

Perdas = zeros(5,5);
for j = 1:n
    for k=1:n
        Perdas(j,k) = (S(j,k) + S(k,j))*100;
    end 
end

%Tabela mostrando as perdas entre as barras
Coluna1 = {'1-2','1-3','2-3','2-4','2-5','3-4','4-5'}';
%Tabela mostrando as perdas entre as barras
PERDAS = table(Coluna1,transpose([Perdas(1,2),Perdas(1,3),Perdas(2,3), ...
                Perdas(2,4),Perdas(2,5), Perdas(3,4), Perdas(4,5)]));
PERDAS.Properties.VariableNames = {'Linha', 'Perdas'}