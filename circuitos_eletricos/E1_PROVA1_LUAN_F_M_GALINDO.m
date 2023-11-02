% Condições iniciais
V = 220
f = 60
w = 2*pi*f

% Para o motor A = 5 de 0.75 CV, em 220V

PmecA = 551.625 % Assumindo que a potência dada na tabela seja a Potência Mecânica
%InA = 6.1
%IpA = 5.2*InA
rendA50 = 0.5
rendA75 = 0.58
rendA100 = 0.61
fpA50 = 0.48
fpA75 = 0.6
fpA100 = 0.69

% Em 50%
PA50 = 0.50*PmecA/rendA50
QA50 = tan(acos(fpA50))*PA50
%SA50 = PA50 + j*QA50

% Em 75%
PA75 = 0.75*PmecA/rendA75
QA75 = tan(acos(fpA75))*PA75

% Em 100%
PA100 = PmecA/rendA100
QA100 = tan(acos(fpA100))*PA100

% A menor potência reativa ocorre em 75% de funcionamento, vide Workspace

% Para o motor B = 10 de 3 CV, em 220V

PmecB = 2206.5 % Assumindo que a potência dada na tabela seja a Potência Mecânica
%InB = 15
%IpB = 7*InB
rendB50 = 0.77
rendB75 = 0.81
rendB100 = 0.815
fpB50 = 0.68
fpB75 = 0.77
fpB100 = 0.83

% Em 50%
PB50 = 0.5*PmecB/rendB50
QB50 = tan(acos(fpB50))*PB50
%SB50 = PB50 + j*QB50

% Em 75%
PB75 = 0.75*PmecB/rendB75
QB75 = tan(acos(fpB75))*PB75

% Em 100%
PB100 = PmecB/rendB100
QB100 = tan(acos(fpB100))*PB100

% A menor potência reativa ocorre em 50% de funcionamento, vide Workspace

% Dadas as condições do circuito, a potência reativa total é a soma das
% potências reativas. Por isso, com ambos os motores a 100%, teremos o
% menor consumo dessa potência

% Para o um capacitor compensar completamente essa potência reativa, temos

Qc  = QA100 + QB50    % ou Xc - Talvez fosse melhor por um "-"
Ceq = Qc/((V^2)*w)    % Xc = 1/wC, Q = |V|^2/Xc

% do Workspace, Ceq = 1.3666x10^-4 F     % 9.5831x10^(-7) F - ERREI

% Para as condições de operação variáveis temos
% Caso 01: A em 50% e B em 50%
fp01 = cos(atan((QA50 + QB50 - Qc)/(PA50 + PB50)))

% Caso 02: A em 50% e B em 75%
fp02 = cos(atan((QA50 + QB75 - Qc)/(PA50 + PB75)))

% Caso 03: A em 50% e B em 100%
fp03 = cos(atan((QA50 + QB100 - Qc)/(PA50 + PB100)))

% Caso 04: A em 75% e B em 50%
fp04 = cos(atan((QA75 + QB50 - Qc)/(PA75 + PB50)))
% Teste caso 4
%t1 = QA75 + QB50 - Qc
%t2 = PA75 + PB50
%t3 = atan(t1/t2)
%tfp04 = cos(t3)

% Caso 05: A em 75% e B em 75%
fp05 = cos(atan((QA75 + QB75 - Qc)/(PA75 + PB75)))

% Caso 06: A em 75% e B em 100%
fp06 = cos(atan((QA75 + QB100 - Qc)/(PA75 + PB100)))

% Caso 07: A em 100% e B em 50%
fp07 = cos(atan((QA100 + QB50 - Qc)/(PA100 + PB50)))

% Caso 08: A em 100% e B em 75%
fp08 = cos(atan((QA100 + QB75 - Qc)/(PA100 + PB75)))

% Caso 09: A em 100% e B em 100%
fp09 = cos(atan((QA100 + QB100 - Qc)/(PA100 + PB100)))

% do Workspace, o menor fp é o fp do caso 03

