%% Plataforma Térmica

%% Inicialização
if strcmp(questdlg('Deseja iniciar um novo experimento?'),'Yes')
    %%
    if exist('Serial','var'), fclose(Serial); end
    Encerrar = 1;
    clear all, clc
    close all
    
    
    %% Configurações
    run('ConfiguracaoSistema.m');
    run('ConfiguracaoComunicacaoSerial.m');
    
    %% Controle da Plataforma
    run('OperacaoPlataformaTermica.m');
    
    %% Salvamento do Experimento
    
    DataHoraExp = clock;
    AnoExp = num2str(DataHoraExp(1));
    MesExp = num2str(DataHoraExp(2));
    DiaExp = num2str(DataHoraExp(3));
    HoraExp = num2str(DataHoraExp(4));
    MinExp = num2str(DataHoraExp(5));
    SegExp = num2str(floor(DataHoraExp(6)),2);
    DiaHoraString = [DiaExp,'-',MesExp,'-',AnoExp,'_', ...
        HoraExp,'-',MinExp,'-',SegExp];
    NomeExp = ['Exp_Malha1-',num2str(modoOperacao1), ...
        '_Malha2-',num2str(modoOperacao2),'_' ...
        DiaHoraString];
    
    if strcmp(questdlg('Você deseja salvar os dados coletados?'),'Yes')
        %       Para salvar na pasta atual (o arquivo não pode ser salvo na
        %       pasta 'bin')
        save(NomeExp,'time','r1','r2','temp1','temp2','u1','u2');
        %       Para salvar numa pasta específica (mudar o caminho para a pasta desejada)
        %         save(['C:\Users\Alunos\Desktop\LCD2018.2\Exp_2\dados_Malha',num2str(Malha),'.mat'],'time','r','u','temp1','temp2');
    end
    
end

