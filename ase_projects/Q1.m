%%%% 2 EST�GIO
%%%% ALUNOS: Luan F�bio Marinho Galindo 
%%%%         Ruan Alecssander de Araujo Silva
%%%%         Douglas de Souza Sesion

%%%% QUEST�O 1: MODELOS DE CARGA -  Pesos nas medi��es 3 e 4

clc, clear, close all

%% Tens�es e Pot�ncias em kV e em MW
Vh1 = [130.5 131.8 133.2 133.8]'; 
Ph1 = [64.63e3 65.31e3 66.01e3 66.31e3]';
       
Vh2 = [130.5 131.8*2 133.2*2 133.8]'; 
Ph2 = [64.63e3 65.31e3*2 66.01e3*2 66.31e3]';

abcd(Vh1, Ph1)
abcd(Vh2, Ph2)

function abcd(Vh, Ph)

    % Tens�es e Potencias normalizadas; 
    V = Vh/Vh(1);
    P = Ph/Ph(1);

    %% Modelo de Imped�ncia constante (Ph = P0*a(Vh/Vo)^2)
    A = (V.^2)
    B = P
    At = A'
    a = (At*B)/(At*A)

    e_z_const = B - A*a

    % Erro quadr�tico total:
    eqt_z = e_z_const'* e_z_const

    P_a_est = polyval([a 0 0], V);

    %% Modelo Fonte de corrente constante  (Ph = Po*b(Vh/Vo))
    A = V
    B = P
    At = A'
    b = (At*B)/(At*A)

    e_i_const = B - A*b

    % Erro quadr�tico total:
    eqt_i = e_i_const'* e_i_const

    P_b_est = polyval([b 0], V);

    %% Modelo Pot�ncia constante (Ph = P0*c)
    A = ones(size(V))
    B = P
    At = A'
    c = (At*B)/(At*A)

    e_pot_const = B - A*c

    % Erro quadr�tico total:
    eqt_pot = e_pot_const'*e_pot_const

    P_c_est = polyval(c, V);

    %% Modelo ZIP Ph = P0((a(Vh/Vo)^2) + b(Vh/Vo) + c)

    A = [V.^2 V ones(size(V))]
    B = A'*P
    At = A'*A
    d = inv(At)*B

    e_ZIP = P - A*d

    % Erro quadr�tico m�dio:
    eqt_ZIP = e_ZIP'*e_ZIP

    P_d_est = polyval(d, V);

    %% Gr�ficos
    fh = figure();
    fh.WindowState = 'maximized';

    subplot(2,2,1)
    hold on
    scatter(Vh, Ph, 'LineWidth', 2);
    plot(Vh, P_a_est*Ph(1), 'LineWidth', 2);
    legend('Tens�es reais','Curva estimada','Location','southeast');
    xlabel('Tens�es [kV]');
    ylabel('Pot�ncias [MW]');
    title('Imped�ncia Constante');

    subplot(2,2,2)
    hold on
    scatter(Vh, Ph, 'LineWidth', 2);
    plot(Vh, P_b_est*Ph(1),  'LineWidth', 2);
    legend('Tens�es reais','Curva estimada','Location','southeast');
    xlabel('Tens�es [kV]');
    ylabel('Pot�ncias [MW]');
    title('Fonte de Corrente Constante');

    subplot(2,2,3)
    hold on
    scatter(Vh, Ph, 'LineWidth', 2);
    plot(Vh, P_c_est*Ph(1),  'LineWidth', 2);
    legend('Tens�es reais','Curva estimada','Location','southeast');
    xlabel('Tens�es [kV]');
    ylabel('Pot�ncias [MW]');
    title('Pot�ncia Constante');

    subplot(2,2,4)
    hold on
    scatter(Vh, Ph, 'LineWidth', 2);
    plot(Vh, P_d_est*Ph(1), 'LineWidth', 2);
    legend('Tens�es reais','Curva estimada','Location','southeast');
    xlabel('Tens�es [kV]');
    ylabel('Pot�ncias [MW]');
    title('ZIP');

    %% Tabelas com resultados finais

    % Tabela mostrando as perdas entre as barras
    labels = {'Imped�ncia Constante','Corrente Constante','Pot�ncia Constante','ZIP'}';

    % Tabela mostrando as perdas entre as barras
    ERRO = table(labels,transpose([eqt_z, eqt_i, ... 
        eqt_pot, eqt_ZIP]))
    ERRO.Properties.VariableNames = {'Modelos', 'Erros Quadr�ticos'}
end    
