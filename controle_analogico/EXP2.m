%% LUAN FÁBIO MARINHO GALINDO, 118110382
clear all; 
clc;

%Jm = 1.5;
Jm = 0.1;
Ra = 60e-3;
La = 1.8e-3;
Ke = 0.8;
Fm = 0.01;
oe = 1;
Ka = (Ke*oe)/(Ke^2*oe^2 + Ra*Fm);
Km = (Ra)/(Ke^2*oe^2 + Ra*Fm);
Ta = La/Ra;
Tm = Jm/Fm;
Den = ((1)/(Ta*Tm)) + ((Ke^2*oe^2)/(Jm*La));
Kv = (Ke*oe)/(Den*Jm*La);
Kc = (1)/(Den*Jm*Ta);

A = [-Ra/La -Ke*oe/La;Ke*oe/Jm -Fm/Jm];
B = [1/La 0;0 -1/Jm];
C = eye(size(A));
D = zeros(size(A));
sys = ss(A, B, C, D);