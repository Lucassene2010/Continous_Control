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

Gs = 12/(1*s^2 + 2*s); % Transfer function

Gs2 = feedback(Gs,1);

[Wn,Z] = damp(Gs2); %

step(Gs2)

%% tempo de subida

Sigma = Wn(1)*Z(1);
Wd = Wn(1)*sqrt(1-1*Z(1)^2);
Beta = atan(Wd/Sigma);
TR = (pi - Beta) / Wd

%% tempo de pico

TP = pi/Wd

%% Máximo sobressinal

Mp = exp((-Z(1)*pi)/sqrt(1-Z(1)^2)) % porcent

%% Tempo de acomodação 

TS = 4/(Z(1)*Wn(1))

%% stepinfo

stepinfo(Gs2)

% RiseTime: 0.3778
% TransientTime: 3.9349
% SettlingTime: 3.9349
% SettlingMin: 0.8496
% SettlingMax: 1.3869
% Overshoot: 38.6910
% Undershoot: 0
% Peak: 1.3869
% PeakTime: 0.9671
%
% TR = 0.5619
% TP = 0.9472
% Mp = 0.3878
% Ts = 0.9472
%
% O único valor que deu discrepância nos cálculos efetuados acima é do
% RiseTime, isso se deve pois o Matlab pega uma range específico do sinal,
% no caso como default é 10% depois do começo da função e termina quando o
% sinal fica em 90%. Assim dando discrepância, uma maneira de resolver isso
% é alterando esse range de cálculo Ex:  s = stepinfo(sys,'RiseTimeLimits',[0.05,0.95])





