%% Escolha o modo de opera��o
% Malha Aberta('MA'), Malha Fechada ('MF') ou Feed-Forward (FF)
modoOperacao1 = 'MA';   modoOperacao2 = 'MA';

%% Valor inicial de Duty Cycle (MA e FF)/ Refer�ncia (MF)
DutyRef1 = 0;         
DutyRef2 = 0;

%% Par�metros dos controladores PI (para o caso MF; ignorar em outros casos)
kp1 = 0.05;              
kp2 = 0.05;
ti1 = 100;              
ti2 = 100;

%% Par�metros dos controladores feedforward (para o caso FF, ignorar em outros casos)
ganhoFF1  = 0.7585;     
taunumFF1 = 231.2990;   
taudenFF1 = 236.5373;   
atrasoFF1 = 71.7890;	

ganhoFF2  = 0.3879;
taunumFF2 = 182.1589;
taudenFF2 = 249.0269;
atrasoFF2 = 15.4295;

%% Configura��o
% Especificar qual porta COM foi configurada para a comunica��o serial
%   com o Arduino
NumPortaSerial = 3;