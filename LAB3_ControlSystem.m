%%

% Author: lucas.gomes and guilherme.oliveira
% Email: lucasgomes.1999@alunos.utfpr.edu.br
% Email: guilherme.1999@alunos.utfpr.edu.br
%
% Calculating the inversor equation transfer 
%

%% Implementation the equation

clc; % Cleaning the command window
clear all; % Cleaning the workspace
close all; % Closing all the others windows

s = tf('s'); % changing s in laplace variable

Gp = (1*s^2-2*s+4)/(1*s^2+4*s+2);

%% Poles and Zeros
p1 = pole(Gs)
z1 = zero(Gs)

%% Cascateamento k = 0.5
K = 0.5;
Gp = (1*s^2-2*s+4)/(1*s^2+4*s+2);

Gs = K*Gp
Gc1 = feedback(Gs,1);
subplot(3,1,1)
pzplot(Gc1)

% K=0.5 Estável pois os polos se encontram no lado esquerdo do eixo Y
% Cascateamento k = 2
K = 2;

Gs = K*Gp
Gc2 = feedback(Gs,1);
subplot(3,1,2)
pzplot(Gc2)

% K=2 Crítico pois os polos se encontram no eixo y
% Cascateamento k = 4
K = 4;

Gs = K*Gp
Gc3 = feedback(Gs,1);
subplot(3,1,3)
pzplot(Gc3)

% K=4 Instável pois os polos se encontram no lado direito do eixo y

%% subplot the step
subplot(3,1,1)
step(Gc1)
% Estável pois a função tende a uma constante
subplot(3,1,2)
step(Gc2)
% Crítico pois a função é oscilante
subplot(3,1,3)
step(Gc3)
% Instável pois a função tende ao infinito 