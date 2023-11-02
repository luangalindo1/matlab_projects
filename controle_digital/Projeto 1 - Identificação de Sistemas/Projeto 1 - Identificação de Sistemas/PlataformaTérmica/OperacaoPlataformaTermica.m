

time = zeros(10000,1);
r1 = zeros(10000,1);    r2 = zeros(10000,1);
u1 = zeros(10000,1);    u2 = zeros(10000,1);
temp1 = zeros(10000,1); temp2 = zeros(10000,1);

recv = fscanf(Serial);
recv = strsplit(recv,',');
recv1 = recv(1);    recv2 = recv(2);
recv3 = recv(3);    recv4 = recv(4);
recv5 = recv(5);    recv6 = recv(6);

r1(1) = str2double(recv1);
temp1(1) = str2double(recv3);
u1(1) = str2double(recv5);

r2(1) = str2double(recv2);
temp2(1) = str2double(recv4);
u2(1) = str2double(recv6);

DutyRef1_anterior = DutyRef1;
DutyRef2_anterior = DutyRef2;

GUI_ControlePlataformaTermica(modoOperacao1,modoOperacao2)
i = 1;
scrollWidth = Inf; % display period in plot, plot entire data log if <= 0
delay = 1; % make sure sample faster than resolution

subplot(6,1,[1 2 3]);
plot(time(1:i),r1(1:i),'k', ...
    time(1:i),r2(1:i),'m', ...
    time(1:i),temp1(1:i),'b', ...
    time(1:i),temp2(1:i),'r');
ylim([20 60]), grid minor,
legend('Referência 1','Referência 2', ...
    'Temperatura 1','Temperatura 2', ...
    'Location','SouthEast')
ylabel('Temperatura (ºC)'),
title('Plataforma Térmica')
subplot(6,1,[4 5]);
plot(time(1:i),u1(1:i), ...
    time(1:i),u2(1:i));
ylim([0 1]), grid minor,
legend('Duty Cycle 1','Duty Cycle 2')
xlabel('Tempo (s)'), ylabel('Duty Cycle (-)')

i = i + 1;
Encerrar = 0;
%%
tic
while (~Encerrar) %Loop when Plot is Active
    recv = fscanf(Serial);
    
    if(~isempty(recv)) %Make sure Data Type is Correct
        time(i) = toc;
        
        recv = fscanf(Serial);
        recv = strsplit(recv,',');
        recv1 = recv(1);    recv2 = recv(2);
        recv3 = recv(3);    recv4 = recv(4);
        recv5 = recv(5);    recv6 = recv(6);
        
        r1(i) = str2double(recv1);
        temp1(i) = str2double(recv3);
        u1(i) = str2double(recv5);
        
        r2(i) = str2double(recv2);
        temp2(i) = str2double(recv4);
        u2(i) = str2double(recv6);
        
        subplot(6,1,[1 2 3]);
        plot(time (time(1:i) > time(i)-scrollWidth), ...
            r1   (time(1:i) > time(i)-scrollWidth), 'k', ...
            time (time(1:i) > time(i)-scrollWidth), ...
            r2   (time(1:i) > time(i)-scrollWidth), 'm', ...
            time(time(1:i) > time(i)-scrollWidth), ...
            temp1(time(1:i) > time(i)-scrollWidth), 'b', ...
            time (time(1:i) > time(i)-scrollWidth), ...
            temp2(time(1:i) > time(i)-scrollWidth), 'r')
        %             ylim([20 60])
        grid minor,
        legend('Referência 1','Referência 2', ...
            'Temperatura 1','Temperatura 2', ...
            'Location','SouthEast')
        ylabel('Temperatura (ºC)'),
        title('Plataforma Térmica')
        subplot(6,1,[4 5]);
        plot(time(time(1:i) > time(i)-scrollWidth), ...
            u1(time(1:i) > time(i)-scrollWidth), 'b', ...
            time(time(1:i) > time(i)-scrollWidth), ...
            u2(time(1:i) > time(i)-scrollWidth),'r');
        ylim([0 1]), grid minor,
        legend('Duty Cycle 1','Duty Cycle 2')
        xlabel('Tempo (s)'), ylabel('Duty Cycle (-)')
        
        if (DutyRef1_anterior ~= DutyRef1 || DutyRef2_anterior ~= DutyRef2)
            fprintf(Serial,'%s',[num2str(DutyRef1),',',num2str(DutyRef2)]);
        end
        
        i = i + 1;
        DutyRef1_anterior = DutyRef1;
        DutyRef2_anterior = DutyRef2;
        %Allow MATLAB to Update Plot
        pause(delay);
    end
end

%%
fprintf(Serial,'%.4f','FIM');
time = time(1:i-1);

r1 = r1(1:i-1);
r2 = r2(1:i-1);
temp1 = temp1(1:i-1);
temp2 = temp2(1:i-1);
u1 = u1(1:i-1);
u2 = u2(1:i-1);

close all
fclose(Serial);
