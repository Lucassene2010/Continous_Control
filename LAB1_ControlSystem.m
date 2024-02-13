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


R1 = 1*10^3; %resistor in ohms
R2 = 10*10^3; %resistor in ohms
C1 = 0.5*10^-3; %capacitor in faradays
C2 = 0.1*10^-3; %capacitor in faradays

s = tf('s') % changing s in laplace variable

Vout = (R2/(s*C2))/(R2 + 1/(s*C2));
Vin = R1 + 1/(s*C1);
Gs = -Vout/Vin % transfer function (-0.5*s^2)/(5e-05*s^3 + 0.00015*s^2 + 0.0001*s)
ss(Gs) % Matrix
step(Gs) % answer of funtion step



