% Author: lucas.gomes
% Email: lucasgomes.1999@alunos.utfpr.edu.br
%%
clc; % Cleaning the command window
clear all; % Cleaning the workspace
close all; % Closing all the others windows

s = tf('s'); % changing s in laplace variable


% Letra A
Gs = 1/(1*s^3 + 6*s^2 + 11*s + 5) % Planta
Hs = 1 % Realimentação

%figure()
%rlocus(Gs)
%[Gain,Poles] = rlocfind(Gs)

% Polos de ganho crítico 
%  -6.0217 + 0.0000i
%   0.0109 + 3.3363i
%   0.0109 - 3.3363i
% possui o ganho crítico de 62.0278 pois há um
% caminho cruzando o eixo imaginário

%K = Gain - 30;
%feedback(K*Gs,Hs)

%figure()
%step(feedback(K*Gs,Hs))
%stepinfo(K*Gs)

% Letra B

New_K = 1
Gs2 = feedback(New_K*Gs,Hs)
[NUM,DEN] = tfdata(Gs2,'v')
[A,B,C,D] = tf2ss(NUM,DEN) % Matriz A 3x3, 3 estados

CO_matrix = ctrb(A,B) % Cálculo da matriz de controlabilidade.
Posto = rank(CO_matrix) % Cáculo do posto


%Sendo o posto=3, no caso sendo igual min{3,3} da matriz A, então o sistema
%é completamente controlável


% Projetando ganho com os polos sugeridos
Pole1 = complex(-2,2);
Pole2 =  complex(-2,-2);
Pole3 = -5;

Poles = [Pole1, Pole2, Pole3]

Gain = place(A,B,Poles)









