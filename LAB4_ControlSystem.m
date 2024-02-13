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

sys1 = 1/(1*s);
sys2 = 2/(1*s + 3);
sys3 = 3;
sys4 = 4*s;

malha1 = feedback(sys2,sys3);
malha2 = series(sys1,malha1);
malha3 = feedback(malha2,sys4);
result = feedback(malha3,1)
G2 = series(malha3,1)
G3 = series(s,G2)

figure()
step(result,100);

t = 0:0.1:100;

u = t;

figure()
lsim(result,u,t)

% Verificando os dois gráfico, percebemos que quando o tempo tende ao
% infinito a função de tranferência tem um erro 0 na resposta ao degrau (
% pois a função tende ao valor do degrau unitário) e um erro constante na
% resposta a rampa/reta (pois é possível identificar que a função de 
% tranferência fica paralela a reta com uma distância constante), por isso
% do tipo 1.

% degrau unitário
syms s;
[num,den] = tfdata(G2);
Gsimb = poly2sym(cell2mat(num),s)/poly2sym(cell2mat(den),s);

G0 = eval(limit(Gsimb,s,0,'right'));

Kp = 1/(1 + G0)

% Rampa
syms s;
[num,den] = tfdata(G3);
Gsimb = poly2sym(cell2mat(num),s)/poly2sym(cell2mat(den),s);

G0 = eval(limit(Gsimb,s,0,'right'));

Kv = 1/G0

% Os valores batem com os resultados obtidos nos gráficos, pois 
% erro degrau = 0 e 
% erro rampa = 8.5













