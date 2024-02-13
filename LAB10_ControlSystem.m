%%

% Author: lucas.gomes and guilherme.oliveira
% Email: lucasgomes.1999@alunos.utfpr.edu.br
% Email: guilherme.1999@alunos.utfpr.edu.br
%%
clc; % Cleaning the command window
clear all; % Cleaning the workspace
close all; % Closing all the others windows

s = tf('s'); % changing s in laplace variable

Gp1 = (10/( 1*s*(1*s + 10)*(1*s + 7.5))) % Planta
Hs = 1; % Realimentação
Gp = feedback(Gp1,Hs); % Sistema de malha fechada

% Método a utilizar: Resposta em frequência, motivo: planta possui um polo
% em s=0

%Sistema em malha fechada para Ti=infinito Td=0 Gc(s)=Kp=Kcr
%rlocus(Gp1);
%[Kcr,Poles] = rlocfind(Gp1);

%Kcr = 133,1383
Kcr = 133.14;
Gp = feedback(Kcr*Gp1,Hs);

%step(Gp,3);

% Período = 2,22 - 1,5

Pcr = 2.22-1.5

% Tabela de Ziegher-Nichols (resp. frequência)

Kp = 0.6*Kcr;
Ti = 0.5*Pcr;
Td = 0.125*Pcr;

Gc = Kp*(1 + ( 1/(Ti*s) ) + Td*s);

% sistema final -> feedback(Gc*Gp1,Hs)

Final_system = feedback(Gc*Gp1,Hs);

% Controlador P

C = pidtune(Gp1,'P');
GcP = C.Kp*(1);

%Controlador PI
%              1 
%   Kp + Ki * ---
%              s 

C = pidtune(Gp1,'PI')
GcPI = C.Kp*(1 + C.Ki/(1*s) );

%Controlador PD
% Kp + Kd * s

 C = pidtune(Gp1,'PD');
 GcPD = C.Kp*(1 + C.Kd*s);

%Controlador PID

C = pidtune(Gp1,'PID');
GcPID = C.Kp*(1 + ( C.Ki/(1*s) ) + C.Kd*s);

subplot(3,2,1)
step(feedback(Gp1,Hs))
legend("Gp1")
subplot(3,2,2)
step(feedback(Gp1*Gc,Hs))
legend("Gc")
subplot(3,2,3)
step(feedback(Gp1*GcP,Hs))
legend("GcP")
subplot(3,2,4)
step(feedback(Gp1*GcPI,Hs))
legend("GcPI")
subplot(3,2,5)
step(feedback(Gp1*GcPD,Hs))
legend("GcPD")
subplot(3,2,6)
step(feedback(Gp1*GcPID,Hs))
legend("GpPID")

% O melhor compensador utilizado é o PID, pois ele alcança o Estado
% estacionário mais rápido do que os outros compensadores, além de ter o
% mais rápido tempo de acomodação.

