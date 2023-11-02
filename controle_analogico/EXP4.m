Jm =1.5;
Ra = 60e-3;
La = 1.8e-3;
Ke = 0.8;
Fm = 0.01;
oe = 1;
Ka =(Ke*oe)/(Ke^2*oe^2 + Ra*Fm);
Km = (Ra)/(Ke^2*oe^2 + Ra*Fm);
Ta = La/Ra;
Tm= Jm/Fm;
Den = ((1)/(Ta*Tm)) + ((Ke^2*oe^2)/(La*Jm));
Kv = (Ke*oe)/(Den*Jm*La);
Kc = (1)/(Den*Jm*Ta);
 
A= [-Ra/La -Ke*oe/La;Ke*oe/Jm -Fm/Jm];
B = [1/La 0;0 -1/Jm];
C= eye(size(A));
D = zeros(size(A));
sistema = ss(A,B,C,D);
 
%% QUESTAO 1

fun_VaIa = tf(sistema(1,1));
fun_CmIa = tf(sistema(1,2));
fun_VaWm = tf(sistema(2,1)); 
fun_CmWm = tf(sistema(2,2)); 
 
figure(1) % Diagrama de bode de Va/Wm
P = bodeoptions('cstprefs');
P.Title.String = 'Va/Wm';
P.Title.FontSize = 14;
P.Title.FontWeight = 'Bold';
P.XLabel.FontSize = 14;
P.XLabel.FontWeight = 'Bold';
P.YLabel.FontSize = 14;
P.YLabel.FontWeight = 'Bold';
bode(fun_VaWm,P);
grid on;

figure(2) % Diagrama de bode de cm/Wm
P = bodeoptions('cstprefs');
P.Title.String = 'Cm/Wm';
P.Title.FontSize = 14;
P.Title.FontWeight = 'Bold';
P.XLabel.FontSize = 14;
P.XLabel.FontWeight = 'Bold';
P.YLabel.FontSize = 14;
P.YLabel.FontWeight = 'Bold';
bode(fun_CmWm,P);
grid on;
 
figure(3) % Diagrama de bode de Va/Ia
P = bodeoptions('cstprefs');
P.Title.String = 'Va/Ia';
P.Title.FontSize = 14;
P.Title.FontWeight = 'Bold';
P.XLabel.FontSize = 14;
P.XLabel.FontWeight = 'Bold';
P.YLabel.FontSize = 14;
P.YLabel.FontWeight = 'Bold';
bode(fun_VaIa,P);
grid on;

%% QUESTAO 2

figure(4) % Diagrama de bode de cm/Ia
P = bodeoptions('cstprefs');
P.Title.String = 'Cm/Ia';
P.Title.FontSize = 14;
P.Title.FontWeight = 'Bold';
P.XLabel.FontSize = 14;
P.XLabel.FontWeight = 'Bold';
P.YLabel.FontSize = 14;
P.YLabel.FontWeight = 'Bold';
bode(fun_CmIa,P);
grid on;

figure(5) % Margem de ganho e fase de VaWm
margin(fun_VaWm); % Exibe a margem no grafico
grid on;
[Gm,Pm,Wcg,Wcp] = margin(fun_VaWm);

figure(6) % Margem de ganho e fase de CmWm
margin(fun_CmWm); % Exibe a margem no grafico
grid on;
[Gm2,Pm2,Wcg2,Wcp2] = margin(fun_CmWm);

figure(7) % Margem de ganho e fase de VaIa
margin(fun_VaIa); % Exibe a margem no grafico
grid on;
[Gm3,Pm3,Wcg3,Wcp3] = margin(fun_VaIa);

figure(8) % Margem de ganho e fase de CmIa
margin(fun_CmIa); % Exibe a margem no grafico
grid on;
[Gm4,Pm4,Wcg4,Wcp4] = margin(fun_CmIa);

%% QUESTAO 3

% Em relação a função de transferencia entre Va/Wm
Gain = evalfr(fun_VaWm,0);
% Em relação a função de transferencia entre Cm/Wm
Gain2 = evalfr(fun_CmWm,0);
% Em relação a função de transferencia entre Va/Ia
Gain3 = evalfr(fun_VaIa,0);
% Em relação a função de transferencia entre Cm/Ia
Gain4 = evalfr(fun_CmIa,0);

%% QUESTAO 4 

% compesador por atraso de fase que vai ser aplicado no sistema Va/wm 
erro = 0.05; 
Kp = (1 - erro)/erro; % Kp = 19.00 
% o ganho Kp é igual ao produto entre o ganho do compensador e o ganho do sistema em baixas frequencias  
Kc = Kp/Gain;   % Kc = 15.2142 
[GmAt,PmAt,WcgAt,WcpAt] = margin(Kc*fun_VaWm); 
% Obtemos GmAt = inf, PmAt = 28.62º, WcgAt = inf ,WcpAt = 64.7643 
wcAt = 31; 
a = db2mag(11); 
w1 = wcAt*10e-2; 
wp =w1/a; 
T = 1/(a*wp); 
Compensador_Atraso = tf(Kc*[T 1], [a*T 1]);
figure(9) % diagrama de bode do sistema com o ganho ajustado
P = bodeoptions('cstprefs'); 
P.Title.String = 'Kc.(Va/Wm)'; 
P.Title.FontSize = 14;
P.Title.FontWeight = 'Bold'; 
P.XLabel.FontSize = 14; 
P.XLabel.FontWeight = 'Bold';
P.YLabel.FontSize = 14; 
P.YLabel.FontWeight = 'Bold';  
bode(Kc*fun_VaWm,P); 
grid on;

%% QUESTAO 5

figure(10)  % Gráfico do Compensador de Atraso de fase
P = bodeoptions('cstprefs'); 
P.Title.String = 'Compensador Atraso de Fase';
P.Title.FontSize = 14;
P.Title.FontWeight = 'Bold';
P.XLabel.FontSize = 14;
P.XLabel.FontWeight = 'Bold';
P.YLabel.FontSize = 14;
P.YLabel.FontWeight = 'Bold'; 
bode(Compensador_Atraso,P); 
grid on; 
 
figure(11) % Gráfico do Compensador Atraso de Fase + Sistema 
P = bodeoptions('cstprefs'); 
P.Title.String = 'Sistema com o Compensador atraso de fase'; 
P.Title.FontSize = 14;
P.Title.FontWeight = 'Bold'; 
P.XLabel.FontSize = 14;
P.XLabel.FontWeight = 'Bold';
P.YLabel.FontSize = 14;
P.YLabel.FontWeight = 'Bold'; 
sistema_com = series(fun_VaWm,Compensador_Atraso);
bode(sistema_com,P);
grid on;   
 
figure(12) 
[Gm_com,Pm_com,Wcg_com,Wcp_com] = margin(sistema_com);
margin(sistema_com); % mostra a margem de fase e de ganho com o compensador

%% QUESTAO 6

figure(13) % Aplicando uma entrada degrau no sistema sem compensador 
step(fun_VaWm); 
grid on; 
figure(14) % Aplicando uma entrada degrau no sistema com compensador 
step(sistema_com); 
grid on;

%% QUESTAO 7 

phiMax = (50 - PmAt + 5); % o valor 5 corresponde aos 10% da margem de fase desejada e PmAt ja foi determinado no compensador de atraso
a2 = (1-sind(phiMax))/(1+sind(phiMax)); 
Ganho = 20*log10(Kc/(sqrt(a2))); 
wmax = 100;
T2=1/(wmax*sqrt(a2));

%% QUESTAO 8 

figure(15) % Diagrama de Bode do Compensador avanço de fase  
Compensador_Avanco = tf([0.2453 15.21], [0.006203 1]);
P = bodeoptions('cstprefs');
P.Title.String = 'Compensador Avanço de Fase'; 
P.Title.FontSize = 14;
P.Title.FontWeight = 'Bold';
P.XLabel.FontSize = 14;
P.XLabel.FontWeight = 'Bold';
P.YLabel.FontSize = 14;
P.YLabel.FontWeight = 'Bold';
bode(Compensador_Avanco,P); 
grid on; 
figure(16) % Diagrama de bode do sistema com compensador de avanço de fase  
P = bodeoptions('cstprefs'); 
P.Title.String = 'Sistema com Compensador Avanço de Fase.';
P.Title.FontSize = 14;
P.Title.FontWeight = 'Bold';
P.XLabel.FontSize = 14; 
P.XLabel.FontWeight = 'Bold';
P.YLabel.FontSize = 14;
P.YLabel.FontWeight = 'Bold';
sistema_comA = series(fun_VaWm,Compensador_Atraso);
bode(sistema_comA,P);
[Gm3,Pm3,Wcg3,Wcp3] = margin(sistema_comA);
grid on; 
figure(17) % Gráfico da margem de fase e de ganho com Compensador Avanço de Fase + Sistema
margin(sistema_comA);

%% QUESTAO 9

figure(18) % Aplicando uma entrada degrau no sistema sem compensador 
step(fun_VaWm);
grid on;
figure(19) % Aplicando uma entrada degrau no sistema com compensador 
step(series(fun_VaWm,Compensador_Avanco)); 
grid on; 

