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
figure('position', [0, 0, 800*sqrt(2), 800]);

strtitle = 'Fourier Transform Test 3';

spl1 = subplot(3,1,1);
pl1 = plot(t,y);
ylabel( 'amplitude[Pa]' );
xlabel( 'time[sec]' );
xlim([ t(1) t(end) ]);
ax = gca;
ax.FontSize = 17;

spl2 = subplot(3,1,2);
[f,p] = fps(y,fs);
pl2 = pltdb(f,p,'ps',[0 0.4470 0.7410]);

spl3 = subplot(3,1,3);
Temporal_Sensitivity_Profile = 0.1;
spectrogram(y,256,120,256,fs,'yaxis');
ylim([ f(1)/1e3 f(end)/1e3 ]);
ylabel( 'frequency[kHz]' );
xlabel( 'time[sec]' );
ax = gca;
ax.FontSize = 17;

spl1Pos = get(spl1,'position');
spl2Pos = get(spl2,'position');
spl3Pos = get(spl3,'position');
spl2Pos(3:4) = [spl1Pos(3:4)];
spl3Pos(3:4) = [spl1Pos(3:4)];
set(spl2,'position',spl2Pos);
set(spl3,'position',spl3Pos);

sgtitle( strtitle , 'FontSize' , 17 );
%% end
