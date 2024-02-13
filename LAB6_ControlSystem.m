%%

% Author: lucas.gomes and guilherme.oliveira
% Email: lucasgomes.1999@alunos.utfpr.edu.br
% Email: guilherme.1999@alunos.utfpr.edu.br
%%
clc; % Cleaning the command window
clear all; % Cleaning the workspace
close all; % Closing all the others windows

s = tf('s'); % changing s in laplace variable

% Polos dominantes -2.018 +- j5.244

Gp1 = 63/(1*s*(1*s + 4)*(1*s + 6));
Gp = feedback(Gp1,1);

rlocus(Gp1);

% Analisando o gráfico podemos ver que os polos dominantes estão fora dos
% lugares das raízes, neste exemplo será um compensador que empurre os
% lugares da raízes para esquerda.

% Calculo de contribuição angular fid = 180° - Etetap + Etetaz

%Calculo fid1

fid1 = atand(5.244/4);

%Calculo fid2

fid2 = atand(5.244/2);

%Calculo fid3

fid3 = 180 - atand(5.244/2);

%Calculo fid

fid = 180 - (fid1 + fid2 + fid3)

% Operação dos parametros alpha e T

%Função do compensador Kc* ( (s + (1/T) )/(s + (1/alpha*T) ) )

PolosDominantes = complex(-2.018,5.244)

alpha = 1/( 5.244/tand(fid - atand( (5.244/-2.018) - 5)) -2.018)

% valor de alpha = 0.1404

% Calculo Kc
func = ( (PolosDominantes + 1)/(PolosDominantes + 1/alpha*5) )*( 63/(PolosDominantes*(PolosDominantes + 4)*(PolosDominantes + 6)))
Kc = 1/abs(func)

% valor de Kc = 20.9608
NewSystem = Kc*( (1*s + 5)/(1*s + 1/(alpha*1/5) ))
figure()
step(Gp)
hold on
step(feedback(NewSystem*Gp1,1))

% O sistema como mostrado nas figuras ficou mais estável pois o ponto
% máximo da função diminuiu, conforme mostra os gráficos.







