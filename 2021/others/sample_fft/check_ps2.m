%% start

%% clear
clc;
clear;

%% constant
fs = 192e3;
f1 = 50e3;
f2 = 10e3;
T = 5;

%% data
t = 0 : 1/fs : T - 1/fs;
y1 = transpose( sqrt(2) * sin(2 * pi * f1 * t) );
y2 = transpose( sin(2 * pi * f2 * t) );

%% plot ps
figure('position', [0, 0, 500*sqrt(2), 500]);

strtitle = 'Fourier Transform Test 2';

[f,p1] = fps(y1,fs);
[~,p2] = fps(y2,fs);
pl1 = pltdb(f,p1,'ps',[0 0.4470 0.7410]);
hold on
pl2 = pltdb(f,p2,'ps',[0.4660 0.6740 0.1880]);
legend( [pl1 pl2] ,{'A','B'} );

title( strtitle );
hold off

%% end
