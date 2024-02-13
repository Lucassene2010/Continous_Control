% Author: lucas.gomes and guilherme.oliveira
% Email: lucasgomes.1999@alunos.utfpr.edu.br
% Email: guilherme.1999@alunos.utfpr.edu.br
%%
clc; % Cleaning the command window
clear all; % Cleaning the workspace
close all; % Closing all the others windows

s = tf('s'); % changing s in laplace variable

% Matriz do espaço de estado

Identity = eye(5); % estados, por isso uma matriz i dentidade 5x5

MatrixA = [0 1 0 0 0 ; -0.1 -0.5 0 0 0 ; 0.5 0 0 0 0 ; 0 0 10 0 0 ; 0.5 1 0 0 0]; % Parâmetro A
MatrixB = [0 ; 1 ; 0 ; 0 ; 0]; % Parâmetro B
MatrixC = [0 0 0 1 0]; % Parâmetro C
MatrixD = 0; % Parâmetro D

CO_matrix = ctrb(MatrixA,MatrixB); % Cálculo da matriz de controlabilidade.

Posto = rank(CO_matrix)

%Sendo o posto=4, no caso diferente de 5, significando que não possui posto
%completo

% Sendo a matriz de controlabilidade quadrada, podemos determinadr o posto
% via determinante

Det = det(CO_matrix)

% Det=0, assim provando além do posto que não possui posto completo

% Calculando a função de transferência

Gs = MatrixC*inv((1*s*Identity - MatrixA))*MatrixB + MatrixD

[NUM,DEN] = ss2tf(MatrixA,MatrixB,MatrixC,MatrixD);
Gs1 = tf(NUM,DEN)

% Cancelando os Polos/Zeros

new_Gs = minreal(Gs1)

% validando se a nova função é controlável.

[Matrix_A,Matrix_B,Matrix_C,Matrix_D] = ssdata(new_Gs);

COmatrix = ctrb(Matrix_A,Matrix_B)

Posto1 = rank(COmatrix)

% Posto1 = 4, que é igual a min{4,4}. Portanto,
% possui posto completo. Como M é uma matriz quadrada, podemos checar
% através do Determinante da matriz

Det2 = det(COmatrix)

% Det2 diferente de zero, assim sendo um matriz que possui posto
% completo.

% Projetando ganho com os polos sugeridos
Pole1 = -10;
Pole2 = -20;
Pole3 = complex(-1,1);
Pole4 =  complex(-1,-1);

Poles = [Pole1, Pole2, Pole3, Pole4]

Gain = place(Matrix_A,Matrix_B,Poles)
