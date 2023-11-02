function GUI_ControlePlataformaTermica(modOp1,modOp2)
f = figure('CloseRequestFcn',@my_closereq);
set(f,'Position',[150 100 1000 600]);

if strcmp(modOp1,'MF')
    % Inserção Temperatura 1
    uicontrol('Style','text','Position',[25 30 450 60]','FontSize',14,'String','Temperatura T1');
    uicontrol('Style','edit','Position',[25 10 450 40]','FontSize',14,'Callback',@changeDutyRef1);
else
    % Inserção Duty Cycle 1
    uicontrol('Style','text','Position',[25 30 450 60]','FontSize',14,'String','Duty Cycle 1');
    uicontrol('Style','edit','Position',[25 10 450 40]','FontSize',14,'Callback',@changeDutyRef1);
end
   
if strcmp(modOp2,'MF')
    % Inserção Temperatura 2
    uicontrol('Style','text','Position',[525 30 450 60]','FontSize',14,'String','Temperatura T2');
    uicontrol('Style','edit','Position',[525 10 450 40]','FontSize',14,'Callback',@changeDutyRef2);
else
    % Inserção Duty Cycle 2
    uicontrol('Style','text','Position',[525 30 450 60]','FontSize',14,'String','Duty Cycle 2');
    uicontrol('Style','edit','Position',[525 10 450 40]','FontSize',14,'Callback',@changeDutyRef2);
end

end

function changeDutyRef1(hObject,~,~)
    DutyRef1 = str2double(get(hObject,'String'));
    if isfinite(DutyRef1)
        assignin('base','DutyRef1',DutyRef1)
    end
end
function changeDutyRef2(hObject,~,~)
    DutyRef2 = str2double(get(hObject,'String'));
    if isfinite(DutyRef2)
        assignin('base','DutyRef2',DutyRef2)
    end
end

function my_closereq(~,~)
% Close request function
% to display a question dialog box
    if strcmp(questdlg('Deseja realmente encerrar o experimento?'),'Yes')
        Encerrar = 1;
        assignin('base','Encerrar',Encerrar)
        delete(gcf)
    end
end








% MATLAB versão 2015a
% function changeRef1(source,~)
%     Ref = str2double(source.String);
%     if isfinite(Ref)
%         assignin('base','Ref',Ref)
%     end
% end
% function changeRef(source,~)
%     Ref = str2double(source.String);
%     if isfinite(Ref)
%         assignin('base','Ref',Ref)
%     end
% end

