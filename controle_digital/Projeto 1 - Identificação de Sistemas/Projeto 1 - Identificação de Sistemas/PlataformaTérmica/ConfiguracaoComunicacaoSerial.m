PortaSerial = ['COM',num2str(NumPortaSerial)];
Serial = serial(PortaSerial);
Serial.BaudRate = 9600;
fopen(Serial);
pause(3);

estadoSistema = 'ON';
fprintf(Serial,'%s',estadoSistema);
pause(2);
fscanf(Serial)

fprintf(Serial,'%s',modoOperacao1);
pause(3);
fscanf(Serial)

if strcmp(modoOperacao1,'MA')
    fprintf(Serial,'%s',['Duty=',num2str(DutyRef1)]);
elseif strcmp(modoOperacao1,'MF')
    fprintf(Serial,'%s',['C=',num2str(kp1),',',num2str(ti1), ...
        ';Ref=',num2str(DutyRef1)]);
else
    fprintf(Serial,'%s',['C=', num2str(ganhoFF1),',', ...
        num2str(taunumFF1),',',num2str(taudenFF1),',', ...
        num2str(atrasoFF1),',Duty=',num2str(DutyRef1)]);
end
pause(3);
% fscanf(Serial)

fprintf(Serial,'%s',modoOperacao2);
pause(3);
fscanf(Serial)

if strcmp(modoOperacao2,'MA')
    fprintf(Serial,'%s',['Duty=',num2str(DutyRef2)]);
elseif strcmp(modoOperacao2,'MF')
    fprintf(Serial,'%s',['C=',num2str(kp2),',',num2str(ti2), ...
        'Ref=',num2str(DutyRef2)]);
else
    fprintf(Serial,'%s',['C=', num2str(ganhoFF2),',', ...
        num2str(taunumFF2),',', num2str(taudenFF2),',', ...
        num2str(atrasoFF2),',Duty=',num2str(DutyRef2)]);
end
pause(3);
fscanf(Serial)

%     if strcmp(fscanf(s),'ON')
%         1
%     end