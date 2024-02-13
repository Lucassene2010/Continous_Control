% Author: lucas.gomes and guilherme.oliveira
% Email: lucasgomes.1999@alunos.utfpr.edu.br
% Email: guilherme.1999@alunos.utfpr.edu.br
%%
clc; % Cleaning the command window
clear all; % Cleaning the workspace
close all; % Closing all the others windows

s = tf('s'); % changing s in laplace variable

K1 = 63;
K2 = 1.56

Gp =  (25)/( 1*s*(1*s + 1) ); % Planta
Hs = 1; % Realimentação
Gs1 = feedback(Gp,(K2*1*s) ); % Sistema de malha fechada
Gs2 = series(K1,Gs1);
Gs = feedback(Gs2,Hs);

[NUM,DEN] = tfdata(Gs,'v');

% Forma canônica controlável

T = [0 1; 1 0]

[A,B,C,D] = tf2ss(NUM,DEN)

Actr = inv(T)*A*T;% Matriz A 

Bctr = inv(T)*B; % Matriz B

Cctr = C*T; % Matriz C

Dctr = D;

% Forma canônica Observável

Aobs = transpose(Actr);

Bobs = transpose(Cctr);

Cobs = transpose(Bctr);

Dobs = transpose(Dctr);


Function_transfer_ctr = Cctr*(inv(1*s*eye(2) - Actr))*Bctr + Dctr
Function_transfer_obs = Cobs*(inv(1*s*eye(2) - Aobs))*Bobs + Dobs

syms t

X = expm(Actr*t)

subs(X,t,0)


