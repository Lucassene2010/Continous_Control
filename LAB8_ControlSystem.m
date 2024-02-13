%%

% Author: lucas.gomes and guilherme.oliveira
% Email: lucasgomes.1999@alunos.utfpr.edu.br
% Email: guilherme.1999@alunos.utfpr.edu.br
%%
clc; % Cleaning the command window
clear all; % Cleaning the workspace
close all; % Closing all the others windows

s = tf('s'); % changing s in laplace variable

% Planta
G1s = (1*s + 1)/(1*s^3 + 0.2*s^2 + 1*s + 1);
G2s = 1/(1*s^2 - 0.5246*s + 1.38);
G3s = (1*s + 3)/(1*s -1);
% Realimentação
H1s = 1*s + 1;
H2s = 1/(1*s + 0.7246);
H3s = 1/s;
% função em malha Aberta
F1ma = G1s*H1s;
F2ma = G2s*H2s;
F3ma = G3s*H3s;

% Analisando os digramas de resposta de freuqência
figure()
bode(F1ma)
legend('System 1')
figure()
bode(F2ma)
legend('System 2')
figure()
bode(F3ma)
legend('System 3')
 
% Diagrama de Nyquist
 figure()
 nyquist(F1ma)
 legend('System 1')
 figure()
 nyquist(F2ma)
 legend('System 2')
 figure()
 nyquist(F3ma)
 axis([-3 0.5 -2 2])
 legend('System 3')

% Sistema 1 -> Margens de estabilidade Wg
[Gm,Pm,Wcg,Wcp] = margin(F1ma);
Gm1 = Gm;
Kg1 = -20*log10(Gm1)
Ang1 = Pm
Wg1 = Wcp
Wf1 = Wcg
[Gm,Pm,Wcg,Wcp] = margin(F2ma);
Gm2 = Gm;
Kg2 = -20*log10(Gm2)
Ang2 = Pm
Wg2 = Wcp
Wf2 = Wcg
[Gm,Pm,Wcg,Wcp] = margin(F3ma);
Gm3 = Gm;
Kg3 = -20*log10(Gm3)
Ang3 = Pm
Wg3 = Wcp
Wf3 = Wcg

% Análisando as margens de fase e margens de ganho, temos o seguite
% critério, se ambas as margens < 0, sistema instável
% critério, se ambas as margens > 0, sistema estável
% Sistema1 Kg = 5.35, Ang = 28.62º, Wg = 1.84 e Wf = 1.44, como os dois são maiores q zero, então
% o sistema é estável
% Sistema2 Kg = -Infinito, Ang = -133,15º Wg = 1.26 Wf = Indefinido (será discutido em outro tópico)
% Sistema3 Kg = -3.8573e-15, Ang = 0 Wg = 1.73121 Wf = 1.7321

% Analisando a estabilidade dos sistemas via critério de estabilidade de Nyquist
% 
% Número de voltas em torno −1 + j0 = 1 e Sentido = Anti-horário
pole(F1ma)
% Número de polos de malha aberta no SPD = 2 polos
% Número de polos de malha fechada = 2 - 2 = 0, pelo critério de Nyquist
% temos zero polos de malha fechada no SPD, então por isso o sistema é
% estável

% Número de voltas em torno −1 + j0 = 0 e Sentido = Anti-horário
pole(F2ma)
% Número de polos de malha aberta no SPD = 2 polos
% Número de polos de malha fechada = 2 + 0 = 2 temos dois polos de 
% malha fechada no SPD, então por isso o sistema é
% instável

% Número de voltas em torno −1 + j0 = 0
pole(F3ma)
% O diagrama de Nyquist cruza o ponto −1 + j0, então há polos de malha fechada
% sobre o eixo imaginário, indicando que o sistema é criticamente estável.









