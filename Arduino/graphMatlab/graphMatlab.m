delete(instrfind('Port', 'COM3'));
puerto = serial('COM3', 'BaudRate', 9600);
fopen(puerto);

figure;
grid off;
% xlim([0 500]);

contador = 1;
% voltaje = zeros(1,500);
while contador<1000
    ylim([0 5.1]);
    xlim([0 contador+50]);
    val = fscanf(puerto, '%d');
    voltaje(contador)= val(1)*5/1024;
    plot(voltaje,'b');
    drawnow;
    contador = contador+1;
end

fclose(puerto);
delete(puerto);
clear all;