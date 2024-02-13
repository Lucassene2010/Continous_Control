close all;
clear all;
close all;

T = 1;
Ts=1;
fim=5;
Fs=24;
bits=1e3;
alfa=0.5;

t = -5*T:1/Fs:5*T;
t = t + 1e-10;
noiseAmplitude = 0.1;
% Gerando o sinal raiz de cosseno levantado
b = pi/T;
a = alfa/T;
p = ((pi^2)/(pi*(a-b)-4*a))*((4*a.*t.*cos(t.*(a+b))+pi.*sin(t.*(b-a)))./(t.*(16.*(t.^2).*a^2 - pi^2)));
p = p/sqrt(sum(p));

% resposta em frequencia ao impulso
c2=0.1;
c1=-0.3;
c0=0.8;
c=[c2 c1 c0 c1 c2];
freqz(c);

% Parâmetros
figure
t=-2*fim*Ts:1/Fs:(2*fim+length(c))*Ts-1/Fs;
temp=conv(p,upsample(c,Fs));
temp=conv(temp,p);
plot(t,temp)
t_amostra=[-2*fim:2*fim+length(c)-1];
temp_amostra=temp(1:Fs:(2*fim+2*fim+length(c))*Fs);
hold
stem(t_amostra,temp_amostra,'r','Linewidth',2)
legend('saída do filtro','saída amostrada')

% Gerando sinal
s=rand(1,bits)>0.5;
s=2*s-1;
s=upsample(s,Fs);
x=conv(s,p);
x=x+randn(size(x))*0.02;
q=conv(x,p);

% Passagem do sinal transmitido x pelo canal com upsampling.
c_up=upsample(c,Fs);
r=conv(x,c_up);
y=conv(r,p);

% Definição do equalizador
w=[c0 c1 c2;
   c1 c0 c1;
   c2 c1 c0];
h=w\[0; 1; 0];
h_up=upsample(h,Fs);
z=conv(y,h_up);

% Recortes dos sinais para diagramas de olho
x1=q(4*fim*Fs+1:1:length(q)-4*fim*Fs+1);
y1=y(4*fim*Fs+1:1:length(y)-4*fim*Fs+1);
z1=z(4*fim*Fs+1:1:length(z)-4*fim*Fs+1);

eyediagram(x1,Fs)
xlabel('Período de Símbolo x1')
eyediagram(y1,Fs)
xlabel('Período de Símbolo y1')
eyediagram(z1,Fs)
xlabel('Período de Símbolo z1')

% Sincronismo de Símbolo

tam=1e3;
erro=-5; 
t_amostra=(2*fim:tam+2*fim-1)*Fs+1+erro;

%Gerando os Simbolos
y=conv(s,p);

%Canal AWNG
Eb=1;
EbN0dB=8;
EbN0=10.^(EbN0dB/10);
N0=Eb/EbN0;
ruido=randn(1,length(y))*sqrt(N0);
y=y+ruido;

%Filtragem casada
r=conv(y,p);

%Gráfico do sinal na saída do filtro casado
t_r=-2*fim:1/Fs:((tam+2*fim)-1/Fs);
figure
plot(t_r,r,'k:');
legend('Sinal Recebido')
xlabel('tempo (s)');

%Parâmetros do algoritmo early-late detection
mu=1;
delta=10;

%Algoritmo
tau=zeros(1,tam);
for a=1:tam
    amostra(a)=r(t_amostra(a)+round(tau(a)));
    amostra_early(a)=r(t_amostra(a)+round(tau(a))-delta);
    amostra_late(a)=r(t_amostra(a)+round(tau(a))+delta); 
    dif(a)=amostra_late(a)-amostra_early(a);
    tau(a+1)=tau(a)+mu*(dif(a).*amostra(a));
  end
tau=tau(1:tam);
t_amostra_novo=(t_amostra+round(tau));

%Gráfico do sinal amostrado
hold
t_amostra_novo=(t_amostra+round(tau));
plot(t_amostra_novo/Fs-1/Fs-2*fim,r(t_amostra_novo),'ro')
t_amostra=t_amostra-erro;
plot(t_amostra/Fs-1/Fs-2*fim,r(t_amostra),'bx')
xlabel('tempo (s)');
legend('Saída do Filtro','Amostra ELD','Amostra Exata');
axis tight
xlim([0 100])

figure
plot(round(tau)/Fs)
xlabel('tempo (s)');
ylabel('tau');
