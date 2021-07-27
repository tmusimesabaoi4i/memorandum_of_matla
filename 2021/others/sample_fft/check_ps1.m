%% start

%% clear
clc;
clear;

%% constant
fs = 192e3;
f = 50e3;
T = 5;

%% data
t = 0 : 1/fs : T - 1/fs;
y = transpose( sqrt(2) * sin(2 * pi * f * t) );

%% plot ps
figure('position', [0, 0, 500*sqrt(2), 500]);

strtitle = 'Fourier Transform Test 1';

subplot(2,1,1);
plot(t,y);
ylabel( 'amplitude[Pa]' );
xlabel( 'time[sec]' );
xlim([ t(1) t(end) ]);
ax = gca;
ax.FontSize = 17;

subplot(2,1,2);
[f,p] = fps(y,fs);
pltdb(f,p,'ps',[0 0.4470 0.7410]);

sgtitle( strtitle , 'FontSize' , 17 );

%% end
