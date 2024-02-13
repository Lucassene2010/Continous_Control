%%

% Author: lucas.gomes and guilherme.oliveira
% Email: lucasgomes.1999@alunos.utfpr.edu.br
% Email: guilherme.1999@alunos.utfpr.edu.br
%%
clc; % Cleaning the command window
clear all; % Cleaning the workspace
close all; % Closing all the others windows

s = tf('s'); % changing s in laplace variable

Gp1 = 2/( 1*s*(1*s + 1)*(1*s + 2) ); % Plantaa
Hs = 1 % Realimentação
Gp = feedback(Gp1,Hs); % Sistema de malha fechada

% Caracteristicas do compensador
Kv = 3; % erro est ́atico de velocidade
Mf = 45;% margem de fase minimo

limit_system = 1*s*1*Gp1;

K = Kv/dcgain(limit_system);

[Gm,Pm,Wcg,Wcp] = margin(K*Gp1);

Ang = Pm
Wg = Wcp
Kg = 20*log10(Gm)

% Pela curva de fase temos Ang = 32,61º
% Pela curva de magnitude temos Kg = 9,54 db

% Calculo do angulo adicional
Ang_gain = Mf + 10 - 180 

%  bode(Gp1);
%  axis([10^-2 10^2 -140 -100]);
%  [x,y] = ginput(1);

% valor de Wg segundo o gráfico 0,4201
% valor de ganho segundo o gráfico 15,98

%Escolha de frequência de Canto Wg/10 = 0.04201 Wg/2 = 0.21005, valor
%escolhido = 15,98
Wg = 0.04201
W1 = 0.05
T = 1/W1
Adb = - 15.98 %db

% Parametro B

B = 10^(15.98/20)

% Calculo W2

W2 = 1/(T*B)

% Ganho Kc

Kc = K/B

% Compensador
Gcs = Kc*((1*s + 1/T)/(1*s + 1/(B*T)))

New_system = feedback((Gcs*Gp1),Hs)

t = 0:0.01:50
u = t;
lsim(New_system,u,t)
hold on
lsim(Gp,u,t)
legend("New System","Old System")

% Analisando o gráfico o modelo compensando o sistema tende a ficar mais
% próxima da rampa na resposta da rampa do que o sistema não compensado,
% assim melhorando o sistema.

 








