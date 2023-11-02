%%%% 2 ESTÁGIO
%%%% ALUNOS: Luan Fábio Marinho Galindo 
%%%%         Ruan Alecssander de Araujo Silva
%%%%         Douglas de Souza Sesion

%%%% QUESTÃO 2: FLUXO DE POTÊNCIA - BÁSICO 
%%%% QUESTAO 2A - Método de Gauss na forma retangular

clc, clear, close all

% Matriz  Admitância
Y = [1/(0.2i) -1/(0.2i); -1/(0.2i) 1/(0.2i)+1/(20i)]
% Número de barras
n = 2; 
% Criação de vetor para receber as tensões
V = zeros(20, n);
% Barra de balanço
V(:,1) = 1; 
% Estimativa inicial V2
V(1,2) = 1;
% Iteração
iter = 1;
% Índice da barra
a = 2;
E(1) = 1;
S = zeros(1,n);
iteracao(1) = 1;
Pd(2) = 1;
Pg(2) = 0;
Qg(2) = 0;

while(abs(E(iter)) >= 1.0e-05)
    Qd(2) = 0.04*(abs(V(iter,2)))^2 + 0.06;
    S(2) = (Pg(2)-Pd(2))+(Qg(2)-Qd(2))*1i;
    somatorio1 = 0; %valor inicial para o primeiro somatório
    somatorio2 = 0; %valor inicial para o segundo somatório
    iter = iter + 1;
    iteracao(iter) = iter;
    for a = 2:n
        if(a-1<1)
            somatorio1 = 0;
        else
            for b = 1:a-1
                somatorio1 = somatorio1 + Y(a,b)*V(iter,b);%V(iter,1)            
            end
        end    
        if(n<a+1) % Verificação e somatório com as barras que ainda não foram processadas.
            somatorio2 = 0;    
        else    
            for b = a+1:n
                somatorio2 = somatorio2 + Y(a,b)*V(iter-1,b);
            end 
        end
        % Formulação de Gauss-Seidel
        V(iter,a) = 1/Y(a,a)*(conj(S(a))/conj(V(iter-1,a))- somatorio1 - somatorio2);
        E(iter) = V(iter,a)- V(iter-1,a);
    end
end 
% Cálculo da corrente entre a barra 1 e 2
I12 = (V(iter,1)-V(iter,2))/(0.2*1i)
% Fluxo de Potência entre a barra 1 e 2
S12 = conj(I12)*V(iter,1)
% Exibição dos resultados
Iteracao = transpose(iteracao);
V2 = V(1:iter,2);
Resultados_Gauss_Seidel = table(Iteracao,V2)