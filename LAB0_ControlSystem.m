% Atividade Introdutória

close all % fecha todas as figuras
clear % limpa todas as variáveis
clc % limpa o Command Window

% Passo 1: declarar as funções de transferência

% G1 = 4

num1 = 4; 
den1 = 1;
sys1 = tf(num1,den1);

% G2 = 1/(s + 1)

num2 = 1;
den2 = [1 1];
sys2 = tf(num2,den2);

% G3 = s/(s^2 + 2)

num3 = [1 0];
den3 = [1 0 2];
sys3 = tf(num3,den3);

% outra maneira de declarar uma função de transferência

s    = tf('s');
sys3 = s/(s^2 + 2);

% G4 = 1/s^2

num4 = 1; 
den4 = [1 0 0]; 
sys4 = tf(num4,den4);

% G5 = (4s + 2)/(s^2 + 2s + 1)

num5 = [4 2]; 
den5 = [1 2 1]; 
sys5 = tf(num5,den5);

% G6 = 50

num6 = 50; 
den6 = 1; 
sys6 = tf(num6,den6);

% G7 = (s^2 + 2)/(s^3 + 14)

num7 = [1 0 2]; 
den7 = [1 0 0 14]; 
sys7 = tf(num7,den7);

% Operações em diagrama de blocos

sysa = feedback(sys4,sys6,+1); % feedback positivo da direita

sysb = series(sys2,sys3); % G2 em cascata com G3

sysc = feedback(sysb,sys5); % feedback negativo da esquerda

sysd = series(sysc,sysa); % resultados dos feedbacks em cascata

syse = feedback(sysd,sys7); % feedback externo

sys  = zpk(series(sys1,syse)) % resultado em cascata com G1 (fatorado)

% Gráfico de polos e zeros

pzmap(sys);

% Polos e zeros da FT equivalente

p = pole(sys);
z = zero(sys);